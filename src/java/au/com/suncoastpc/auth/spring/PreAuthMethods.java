package au.com.suncoastpc.auth.spring;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.StringTokenizer;

import javax.ejb.EJB;
import javax.naming.InitialContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.lightcouch.CouchDbClient;
import org.springframework.web.servlet.ModelAndView;

import au.com.suncoastpc.auth.annotations.BypassesQuarantine;
import au.com.suncoastpc.auth.annotations.EchoesParameters;
import au.com.suncoastpc.auth.annotations.ForbidsLogin;
import au.com.suncoastpc.auth.spring.base.BaseMethods;
import au.com.suncoastpc.auth.spring.base.BaseSpringController;
import au.com.suncoastpc.auth.util.AccessUtils;
import au.com.suncoastpc.auth.util.Constants;
import au.com.suncoastpc.auth.util.CookieUtil;
import au.com.suncoastpc.auth.util.EmailUtility;
import au.com.suncoastpc.auth.util.StringUtilities;
import au.com.suncoastpc.conf.Configuration;
import au.com.suncoastpc.util.CouchDBUtil;
import au.com.suncoastpc.util.types.CouchDatabase;

import com.google.gson.JsonObject;
import com.pokerace.ejb.iface.SocketManager;
import com.pokerace.ejb.iface.TournamentManager;
import com.pokerace.ejb.iface.UserManager;
import com.pokerace.ejb.model.Tournament;
import com.pokerace.ejb.model.User;

/**
 * This class contains controller logic for pre-auth requests and API calls.
 * 
 * @author Adam
 */
public class PreAuthMethods extends BaseMethods {
	private static final Logger LOG = Logger.getLogger(PreAuthMethods.class);

	private static final String UNKNOWN_FACEBOOK_DOMAIN = "@unknown.facebook.com";
	private static final String UNKNOWN_GOOGLE_DOMAIN = "@unknown.google.com";

	private static final int DEFAULT_CREDITS = 10000;
	
	private static final int NUM_LEADERBOARD_PLAYERS = 25;

	@EJB
	private UserManager userManager;

	@EJB
	private SocketManager socketManager;

	@EJB
	private TournamentManager tournamentManager;

	private int playersHitCount = 0;
	private int tournamentHitCount = 0;

	private void initEjbs() {
		try {
			InitialContext ctx = new InitialContext();
			if (userManager == null) {
				userManager = (UserManager) ctx.lookup("java:global/Production_4/UserEJB!com.pokerace.ejb.iface.UserManager");
			}
			if (tournamentManager == null) {
				tournamentManager = (TournamentManager) ctx.lookup("java:global/Production_4/TournamentEJB!com.pokerace.ejb.iface.TournamentManager");
			}
			if (socketManager == null) {
				socketManager = (SocketManager) ctx.lookup("java:global/Production_4/SocketEJB!com.pokerace.ejb.iface.SocketManager");
			}
		}
		catch (Throwable e) {
			e.printStackTrace();
		}
	}

	@Override
	protected void initServletContext(ServletContext sc) {
		initEjbs();
	}
	
	public ModelAndView registrationPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (AccessUtils.getCurrentUser(request) != null) {
			response.sendRedirect("/");
			return null;
		}
		
