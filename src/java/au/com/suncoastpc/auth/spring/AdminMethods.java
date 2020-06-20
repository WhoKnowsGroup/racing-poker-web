package au.com.suncoastpc.auth.spring;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import javax.ejb.EJB;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.lightcouch.CouchDbClient;
import org.springframework.web.servlet.ModelAndView;

import au.com.suncoastpc.auth.spring.base.BaseMethods;
import au.com.suncoastpc.auth.util.StringUtilities;
import au.com.suncoastpc.util.CouchDBUtil;
import au.com.suncoastpc.util.CryptoUtil;
import au.com.suncoastpc.util.types.CouchDatabase;

import com.google.gson.JsonObject;
import com.pokerace.ejb.iface.TournamentManager;
import com.pokerace.ejb.iface.UserManager;
import com.pokerace.ejb.model.Tournament;
import com.pokerace.ejb.model.User;

//FIXME:  secure these methods (new annotations that work with RP database)
//FIXME:  tend to other fixmes
//@RequiresTrustLevel(minimumTrust = Constants.TRUST_LEVEL_ADMIN)  //admin access only
public class AdminMethods extends BaseMethods {
	private static final Logger LOG = Logger.getLogger(AdminMethods.class);

	@EJB
	private TournamentManager tournamentManager;
	
	@EJB
	private UserManager userManager;
	
	private void initEjbs() {
		try {
			InitialContext ctx = new InitialContext();
			if (tournamentManager == null) {
				tournamentManager = (TournamentManager)ctx.lookup("java:global/Production_4/TournamentEJB!com.pokerace.ejb.iface.TournamentManager");
			}
			if (userManager == null) {
				userManager = (UserManager) ctx.lookup("java:global/Production_4/UserEJB!com.pokerace.ejb.iface.UserManager");
			}
		}
		catch (Throwable e) {
			e.printStackTrace();
		}
	}
	
	@Override
	protected void initServletContext(ServletContext sc){
		initEjbs();
	}

