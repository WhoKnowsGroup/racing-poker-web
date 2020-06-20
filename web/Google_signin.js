
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

window.handleClientLoad = function() {
	gapi.load('client:auth', function() {
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

function handleAuthClick() {
    gapi.auth2.authorize({
        client_id: clientId,
        scope: scopes,
        immediate: false
    }, handleAuthResult);
}

function handleAuthResult(authResult) {
	//var authorizeButton = document.getElementById('authorize-button');
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
        alert("not authorized");
        //authorizeButton.onclick = handleAuthClick;
    }
}

//FIXME: things should not call this!!! (or should be modified so that all it does is set the user's nickname)
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
            // alert("success");

        }
        // window.location.href="index.html";
    );
}