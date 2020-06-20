package au.com.suncoastpc.auth.spring;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ejb.EJB;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.lightcouch.CouchDbClient;
import org.lightcouch.NoDocumentException;
import org.springframework.web.servlet.ModelAndView;

import au.com.suncoastpc.auth.annotations.BypassesQuarantine;
import au.com.suncoastpc.auth.annotations.EchoesParameters;
import au.com.suncoastpc.auth.annotations.RequiresLogin;
import au.com.suncoastpc.auth.annotations.RequiresParameters;
import au.com.suncoastpc.auth.spring.base.BaseMethods;
import au.com.suncoastpc.auth.util.AccessUtils;
import au.com.suncoastpc.auth.util.StringUtilities;
import au.com.suncoastpc.auth.util.comparators.TournamentCostCompare;
import au.com.suncoastpc.conf.Configuration;
import au.com.suncoastpc.util.CouchDBUtil;
import au.com.suncoastpc.util.types.CouchDatabase;

import com.google.gson.JsonObject;
import com.pokerace.ejb.iface.TournamentManager;
import com.pokerace.ejb.iface.UserManager;
import com.pokerace.ejb.model.Tournament;
import com.pokerace.ejb.model.User;
import com.pokerace.purchases.ComboPurchase;
import com.pokerace.purchases.DigitalPurchase;

@RequiresLogin
public class PostAuthMethods extends BaseMethods {
	private static final Logger LOG = Logger.getLogger(PostAuthMethods.class);
	
	private static final String POT_POKER_MODE = "pot";
	private static final String TOURNAMENT_MODE = "tournament";
	
	@EJB
	private TournamentManager tournamentManager;
	
	@EJB
	private UserManager userManager;

	private void initEjbs() {
		try {
			InitialContext ctx = new InitialContext();
			if (userManager == null) {
				userManager = (UserManager) ctx.lookup("java:global/Production_4/UserEJB!com.pokerace.ejb.iface.UserManager");
			}
			if (tournamentManager == null) {
				tournamentManager = (TournamentManager) ctx.lookup("java:global/Production_4/TournamentEJB!com.pokerace.ejb.iface.TournamentManager");
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
	
	@EchoesParameters
	@RequiresParameters(paramNames="mode", redirectTo="home")
	public ModelAndView gameSelect(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mode = request.getParameter("mode");
		if (! POT_POKER_MODE.equalsIgnoreCase(mode) && ! TOURNAMENT_MODE.equalsIgnoreCase(mode)) {
			return home(request, response);
		}
		
		//pot -> '/Tournament_list?command=tournament_list', data.Pot_list
		//tournament -> '/Tournament_list?command=tournament_list', data.Multi_list
		List<Tournament> tournaments = new ArrayList<>();
		try {
			CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.ACTIVE_TOURNAMENTS);
			List<JsonObject> list = db.view("_all_docs").query(JsonObject.class);

			int count = list.size();
			if (count > 0) {
				for (JsonObject json : list) {
					String token = json.get("id").toString().replace("\"", "");
					JsonObject json1 = db.find(JsonObject.class, token);
					String type = json1.get("Type").toString().replace("\"", "");
					if (type.equalsIgnoreCase("Pot_poker") && POT_POKER_MODE.equalsIgnoreCase(mode)) {
						tournaments.add(new Tournament(json1));
					}
					else if (type.equalsIgnoreCase("Multi_Level") && TOURNAMENT_MODE.equalsIgnoreCase(mode)) {
						tournaments.add(new Tournament(json1));
					}
				}
			}
		}
		catch (Exception e) {
			LOG.error("Unable to load tournaments!", e);
		}
		
		if (tournaments.isEmpty()) {
			request.setAttribute("error", "No tournaments found for mode=" + mode + "!");
			return home(request, response);
		}
		
		Collections.sort(tournaments, new TournamentCostCompare());
		
		//request.setAttribute("mode", mode);
		request.setAttribute("games", tournaments);
		if (this.anyPayments(request)) {
			request.setAttribute("hasPayments", "true");
		}
		
		return new ModelAndView("gameSelect");
	}
	
	@EchoesParameters
	public ModelAndView home(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("homeV2");
	}
	
	public ModelAndView singleMode(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("singleMode");
	}
	
	public ModelAndView singleModeV2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("singleModeV2");
	}
	
	public ModelAndView leaderboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("leaderboard");
	}

