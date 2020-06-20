    var user_id;
    var email_id = "";
    var first_name = "";
    var last_name = "";
    var nick_name = "";
    var gender = "";

    function statusChangeCallback(response) {
        console.log('statusChangeCallback');
        //console.log(response.name);
        // The response object is returned with a status field that lets the
        // app know the current login status of the person.
        // Full docs on the response object can be found in the documentation
        // for FB.getLoginStatus().
        if (response.status === 'connected' && response.authResponse) {
            // the user completed an authentication request with facebook; pass the auth details to the server so that it can log them in
        	/* response.authResponse will look like:
        	 * 
        	 * accessToken:
					"EAAWDHY1R5ZBYBAElSRC26UqiQ5b8gRRaTObFZBQbmf0SubHWkpx92nXz1xeFKFL1pxAxkyB22FNcY0IkH7mteBgR8Wx1X3D7j9B0pRGqAB6OceOEvMjgLf99VHD2Qgh47VaDriR26kXiblZCeJ24NeZCWWDN7PWZBwXMCj81cavWjPFduGBKfzJftQt3ZBKUhZCjrkhSX3RPAZDZD"
			   expiresIn: 5319,
			   signedRequest:
					"KkrHLMvbbSRhq-sGPa16lpTFWwte4lHHHbaCJG8ll0M.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImNvZGUiOiJBUUI1Vm9LREpoUjlRWUF4WDU0MF90a1BJZ1VRODZBd0U4QlZzaFFabUtKZmMtWnRvU1UxaHR5cE84SWI3b1J5b0RvSHc2NnEzRWo1NWJOYy14OEhRWl9TVHpUZlZvZU9qVnJ0a3ZGMnE1Sjg2b2d3dU9kbUc5ZFE5QTkyWnZ6cVU3SmJrM3pUYjRqeWxxZm5meFpRTUx3M3FlZkpJSFNGNHlIR1V3VmpWM21OcW1KaHYyeld5a2N2bGQ5bzJ3MU5zWnV0TVl1WWp3dzRYUXpINXRTazB6Q3dITlZVR1VEOXVJR3hqcWJCelRjZVhKeVdKRnU4Z3RfTmdkcWwxRWRCMktUcG9sdWRlN2tzRlBiS1ZpbFl0Zkh4eWtKT3BIeC12R3VqQm1NS0tfUVZpZlFzNTZYeFRNMEFWN3Y5VXRmTWgzRXZsQldkX1FDQ1J1YlBDSkt4YVJJS0k3MEs1NVZjQjd1bFBFR3dkbjNDMURhLTRwNkg2MXEycDFQc2RVWGw5ajAiLCJpc3N1ZWRfYXQiOjE1MTk3MjAyODEsInVzZXJfaWQiOiI2OTcwMDg3NDc4MjEifQ"
			   userID: "697008747821"
        	 */
        	$.getJSON("/r/facebookAuth", response.authResponse, function(data) {
        		console.log("facebookAuth result", data);

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
        else if (response.status === 'not_authorized') {
            // The person is logged into Facebook, but not your app.

        }
        else {
            // The person is not logged into Facebook, so we're not sure if
            // they are logged into this app or not.
        }
    }

    // This function is called when someone finishes with the Login
    // Button.  See the onlogin handler attached to it in the sample
    // code below.
    function checkLoginState() {
    	//this is the entry-point when the user clicks on 'Log in with Facebook'
        //okay to make this call client-side; user will complete auth w/ Facebook if they want
    	FB.getLoginStatus(function(response) {
            console.log(response);
            statusChangeCallback(response);
        });
    }

    window.fbAsyncInit = function() {
        FB.init({
            appId: '1551537831798758',
            cookie: true, // enable cookies to allow the server to access 
            // the session
            xfbml: true, // parse social plugins on this page
            oauth: true,
            version: 'v2.5' // use version 2.2
        });

        FB.getLoginStatus(function(response) {
            //statusChangeCallback(response);
        });

        FB.Event.subscribe('edge.create', function(response) {
            increase_credits("fblike");
        });

    };

    // Load the SDK asynchronously
    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s);
        js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

	//FIXME:  things should not call this!!!  (or should be modified so that all it does is set the user's nickname)
    function nickname() {
        nick_name = document.getElementById("snname").value;
        var fpassword = "abc1234";
        var register = email_id + " " + fpassword + " " + first_name + " " + last_name + " " + nick_name + " " + gender + " " + "5000.0";
        var info = document.getElementById("error_message2");
        info.innerHTML = "Verifying Nickname existence";
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
                                window.location.href = "/u/home";
                            }
                        });
                }
                else {

                    alert("Nickname already used");
                    var info = document.getElementById("error_message2");
                    info.innerHTML = "Please choose another Nickname";
                }
                // alert("success");

            }
            // window.location.href="index.html";
        );
    }

    function fb_share(url, message, name) {
        FB.ui({
                method: 'feed',
                app_id: '1551537831798758',
                place: '1011070518957670',
                link: url,
                picture: 'http://www.racingpoker.com/images/racingpoker-logo9.png',
                name: name,
                caption: 'Racing Poker',
                description: message
            },
            function(response) {
                console.log(response);
                if (response && (response.post_id || Array.isArray(response))) {
                	if (! response.error_message) {
                		// self.location.href = 'http://www.thomaspynchon.com/inherent-vice.html'
                		increase_credits("fbshare");
                	}
                }
                else {
                    // self.location.href = 'http://www.google.com/'
                }
            });
    }
    
    function increase_credits(id) {
        if(id == "fbshare") {
        	var d = new Date()
            sessionStorage.Payment_amount = 0.0;
            var transaction_id = "Pokerace"+ d.getFullYear()  +d.getMonth() + d.getDate()  + d.getHours() + d.getMinutes() +d.getSeconds() ;
            var Approval_status = "requested";
            var credits = 5000;
            var Description = "Fb-share-result";
            $.getJSON("/u/facebookAction", {"Transaction_id" : transaction_id, "Description" : "FB-share" }, function(data){ 
                if(data.result === "success") {
			        if (window.shareCountdown) {
			        	shareCountdown((60 * 60 * 24) - 1);
			        }
        
			        var credits  = data.Credit ;
			        //var bitlets = data.Bitlets;
			        //user_coins += 10.0;
			        var div3 = document.getElementById("credits");
			        var div4 = document.getElementById("bitlets");
			        var div5 = document.getElementById("level");
			        
			        if (div3 && div4 && div5) {
				        $("#promotionsModal").modal('hide');
	        
				        for(var i=0;i< 5000 ; i++) {
				            //credits_user += 1.0;
				            //div3.innerHTML = "<em> <span>"+ parseInt(credits_user) + "</em></span>" +"&nbsp;" +"Credits"+ "&nbsp; &nbsp;";
				            //div4.innerHTML = "<em> <span>" + parseInt(user_coins) + "</em></span>" + "&nbsp;"+"Coins"+ "&nbsp; &nbsp;";
				            //div5.innerHTML = "<em> <span>" + user_level + "</em></span>" + "&nbsp;"+"Level"+ "&nbsp; &nbsp;";
				        }
			        }
                }
                 
            });
        }
        else if(id == "fblike") {
        	var d = new Date()
            var transaction_id = "Pokerace"+ d.getFullYear()  +d.getMonth() + d.getDate()  + d.getHours() + d.getMinutes() +d.getSeconds() ;
            var Approval_status = "requested";
            var credits = 1000;
            var Description = "Fb-like";
            $.getJSON("/u/facebookAction", {"Transaction_id" : transaction_id, "Description" : "FB-like" }, function(data){ 
            	if(data.result === "success") {
            		if (window.likeCountdown) {
            			likeCountdown((60 * 60 * 24) - 1);
			        }
            		
            		var credits  = data.Credit ;
            		$("#ineligibleModal").modal('hide');
            		
            		var div3 = document.getElementById("credits");
			        if (div3) {
	            		$("#promotionsModal").modal('hide');
				        $('html,body').animate({ 
				           scrollTop:$("#credits").offset().top
				        },1000);
				        //div3.innerHTML = "<em> <span>" + credits_user + "</em></span>" +"&nbsp;" +"Credits"+ "&nbsp; &nbsp;";
				        //div3.innerHTML += "<em> <span>" + user_coins + "</em></span>" + "&nbsp;"+"Coins"+ "&nbsp; &nbsp;";
				        //div3.innerHTML += "<em> <span>" + user_level + "</em></span>" + "&nbsp;"+"Level"+ "&nbsp; &nbsp;";
				        for(var i=0;i< 1000 ; i++) {
				             //credits_user += 1.0;
				             //div3.innerHTML = "<em> <span>" + credits_user + "</em></span>" +"&nbsp;" +"Credits"+ "&nbsp; &nbsp;";
				             //div3.innerHTML += "<em> <span>" + user_coins + "</em></span>" + "&nbsp;"+"Coins"+ "&nbsp; &nbsp;";
				             //div3.innerHTML += "<em> <span>" + user_level + "</em></span>" + "&nbsp;"+"Level"+ "&nbsp; &nbsp;";
				        }
			        }
            	}
             
            });
        }
            
    }
