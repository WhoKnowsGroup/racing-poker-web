package au.com.suncoastpc.auth.spring.base;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.lightcouch.CouchDbClient;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import au.com.suncoastpc.auth.annotations.ForbidsLogin;
import au.com.suncoastpc.auth.filter.InputSanitizerFilter;
import au.com.suncoastpc.auth.util.AccessUtils;
import au.com.suncoastpc.auth.util.EscapeUtility;
import au.com.suncoastpc.util.CouchDBUtil;
import au.com.suncoastpc.util.types.CouchDatabase;

/**
 * Provides a handful of default method implementations that need to be accessible through any 
 * MultiActionController instance, namely login and indexPage.
 * 
 * @author Adam
 */
public abstract class BaseMethods extends MultiActionController implements MessageSourceAware {
	protected MessageSource localizedStrings;
	private static MessageSource staticLocalizedStrings;  //XXX:  minor hack
	
	/**
	 * Forward the user to the default landing page, depending upon whether or not they are currently logged in.
	 *
	 * @param request the http request object.
	 * @param response the http response object.
	 *
	 * @return the index page if the user currently holds a valid session, or the login page otherwise.
	 *
	 * @throws ServletException
	 * @throws IOException
	 */
	public ModelAndView indexPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//XXX:  all users go to the same index (or redirect logged-in users to /home?)
		//if the user is logged in, send them to the post-login landing page, otherwise send them to the login page
		//if (isUserLoggedIn(request)) {
		//	request.setAttribute("user", AccessUtils.getCurrentUser(request));
		//	return new ModelAndView("index");
		//}
		//no current user, go to login page
		//return login(request, response);
		
		//combined index page for logged-in and anonymous users
		if (AccessUtils.getCurrentUser(request) != null) {
			response.sendRedirect("/u/home");
			return null;
		}
		
		//XXX:  are we meant to return the total number of registered users, or just the count of users currently active?
		long numUsers = 0;
		long numTournaments = 0;
		
		try {
			CouchDbClient client = CouchDBUtil.getClient(CouchDatabase.USERS);
			numUsers = client.context().info().getDocCount();
		
			client = CouchDBUtil.getClient(CouchDatabase.TOURNAMENTS);
			numTournaments = client.context().info().getDocCount();
		}
		catch (Throwable e) {
			e.printStackTrace();
		}
		
		request.setAttribute("numUsers", numUsers);
		request.setAttribute("numTournaments", numTournaments);
		
		//XXX:  are we meant to return the total number of tournaments that exist, ot just the currently active ones?
		//client = CouchDBUtil.getClient(CouchDatabase.RUNNING_TOURNAMENTS);
		
		request.setAttribute("user", AccessUtils.getCurrentUser(request));
		return new ModelAndView("indexV2");
	}
	
	/**
	 * Display the login page, or the use user is already logged in, go to the default landing page.
	 *
	 * @param request the http request object.
	 * @param response the http response object.
	 *
	 * @return the login page, or the default landing page if the user is already logged in.
	 *
	 * @throws ServletException
	 * @throws IOException
	 */
	@ForbidsLogin
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("login");
	}
	
	//utilities
	protected boolean isUserLoggedIn(HttpServletRequest request) {
		return AccessUtils.getCurrentUser(request) != null;
	}
	
	protected void echoParamsAsAttribs(HttpServletRequest request, String... paramNames) {
		for (String name : paramNames) {
			request.setAttribute(name, EscapeUtility.escapeMarkupChars(request.getParameter(name)));
		}
	}
	
	@SuppressWarnings("unchecked")
	protected void echoQuarantinedParamsAsAttribs(HttpServletRequest request, String... paramNames) {
		Map<String, String> quarantine = (Map<String, String>)request.getAttribute(InputSanitizerFilter.QUARANTINE_ATTRIBUTE_NAME);
		for (String name : paramNames) {
			String value = quarantine.get(name);
			if (value != null) {
				request.setAttribute(name, EscapeUtility.escapeMarkupChars(value));
			}
		}
	}
	
	@Override
	public void setMessageSource(MessageSource source) {
		this.localizedStrings = source;
		staticLocalizedStrings = source;
	}
	
	public static MessageSource getMessageSource() {
		return staticLocalizedStrings;
	}
}