	public ModelAndView adminLinks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("adminLinks");
	}

	// was: @WebServlet(urlPatterns = {"/Users_list"})
	@SuppressWarnings("unchecked")
	public ModelAndView listUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.USERS);
		List<JsonObject> list = db.view("_all_docs").query(JsonObject.class);
		JSONObject users_lists = new JSONObject();
		String all_email_users = "";
		String status_users = "";
		String last_login_users = "";
		String users_joined_date = "";
		for (JsonObject json : list) {
			String id = json.get("id").toString().replace("\"", "");
			User user = new User(db.find(JsonObject.class, id));
			System.out.println(user.toJson());
			String status = user.getStatus();
			String last_login = user.getLastLogin().toString();
			String joined_date = user.getCreatedAt().toString();
			
			all_email_users += id + ",";
			status_users += status + ",";
			last_login_users += last_login + ",";
			users_joined_date += joined_date + ",";
			// users_lists.add(i,obj);
		}
		users_lists.put("Email", all_email_users);
		users_lists.put("Status", status_users);
		users_lists.put("Last_login", last_login_users);
		users_lists.put("Joined_date", users_joined_date);
		
		request.setAttribute("json", users_lists);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/UserPasswordMigration"})
	@SuppressWarnings("unchecked")
	public ModelAndView migrateOldPasswords(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONArray result = new JSONArray();
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.USERS);
		List<JsonObject> list = db.view("_all_docs").query(JsonObject.class);

		for (JsonObject meta : list) {
			if (meta.has("id")) {
				//XXX:  getAsString is okay; it's Gson.toString that's broken
				JsonObject user = db.find(JsonObject.class, meta.get("id").getAsString());
				if (user.has("Password")) {
					try {
						String salt = StringUtilities.randomStringWithLengthBetween(12, 20);
						String password = user.get("Password").getAsString();
						String hashedPassword = CryptoUtil.computeHash(password, salt);

						user.addProperty("salt", salt);
						user.addProperty("hashedPassword", hashedPassword);
						user.remove("Password");

						db.update(user);
						result.add(user.get("Email").getAsString());
					} catch (Exception e) {
						LOG.warn("Unexpected exception when migrating password; user=" + user.get("Email").getAsString() + ", ex=" + e.getMessage(), e);
					}
				}
			}
		}

		request.setAttribute("json", result);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Unblocking_location"})
	@SuppressWarnings("unchecked")
	public ModelAndView unblockLocation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.COUNTRIES);

		String country_code = request.getParameter("Country_code");
		String regions = request.getParameter("Regions");
		String notes = request.getParameter("Notes");
		String unblocked = "";
		JsonObject obj2 = db.find(JsonObject.class, country_code);
		String[] blocked_list = obj2.get("Blocked_list").toString().replaceAll("\"", "").split(",");
		boolean blocked = false;

		for (String b : blocked_list) {
			if (b.equalsIgnoreCase(regions))
				blocked = true;
			else
				unblocked += b + ",";
		}

		JSONObject output = new JSONObject();

		if (blocked) {

			output.put("result", "success");
			obj2.addProperty("Blocked_list", unblocked);
			obj2.addProperty("Notes", notes);
			db.update(obj2);

		} 
		else {
			output.put("result", "failed");
		}

		request.setAttribute("json", output);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Unblock_regions"})
	@SuppressWarnings("unchecked")
	public ModelAndView unblockRegions(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.COUNTRIES);

		String country_code = request.getParameter("Country_code");
		String[] regions = request.getParameter("Regions").split(",");
		// String notes = request.getParameter("Notes");
		String unblocked = "";
		JsonObject obj2 = db.find(JsonObject.class, country_code);
		String[] blocked_list = obj2.get("Blocked_list").toString().replaceAll("\"", "").split(",");

		boolean blocked = false;

		for (String r : regions) {
			System.out.println(r.length() + r);
			if (r.length() > 1) {
				for (int b = 0; b <= blocked_list.length - 1; b++) {
					System.out.println(blocked_list[b]);
					if (blocked_list[b].equalsIgnoreCase(r)) {
						blocked = true;
						blocked_list[b] = "";
					}
				}
			}
		}

		for (int k = 0; k <= blocked_list.length - 1; k++) {
			if (blocked_list[k].length() > 1)
				unblocked += blocked_list[k] + ",";
		}
		JSONObject output = new JSONObject();

		if (blocked) {
			output.put("result", "success");
			obj2.addProperty("Blocked_list", unblocked);
			// obj2.addProperty("Notes", notes);
			db.update(obj2);

		} else
			output.put("result", "failed");

		request.setAttribute("json", output);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Send_invitation"})
	@SuppressWarnings("unchecked")
	public ModelAndView inviteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//XXX:  this method does not look like it ever actually worked; it just sent a test e-mail to lokesh.metla@gmail.com
		//		as such it has been disabled
		JSONObject json = new JSONObject();
		json.put("result", "success");

		request.setAttribute("json", json);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Registered_users"})
	@SuppressWarnings("unchecked")
	public ModelAndView listRegisteredUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.USERS);
		String email = "";
		String first_name = "";
		String last_name = "";
		String credit = "";
		// JsonObject json = new JsonObject();
		JSONObject obj = new JSONObject();
		List<JsonObject> list = db.view("_all_docs").query(JsonObject.class);
		int count = list.size();
		if (count > 0) {
			for (JsonObject json : list) {
				try {
					System.out.println(json);
					String id = json.get("id").toString().replace("\"", "");
					User user = new User(db.find(JsonObject.class, id));
					first_name += user.getFirstName() + ",";
					last_name += user.getLastName() + ",";
					credit += user.getCredits() + ",";
					email += user.getEmail() + ",";
				} catch (Exception e) {
					System.out.println(e);
				}
			}
			obj.put("Email", email);
			obj.put("Firstname", first_name);
			obj.put("Lastname", last_name);
			obj.put("Credit", credit);
		}

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Regions"})
	@SuppressWarnings("unchecked")
	public ModelAndView listRegions(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// JSONObject output = new JSONObject();
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.COUNTRIES);
		String id = request.getParameter("Country_code");
		String unblocked_list = "";
		JsonObject obj2 = db.find(JsonObject.class, id);
		String country_name = obj2.get("Country_Name").toString().replaceAll("\"", "");
		String[] blocked_list = obj2.get("Blocked_list").toString().replaceAll("\"", "").split(",");
		String[] regions = obj2.get("Regions").toString().replaceAll("\"", "").split(",");
		boolean blocked = false;
		for (String r : regions) {
			String rs = r.replaceAll(" ", "+");
			for (String s : blocked_list) {
				if (rs.equalsIgnoreCase(s)) {
					blocked = true;
				}
			}
			if (!blocked) {
				unblocked_list += r + ",";
			}
		}
		System.out.println("success");
		JSONObject output = new JSONObject();
		output.put("result", "success");
		
		//XXX:  these were commented out in the actual production code, making this method a no-op
		output.put("Blocked_regions",blocked_list);
		output.put("Unblocked_regions",unblocked_list);
		output.put("Country_name",country_name);

		request.setAttribute("json", output);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(name = "Guest_mode_users", urlPatterns ={"/guest_mode_users"})
	@SuppressWarnings("unchecked")
	public ModelAndView listGuestUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String name = request.getParameter("screenname");
		String userAgent = request.getParameter("userAgent");
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.GUEST_USERS);

		JsonObject obj = new JsonObject();
		Date after = new Date();
		String time = after.toString();

		obj.addProperty("email", username);
		obj.addProperty("screenname", name);
		obj.addProperty("UserAgent", userAgent);
		obj.addProperty("_id", username);
		obj.addProperty("lasttime", time);
		try {
			db.save(obj);
		} catch (Exception e) {
			JsonObject json1 = db.find(JsonObject.class, username);
			json1.addProperty("UserAgent", userAgent);
			json1.addProperty("lasttime", time);
			db.update(json1);
		}
		
		//XXX:  this used to e-mail the server admin whenever a user started playing a tournament; that's kind of creepy and has been disabled
		JSONObject json = new JSONObject();
		json.put("result", "success");

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Create_tournament"})
	@SuppressWarnings("unchecked")
	public ModelAndView createTournament(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//initEjbs();
		
		JSONObject obj = new JSONObject();

		//FIXME:  this is a crappy way to handle the tournament fields (same pattern is repeated in many places)
		String fields = request.getParameter("create_tournament");
		
		String tournament_name = "";
        String starting_credit_points = "";
        String number_of_games = "";
        String number_of_MinPlayers = "";
        String number_of_MaxPlayers = "";
        String type = "";
        int count = 0;
        StringTokenizer sub_boxes = new StringTokenizer(fields, " ");
        
        while (sub_boxes.hasMoreTokens()) {
			String token = sub_boxes.nextToken();
            if(count == 0)
            	tournament_name=token;
            if(count == 1)
            	starting_credit_points=token;
            if(count == 2)
            	number_of_games=token;
            if(count == 3)
            	number_of_MinPlayers=token;
            if(count == 4 )
            	number_of_MaxPlayers=token;
            if(count == 4 )
            	number_of_MaxPlayers=token;
            if(count == 5)
            	type=token;
            
            count++;
		}
		
        Tournament tournament = new Tournament(tournament_name, type, parseInt(starting_credit_points), 
        				parseInt(number_of_games), parseInt(number_of_MinPlayers), parseInt(number_of_MaxPlayers));
		Boolean check = tournamentManager.createTournament(tournament);// create_tournament.Store_tournament(tournament);
		if (check) {
			obj.put("result", "success");
		} else {
			obj.put("result", "failed");
		}

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Country_details"})
	@SuppressWarnings("unchecked")
	public ModelAndView countryDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.COUNTRIES);
		String id = request.getParameter("Country_code");
		String unblocked_list = "";
		String blocked_list = "";
		JsonObject obj2 = db.find(JsonObject.class, id);
		String country_name = obj2.get("Country_Name").toString().replaceAll("\"", "");
		String[] blocked = obj2.get("Blocked_list").toString().replaceAll("\"", "").split(",");
		String[] regions = obj2.get("Regions").toString().replaceAll("\"", "").split(",");
		boolean blocked1 = false;
		for (String r : regions) {
			String rs = r.replaceAll(" ", "+");
			for (String s : blocked) {
				if (rs.equalsIgnoreCase(s)) {
					blocked1 = true;
					if (s.length() > 1)
						blocked_list += s + ",";
				}
			}
			if (!blocked1) {
				unblocked_list += r + ",";
			}
			blocked1 = false;
		}
		System.out.println("success");
		JSONObject output = new JSONObject();
		output.put("result", "success");
		output.put("Blocked_regions", blocked_list);
		output.put("Unblocked_regions", unblocked_list);
		output.put("Country_name", country_name);
		
		request.setAttribute("json", output);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Countries_list"})
	@SuppressWarnings("unchecked")
	public ModelAndView listCountries(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.COUNTRIES);

		List<JsonObject> list = db.view("_all_docs").query(JsonObject.class);
		String codes = "";
		String names = "";
		String region_names = "";
		JSONObject json = new JSONObject();
		for (JsonObject obj : list) {
			String id = obj.get("id").toString().replaceAll("\"", "");
			String unblocked_regions = "";
			boolean block = false;
			JsonObject obj2 = db.find(JsonObject.class, id);
			String country_name = obj2.get("Country_Name").toString().replaceAll("\"", "");
			String[] regions = obj2.get("Regions").toString().replaceAll("\"", "").split(",");
			String[] blocked_list = obj2.get("Blocked_list").toString().replaceAll("\"", "").split(",");
			codes += id + ",";
			names += country_name + ",";
			for (String s : regions) {
				String as = s.replaceAll(" ", "+");
				for (String d : blocked_list) {
					if (as.equalsIgnoreCase(d)) {
						block = true;
					}
					// region_names += regions + "|";
				}
				if (!block) {
					unblocked_regions += s + ",";
				}
				block = false;
			}
			region_names += unblocked_regions + "|";
		}

		json.put("Codes", codes);
		json.put("Names", names);
		json.put("Regions", region_names);

		request.setAttribute("json", json);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Bots_list"})
	@SuppressWarnings("unchecked")
	public ModelAndView listBots(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.BOTS);
		List<JsonObject> list = db.view("_all_docs").query(JsonObject.class);
		JSONObject users_lists = new JSONObject();
		String all_email_users = "";
		String playerlevel_users = "";
		String level_users = "";
		String nickname_users = "";
		String firstname_users = "";

		for (JsonObject json : list) {
			String id = json.get("id").toString().replace("\"", "");
			JsonObject obj = db.find(JsonObject.class, id);
			String nickname = obj.get("Nickname").toString().replace("\"", "");
			String firstname = obj.get("Firstname").toString().replace("\"", "");
			String player_level = obj.get("playerlevel").toString().replace("\"", "");
			String level = obj.get("level").toString().replace("\"", "");

			all_email_users += id + ",";
			playerlevel_users += player_level + ",";
			level_users += level + ",";
			nickname_users += nickname + ",";
			firstname_users += firstname + ",";
		}
		users_lists.put("Email", all_email_users);
		users_lists.put("Playerlevel", playerlevel_users);
		users_lists.put("level", level_users);
		users_lists.put("nickname", nickname_users);
		users_lists.put("firstname", firstname_users);

		request.setAttribute("json", users_lists);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Bots"})
	public ModelAndView manageBots(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//XXX:  this method doesn't do anything
		request.setAttribute("json", new JSONObject());
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/bot_registration"})
	@SuppressWarnings("unchecked")
	public ModelAndView createBot(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject obj = new JSONObject();
		JSONObject obj1 = new JSONObject();
		JSONObject obj2 = new JSONObject();
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.BOTS);
		CouchDbClient db1 = CouchDBUtil.getClient(CouchDatabase.KENTUCKY_USERS);
		List<JsonObject> list = db.view("_all_docs").query(JsonObject.class);
		int length = list.size();
		int count2 = 0;
		String email = "";
		// String password="";
		String firstname = "";
		String lastname = "";
		String nickname = "";
		String gender = "";
		String level = "";
		int count = 0;
		// response.setContentType("text/html;charset=UTF-8");
		System.out.println(" in the user_register");
		String register = request.getParameter("register");

		StringTokenizer sub_boxes = new StringTokenizer(register);

		while (sub_boxes.hasMoreTokens()) {
			String token = sub_boxes.nextToken();
			// views.add(token);
			if (count == 0)
				email = token;
			if (count == 1)
				firstname = token;
			if (count == 2)
				lastname = token;
			if (count == 3)
				nickname = token;
			if (count == 4)
				gender = token;
			if (count == 5)
				level = token;
			System.out.println(token);
			count++;
		}
		Date date = new Date();
		nickname = nickname.toLowerCase();
		try {
			obj.put("Email", email);
			obj2.put("_id", nickname);
			obj2.put("User_type", "botuser");
			db1.save(obj2);
			count2++;
			// obj.put("Password", password);
			obj.put("Firstname", firstname);
			obj.put("Lastname", lastname);
			obj.put("Gender", gender);
			obj.put("Nickname", nickname);
			obj.put("Credit", "1000");
			obj.put("CreatedAt", date.toString());
			obj.put("Last_login", date.toString());
			obj.put("User_type", "normaluser");
			obj.put("Status", "inactive");
			obj.put("_id", email);
			obj.put("no_of_tournaments", "0");
			obj.put("no_of_bitlets", "0");
			obj.put("no_of_bonuses", "1");
			obj.put("playerlevel", "1");
			obj.put("level", level);
			obj.put("User_id", length + 1);
			db.save(obj);
			obj1.put("result", "success");

		} catch (Exception e) {
			System.out.println(e);
			obj1.put("result", "fail");
			if (count2 == 0)
				obj1.put("message", "nickname");
			else
				obj1.put("message", "email");
		}

		request.setAttribute("json", obj1);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Bot_details"})
	@SuppressWarnings("unchecked")
	public ModelAndView botDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.BOTS);
		JSONObject obj1 = new JSONObject();
		try {
			String id = request.getParameter("username");
			JsonObject obj = db.find(JsonObject.class, id);
			obj1.put("result", obj);
		} catch (Exception e) {
			System.out.println(e);
			obj1.put("result", "fail");
		}

		request.setAttribute("json", obj1);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Bot_delete"})
	@SuppressWarnings("unchecked")
	public ModelAndView deleteBot(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.BOTS);
		JSONObject obj1 = new JSONObject();
		try {
			String id = request.getParameter("username");
			JsonObject obj = db.find(JsonObject.class, id);
			db.remove(obj);
			obj1.put("result", "success");
		} catch (Exception e) {
			System.out.println(e);
			obj1.put("result", "error");
		}
		
		request.setAttribute("json", obj1);	
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/bot_changes"})
	public ModelAndView updateBot(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject obj = new JSONObject();
		try {
			CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.BOTS);
			String username = request.getParameter("username");
			String firstname = request.getParameter("firstname");
			String lastname = request.getParameter("lastname");
			String nickname = request.getParameter("nickname");
			String no_bitlets = request.getParameter("bitlets");
			String no_bonuses = request.getParameter("bonuses");
			String no_tournaments = request.getParameter("tournaments");
			String player_level = request.getParameter("player_level");
			String credits = request.getParameter("credits");
			String level = request.getParameter("level");

			JsonObject json1 = db.find(JsonObject.class, username);
			json1.addProperty("Firstname", firstname);
			json1.addProperty("Lastname", lastname);
			json1.addProperty("Nickname", nickname);
			json1.addProperty("no_of_bitlets", no_bitlets);
			json1.addProperty("no_of_bonuses", no_bonuses);
			json1.addProperty("no_of_tournaments", no_tournaments);
			json1.addProperty("playerlevel", player_level);
			json1.addProperty("Credit", credits);
			json1.addProperty("level", level);
			db.update(json1);
		} catch (Exception e) {
			System.out.println(e);
		}

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: ??? (check original web.xml)
	@SuppressWarnings("unchecked")
	public ModelAndView blockedLocations(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.COUNTRIES);

		String country_code = request.getParameter("Country_code");
		String[] regions = request.getParameter("Regions").split(",");
		String notes = request.getParameter("Notes");
		JsonObject obj2 = db.find(JsonObject.class, country_code);
		String[] blocked_list = obj2.get("Blocked_list").toString().replaceAll("\"", "").split(",");
		String block_list = obj2.get("Blocked_list").toString().replaceAll("\"", "");
		boolean blocked = false;

		for (String r : regions) {
			for (String b : blocked_list) {
				if (b.equalsIgnoreCase(r))
					blocked = true;
			}
		}
		JSONObject output = new JSONObject();

		if (!blocked) {
			for (String r : regions) {
				if (blocked_list.length > 1) {
					block_list += "," + r.replaceAll(" ", "+");
				} else {
					block_list += r.replaceAll(" ", "+") + ",";
				}
			}
			output.put("result", "success");
			obj2.addProperty("Blocked_list", block_list);
			obj2.addProperty("Notes", notes);
			db.update(obj2);

		} else
			output.put("result", "failed");

		request.setAttribute("json", output);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Blocked_list"})
	@SuppressWarnings("unchecked")
	public ModelAndView blockedList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.COUNTRIES);

		List<JsonObject> list = db.view("_all_docs").query(JsonObject.class);
		String codes = "";
		String names = "";
		String region_names = "";
		JSONObject json = new JSONObject();
		for (JsonObject obj : list) {
			String id = obj.get("id").toString().replaceAll("\"", "");
			String unblocked_regions = "";
			boolean block = false;
			JsonObject obj2 = db.find(JsonObject.class, id);
			String country_name = obj2.get("Country_Name").toString().replaceAll("\"", "");
			String[] regions = obj2.get("Regions").toString().replaceAll("\"", "").split(",");
			String[] blocked_list = obj2.get("Blocked_list").toString().replaceAll("\"", "").split(",");
			codes += id + ",";
			names += country_name + ",";
			for (String s : regions) {
				String as = s.replaceAll(" ", "+");
				for (String d : blocked_list) {
					if (as.equalsIgnoreCase(d)) {
						block = true;
					}
					// region_names += regions + "|";
				}
				if (block) {
					unblocked_regions += s + ",";
				}
				block = false;
			}
			region_names += unblocked_regions + "|";
		}

		json.put("Codes", codes);
		json.put("Names", names);
		json.put("Regions", region_names);

		request.setAttribute("json", json);
		return new ModelAndView("json/legacyJsonView");
	}

	// was: @WebServlet(urlPatterns = {"/Admin_changes"})
	@SuppressWarnings("unchecked")
	public ModelAndView adminChanges(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject obj = new JSONObject();
		try {
			String username = request.getParameter("username");
			CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.USERS);
			String firstname = request.getParameter("firstname");
			String lastname = request.getParameter("lastname");
			String nickname = request.getParameter("nickname");
			String no_bitlets = request.getParameter("bitlets");
			String no_bonuses = request.getParameter("bonuses");
			String no_tournaments = request.getParameter("tournaments");
			String player_level = request.getParameter("player_level");
			String credits = request.getParameter("credits");
			// String nickname = request.getParameter("");

			User user = new User(db.find(JsonObject.class, username));
			user.setFirstName(firstname);
			user.setLastName(lastname);
			user.setNickname(nickname);
			user.setBitlets(Double.parseDouble(no_bitlets));
			user.setNumBonuses(Integer.parseInt(no_bonuses));
			user.setNumTournaments(Integer.parseInt(no_tournaments));
			user.setPlayerLevel(Double.parseDouble(player_level));
			user.setCredits(Long.parseLong(credits));
			
			userManager.update(user);
			obj.put("result", "success");

		} catch (Exception e) {
			obj.put("result", "fail");
		}

		request.setAttribute("json", obj);
		return new ModelAndView("json/legacyJsonView");
	}
	
	private int parseInt(String text) {
		try {
			return Integer.parseInt(text);
		}
		catch (Throwable ignored) {
			//ignored
		}
		
		return -1;
	}
}