	@RequiresParameters(paramNames="tournamentId", redirectTo="home")
	public ModelAndView multiMode(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tournamentName = request.getParameter("tournamentId");
		Tournament tournament = tournamentManager.findTournament(tournamentName);
		
		if (tournament == null) {
			request.setAttribute("error", "Invalid tournament or tournament not found!");
			return home(request, response);
		}
		
		request.setAttribute("tournament", tournament);
		
		return new ModelAndView("multiModeV2");
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView addChips(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//credits purchases
		List<Map<String, Object>> chipsProducts = new ArrayList<>();
		for (DigitalPurchase purchase : DigitalPurchase.getProductsForGroup(Configuration.getCreditsProductGroup())) {
			chipsProducts.add(purchase.getJson());
		}
		
		//gold purchases
		List<Map<String, Object>> goldProducts = new ArrayList<>();
		for (DigitalPurchase purchase : DigitalPurchase.getProductsForGroup(Configuration.getGoldProductGroup())) {
			goldProducts.add(purchase.getJson());
		}
		
		//combo purchases
		List<Map<String, Object>> comboProducts = new ArrayList<>();
		for (ComboPurchase purchase : ComboPurchase.getProductsForGroup(Configuration.getComboProductGroup())) {
			comboProducts.add(purchase.getJson());
		}
		
		if (! chipsProducts.isEmpty()) {
			request.setAttribute("chipsProducts", chipsProducts);
		}
		if (! goldProducts.isEmpty()) {
			request.setAttribute("goldProducts", goldProducts);
		}
		if (! comboProducts.isEmpty()) {
			request.setAttribute("comboProducts", comboProducts);
		}
		
		return new ModelAndView("addChips");
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView profile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//expose achievements
		User user = AccessUtils.getCurrentUser(request);
		JSONObject achievements = new JSONObject();
		
		try {
			achievements.put("highestProfit", user.getHighestReturn());
			achievements.put("royalFlush", user.getRoyalFlushCount());
			achievements.put("straightFlush", user.getStraightFlushCount());
			achievements.put("highestOdds", user.getHighestOdds());
			achievements.put("doubleCredits", user.getDoubleCreditsCount());
			achievements.put("tripleCredits", user.getTripleCreditsCount());
			achievements.put("reachLevel", user.getReachLevel());
			
			request.setAttribute("achievements", achievements);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		//gather gameplay history
		List<Map<String, Object>> games = new ArrayList<>();
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.CREDIT_HISTORY);
		CouchDbClient resultsClient = CouchDBUtil.getClient(CouchDatabase.TOURNAMENT_RESULTS);
		try {
			JsonObject history = db.find(JsonObject.class, user.getEmail());
			String[] tour_id = history.get("Tournament_id").toString().replace("\"", "").split("\\,");
			String[] start_credits = history.get("Starting_Credits").toString().replace("\"", "").split("\\,");
			String[] end_credits = history.get("Ending_Credits").toString().replace("\"", "").split("\\,");
			String[] avail_credits = history.get("Available_Credits").toString().replace("\"", "").split("\\,");
			String[] bitlets = history.get("Bitlets").toString().replace("\"", "").split("\\,");
			
			for (int index = tour_id.length - 1; index >= 0; index--) {
				Map<String, Object> game = new HashMap<>();
				game.put("id", tour_id[index]);
				game.put("start", start_credits[index]);
				game.put("end", end_credits[index]);
				game.put("bal", avail_credits[index]);
				
				int gold = (int)Double.parseDouble(bitlets[index]);
				if (gold > 0) {
					//subtract the tournament buy-in amount
					try {
						JsonObject fullResult = resultsClient.find(JsonObject.class, tour_id[index]);
						String[] fullBitlets = fullResult.get("Bitlets").toString().replace("\"", "").split("\\,");
						int buyIn = (int)Double.parseDouble(fullBitlets[fullBitlets.length - 2]);
						if (buyIn < 0) {
							gold += buyIn;
						}
					}
					catch (Exception ignored) {
						//just display the recorded value with no adjustment for buy-in
					}
				}
				game.put("gold", gold);
				
				games.add(game);
			}
		}
		catch (NoDocumentException ignored) {
			//NOTE:  will occur when there is no history for the user yet
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		//gather transactions
		NumberFormat formatter = new DecimalFormat("#0.00"); 
		List<Map<String, Object>> transactions = new ArrayList<>();
		db = CouchDBUtil.getClient(CouchDatabase.PAYMENT_HISTORY);
		try {
			if (user.getPayments() == null) {
				user.setPayments("");
			}
			
			String payments = user.getPayments();
			String[] payments_list = payments.split(",");
			for (String payment : payments_list) {
				Map<String, Object> transaction = new HashMap<>();
				JsonObject json1 = db.find(JsonObject.class, payment);
				
				transaction.put("date", json1.get("Date").toString().replace("\"", ""));
				transaction.put("credits", (int)Double.parseDouble(json1.get("Credits_added").toString().replace("\"", "")));
				transaction.put("gold", (int)Double.parseDouble(json1.get("Bitlets").toString().replace("\"", "")));
				transaction.put("cost", "AU$" + formatter.format(Double.parseDouble(json1.get("Payment_amount").toString().replace("\"", ""))));  //FIXME:  should take cost details from enum
				transaction.put("notes", json1.get("Description").toString().replace("\"", ""));
				
				transactions.add(transaction);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		request.setAttribute("games", games);
		request.setAttribute("transactions", transactions);
	
		
		//done
		return new ModelAndView("profile");
	}
	
	@RequiresParameters(paramNames={"email", "firstname", "lastname", "nickname", "gender", "birthYear"}, redirectTo="profile")
	public ModelAndView updateProfileV2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//update profile data
		String email = request.getParameter("email");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String nickname = request.getParameter("nickname");
		String gender = request.getParameter("gender");
		String ageGroup = request.getParameter("age");
		String music = request.getParameter("music");
		String voice = request.getParameter("voice");
		String yearOfBirth = request.getParameter("birthYear");
		
		User user = AccessUtils.getCurrentUser(request);
		
		//ensure email address can never be changed (for now)
		email = user.getEmail();
		
		boolean emailChanged = false;
		if (! user.getEmail().equalsIgnoreCase(email)) {
			//handle request to change the account e-mail address
			User existing = userManager.getUserDetails(email);
			if (existing != null) {
				//cannot proceeed, the requested e-mail address is already in use
				request.setAttribute("error", "The email address '" + email + "' is already in use!");
				return profile(request, response);
			}
			emailChanged = true;
		}
		
		try {
			user.setEmail(email);
			user.setFirstName(firstname);
			user.setLastName(lastname);
			user.setMusicEnabled("true".equalsIgnoreCase(music));
			user.setSpeechEnabled("true".equalsIgnoreCase(voice));
			
			//FIXME:  should check to confirm that desired nickname is not in use
			user.setNickname(nickname);
			
			if (! "-1".equals(gender)) {
				user.setGender(gender);
			}
			if (! "-1".equals(ageGroup)) {
				user.setSelectedAgeGroup(ageGroup);
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
			
			if (emailChanged) {
				//FIXME:  still broken
				//changing an email changes the entry's primary key; so delete the old one and save a new one (and also relink any entries in foreign tables!!!)
				//db.remove(json1);
				
				//json1.addProperty("_id", email);
				//json1.remove("verify_email");
				//json1.addProperty("Status", "inactive");
				
				//db.save(json1);
				//request.getSession().setAttribute(Constants.SESSION_USER_KEY, userManager.getUserDetails(email));
			}
			else {
				//db.update(json1);
				userManager.update(user);
			}
			request.setAttribute("message", "Profile updated successfully!");
			
			if (emailChanged) {
				//send confirmation message and link; the account is deactivated until the new address is confirmed
				PreAuthMethods.sendRegistrationEmail(userManager, email);
			}
			
			response.sendRedirect("/u/profile?profileUpdated=true");
			return null;
		}
		catch (Exception e) {
			request.setAttribute("error", "Failed to update user profile:  " + e.getMessage());
			e.printStackTrace();
		}
		
		return profile(request, response);
	}

	//FIXME:  deprecated; remove (also, corrupts user profile data if accidentally visited!!!)
	// was: @WebServlet(urlPatterns = {"/Updateuser"})
	@SuppressWarnings("unchecked")
	public ModelAndView updateProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject obj1 = new JSONObject();
		try {
			//String username = request.getParameter("username");
			User user = AccessUtils.getCurrentUser(request);
			String firstname = request.getParameter("firstname");
			String lastname = request.getParameter("lastname");
			String nickname = request.getParameter("nickname");
			// JsonObject json = new JsonObject();

			// String
			// password=json1.get("Password").toString().replace("\"","");
			user.setFirstName(firstname);
			user.setLastName(lastname);
			
			//FIXME:  should check to confirm that desired nickname is not in use
			user.setNickname(nickname);
			
			userManager.update(user);

			obj1.put("result", "success");
		} catch (Exception e) {

			obj1.put("result", "failed");
		}

		request.setAttribute("json", obj1);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Updatepassword"})
	@SuppressWarnings("unchecked")
	public ModelAndView updatePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject obj1 = new JSONObject();
		try {
			String npassword = request.getParameter("new");
			User user = AccessUtils.getCurrentUser(request);					
			user.setPassword(npassword);
			userManager.update(user);
			

			//JsonObject json1 = db.find(JsonObject.class, user.getEmail());
			//String salt = StringUtilities.randomStringWithLengthBetween(12, 20);
			//String hashedPassword = CryptoUtil.computeHash(npassword, salt);

			//json1.addProperty("salt", salt);
			//json1.addProperty("hashedPassword", hashedPassword);
			//db.update(json1);
			
			obj1.put("result", "success");
		} 
		catch (Exception e) {
			obj1.put("result", "failed");
			e.printStackTrace();
		}
		
		request.setAttribute("json", obj1);	
		return new ModelAndView("json/legacyJsonView");
	}
	
	@BypassesQuarantine(paramNames={"old", "new", "new2"})
	@RequiresParameters(paramNames={"old", "new", "new2"}, redirectTo="profile")
	public ModelAndView updatePasswordV2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String old = request.getParameter("old");
		String newPass = request.getParameter("new");
		String conf = request.getParameter("new2");
		User user = AccessUtils.getCurrentUser(request);
		
		User validRequest = userManager.authenticate(user.getEmail(), old, null);
		if (validRequest == null) {
			request.setAttribute("error", "Incorrect password!");
			return profile(request, response);
		}
		if (StringUtilities.isEmpty(newPass)) {
			request.setAttribute("error", "Your new password cannot be blank!");
			return profile(request, response);
		}
		if (! newPass.equals(conf)) {
			request.setAttribute("error", "Password and confirmation don't match, please try again.");
			return profile(request, response);
		}
		if (newPass.equals(old)) {
			request.setAttribute("error", "Your new password cannot be the same as your current password!");
			return profile(request, response);
		}
		
		//valid password change
		
		try {
			user.setPassword(newPass);
			userManager.update(user);

			//JsonObject json1 = db.find(JsonObject.class, user.getEmail());
			//String salt = StringUtilities.randomStringWithLengthBetween(12, 20);
			//String hashedPassword = CryptoUtil.computeHash(newPass, salt);

			//json1.addProperty("salt", salt);
			//json1.addProperty("hashedPassword", hashedPassword);
			//db.update(json1);
			
			request.setAttribute("message", "Password updated successfully!");	
			
		} 
		catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Password update failed:  " + e.getMessage());	
		}
		
		
		return profile(request, response);
	}

	// was: @WebServlet(urlPatterns = {"/Tournamentresults"})
	@SuppressWarnings("unchecked")
	public ModelAndView tournamentResults(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject obj = new JSONObject();
		String tournament_id = request.getParameter("tournament_id");
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.TOURNAMENT_RESULTS);
		JsonObject json = db.find(JsonObject.class, tournament_id);
		String player_name = json.get("Playername").toString().replace("\"", "");
		String credit_points = json.get("Creditpoints").toString().replace("\"", "");
		String tournament_points = json.get("Tournamentpoints").toString().replace("\"", "");
		String bitlets = json.get("Bitlets").toString().replace("\"", "");
		try {
			json.get("facebook_count").toString().replace("\"", "");
			obj.put("facebook_count", "1");
		} catch (Exception e) {
			obj.put("facebook_count", "0");
		}
		obj.put("Playername", player_name);
		obj.put("Credit_points", credit_points);
		obj.put("Tournament_points", tournament_points);
		obj.put("Bitlets", bitlets);

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView facebookAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CouchDbClient db1 = CouchDBUtil.getClient(CouchDatabase.PAYMENT_HISTORY);
		
		//setup result obj
		JSONObject obj = new JSONObject();
		obj.put("result", "fail");
		request.setAttribute("json", obj);
		
		String desc = request.getParameter("Description");
		String transaction_id = request.getParameter("Transaction_id");
		
		if (desc == null) {
			desc = "";
		}
		
		//see if it's a valid social operation
		if (! desc.endsWith("share") && ! desc.endsWith("like")) {
			return new ModelAndView("json/legacyJsonView");
		}
		
		//see if the user is able to like/share right now
		User user = AccessUtils.getCurrentUser(request);
		if (desc.endsWith("share") && user.getSecondsUntilNextShare() > 0) {
			return new ModelAndView("json/legacyJsonView");
		}
		else if (desc.endsWith("like") && user.getSecondsUntilNextLike() > 0) {
			return new ModelAndView("json/legacyJsonView");
		}

		//award the bonus credits
		double add_credits = desc.endsWith("share") ? Configuration.getFacebookShareCredits() : Configuration.getFacebookLikeCredits(); 
		try {
			//update the user's balance
			long credits = user.getCredits();
			credits += add_credits;

			String payments = user.getPayments();		//may be null
			payments = StringUtilities.isEmpty(payments) ? transaction_id : payments + "," + transaction_id;
			user.setPayments(payments);
		
			user.setCredits(credits);
			
			//update social times
			Date now = new Date();
			if (desc.endsWith("share")) {
				user.setLastShare(now);
			}
			else {
				user.setLastLike(now);
			}
			userManager.update(user);
			
			JsonObject json1 = new JsonObject();
			Calendar cal = Calendar.getInstance();
			Date date = new Date();
			cal.setTime(date);
			json1.addProperty("_id", transaction_id);

			json1.addProperty("Username", user.getEmail());
			json1.addProperty("Payment_amount", 0.0);
			json1.addProperty("Status", "confirmed");
			json1.addProperty("Date", (cal.get(Calendar.DAY_OF_MONTH)) + "/" + (cal.get(Calendar.MONTH) + 1) + "/" + cal.get(Calendar.YEAR));
			json1.addProperty("Credits_added", add_credits);
			json1.addProperty("Description", desc);
			json1.addProperty("Total_credits", credits);
			json1.addProperty("Bitlets", 0.0);
			System.out.println(json1);
			db1.save(json1);
			obj.put("result", "success");
			obj.put("Credit", credits);
			obj.put("Bitlets", 0.0);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("result", "fail");
		}

		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Process_payment_success"})
	@SuppressWarnings("unchecked")
	@Deprecated
	//FIXME:  remove (allows users to give themselves an arbitrary number of credits and bitlets)
	public ModelAndView paymentSuccess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		CouchDbClient db1 = CouchDBUtil.getClient(CouchDatabase.PAYMENT_HISTORY);

		//String username = request.getParameter("Username");
		User user = AccessUtils.getCurrentUser(request);
		String transaction_id = request.getParameter("Transaction_id");
		Double amount = Double.parseDouble(request.getParameter("Amount"));
		Double add_credits = Double.parseDouble(request.getParameter("Credits"));
		Double credits = 0.0;
		Double bitlets = 0.0;
		Double add_bitlets = Double.parseDouble(request.getParameter("Bitlets"));
		bitlets += add_bitlets;
		String desc = request.getParameter("Description");
		JSONObject obj = new JSONObject();
		try {
			JsonObject json = db.find(JsonObject.class, user.getEmail());
			credits = Double.parseDouble(json.get("Credit").toString().replace("\"", ""));
			credits += add_credits;
			bitlets = Double.parseDouble(json.get("no_of_bitlets").toString().replace("\"", ""));
			bitlets += add_bitlets;
			try {
				String payments = json.get("Payments").toString().replace("\"", "");
				payments += "," + transaction_id;
				json.addProperty("Payments", payments);
			} catch (Exception e) {
				json.addProperty("Payments", transaction_id);
				// db.update(json);
			}
			json.addProperty("Credit", credits);
			json.addProperty("no_of_bitlets", bitlets);
			db.update(json);
			JsonObject json1 = new JsonObject();
			Calendar cal = Calendar.getInstance();
			Date date = new Date();
			cal.setTime(date);
			json1.addProperty("_id", transaction_id);

			json1.addProperty("Username", user.getEmail());
			json1.addProperty("Payment_amount", amount);
			json1.addProperty("Status", "confirmed");
			json1.addProperty("Date", (cal.get(Calendar.DAY_OF_MONTH)) + "/" + (cal.get(Calendar.MONTH) + 1) + "/" + cal.get(Calendar.YEAR));
			json1.addProperty("Credits_added", add_credits);
			json1.addProperty("Description", desc);
			json1.addProperty("Total_credits", credits);
			json1.addProperty("Bitlets", add_bitlets);
			System.out.println(json1);
			db1.save(json1);
			obj.put("result", "success");
			obj.put("Credit", credits);
			obj.put("Bitlets", bitlets);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("result", "fail");
		}*/
		
		JSONObject obj = new JSONObject();
		obj.put("result", "fail");
		obj.put("message", "This API has been deprecated and is no longer supported.");

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Pokerace_user_credit_history"})
	@SuppressWarnings("unchecked")
	public ModelAndView creditHistory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.CREDIT_HISTORY);
		JSONObject json = new JSONObject();
		try {
			//String username = request.getParameter("Username");
			User user = AccessUtils.getCurrentUser(request);

			JsonObject obj = db.find(JsonObject.class, user.getEmail());

			String tour_id = obj.get("Tournament_id").toString().replace("\"", "");
			String start_credits = obj.get("Starting_Credits").toString().replace("\"", "");
			String end_credits = obj.get("Ending_Credits").toString().replace("\"", "");
			String avail_credits = obj.get("Available_Credits").toString().replace("\"", "");
			String bitlets = obj.get("Bitlets").toString().replace("\"", "");
			json.put("Tournaments", tour_id);
			json.put("Start_Credits", start_credits);
			json.put("End_Credits", end_credits);
			json.put("Avail_Credits", avail_credits);
			json.put("result", "success");
			json.put("Bitlets", bitlets);
		} catch (Exception e) {
			json.put("result", "fail");
		}
		
