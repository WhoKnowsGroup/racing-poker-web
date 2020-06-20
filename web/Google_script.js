//production keys
//var clientId = '86010243824-6seapl6v8hjablprbmkjkf0jfj4ah6h9.apps.googleusercontent.com';
//var apiKey = 'AIzaSyCTiOaoXN_cL4gkwUjV32B_gsj1-B_1M-U';

//stage keys
var clientId = '387715727647-kctkmi847db13tldotf5v9a2evk0inqq.apps.googleusercontent.com';
var apiKey = 'W1SF9PkZj4bpu6GDhRM0iOOl';

var scopes = 'https://www.googleapis.com/auth/plus.login ' + 
             'https://www.googleapis.com/auth/userinfo.email ' + 
             'https://www.googleapis.com/auth/userinfo.profile ' + 
             'https://www.googleapis.com/auth/plus.me ' + 
             'https://www.googleapis.com/auth/plus.profile.emails.read';

var user_id;
var email_id = "";
var first_name = "";
var last_name = "";
var nick_name = "";
var gender = "male";

window.handleClientLoad = function() {
	gapi.load('client:auth', function() {
		gapi.signin.render('myButton', {
	        'clientid': clientId,
	        'cookiepolicy': 'single_host_origin',
	        'callback': 'signinCallback',
	        'requestvisibleactions': 'http://schema.org/AddAction http://schema.org/CommentAction',
	        'scope': scopes
	    });
	    gapi.client.setApiKey(apiKey);
	    //window.setTimeout(checkAuth, 1);
	});
};

function checkAuth() {
    gapi.auth2.authorize({
        client_id: clientId,
        scope: scopes,
        immediate: true
    }, handleAuthResult);
}

function handleAuthClick(event) {
    gapi.auth2.authorize({
        client_id: clientId,
        scope: scopes,
        immediate: false
    }, handleAuthResult);
    return false;
}

function handleAuthResult(authResult) {
    // var authorizeButton = document.getElementById('authorize-button');
	if (authResult && !authResult.error && authResult.access_token) {
		//pass auth details up to the server, handle as with Facebook
    	$.getJSON("/r/googleAuth", {accessToken: authResult.access_token}, function(data) {
    		console.log("googleAuth result", data);

            if (data.result === "success") {
                if (typeof(Storage) !== "undefined") {
                    if (sessionStorage.username) {
                        sessionStorage.username = email_id;
                    }
                    else {
                        sessionStorage.username = email_id;
                    }
                    window.location.href = "/u/home";
                }
                else {
                    //alert("Sorry, your browser does not support HTML5");
                	window.location.href = "/r/indexPage";
                }
            }
            else {
                /*  $("#login_form").hide();
                  $("#Forgotpassword").hide();
                  $("#login").hide();
                  var fb_register = document.getElementById("fb_register");
                  fb_register.style.visibility = "visible";*/
                $('#login_popup1').modal('hide');
                $('#login_popup2').modal('show');
            }
    	});
    }
    else {
        // authorizeButton.style.visibility = '';
        // authorizeButton.onclick = handleAuthClick;
    	//FIXME:  infinite loop if the user never approves
        handleAuthClick(event);
    }
}

//FIXME:  things should not call this!!!  (or should be modified so that all it does is set the user's nickname)
function gnickname() {
    nick_name = document.getElementById("gnname").value;
    var fpassword = "abc1234";
    var register = email_id + " " + fpassword + " " + first_name + " " + last_name + " " + nick_name + " " + gender + " " + "5000.0";
    // alert("in the servlet");
    $.getJSON("/Socialwebsite_userregistration", {
        "command": "register",
        "register": register
    }, function(data) {

        console.log(data);

        if (data.result === "success") {
            $.getJSON("/Facebook_login", {
                    "command": "login",
                    "email": email_id,
                    "first_name": first_name,
                    "last_name": last_name,
                    "nick_name": nick_name,
                    "gender": gender
                },
                function(data) {

                    console.log(data);

                    if (typeof(Storage) !== "undefined") {
                        if (sessionStorage.username) {
                            sessionStorage.username = email_id;
                        }
                        else {
                            sessionStorage.username = email_id;
                        }
                        window.location.href = "bootstrap_/u/home";
                    }
                });
        }
        else {

            alert("Nickname already used");
        }

    });
}