		return new ModelAndView("register");
	}
	
	public ModelAndView learnGame(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("learnGame");
	}
	
	public ModelAndView support(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("support");
	}
	
	public ModelAndView about(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("about");
	}
	
	@EchoesParameters(paramNames="selectedTab")
	public ModelAndView legals(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("legals");
	}
	
	public ModelAndView guestMode(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (AccessUtils.getCurrentUser(request) != null) {
			//authenticated users should not have access to the guest-mode page
			response.sendRedirect(Configuration.getServerAddress() + "/u/home");
			return null;
		}
		
		return new ModelAndView("guestMode");
	}
	
	public ModelAndView guestModeV2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (AccessUtils.getCurrentUser(request) != null) {
			//authenticated users should not have access to the guest-mode page
			response.sendRedirect(Configuration.getServerAddress() + "/u/home");
			return null;
		}
		
		return new ModelAndView("guestModeV2");
	}

	@ForbidsLogin
	public ModelAndView recoverPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		User user = userManager.getUserDetails(email);
		if (user != null) {
			String token = request.getParameter("token");
			String authToken = user.getAuthToken();

			if (!StringUtilities.isEmpty(token) && token.equalsIgnoreCase(authToken)) {
				user.setAuthToken(null);
				userManager.update(user);

				request.getSession().setAttribute(Constants.SESSION_USER_KEY, user);
				CookieUtil.setCookie("username", email, Configuration.getHttpTimeoutMinutes() * 60 * 1000, response);

				// FIXME: ideally we should force the 'pasword reset' UI to show
				response.sendRedirect(Configuration.getServerAddress() + "/profile.html");
				return null;
			}
		}

		return indexPage(request, response);
	}

	// was: @WebServlet(urlPatterns = {"/Verification"})
	@SuppressWarnings("unchecked")
	public ModelAndView verify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		User user = userManager.getUserDetails(email);
		JSONObject json = new JSONObject();
		if (user != null) {
			// FIXME: verification token not available via the 'User' object
			String token = request.getParameter("token");
			String verify_token = user.getVerifyToken();

			if (token.equalsIgnoreCase(verify_token) && ! user.isVerifyEmail()) {
				user.setVerifyEmail(true);
				userManager.update(user);

				request.getSession().setAttribute(Constants.SESSION_USER_KEY, user);
				CookieUtil.setCookie("username", email, Configuration.getHttpTimeoutMinutes() * 60 * 1000, response);

				json.put("result", "success");
			}
			else {
				json.put("result", "failed");
			}
		}
		else {
			json.put("result", "failed");
		}

		request.setAttribute("json", json);
		// return new ModelAndView("json/legacyJsonView");
		return indexPage(request, response);
	}

	// was: @WebServlet(urlPatterns = {"/UserRegister"})
	@SuppressWarnings("unchecked")
	@ForbidsLogin
	public ModelAndView register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, InvalidKeySpecException, NoSuchAlgorithmException {
		// initEjbs();
		CouchDbClient db1 = CouchDBUtil.getClient(CouchDatabase.KENTUCKY_USERS);
		CouchDbClient db2 = CouchDBUtil.getClient(CouchDatabase.BOTS);
		JSONObject obj = new JSONObject();
		JSONObject obj1 = new JSONObject();
		String email = "";
		String password = "";
		String firstname = "";
		String lastname = "";
		String nickname = "";
		String gender = "";
		String yearParam = "";
		long credits = DEFAULT_CREDITS;
		boolean nickname_result = true;
		int count = 0;
		System.out.println(" in the user_register");
		String register = request.getParameter("register");

		StringTokenizer sub_boxes = new StringTokenizer(register);

		while (sub_boxes.hasMoreTokens()) {
			String token = sub_boxes.nextToken();
			// views.add(token);
			if (count == 0)
				email = token;
			if (count == 1)
				password = token;
			if (count == 2)
				firstname = token;
			if (count == 3)
				lastname = token;
			if (count == 4)
				nickname = token;
			if (count == 5)
				gender = token;
			if (count == 6)
				yearParam = token;
			//if (count == 7)
			//	credits = DEFAULT_CREDITS;
			System.out.println(token);
			count++;
		}
		try {

			System.out.println(" the writer");
			nickname = nickname.toLowerCase();
			System.out.println(nickname);
			obj1.put("_id", nickname);
			obj1.put("User_type", "realuser");
			db1.save(obj1);
		}
		catch (Exception e) {
			System.out.println(e);
			JsonObject obj2 = db1.find(JsonObject.class, nickname);
			System.out.println(obj2);
			String usertype = obj2.get("User_type").toString().replace("\"", "");

			if (usertype.equalsIgnoreCase("botuser")) {
				obj2.addProperty("User_type", "realuser");
				db1.update(obj2);
				String email_id = nickname + "@kentuckypoker.vegas";
				JsonObject obj3 = db2.find(JsonObject.class, email_id);
				db2.remove(obj3);
				// db1.remove(nickname, gender);

			}
			else {
				System.out.println("Real user");
				obj.put("result", "error");
				obj.put("message", "nickname");
				nickname_result = false;
			}
		}
		// aroth: this should be unnecessary and is probably even incorrect
		// db1.shutdown();
		// CouchDBUtil.shutdownClient(CouchDatabase.KENTUCKY_USERS);
		// db2.shutdown();
		// CouchDBUtil.shutdownClient(CouchDatabase.BOTS);
		System.out.print(nickname);
		if (nickname_result) {
			User user = new User(email, password, firstname, lastname, nickname, gender);
			user.setCredits(credits);
			
			//set age group and default audio preferences
			String ageGroup = request.getParameter("age");
			String yearOfBirth = request.getParameter("birthYear");
			if (StringUtils.isEmpty(yearOfBirth) && ! StringUtils.isEmpty(yearParam)) {
				yearOfBirth = yearParam;
			}
			
			user.setMusicEnabled(false);
			user.setSpeechEnabled(false);
			if (! "-1".equals(ageGroup)) {
				//user.setSelectedAgeGroup(ageGroup);
			}
			
			if (! "-1".equals(yearOfBirth)) {
				try {
					int year = Integer.parseInt(yearOfBirth);
					int calYear = Calendar.getInstance().get(Calendar.YEAR);
					if (calYear < 1000) {
						calYear += 1900;
					}
					
					if (year >= 1900 && year <= calYear) {
						user.setYearOfBirth(year);
					}
				}
				catch (Throwable ignored) { }
			}
			
			if (userManager.register(user)) {
				if (sendRegistrationEmail(userManager, user.getEmail()))
					;
				obj.put("result", "success");
				
				try {
					user = userManager.authenticate(email, password, "Unknown/RP-Registration");

					if (user != null) {
						loginUser(request, response, user);
						obj.put("user_type", user.getUserType());
					}
				}
				catch (Exception e) {
					System.out.println(e);
					obj.put("result", "failed");
				}
			}
			else {
				System.out.print("in user error");
				obj.put("result", "error");
				obj.put("message", "email");
			}
		}
		else {
			System.out.print("in user error");
			obj.put("result", "error");
			obj.put("message", "nickname");

		}

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Tournament_list"})
	@SuppressWarnings("unchecked")
	public ModelAndView listTournaments(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject obj = new JSONObject();
		String sorted_coins = "";
		String sorted_coins1 = "";
		List<String> high_list = new ArrayList<String>();
		List<String> mid_list = new ArrayList<String>();
		List<String> low_list = new ArrayList<String>();
		List<String> one_list = new ArrayList<String>();
		List<String> pot_list = new ArrayList<String>();
		List<String> pot_sorted = new ArrayList<String>();
		List<String> multi_list = new ArrayList<String>();
		System.out.println("in the servlet");
		try {
			CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.ACTIVE_TOURNAMENTS);
			List<JsonObject> list = db.view("_all_docs").query(JsonObject.class);

			int count = list.size();
			if (count > 0) {
				for (JsonObject json : list) {
					System.out.println(json.toString());
					String token = json.get("id").toString().replace("\"", "");
					JsonObject json1 = db.find(JsonObject.class, token);
					String coins = json1.get("starting_credit_points").toString().replace("\"", "");
					String allowed_players = json1.get("Number_of_MaxPlayers").toString().replace("\"", "");
					String no_of_games = json1.get("Number_of_games").toString().replace("\"", "");
					String type = json1.get("Type").toString().replace("\"", "");
					if (type.equalsIgnoreCase("Multi_Level")) {
						high_list.add(token + "," + coins + "," + allowed_players + "," + no_of_games);
						sorted_coins += coins + ",";
					}
					if (type.equalsIgnoreCase("Mid_Level_Tournament"))
						mid_list.add(token + "," + coins + "," + allowed_players + "," + no_of_games);
					if (type.equalsIgnoreCase("Low_Level_Tournament"))
						low_list.add(token + "," + coins + "," + allowed_players + "," + no_of_games);
					if (type.equalsIgnoreCase("One_player_level"))
						one_list.add(token + "," + coins + "," + allowed_players + "," + no_of_games);
					if (type.equalsIgnoreCase("Pot_poker")) {
						String required_bitlets = json1.get("Required_bitlets").toString().replace("\"", "");
						pot_list.add(token + "," + coins + "," + allowed_players + "," + no_of_games + "," + required_bitlets);
						sorted_coins1 += coins + ",";
					}

				}
				String[] asec = sorted_coins.split(",");
				System.out.println(asec[0] + asec[1] + asec[2] + asec.length);
				for (int h = 0; h < asec.length; h++) {
					System.out.println(h);
					for (int k = 0; k < asec.length - h - 1; k++) {
						System.out.println(k);
						if (Double.parseDouble(asec[k]) > Double.parseDouble(asec[k + 1])) {
							String temp = asec[k];
							asec[k] = asec[k + 1];
							asec[k + 1] = temp;
						}
					}
				}
				System.out.println(asec[0] + asec[1] + asec[2] + asec.length);
				String[] asec_or1 = sorted_coins.split(",");
				for (String asec_or : asec) {

					for (int k = 0; k < asec_or1.length; k++) {
						if (asec_or.equals(asec_or1[k])) {
							multi_list.add(high_list.get(k));
						}
					}
				}
				asec = sorted_coins1.split(",");
				System.out.println(asec[0] + asec[1] + asec[2] + asec.length);
				for (int h = 0; h < asec.length; h++) {
					System.out.println(h);
					for (int k = 0; k < asec.length - h - 1; k++) {
						System.out.println(k);
						if (Double.parseDouble(asec[k]) > Double.parseDouble(asec[k + 1])) {
							String temp = asec[k];
							asec[k] = asec[k + 1];
							asec[k + 1] = temp;
						}
					}
				}
				System.out.println(asec[0] + asec[1] + asec[2] + asec.length);
				asec_or1 = sorted_coins1.split(",");
				for (String asec_or : asec) {

					for (int k = 0; k < asec_or1.length; k++) {
						if (asec_or.equals(asec_or1[k])) {
							pot_sorted.add(pot_list.get(k));
						}
					}
				}
				obj.put("result", "success");
				obj.put("Multi_list", multi_list);
				obj.put("Mid_list", mid_list);
				obj.put("Low_list", low_list);
				obj.put("One_list", one_list);
				obj.put("Pot_list", pot_sorted);
				obj.put("HitCount", ++tournamentHitCount);
			}
		}
		catch (Exception e) {
			System.out.println(e);
		}

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Tournament_find"})
	@SuppressWarnings("unchecked")
	public ModelAndView findTournament(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// initEjbs();

		JSONObject obj = new JSONObject();
		String tournament_id = request.getParameter("tournament_id");
		System.out.println(tournament_id);
		tournament_id = tournament_id.replaceAll("\"", "");
		Tournament tournament = tournamentManager.findTournament(tournament_id);
		String tournament_details = tournament == null ? null : tournament.toJsonString();
		obj.put("tournament_detail", tournament_details);
		obj.put("result", "success");

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Top_shots"})
	@SuppressWarnings("unchecked")
	public ModelAndView topShots(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String selected_shot_type = request.getParameter("Shot_type");

		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.SHOTS);

		JsonObject json = db.find(JsonObject.class, "0");
		String playernames = json.get(selected_shot_type + "_" + "players").toString().replace("\"", "");
		String shots = json.get(selected_shot_type).toString().replace("\"", "");
		JSONObject json1 = new JSONObject();
		json1.put("Playernames", playernames);
		json1.put("Shots", shots);

		request.setAttribute("json", json1);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Top_players"})
	@SuppressWarnings("unchecked")
	public ModelAndView topPlayers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject obj = new JSONObject();
		CouchDbClient db3 = CouchDBUtil.getClient(CouchDatabase.TOP_50_PLAYERS);
		int j = 0;
		List<JsonObject> list = db3.view("_all_docs").query(JsonObject.class);
		int size = list.size();
		String level = "";
		String names = "";
		for (j = 0; j < size; j++) {
			try {
				JsonObject json1 = db3.find(JsonObject.class, Integer.toString(j));
				level = json1.get("Levels").toString().replace("\"", "");
				names = json1.get("Names").toString().replace("\"", "");
			}
			catch (Exception e) {
				// System.out.println(e);
			}
		}
		
		List<User> top = BaseSpringController.getTopPlayers(NUM_LEADERBOARD_PLAYERS);
		List<User> topDaily = BaseSpringController.getTopDailyPlayers(NUM_LEADERBOARD_PLAYERS);
		List<User> topWeekly = BaseSpringController.getTopWeeklyPlayers(NUM_LEADERBOARD_PLAYERS);
		
		//FIXME:  refactor replicated code
		JSONArray topList = new JSONArray();
		for (User user : top) {
			JSONObject json = new JSONObject();
			json.put("name", user.getNickname());
			json.put("level", user.getLevelName());
			json.put("avatar", user.getAvatarUrl());
			
			topList.add(json);
		}
		
		JSONArray dayList = new JSONArray();
		for (User user : topDaily) {
			JSONObject json = new JSONObject();
			json.put("name", user.getNickname());
			json.put("level", user.getLevelName());
			json.put("avatar", user.getAvatarUrl());
			
			dayList.add(json);
		}
		
		JSONArray weekList = new JSONArray();
		for (User user : topWeekly) {
			JSONObject json = new JSONObject();
			json.put("name", user.getNickname());
			json.put("level", user.getLevelName());
			json.put("avatar", user.getAvatarUrl());
			
			weekList.add(json);
		}
		
		//also send shots
		//FIXME:  we should cache this and re-evaulate each hour
		JSONArray shotList = new JSONArray();
		Set<String> seenPlayers = new HashSet<>();
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.SHOTS);
		JsonObject shotData = db.find(JsonObject.class, "0");
		for (int shotNum = 10; shotNum >= 4; shotNum--) {
			String shotType = shotNum + "shots";
			String[] playerNames = shotData.get(shotType + "_players").toString().replace("\"", "").split("\\,");
			String[] numShots = shotData.get(shotType).toString().replace("\"", "").split("\\,");
			for (int index = 0; index < playerNames.length; index++) {
				String player = playerNames[index];
				if (! seenPlayers.contains(player)) {
					JSONObject json = new JSONObject();
					json.put("name", player);
					json.put("shotType", shotType);
					json.put("numShots", numShots[index]);
					
					shotList.add(json);
					seenPlayers.add(player);
				}
				
				if (shotList.size() >= NUM_LEADERBOARD_PLAYERS) {
					break;
				}
			}
		}

		obj.put("Levels", level);
		obj.put("Names", names);
		obj.put("HitCount", ++playersHitCount);
		obj.put("topPlayers", topList);
		obj.put("dailyPlayers", dayList);
		obj.put("weeklyPlayers", weekList);
		obj.put("topShots", shotList);

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Socialwebsite_userregistration"})
	@SuppressWarnings("unchecked")
	@ForbidsLogin
	public ModelAndView socialRegistration(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSuchAlgorithmException, InvalidKeySpecException {
		// initEjbs();

		CouchDbClient db1 = CouchDBUtil.getClient(CouchDatabase.KENTUCKY_USERS);
		CouchDbClient db2 = CouchDBUtil.getClient(CouchDatabase.BOTS);
		JSONObject obj = new JSONObject();
		JSONObject obj1 = new JSONObject();
		String email = "";
		String password = "";
		String firstname = "";
		String lastname = "";
		String nickname = "";
		String gender = "";
		long credits = 5000;
		int count = 0;
		System.out.println(" in the user_register");
		String register = request.getParameter("register");

		StringTokenizer sub_boxes = new StringTokenizer(register);

		while (sub_boxes.hasMoreTokens()) {
			String token = sub_boxes.nextToken();
			// views.add(token);
			if (count == 0)
				email = token;
			if (count == 1)
				password = token;
			if (count == 2)
				firstname = token;
			if (count == 3)
				lastname = token;
			if (count == 4)
				nickname = token;
			if (count == 5)
				gender = token;
			if (count == 6)
				credits = 5000;
			System.out.println(token);
			count++;
		}
		try {
			System.out.println(" the writer");
			// user_register = new User_register();\
			nickname = nickname.toLowerCase();
			System.out.println(nickname);
			obj1.put("_id", nickname);
			obj1.put("User_type", "realuser");
			db1.save(obj1);
		}
		catch (Exception e) {
			System.out.println(e);

			JsonObject obj2 = db1.find(JsonObject.class, nickname);
			System.out.println(obj2);
			String usertype = obj2.get("User_type").toString().replace("\"", "");

			if (usertype.equalsIgnoreCase("botuser")) {
				obj2.addProperty("User_type", "realuser");
				db1.update(obj2);
				String email_id = nickname + "@kentuckypoker.vegas";
				JsonObject obj3 = db2.find(JsonObject.class, email_id);
				db2.remove(obj3);
				// db1.remove(nickname, gender);

			}
			else {
				obj.put("result", "error");
				obj.put("message", "nickname");
			}
		}

		System.out.print(nickname);
		User user = new User(email, password, firstname, lastname, nickname, gender);
		user.setCredits(credits);
		if (userManager.register(user)) {
			System.out.print("in user registration");
			if (sendSocialRegistrationEmail(email))
				;
			obj.put("result", "success");

		}
		else {
			System.out.print("in user error");
			obj.put("result", "error");
			obj.put("message", "email");
		}

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Resendlink"})
	@SuppressWarnings("unchecked")
	@ForbidsLogin
	public ModelAndView resendVerficationLink(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		JSONObject obj = new JSONObject();
		if (resendVerificationEmail(username)) {
			obj.put("result", "success");
		}
		else
			obj.put("result", "failed");

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Recent_winners"})
	@SuppressWarnings("unchecked")
	public ModelAndView recentWinners(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject obj = new JSONObject();
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.TOURNAMENT_RANKING);
		List<JsonObject> list = db.view("_all_docs").query(JsonObject.class);
		int count = 0;
		String names = "";
		String Player_level = "";
		String rank_players = "";
		String[] players = new String[25];
		String[] player_levels = new String[25];
		String[] rank_levels = new String[25];
		for (int i = 0; i < 25; i++) {
			players[i] = "";
		}
		int count11 = 0;
		int j = 0;
		if (list.size() > 25) {
			count = list.size() - 25;
			for (count = list.size() - 25; count < list.size(); count++) {
				count11 = 0;
				JsonObject rank_users = db.find(JsonObject.class, Integer.toString(count));
				// System.out.println(count);
				String name = rank_users.get("Nickname").toString().replace("\"", "");
				String level = rank_users.get("playerlevel").toString().replace("\"", "");
				String rank = rank_users.get("rank").toString().replace("\"", "");
				for (int i = 0; i < 25; i++) {
					if (players[i].equalsIgnoreCase(name)) {
						player_levels[i] = level;
						rank_levels[i] = rank;
						count11++;
					}
				}

				if (count11 == 0) {
					players[j] = name;
					player_levels[j] = level;
					rank_levels[j] = rank;
					j++;
				}

			}
		}
		else {
			int length = list.size();

			for (int i = 1; i <= length; i++) {
				JsonObject rank_users = db.find(JsonObject.class, Integer.toString(i));
				String name = rank_users.get("Nickname").toString().replace("\"", "");
				String level = rank_users.get("playerlevel").toString().replace("\"", "");
				String rank = rank_users.get("rank").toString().replace("\"", "");

				names += name + ",";
				Player_level += level + ",";
				rank_players += rank + ",";

			}
		}
		for (int k = 0; k < j; k++) {
			names += players[k] + ",";
			Player_level += player_levels[k] + ",";
			rank_players += rank_levels[k] + ",";
		}

		obj.put("Players", names);
		obj.put("level", Player_level);
		obj.put("rank", rank_players);

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Logout"})
	@SuppressWarnings("unchecked")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = AccessUtils.getCurrentUser(request);
		request.getSession().removeAttribute(Constants.SESSION_USER_KEY);

		if (user != null && !StringUtilities.isEmpty(user.getEmail())) {
			try {
				//request.getContextPath();
				
				//FIXME:  does this code even do anything?
				//CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.USERS);

				//JsonObject json = db.find(JsonObject.class, user.getEmail());
				//String revision = json.get("_rev").toString().replace("\"", "");
				//json.addProperty("_rev", revision);
				// json.addProperty("Last_login",date.toString());
				//db.update(json);

			}
			catch (Exception e) {
				System.out.println(e);
				// obj.put("result", "success");
			}
		}

		JSONObject obj = new JSONObject();
		HttpSession session = request.getSession(false);
		Cookie[] cook = request.getCookies();
		try {
			for (Cookie c1 : cook) {
				c1.setValue(null);
				c1.setMaxAge(0);
				response.addCookie(c1);
			}
			System.out.println(session);
			if (session != null)
				session.invalidate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		obj.put("result", "success");
		// String location = "index.html";
		// response.sendRedirect(location);

		request.setAttribute("json", obj);

		// return new ModelAndView("json/legacyJsonView");
		// return indexPage(request, response);
		response.sendRedirect(Configuration.getServerAddress() + "/r/indexPage");
		return null;
	}

	// was: @WebServlet(urlPatterns = {"/Login_form"})
	public ModelAndView loginPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// XXX: returns an empty json-object
		request.setAttribute("json", new JSONObject());
		return new ModelAndView("json/legacyJsonView");
	}

	private void loginUser(HttpServletRequest request, HttpServletResponse response, User user) {
		HttpSession session = request.getSession(false); // FIXME: 'false' not necessary once session/cookie handling is fixed
		// confirmUserHasVerified(email); //XXX: this call appears pointless and/or broken

		// FIXME: this session/cookie handling is not sane; to fix it we have to update everywhere that uses the 'username' cookie (including JavaScript code!)
		if (session != null) {
			boolean session_id_validate = request.isRequestedSessionIdValid();
			if (session_id_validate) {
				Cookie cookie = new Cookie("username", user.getEmail());
				response.addCookie(cookie);
				System.out.println("valid session");
			}
			else {

				Cookie[] cook = request.getCookies();
				for (Cookie c1 : cook) {
					c1.setValue(null);
					c1.setMaxAge(0);
					response.addCookie(c1);
				}
				session.invalidate();
				System.out.println("session Invalidated");
				session = request.getSession(true);
				session.setMaxInactiveInterval(Configuration.getHttpTimeoutMinutes() * 60);
				Cookie cookie = new Cookie("username", user.getEmail());
				response.addCookie(cookie);
			}

			session.setAttribute(Constants.SESSION_USER_KEY, user);
		}
		else {
			// System.out.println(session);
			// session.setAttribute("UserName", email);
			session = request.getSession(true);
			session.setMaxInactiveInterval(Configuration.getHttpTimeoutMinutes() * 60);
			System.out.println(" Session generated");
			Cookie cookie = new Cookie("username", user.getEmail());
			response.addCookie(cookie);

			session.setAttribute(Constants.SESSION_USER_KEY, user);
		}
		// sendLoginEmail(email);
	}

	// was: @WebServlet(urlPatterns = {"/Login"})
	@SuppressWarnings("unchecked")
	@BypassesQuarantine(paramNames = "password")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// initEjbs();

		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String userAgent = request.getParameter("userAgent");
		JSONObject obj = new JSONObject();
		try {
			User user = userManager.authenticate(email, password, userAgent);

			if (user == null) {
				obj.put("result", "failed");
			}
			else {
				loginUser(request, response, user);
				obj.put("result", "success");
				obj.put("user_type", user.getUserType());
			}

		}
		catch (Exception e) {
			System.out.println(e);
			obj.put("result", "failed");
		}

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: /hand (see original web.xml) hand.java
	//FIXME:  appears unused
	@SuppressWarnings("unchecked")
	public ModelAndView hand(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// initEjbs();

		JSONObject obj = new JSONObject();
		try {
			String msg = "1" + "," + "2" + "," + "3" + "," + "4" + "," + "5000" + "," + "tupas_gang" + "," + "23";
			String hand = socketManager.connectSocket(msg);
			obj.put("hand", hand);
		}
		catch (Exception e) {
			System.out.println(e);
		}

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: /FrontControl (see original web.xml) FrontControl.java
	// used by JavaScript to route a variety of actions, notably login operations
	@SuppressWarnings("unchecked")
	public ModelAndView frontControl(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// initEjbs();

		try {

			boolean session_id_validate = false;
			HttpSession session = request.getSession(false);
			// System.out.println(session);
			if (session != null) {
				session_id_validate = request.isRequestedSessionIdValid();
				System.out.println(session_id_validate);
			}
			else {
				String command = "";
				JSONObject obj1 = new JSONObject();
				command = request.getParameter("command");
				if (command.equals("clicked")) {
					// HttpSession session = request.getSession();
					System.out.println("in clicked");
					String clicked = request.getParameter("clicked");
					System.out.print(clicked);
					clicked = clicked.replaceAll("\"", "");
					// session.setAttribute("tournament_id", clicked);
					Cookie cookie = new Cookie("clicked", clicked);
					response.addCookie(cookie);

					obj1.put("result", "success");
					request.setAttribute("json", obj1);
					// response.sendRedirect("Tournament_details.html");
				}
				else
					routeFrontControlRequest(request, response);
			}
			if (session_id_validate == true) {

				// dispatch(request,response);
				String command = "";
				User user = null;
				JSONObject obj1 = new JSONObject();
				command = request.getParameter("command");
				
				request.setAttribute("json", obj1);

				if (command.equals("clicked")) {
					// HttpSession session = request.getSession();
					System.out.println("in clicked");
					String clicked = request.getParameter("clicked");
					System.out.print(clicked);
					clicked = clicked.replaceAll("\"", "");
					session.setAttribute("tournament_id", clicked);
					Cookie cookie = new Cookie("clicked", clicked);
					response.addCookie(cookie);
					
					obj1.put("result", "success");
				}
				else {
					if (command.equals("user_details")) {
						//user_name = request.getParameter("username");
						user = AccessUtils.getCurrentUser(request);//userManager.getUserDetails(user_name);
						if (user != null) {
							obj1.put("user_detail", user.toCsv() + "," + user.isVerifyEmail());
							obj1.put("result", "success");
						}
						else {
							obj1.put("result", "error");
						}
					}
					else {
						if (command.equals("verify")) {
							//user_name = request.getParameter("username");
							user = AccessUtils.getCurrentUser(request);//userManager.getUserDetails(user_name);
							if (user != null) {
								obj1.put("user_detail", user.toCsv());
								obj1.put("result", "success");
							}
						}
						else {
							routeFrontControlRequest(request, response);
						}
					}
				}
			}
		}
		catch (Throwable e) {
			e.printStackTrace();
		}

		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Forgotpassword"})
	@SuppressWarnings("unchecked")
	public ModelAndView forgotPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		JSONObject obj = new JSONObject();
		try {
			User user = userManager.getUserDetails(email);
			if (user != null) {
				Boolean valu = sendForgotPasswordEmail(email);
				if (valu) {
					obj.put("result", "success");
				}
				else {
					obj.put("result", "Failed");
				}
			}
			else {
				obj.put("result", "Failed");
			}
		}
		catch (Exception e) {
			System.out.println(e);
			obj.put("result", "Failed");
		}

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/FacebookShareResult"})
	public ModelAndView facebookShareResult(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject obj = new JSONObject();
		String tournament_id = request.getParameter("tournament_id");
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.TOURNAMENT_RESULTS);
		JsonObject json = db.find(JsonObject.class, tournament_id);
		json.addProperty("facebook_count", "1");
		db.update(json);

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	@SuppressWarnings("unchecked")
	// FIXME: refactor duplicated social-login code
	public ModelAndView googleAuth(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject result = new JSONObject();

		// get user data by calling: https://www.googleapis.com/oauth2/v1/userinfo?access_token=<access token>
		String accessToken = request.getParameter("accessToken");
		String apiUrl = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + accessToken;

		/**
		 * Example response:
		 * 
		 * { "id": "111265655555512795521", "email": "email@domain.com", "verified_email": true, "name": "First Last", "given_name": "First", "family_name": "Last", "link":
		 * "https://plus.google.com/+ProfileName", "picture": "<url>", "gender": "male", "locale": "en-GB" }
		 */
		try (InputStream in = new URL(apiUrl).openStream()) {
			JSONObject apiData = (JSONObject) JSONValue.parse(new InputStreamReader(in));
			String email = apiData.containsKey("email") ? apiData.get("email").toString() : apiData.get("id").toString() + UNKNOWN_GOOGLE_DOMAIN;
			String gender = apiData.containsKey("gender") ? apiData.get("gender").toString() : "male";

			// check to see if we know about this user already
			User existingUser = userManager.getUserDetails(email);
			if (existingUser == null) {
				// create a new account
				existingUser = new User(email, StringUtilities.randomStringOfLength(16), apiData.get("given_name").toString(), apiData.get("family_name").toString(), apiData.get("name").toString(),
								gender);
				existingUser.setCredits(DEFAULT_CREDITS);
				
				//FIXME:  set default prefs here, other fields available from google, etc.
				existingUser.setMusicEnabled(false);
				existingUser.setSpeechEnabled(false);
				
				existingUser.setStatus("active");
				existingUser.setLastLogin(new Date());
				
				//activate the user immediately
				existingUser.setVerifyEmail(true);

				if (userManager.register(existingUser)) {
					// successful registration; we don't require activation because we trust the info we got from Facebook (or Google)
					// activate the user immediately
				}
				else {
					// registration failed
					throw new RuntimeException("Failed to register user from Facebook; email=" + email);
				}
			}
			else {
				// logging in to an existing account
				existingUser.setStatus("active");
				existingUser.setLastLogin(new Date());
				
				userManager.update(existingUser);
			}

			// at this point the user's account should definitely exist
			Cookie cookie = new Cookie("username", email);
			response.addCookie(cookie);

			result.put("user_type", existingUser.getUserType());

			loginUser(request, response, existingUser);

			apiData.put("gender", gender);
			apiData.put("email", email); // ensure the FB data is up to date
			result.putAll(apiData);
			result.put("result", "success"); // FIXME: when this occurs the user is taken to the 'home' page but then gets kicked back to the standard index page
		}
		catch (Throwable e) {
			// FIXME: when this occurs the client UI still acts as if something successful has happened
			LOG.error("Failed to get user data from Facebook!", e);
			result.put("result", "failed");
		}

		request.setAttribute("json", result);
		return new ModelAndView("json/legacyJsonView");
	}

	@SuppressWarnings("unchecked")
	public ModelAndView facebookAuth(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject result = new JSONObject();

		// get user data by calling: https://graph.facebook.com/me?access_token=<access token>&fields=id,name,email,first_name,last_name,birthday
		String accessToken = request.getParameter("accessToken");
		String apiUrl = "https://graph.facebook.com/me?fields=id,name,email,first_name,last_name,birthday,gender&access_token=" + accessToken;

		/**
		 * Example response:
		 * 
		 * { "id": "697555557821", "name": "First Last", "first_name": "First", "last_name": "Last", "gender": "male" }
		 */
		try (InputStream in = new URL(apiUrl).openStream()) {
			JSONObject apiData = (JSONObject) JSONValue.parse(new InputStreamReader(in));
			String email = apiData.containsKey("email") ? apiData.get("email").toString() : apiData.get("id").toString() + UNKNOWN_FACEBOOK_DOMAIN;
			String gender = apiData.containsKey("gender") ? apiData.get("gender").toString() : "male";

			// check to see if we know about this user already
			User existingUser = userManager.getUserDetails(email);
			if (existingUser == null) {
				// create a new account
				existingUser = new User(email, StringUtilities.randomStringOfLength(16), apiData.get("first_name").toString(), apiData.get("last_name").toString(), apiData.get("name").toString(),
								gender);
				existingUser.setCredits(DEFAULT_CREDITS);
				
				existingUser.setMusicEnabled(false);
				existingUser.setSpeechEnabled(false);
				
				existingUser.setStatus("active");
				existingUser.setLastLogin(new Date());
				
				//activate the user immediately
				existingUser.setVerifyEmail(true);

				if (userManager.register(existingUser)) {
					// successful registration; we don't require activation because we trust the info we got from Facebook
					// activate the user immediately
				}
				else {
					// registration failed
					throw new RuntimeException("Failed to register user from Facebook; email=" + email);
				}
			}
			else {
				// logging in to an existing account (nothing we actually need to do here)
				existingUser.setStatus("active");
				existingUser.setLastLogin(new Date());
				userManager.update(existingUser);
			}

			// at this point the user's account should definitely exist

			Cookie cookie = new Cookie("username", email);
			response.addCookie(cookie);

			result.put("user_type", existingUser.getUserType());

			loginUser(request, response, existingUser);

			apiData.put("gender", gender);
			apiData.put("email", email); // ensure the FB data is up to date
			result.putAll(apiData);
			result.put("result", "success"); // FIXME: when this occurs the user is taken to the 'home' page but then gets kicked back to the standard index page
		}
		catch (Throwable e) {
			// FIXME: when this occurs the client UI still acts as if something successful has happened
			LOG.error("Failed to get user data from Facebook!", e);
			result.put("result", "failed");
		}

		request.setAttribute("json", result);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Facebook_login"})
	@SuppressWarnings("unchecked")
	@Deprecated
	public ModelAndView facebookLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JsonObject obj = new JsonObject();
		JSONObject obj1 = new JSONObject();
		try {
			// FIXME: this is not secure; allows people to log into any user account they want by changing a URL param
			throw new RuntimeException("This authentication method is insecure and has been disabled!");

			/*
			 * obj = db.find(JsonObject.class, username); User existingUser = userManager.getUserDetails(username); String user = existingUser.getUserType();
			 * 
			 * HttpSession session1 = request.getSession(true); session1.setMaxInactiveInterval(500);
			 * 
			 * Cookie cookie = new Cookie("username", username); response.addCookie(cookie);
			 * 
			 * obj1.put("result", "success"); obj1.put("user_type", user); String revision = obj.get("_rev").toString().replace("\"", ""); obj.addProperty("Status", "active"); Date date = new Date();
			 * obj.addProperty("_rev", revision); obj.addProperty("Last_login", date.toString()); db.update(obj);
			 */
		}
		catch (Exception e) {
			e.printStackTrace();
			obj1.put("result", "fail");
		}

		request.setAttribute("json", obj1);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/connect_check"})
	@SuppressWarnings("unchecked")
	public ModelAndView connectionCheck(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Boolean session_id_validate = false;
		HttpSession session = request.getSession(false);
		JSONObject obj = new JSONObject();
		// System.out.println(session);
		if (session != null) {
			session_id_validate = request.isRequestedSessionIdValid();
			System.out.println(session_id_validate);
		}
		if (session_id_validate)
			obj.put("result", "success");
		else {
			obj.put("result", "fail");
			Cookie[] cook = request.getCookies();
			for (Cookie c1 : cook) {
				c1.setValue(null);
				c1.setMaxAge(0);
				response.addCookie(c1);
			}
			// session.invalidate();
		}

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	@SuppressWarnings("unchecked")
	protected void routeFrontControlRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String command = "";
		JSONObject obj = new JSONObject();
		request.setAttribute("json", obj);

		command = request.getParameter("command");
		System.out.println(command);
		if (command.equals("register")) {
			ServletContext context = getServletContext();
			RequestDispatcher rd = context.getRequestDispatcher("/auth?method=register");
			rd.forward(request, response);
		}
		if (command.equals("hand")) {
			ServletContext context = getServletContext();
			RequestDispatcher rd = context.getRequestDispatcher("/auth?method=hand");
			rd.forward(request, response);
		}
		if (command.equals("login")) {
			ServletContext context = getServletContext();
			RequestDispatcher rd = context.getRequestDispatcher("/auth?method=login");
			rd.forward(request, response);
		}
		if (command.equals("create_tournament")) {
			ServletContext context = getServletContext();
			RequestDispatcher rd = context.getRequestDispatcher("/admin?method=createTournament");
			rd.forward(request, response);
		}
		if (command.equals("logout")) {
			ServletContext context = getServletContext();
			RequestDispatcher rd = context.getRequestDispatcher("/auth?method=logout");
			rd.forward(request, response);
		}
		else {
			obj.put("result", "failed");
		}
	}

	// public boolean confirmUserHasVerified(String email) {
	// JsonObject obj = db.find(JsonObject.class, email);
	// boolean verify_email = obj.get("verify_email").getAsBoolean();
	//
	// if (verify_email)
	// return true;
	// return false;
	// }

	// @SuppressWarnings("unchecked")
	// public boolean sendLoginEmail(String email) {
	// //this used to notify the admin of every login that occurred; that's kind of creepy and has been disabled
	// }

	protected boolean resendVerificationEmail(String email) {
		String to = email;
		String subject = "Registration";
		try {
			// Now set the actual message
			String token = generateAuthToken(userManager, email, false);
			if (StringUtilities.isEmpty(token)) {
				return false;
			}

			String link = Configuration.getServerAddress() + "/r/verify?token=" + token + "&email=" + to;

			String content = "<p> Dear user </p>" + "<h2>Email verification</h2> ";
			content += " We want to ensure every user in our system to be a legitimate user. Please click below link for your email address verification.";
			content += "<br/>" + "&nbsp;" + link;
			content += "<br/>" + "<p> Regards </p>";
			content += "<p> Admin Team , </p>" + "<p> Racing Poker(brought you by Pokerace Pty Ltd. ) </p>";

			return EmailUtility.sendEmail(Configuration.getAdminEmailAddress(), to, subject, content, Configuration.getAdminEmailName(), null);
		}
		catch (Exception mex) {
			mex.printStackTrace();
		}
		return false;
	}

	// FIXME: needs revision/testing (used to send the user a password in plaintext)
	protected boolean sendSocialRegistrationEmail(String email) {
		String to = email;
		String subject = "Registration";
		try {
			// Now set the actual message
			String token = generateAuthToken(userManager, email, true);
			String link = Configuration.getServerAddress() + "/r/verify?token=" + token + "&email=" + email;
			String content = "<p> Dear user </p>" + "<h2>Your registration has been successfull </h2>" + "<br/>";
			content += "Please click below link for your email address confirmation.";

			content += "<br/>" + "&nbsp;" + link + "<br/>";
			content += "<p> Please login and play </p>";
			content += "<br/>" + "<p> Regards </p>";
			content += "<p> Admin Team , </p>" + "<p> Racing Poker(brought you by Pokerace Pty Ltd. ) </p>";

			return EmailUtility.sendEmail(Configuration.getAdminEmailAddress(), to, subject, content, Configuration.getAdminEmailName(), null);
		}
		catch (Exception mex) {
			mex.printStackTrace();
		}
		return false;

	}

	//FIXME:  refactor to utils
	public static boolean sendRegistrationEmail(UserManager um, String email) {
		String to = email;
		String subject = "Registration";

		try {
			String token = generateAuthToken(um, email, false);
			if (StringUtilities.isEmpty(token)) {
				return false;
			}

			String link = Configuration.getServerAddress() + "/r/verify?token=" + token + "&email=" + email;

			String content = "<p> Dear user </p>" + "<h2>Your registration has been successfull </h2>" + "<br/>";
			content += "Please click below link for your email address confirmation.";
			content += "<br/>" + "&nbsp;" + link + "<br/>";
			content += "<p> Please login and play </p>";
			content += "<br/>" + "<p> Regards </p>";
			content += "<p> Admin Team , </p>" + "<p> Racing Poker(brought you by Pokerace Pty Ltd. ) </p>";

			System.out.println("Sending message....");
			return EmailUtility.sendEmail(Configuration.getAdminEmailAddress(), to, subject, content, Configuration.getAdminEmailName(), null);
		}
		catch (Exception mex) {
			mex.printStackTrace();
		}

		return false;
	}

	protected boolean sendForgotPasswordEmail(String email) {
		String to = email;
		String from = "info@racingpoker.com";
		try {
			User user = userManager.getUserDetails(email);
			String token = "RPAUTH-" + System.currentTimeMillis() + (int) (Math.random() * (100));
			String link = Configuration.getServerAddress() + "/r/recoverPassword?token=" + token + "&email=" + to;

			if (! user.isVerifyEmail()) {
				// if user has never verified their e-mail address, they cannot request a password reset
				return false;
			}

			// save the one-time auth token
			user.setAuthToken(token);
			userManager.update(user);

			// Now set the actual message
			String content = "<p>Dear user</p><h4>Thank you for your password recovery request.</h4><h4>We've generated a one-time link that you can use to recover your account.</h4>";
			content += "Your one-time link is:  <a href='" + link + "' target='_blank'>" + link + "</a>";
			content += "<p>Please remember to set a new password after</p>";
			content += "<br/>" + "<p> Regards </p>";
			content += "<p> Admin Team , </p>" + "<p> Racing Poker(brought you by Pokerace Pty Ltd.)</p>";

			return EmailUtility.sendEmail(from, to, "Login details", content, Configuration.getAdminEmailName(), null);
		}
		catch (Exception mex) {
			mex.printStackTrace();
		}
		return false;
	}

	//FIXME:  refactor to utils
	private static String generateAuthToken(UserManager um, String email, boolean verifyFlag) {
		Calendar cal = Calendar.getInstance();
		Date date = new Date();
		cal.setTime(date);
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH);
		int day = cal.get(Calendar.DAY_OF_MONTH);
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		int minute = cal.get(Calendar.MINUTE);
		int second = cal.get(Calendar.SECOND);
		String token = "RPUSER" + year + month + day + hour + minute + second + (int) (Math.random() * 100);

		User user = um.getUserDetails(email);
		
		if (!verifyFlag && user != null && user.isVerifyEmail()) {
			return null;
		}

		user.setVerifyToken(token);
		user.setVerifyEmail(verifyFlag);
		um.update(user);

		return token;
	}
}
