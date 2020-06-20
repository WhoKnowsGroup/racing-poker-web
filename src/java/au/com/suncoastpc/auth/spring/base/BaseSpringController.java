package au.com.suncoastpc.auth.spring.base;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.ejb.EJB;
import javax.naming.InitialContext;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Appender;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.ConsoleAppender;
import org.apache.log4j.Layout;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;
import org.apache.log4j.spi.Filter;
import org.apache.log4j.spi.LoggingEvent;
import org.lightcouch.CouchDbClient;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import au.com.suncoastpc.auth.annotations.SynchronizedPerAccount;
import au.com.suncoastpc.auth.util.AccessUtils;
import au.com.suncoastpc.auth.util.AnnotationUtils;
import au.com.suncoastpc.auth.util.Constants;
import au.com.suncoastpc.auth.util.OverridableHttpRequest;
import au.com.suncoastpc.auth.util.StringUtilities;
import au.com.suncoastpc.auth.util.comparators.UserLevelCompare;
import au.com.suncoastpc.conf.Configuration;
import au.com.suncoastpc.util.CouchDBUtil;
import au.com.suncoastpc.util.types.CouchDatabase;

import com.google.gson.JsonObject;
import com.pokerace.ejb.iface.UserManager;
import com.pokerace.ejb.model.User;

/**
 * Provides a common starting-point for adding additional spring controllers to the webapp.  This class 
 * provides default behavior supporting pre- and post-request authorization and other commonly required 
 * tasks.  Subclasses only need to specify their desired MultiActionController, its configured mapping 
 * parameter, and (optionally) user-friendly names for each view made accessible view their associated 
 * MultiActionController. 
 * 
 * @author Adam
 */
public abstract class BaseSpringController extends DispatcherServlet {
	/**
	 * Serialization id.
	 */
	private static final long serialVersionUID = 1L;
	
	private static final Logger LOG = Logger.getLogger(BaseSpringController.class);
	
	//leaderboards
	private static final List<User> TOP_USERS = new ArrayList<>();				//top 100 users of all time
	private static final List<User> TOP_WEEKLY_USERS = new ArrayList<>();		//top 100 users with active in the past week
	private static final List<User> TOP_DAILY_USERS = new ArrayList<>();		//top 100 users active in the past day
	
	private static long lastStatsPrune = 0;										//when the last stats prune occurred
	private static boolean statsReady = false;									//whether or not stats are available yet
	private static final int MAX_LIST_SIZE = 100;								//the max number of items to retain in stats lists
	private static final long STATS_INTERVAL = 1000 * 60 * 60;					//how often to prune the daily/weekly lists
	private static final long ONE_DAY = 1000L * 60 * 60 * 24;
	private static final long ONE_WEEK = ONE_DAY * 7;
	
	private static final Map<Locale, Map<String, String>> LOCALIZED_STRINGS = new HashMap<Locale, Map<String, String>>();
	private static String webappBasePath = "";
	
	@EJB
	private UserManager userManager;
	
	static {
		//make log4j work
		BasicConfigurator.resetConfiguration();
		Layout layout = new PatternLayout("%d{HH:mm:ss} [%C{1}] %p:  %m%n");
		Appender appender = new ConsoleAppender(layout);
		appender.addFilter(new LogFilter());
		BasicConfigurator.configure(appender);
	}
	
