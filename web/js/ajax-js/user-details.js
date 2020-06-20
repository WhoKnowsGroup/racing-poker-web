/**
 * This file gets user details for given sessionId
 */
var user;
var userEmailAddress = "";
var userFirstName = "";
var userLastName = "";
var userUserName = "";
var userGender = "";

var userCredits = 0.0;
var userPlayerLevel = 0.0;
var userGoldCoins = 0.0;

$(function() {
	$.post("UserInfoController",{},function(data) {
		console.log(data);
		if (data.result === "success") {
			user = data.user;
			
			userEmailAddress = user.emailAddress;
			userFirstName = user.firstName;
			userLastName = user.lastName;
			userUserName = user.userName;
			
			userCredits = user.credits;
			userPlayerLevel = user.xpPlayerLevel;
			userGoldCoins = user.goldCoins;
			renderUserDetails();
		} else {
			// redirect to index page 
		}
	}, "json");
});

function renderUserDetails() {
	var userName = document.getElementById("userName");
	userName.innerHTML = "<p>" + userFirstName + "<br>" + userLastName + "</p>";
	
	var profileName = document.getElementById("profileName");
	profileName.innerHTML = userUserName ;
	
	var goldCoins = document.getElementById("goldCoins");
	goldCoins.innerHTML = userGoldCoins;
	
	var credits = document.getElementById("credits");
	credits.innerHTML = "$" + userCredits;
}