		request.setAttribute("json", json);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Payment_history"})
	@SuppressWarnings("unchecked")
	public ModelAndView paymentHistory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.PAYMENT_HISTORY);

		//String username = request.getParameter("Username");
		User user = AccessUtils.getCurrentUser(request);
		JSONObject obj = new JSONObject();
		try {
			String payments = user.getPayments();  //XXX:  may be null
			if (payments == null) {
				payments = "";
			}
			
			String[] payments_list = payments.split(",");

			String payment_amount = "";
			String credits_added = "";
			String statuses = "";
			String transaction_ids = "";
			String dates = "";
			String Description = "";
			String bitlets_added = "";
			for (String payment : payments_list) {
				System.out.println(payment);
				JsonObject json1 = db.find(JsonObject.class, payment);
				transaction_ids += payment + ",";
				payment_amount += json1.get("Payment_amount").toString().replace("\"", "") + ",";
				credits_added += json1.get("Credits_added").toString().replace("\"", "") + ",";
				bitlets_added += json1.get("Bitlets").toString().replace("\"", "") + ",";
				statuses += json1.get("Status").toString().replace("\"", "") + ",";
				dates += json1.get("Date").toString().replace("\"", "") + ",";
				Description += json1.get("Description").toString().replace("\"", "") + ",";
			}
			obj.put("result", "success");
			obj.put("Payments", transaction_ids);
			obj.put("Credits_added", credits_added);
			obj.put("Bitlets_added", bitlets_added);
			obj.put("Status", statuses);
			obj.put("Date", dates);
			obj.put("Payment_amount", payment_amount);
			obj.put("Description", Description);
			// System.out.println(statuses);

		} catch (Exception e) {
			//e.printStackTrace();
			obj.put("result", "fail");
		}

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Exit_tournament"})
	@SuppressWarnings("unchecked")
	public ModelAndView exitTournament(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tournament_id = request.getParameter("tournament_id");
		String credits = request.getParameter("user_credits");
		//String username = request.getParameter("username");
		User user = AccessUtils.getCurrentUser(request);
		String Starting_credit_points = getUserHistory(tournament_id, user.getEmail());
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.CREDIT_HISTORY);

		try {
			JsonObject json = db.find(JsonObject.class, user.getEmail());
			String tour_ids = json.get("Tournament_id").toString().replace("\"", "");
			tour_ids += "," + tournament_id;
			String initial_credits = json.get("Starting_Credits").toString().replace("\"", "");
			// String Starting_credit_points = json1.
			initial_credits += "," + Starting_credit_points;

			String end_credits = json.get("Ending_Credits").toString().replace("\"", "");
			end_credits += "," + Double.parseDouble(credits);
			String available_credits = json.get("Available_Credits").toString().replace("\"", "");

			String avail_credits = user.getCredits() + "";

			Double final_credits = Double.parseDouble(avail_credits) + Double.parseDouble(credits);

			available_credits += "," + final_credits;

			json.addProperty("Starting_Credits", initial_credits);
			json.addProperty("Ending_Credits", end_credits);
			json.addProperty("Available_Credits", available_credits);
			json.addProperty("Tournament_id", tour_ids);

			user.setCredits(final_credits.longValue());
			db.update(json);
			userManager.update(user);
		} catch (Exception e) {
			JsonObject json = new JsonObject();
			json.addProperty("_id", user.getEmail());
			json.addProperty("Tournament_id", tournament_id);
			json.addProperty("Starting_Credits", Starting_credit_points);
			json.addProperty("Ending_Credits", credits);
			String avail_credits = user.getCredits() + "";
			Double final_credits = Double.parseDouble(avail_credits) + Double.parseDouble(credits);
			json.addProperty("Available_Credits", final_credits);
			db.save(json);
			user.setCredits(final_credits.longValue());
			userManager.update(user);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("result", "success");

		request.setAttribute("json", obj1);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: ??? (see original web.xml) Convert_bitlets.java
	@SuppressWarnings("unchecked")
	public ModelAndView convertBilets(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//String username = request.getParameter("username");
		User user = AccessUtils.getCurrentUser(request);
		Double add_bitlets = Double.parseDouble(request.getParameter("Bitlets"));
		Double add_credits = Double.parseDouble(request.getParameter("Credits"));
		Double credits = 0.0;
		Double bitlets = 0.0;
		credits = (double)user.getCredits();
		credits += add_credits;
		bitlets = user.getBitlets();
		bitlets -= add_bitlets;
		
		user.setCredits(credits.longValue());
		user.setBitlets(bitlets);
		
		JSONObject obj = new JSONObject();
		userManager.update(user);
		obj.put("result", "success");

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: ??? (see original web.xml) Chat_servlet.java
	@SuppressWarnings("unchecked")
	public ModelAndView sendChatMessage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = request.getParameter("User");
		String msg = request.getParameter("Message");
		String tournament_id = request.getParameter("Tournament_id");
		String format = "Chat:" + msg + "|" + "User-" + user;
		// format.replaceAll(" ",",");

		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.CHAT);

		try {
			JsonObject json = db.find(JsonObject.class, tournament_id);
			// JsonObject json5 = db4.find(JsonObject.class,token);
			String msg1 = json.get("Messages").toString().replace("\"", "");
			msg1 += "*" + format;
			json.addProperty("Messages", msg1);
			json.addProperty("Send_status", "false");
			db.update(json);
		} catch (Exception e) {
			JSONObject json2 = new JSONObject();
			json2.put("_id", tournament_id);
			json2.put("Messages", format);
			json2.put("Send_status", "false");
			db.save(json2);
		}

		JSONObject obj = new JSONObject();
		obj.put("result", "success");

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Bets"})
	@SuppressWarnings("unchecked")
	public ModelAndView bets(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject obj = new JSONObject();
		System.out.println("in the servlet");
		try {
			// String tournament_detail="";
			String tournament_id = request.getParameter("tournament_id");
			//String username = request.getParameter("username");
			User user = AccessUtils.getCurrentUser(request);
			String game_number = request.getParameter("game_number");
			String deal_number = request.getParameter("deal_number");
			String hand_number = request.getParameter("hand_number");
			String bet_amount = request.getParameter("bet_amount");
			String return_amount = request.getParameter("return_amount");
			obj.put("tournament_id", tournament_id);
			obj.put("user_id", user.getEmail());
			obj.put("game_number", game_number);
			obj.put("deal_number", deal_number);
			obj.put("hand_number", hand_number);
			obj.put("bet_amount", bet_amount);
			obj.put("return_amount", return_amount);
			CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.RUNNING_BETS);

			List<JsonObject> list = db.view("_all_docs").query(JsonObject.class);
			int count = list.size();
			String id = "" + (count + 1);
			if (count > 0) {
				obj.put("_id", id);
				obj.put("bet_id", id);
				db.save(obj);

				// aroth: this should be unnecessary and is probably not
				// correct
				// CouchDBUtil.shutdownClient(CouchDatabase.RUNNING_BETS);
				// db.shutdown();

				updateBet(tournament_id, id);
				obj.put("result", "success");
			}
		} catch (Exception e) {
			System.out.println(e);
			obj.put("result", "fail");
		}

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Achievements"})
	// note: two actions; 'save' and 'get', should delegate
	@SuppressWarnings("unchecked")
	public ModelAndView achievements(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getParameter("command");
		//String user_id = request.getParameter("username");
		User user = AccessUtils.getCurrentUser(request);
		if (command.equals("save")) {
			//FIXME:  appears broken for accounts that have no achievements yet; needs to handle nulls correctly
			String highest_profit = user.getHighestReturn() + "";
			String royal_flush = user.getRoyalFlushCount() + "";
			String straight_flush = user.getStraightFlushCount() + "";
			String highest_odds = user.getHighestOdds() + "";
			String double_credits = user.getDoubleCreditsCount() + "";
			String triple_credits = user.getTripleCreditsCount() + "";
			String reach_level = user.getReachLevel() + "";
			
			String highest_profit1 = request.getParameter("Highest_profit");
			String royal_flush1 = request.getParameter("Royal_flush");
			String straight_flush1 = request.getParameter("Straight_flush");
			String highest_odds1 = request.getParameter("Highest_odds");
			String double_credits1 = request.getParameter("Double_credits");
			String triple_credits1 = request.getParameter("Triple_credits");
			String reach_level1 = request.getParameter("Reach_level");

			if (double_credits1.equals("yes")) {
				int double_credits_count = Integer.parseInt(double_credits);
				double_credits_count++;
				double_credits = "" + double_credits_count;
			}
			if (triple_credits1.equals("yes")) {
				int triple_credits_count = Integer.parseInt(triple_credits);
				triple_credits_count++;
				triple_credits = "" + triple_credits_count;
			}
			if (Integer.parseInt(highest_profit) < Integer.parseInt(highest_profit1)) {
				highest_profit = highest_profit1;
			}
			if (Double.parseDouble(highest_odds) < Double.parseDouble(highest_odds1)) {
				highest_odds = highest_odds1;
			}
			if (Integer.parseInt(reach_level) < Integer.parseInt(reach_level1)) {
				reach_level = reach_level1;
			}
			if (Integer.parseInt(straight_flush) < Integer.parseInt(straight_flush1)) {
				straight_flush = straight_flush1;
			}
			if (Integer.parseInt(royal_flush) < Integer.parseInt(royal_flush1)) {
				royal_flush = royal_flush1;
			}

			user.setHighestReturn(Integer.parseInt(highest_profit));
			user.setRoyalFlushCount(Integer.parseInt(royal_flush));
			user.setStraightFlushCount(Integer.parseInt(straight_flush));
			user.setDoubleCreditsCount(Integer.parseInt(double_credits));
			user.setTripleCreditsCount(Integer.parseInt(triple_credits));
			user.setReachLevel(Integer.parseInt(reach_level));
			user.setHighestOdds(Double.parseDouble(highest_odds));
			
			userManager.update(user);

			JSONObject out1 = new JSONObject();
			out1.put("result", "success");
			
			request.setAttribute("json", out1);
		} else {
			if (command.equals("get")) {
				String highest_profit = user.getHighestReturn() + "";
				String royal_flush = user.getRoyalFlushCount() + "";
				String straight_flush = user.getStraightFlushCount() + "";
				String highest_odds = user.getHighestOdds() + "";
				String double_credits = user.getDoubleCreditsCount() + "";
				String triple_credits = user.getTripleCreditsCount() + "";
				String reach_level = user.getReachLevel() + "";
				
				JSONObject json = new JSONObject();
				String achievements = highest_profit + "," + royal_flush + "," + straight_flush + "," + highest_odds + "," + double_credits + "," + triple_credits + "," + reach_level;
				json.put("achievement", achievements);
				json.put("highest_profit", highest_profit);
				json.put("royal_flush", royal_flush);
				json.put("straight_flush", straight_flush);
				json.put("highest_odds", highest_odds);
				json.put("reach_level", reach_level);
				
				request.setAttribute("json", json);
			}
		}

		return new ModelAndView("json/legacyJsonView");
	}

	@SuppressWarnings("unchecked")
	protected synchronized void updateBet(String tournament_id, String bet_id) {
		try {
			CouchDbClient db1 = CouchDBUtil.getClient(CouchDatabase.RUNNING_TOURNAMENTS);
			JsonObject obj = db1.find(JsonObject.class, tournament_id);
			JSONObject json = new JSONObject();
			String bets = obj.get("bets").toString().replace("\"", "");
			String users = obj.get("users").toString().replace("\"", "");
			String game_number = obj.get("game_number").toString().replace("\"", "");
			String tournament_name = obj.get("tournament_id").toString().replace("\"", "");
			String deal_number = obj.get("deal_number").toString().replace("\"", "");
			String revision = obj.get("_rev").toString().replace("\"", "");
			bets += "," + bet_id;
			json.put("_id", tournament_id);
			json.put("users", users);
			json.put("bets", bets);
			json.put("game_number", game_number);
			json.put("tournament_id", tournament_name);
			json.put("deal_number", deal_number);
			json.put("status", "running");
			json.put("left_players", "");
			json.put("_rev", revision);
			db1.update(json);

			// aroth: this should be unnecessary and is probably not correct
			// CouchDBUtil.shutdownClient(CouchDatabase.RUNNING_TOURNAMENTS);
			// db.shutdown();
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	protected String getUserHistory(String tournament_id, String username) {
		CouchDbClient db1 = CouchDBUtil.getClient(CouchDatabase.RUNNING_TOURNAMENTS);
		CouchDbClient db2 = CouchDBUtil.getClient(CouchDatabase.ACTIVE_TOURNAMENTS);

		JsonObject obj = db1.find(JsonObject.class, tournament_id);
		String name = obj.get("tournament_id").toString().replace("\"", "");
		JsonObject obj2 = db2.find(JsonObject.class, name);
		String Starting_credit_points = obj2.get("starting_credit_points").toString().replace("\"", "");
		try {
			String left_players = obj.get("left_players").toString().replace("\"", "");

			left_players += username + ",";
			obj.addProperty("left_players", left_players);
			db1.update(obj);
		} catch (Exception e) {
			String left_players = username;
			obj.addProperty("left_players", left_players);
			db1.update(obj);
		}
		// aroth: this should be unnecessary and is probably not correct
		// CouchDBUtil.shutdownClient(CouchDatabase.RUNNING_TOURNAMENTS);
		// db1.shutdown();
		// CouchDBUtil.shutdownClient(CouchDatabase.ACTIVE_TOURNAMENTS);
		// db2.shutdown();

		return Starting_credit_points;
	}
	
	private boolean anyPayments(HttpServletRequest request) {
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.PAYMENT_HISTORY);

		//String username = request.getParameter("Username");
		User user = AccessUtils.getCurrentUser(request);
		try {
			String payments = user.getPayments();
			String[] payments_list = payments.split(",");

			String payment_amount = "";
			String credits_added = "";
			String statuses = "";
			String transaction_ids = "";
			String dates = "";
			String Description = "";
			String bitlets_added = "";
			for (String payment : payments_list) {
				System.out.println(payment);
				JsonObject json1 = db.find(JsonObject.class, payment);
				transaction_ids += payment + ",";
				payment_amount += json1.get("Payment_amount").toString().replace("\"", "") + ",";
				credits_added += json1.get("Credits_added").toString().replace("\"", "") + ",";
				bitlets_added += json1.get("Bitlets").toString().replace("\"", "") + ",";
				statuses += json1.get("Status").toString().replace("\"", "") + ",";
				dates += json1.get("Date").toString().replace("\"", "") + ",";
				Description += json1.get("Description").toString().replace("\"", "") + ",";
				
				break;
			}
			
			return payments_list.length > 0;

		} catch (Exception e) {
			return false;
		}
	}
}