	private static void initStats() {
		long pastDay = System.currentTimeMillis() - ONE_DAY;
		long pastWeek = System.currentTimeMillis() - ONE_WEEK;
		synchronized(TOP_USERS) {
			//scan the list of users; we do this once at startup
			CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.USERS);
			List<JsonObject> list = db.view("_all_docs").query(JsonObject.class);
			for (JsonObject obj : list) {
				String id = obj.get("id").toString().replace("\"", "");
				User user = new User(db.find(JsonObject.class, id));
				long lastActive = user.getLastLogin().getTime();
				
				addToList(user, TOP_USERS);			//all users are eligible for the TOP_USERS list
				if (lastActive > pastDay) {
					//users active in the past day are eligible for the TOP_DAILY_USERS list
					addToList(user, TOP_DAILY_USERS);
				}
				if (lastActive > pastWeek) {
					//users active in the past week are eligible for the TOP_WEEKLY_USERS list
					addToList(user, TOP_WEEKLY_USERS);
				}
			}
			
			Collections.sort(TOP_USERS, new UserLevelCompare());
			Collections.sort(TOP_DAILY_USERS, new UserLevelCompare());
			Collections.sort(TOP_WEEKLY_USERS, new UserLevelCompare());
			
			statsReady = ! TOP_USERS.isEmpty();
			lastStatsPrune = System.currentTimeMillis();
		}
	}
	
	private static void addToList(User user, List<User> list) {
		if (StringUtilities.isEmpty(user.getNickname())) {
			return;
		}
		synchronized(TOP_USERS) {
			if (list.contains(user)) {
				list.get(list.indexOf(user)).setLastLogin(user.getLastLogin());
				return;
			}
			if (list.size() < MAX_LIST_SIZE) {
				list.add(user);
				if (list.size() == MAX_LIST_SIZE) {
					Collections.sort(list, new UserLevelCompare());
				}
			}
			else {
				User worstUser = list.get(list.size() - 1);
				if (user.getPlayerLevelInt() > worstUser.getPlayerLevelInt()) {
					list.remove(worstUser);
					list.add(user);
					Collections.sort(list, new UserLevelCompare());
				}
			}
		}
	}
	
	private static void pruneList(List<User> list, long cutoffTimestamp) {
		synchronized(TOP_USERS) {
			List<User> survivors = new ArrayList<>();
			for (User user : list) {
				if (user.getLastLogin().getTime() > cutoffTimestamp) {
					survivors.add(user);
				}
			}
			
			list.clear();
			list.addAll(survivors);
		}
	}
	
	private void initEjbs() {
		if (userManager != null) {
			if (TOP_USERS.isEmpty()) {
				initStats();
			}
			return;
		}
		
		try {
			InitialContext ctx = new InitialContext();
			if (userManager == null) {
				userManager = (UserManager) ctx.lookup("java:global/Production_4/UserEJB!com.pokerace.ejb.iface.UserManager");
			}
		}
		catch (Throwable e) {
			e.printStackTrace();
		}
		if (userManager != null && TOP_USERS.isEmpty()) {
			initStats();
		}
	}
	
	public static String getWebappBasePath() {
		return webappBasePath;
	}
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		synchronized(webappBasePath) {
			if ("".equals(webappBasePath)) {
				webappBasePath = config.getServletContext().getRealPath("/");
				LOG.debug("Initialized with webapp base path=" + webappBasePath);
			}
		}
		super.init(config);
	}
	
	@Override
	public void doService(HttpServletRequest request, HttpServletResponse response) throws Exception {
		initEjbs();
		
		//do any required pre-processing here, expose any session-wide state that the application needs to process a request
		if (Configuration.getServerRequiresSecureConnection() && ! request.isSecure()) {
			//FIXME:  causes a redirection loop with HAProxy
			//if our configuration requires HTTPS and the request is not using HTTPS, redirect it
			//String url = request.getRequestURL().substring(request.getRequestURL().indexOf("://") + "://".length());
			//String path = url.contains("/") ? url.substring(url.indexOf("/")) : "";
			//String secureUrl = Configuration.getServerAddress() + path + "?" + request.getQueryString();
			//LOG.warn("Redireting insecure request to:  " + secureUrl);
			//response.sendRedirect(secureUrl);
			//return;
		}
		
		//validate any pre-request authorization constraints, dump the user to the default landing page if they fail
		OverridableHttpRequest overriddenRequest = new OverridableHttpRequest(request);
		String method = request.getParameter(this.getMethodMappingParamName());
		if (! AnnotationUtils.validatePreRequestAnnotations(this.getControllerClass(), method, overriddenRequest, response)) {
			if (request.getSession().getAttribute(Constants.SESSION_USER_KEY) == null) {
				//user is not logged in, so remember their desired URL so that we can redirect them to it if/when they log in
				overriddenRequest.setAttribute(Constants.POST_LOGIN_URL_KEY, getUrl(request));
			}
			overriddenRequest.setParameter(this.getMethodMappingParamName(), Constants.DEFAULT_REQUEST_METHOD);
		}
		
		//ensure that the user in the session is always up to date
		User user = AccessUtils.getCurrentUser(request);
		if (user != null) {
			//refresh with couchdb/EJB?
			user = userManager.getUserDetails(user.getEmail());
			request.setAttribute("user", user);
			request.getSession().setAttribute(Constants.SESSION_USER_KEY, user);
			
			//maintain stats
			if (statsReady && ! TOP_USERS.isEmpty()) {
				synchronized(TOP_USERS) {
					User worst = TOP_USERS.get(TOP_USERS.size() - 1);
					User worstDaily = TOP_DAILY_USERS.isEmpty() ? null : TOP_DAILY_USERS.get(TOP_DAILY_USERS.size() - 1);
					User worstWeekly = TOP_WEEKLY_USERS.isEmpty() ? null : TOP_WEEKLY_USERS.get(TOP_WEEKLY_USERS.size() - 1);
				
					//see if the user displaces any of the current users
					if (user.getPlayerLevelInt() > worst.getPlayerLevel() || TOP_USERS.size() < MAX_LIST_SIZE) {
						addToList(user, TOP_USERS);
						Collections.sort(TOP_USERS, new UserLevelCompare());
					}
					if (worstDaily == null || user.getPlayerLevelInt() > worstDaily.getPlayerLevel() || TOP_USERS.size() < MAX_LIST_SIZE) {
						addToList(user, TOP_DAILY_USERS);
						Collections.sort(TOP_DAILY_USERS, new UserLevelCompare());
					}
					if (worstWeekly == null || user.getPlayerLevelInt() > worstWeekly.getPlayerLevel() || TOP_USERS.size() < MAX_LIST_SIZE) {
						addToList(user, TOP_WEEKLY_USERS);
						Collections.sort(TOP_WEEKLY_USERS, new UserLevelCompare());
					}
					
					if (System.currentTimeMillis() > lastStatsPrune + STATS_INTERVAL) {
						pruneList(TOP_DAILY_USERS, System.currentTimeMillis() - ONE_DAY);
						pruneList(TOP_WEEKLY_USERS, System.currentTimeMillis() - ONE_WEEK);
					}
				}
			}
		}
		
		//process any redirected attributes
		HttpSession session = overriddenRequest.getSession();
		for (String attribName : Collections.list(session.getAttributeNames())) {
			if (attribName.startsWith("__")) {
				overriddenRequest.setAttribute(attribName.substring(2), session.getAttribute(attribName));
				session.removeAttribute(attribName);
			}
		}
		
		//for (Object paramName : overriddenRequest.getParameterMap().keySet()) {
		//	String name = paramName.toString();
		//	if (name.startsWith("__")) {
		//		overriddenRequest.setAttribute(name.substring(2), overriddenRequest.getParameter(name));
		//	}
		//}
		
		request = overriddenRequest;
		
		boolean alreadyCalled = false;
		try {
			Method serviceMethod = this.getControllerClass().getMethod(method, HttpServletRequest.class, HttpServletResponse.class);
			if (AnnotationUtils.doesMethodHaveAnnotation(serviceMethod, SynchronizedPerAccount.class)) {
				
				//this will cause the remainder of the request processing to be synchronized
				
				//TODO:  reimplement for RP, if required
				//synchronized(AccessUtils.getAccountLock(request)) {
					alreadyCalled = true;
					super.doService(request, response);
				//}
			}
			else {
				//don't need to execute synchronously
				alreadyCalled = true;
				super.doService(request, response);
			}
		}
		catch (Exception ignored) {
			//couldn't find the target API method or something else went wrong, just try to proceed normally
			if (! alreadyCalled) {
				super.doService(request, response);
			}
			else {
				LOG.warn("Was unable to process request:  " + request.getRequestURI(), ignored);
				
				//XXX: we won't hit render() if we go through here; so we need to make sure that we clean up the EntityManager, if there was one
				try {
					/*EntityManager em = (EntityManager)request.getAttribute(Constants.ENTITY_MANAGER_REQUEST_KEY);
					if (em != null && em.isOpen()) {
						if (em.getTransaction().isActive()) {
							em.getTransaction().rollback();
						}
						em.close();
						request.removeAttribute(Constants.ENTITY_MANAGER_REQUEST_KEY);
					}*/
				}
				catch (Throwable atThisPointItsHopeless) {
					//do nothing
				}
				
				throw ignored;
			}
		}
	}
	
	@Override
	protected void render(ModelAndView mv, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//do any required post-processing here, expose any commonly-needed params to the destination view
		
		//validate any post-request authorization constraints, dump the user to the login page and end their session if they fail
		String method = request.getParameter(this.getMethodMappingParamName());
		if (! AnnotationUtils.validatePostRequestAnnotations(this.getControllerClass(), method, request, response)) {
			request.setAttribute("error", "Your request could not be processed, please try again");
			request.getSession().removeAttribute(Constants.SESSION_USER_KEY);
			request.getSession().removeAttribute(Constants.SESSION_ACCOUNT_KEY);
			mv = new ModelAndView("login");
		}
		
		//if the client requested a specific data format, redirect to the correct view here
		String format = request.getParameter("format");
		String viewPrefix = StringUtilities.isEmpty(this.getBaseResourcePathPrefix()) ? "" : this.getBaseResourcePathPrefix() + "/";
		viewPrefix += format == null ? "" : format + "/";
		mv.setViewName(viewPrefix + mv.getViewName());
		
		//IE stupidly caches AJAX requests, so set some headers to tell it not to
		if ("ajax".equals(format) || "json".equals(format)) {
			response.addHeader("Cache-Control", "max-age=0,no-cache,no-store,post-check=0,pre-check=0");
			response.addHeader("Expires", "Mon, 26 Jul 1997 05:00:00 GMT");
		}
		
		User user = AccessUtils.getCurrentUser(request);
		if (user != null) {
			//refresh from couch/EJB?
			user = userManager.getUserDetails(user.getEmail());
			request.setAttribute("user", user);
			request.getSession().setAttribute(Constants.SESSION_USER_KEY, user);
		}
		
		//expose the localized strings appropriate to the current locale
		//Locale locale = RequestContextUtils.getLocale(request);
		//Map<String, String> bundle = LOCALIZED_STRINGS.get(locale);
		//if (bundle == null) {
		//	//we haven't processed this locale yet
		//	bundle = new HashMap<String, String>();
		//	ResourceBundle resources = ResourceBundle.getBundle("localization.messages_en_US");
		//	MessageSource localizer = BaseMethods.getMessageSource();
		//	Enumeration<String> keys = resources.getKeys();
		//	while (keys.hasMoreElements()) {
		//		String key = keys.nextElement();
		//		try {
		//			bundle.put(key, localizer.getMessage(key, null, locale));
		//		}
		//		catch (Throwable ignored) {
		//			//exceptions may be thrown if a given bundle does not contain all the keys defined in the en_US one, and for any string that requires params, it is safe to ignore these
		//		}
		//	}
		//	LOCALIZED_STRINGS.put(locale, bundle);
		//}
		//request.setAttribute("messages", bundle);
		
		request.setAttribute("pageName", this.getPageNameForView(mv));							  	  //expose the user-friendly name for the current view
		request.setAttribute("serverHome", Configuration.getServerAddress());						  //expose the server's home address
		
		Exception rethrow = null;
		try {
			super.render(mv, request, response);
		}
		catch (Exception ignored) {
			//nothing we can do at this point, just remember the exception to re-throw later
			rethrow = ignored;
		}
		finally {
			//finally, close the entity-manager for this request, if one is open
		}
		
		//now the the entity-manager is closed, re-throw the exception if we triggered one earlier so that Spring can deal with it
		if (rethrow != null) {
			throw rethrow;
		}
	}
	
	//interface for subclasses to implement
	/**
	 * @return the MultiActionController class that should be used to handle requests that are mapped through this DispatcherServlet.  For 
	 *         instance 'AdminMethods.class' for the admin controller.
	 */
	protected abstract Class<? extends MultiActionController> getControllerClass();
	
	/**
	 * @return the name of the request parameter used to specify which MultiActionController method to invoke.  This must match what has been 
	 *         configured for this dispatcher in spring-servlet.xml.  The standard value is "method".  
	 */
	protected abstract String getMethodMappingParamName();
	
	/**
	 * Used to look up a user-friendly display name for the destination view.
	 * 
	 * @param mv the ModelAndView that will be rendered.
	 * 
	 * @return a String describing the destination view in a user-friendly way, like "Log In", "Register", "Reset Password", etc.. 
	 */
	protected abstract String getPageNameForView(ModelAndView mv);
	
	/**
	 * Allows views to be segregated by controller, if desired.  A subclass can override this to provide 
	 * a prefix that will be used when the controller forwards to any view.  This should be a string like 
	 * 'admin' or 'moderator/views'.
	 * 
	 * Note that the format specifier from the request will be appended to this as well, so that the final path 
	 * might resolve to 'admin/ajax' or 'moderator/views/json', and so on.  The default return value is an empty 
	 * string.
	 * 
	 * The return value should never be null.
	 * 
	 * @return the base path to use when locating resources for this view controller.  The path will be interpreted from WEB-INF/views.  
	 * 		   for example, a value of 'admin' will cause the controller to look for views under 'WEB-INF/views/admin'.
	 */
	protected String getBaseResourcePathPrefix() {
		return "";
	}
	
	private String getUrl(HttpServletRequest req) {
		String paramString = "";
		for (String paramName : req.getParameterMap().keySet()) {
			if (! "".equals(paramString)) {
				paramString += "&";
			}
			paramString += paramName + "=" + req.getParameter(paramName);
		}
		
	    String reqUrl = req.getRequestURL().toString();  //base url
	    if (! StringUtilities.isEmpty(paramString)) {
	    	reqUrl += "?" + paramString;
	    }
	    return reqUrl;
	}
	
	private static class LogFilter extends Filter {
		private static final Map<String, Integer> DECISION_MAP = new ConcurrentHashMap<String, Integer>(1024);
		
		/**
		 * Constructor
		 */
		public LogFilter() {
			//no initialization needed
		}
		
		@Override
		public int decide(LoggingEvent event) {
			if (! Configuration.getDebugEnabled()) {
				//if debugging is not enabled, then decide purely based upon the log level
				return event.getLevel().toInt() >= Level.WARN_INT ? ACCEPT : DENY;
			}
			
			if (event.getLevel().toInt() >= Level.WARN_INT) {
				//log warning and above from all classes
				return ACCEPT;
			}
			
			//check for a cached decision
			String className = event.getLocationInformation().getClassName();
			if (DECISION_MAP.containsKey(className)) {
				return DECISION_MAP.get(className);
			}
			
			//modify this to exclude different types/levels of logger messages
			if (className.contains("au.com.suncoastpc")) {
				//log all internal messages
				DECISION_MAP.put(className, ACCEPT);
				return ACCEPT;
			}
			
			//ignore any other messages
			DECISION_MAP.put(className, DENY);
			return DENY;
		}
	}
	
	private static List<User> sublist(List<User> list, int num) {
		if (! statsReady) {
			return Collections.emptyList();
		}
		if (num > list.size()) {
			num = list.size();
		}
		synchronized(TOP_USERS) {
			return list.subList(0,  num);
		}
	}
	
	public static List<User> getTopPlayers(int num) {
		return sublist(TOP_USERS, num);
	}
	public static List<User> getTopDailyPlayers(int num) {
		return sublist(TOP_DAILY_USERS, num);
	}
	public static List<User> getTopWeeklyPlayers(int num) {
		return sublist(TOP_WEEKLY_USERS, num);
	}
}