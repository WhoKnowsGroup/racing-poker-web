/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


    var user_id ;
    var email_id ="";
    var first_name ="";
    var last_name = "";
    var nick_name = "";
    var gender = "";

function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response.status);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
      //fb_login();
    } else if (response.status === 'not_authorized') {
      // The person is logged into Facebook, but not your app.
     //testAPI();
    // fb_login();
    $("#user_input").modal('show');
     
    } else {
      // The person is not logged into Facebook, so we're not sure if
      // they are logged into this app or not.
      //testAPI();
      //  $("#user_input").modal('show');
      //fb_login();
      $("#user_input").modal('show');
         }
    }
/// Log the user from the app
    
    
    
  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
     
    FB.getLoginStatus(function(response) {
      console.log(response);
      statusChangeCallback(response);
    });
  }

  window.fbAsyncInit = function() {
  FB.init({
    appId     : '1551537831798758',
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    oauth      : true,
    version    : 'v2.5' // use version 2.2
  });
 /* $.browser.chrome = /chrome/.test(navigator.userAgent.toLowerCase());
if ($.browser.chrome || $.browser.msie) {
    FB.XD._origin = window.location.protocol + "//" + document.domain + "/" + FB.guid();
    FB.XD.Flash.init();
    FB.XD._transport = "flash";
  } else if ($.browser.opera) {
    FB.XD._transport = "fragment";
    FB.XD.Fragment._channelUrl = window.location.protocol + "//" + window.location.host + "/";
  }*/
  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
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


function fb_login()
    {
        console.log("in fb_login function");
        
        FB.login(function(response){
            console.log(response);
        if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
        
    } else if (response.status === 'not_authorized') {
      // The person is logged into Facebook, but not your app.
     //testAPI();
    } else {
      // The person is not logged into Facebook, so we're not sure if
      // they are logged into this app or not.
      //testAPI();
        $("#user_input").modal('show');
         }        
        },{scope:"public_profile,user_friends,email,publish_actions"});
    
    }
  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() {
    
    var status="";
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me?fields=id,name,email,first_name,last_name,birthday', function(response) {
      console.log('Successful login for: ' + response.name);
    //  document.getElementById('status').innerHTML =
      console.log(response);
      user_id = response.id 
      email_id = response.email;
      first_name = response.first_name;
      last_name = response.last_name;
      gender = response.gender;
      if(gender != "male" || gender != "female")
      gender = "male";
      screenname = first_name;
      console.log(email_id);
      console.log(screenname);
       if(screenname.length > 0)
    {
         $.getJSON("/Facebook_login", {"command" : "login", "email": email_id , "first_name" : first_name , "last_name" : last_name , "nick_name" : nick_name, "gender" : gender }, function(data){ 
			console.log(data);
                        
                       if(data.result === "success")
        {
                          if(typeof(Storage) !== "undefined") 
                         {
                             if (sessionStorage.username)
                             {
                             sessionStorage.username = email_id;
                             }
                             else
                             {
                              sessionStorage.username = email_id;
                             }
                            window.location.href = "https://www.racingpoker.com/home.html";
                         } 
                        else 
                        {
                            
                            alert("Sorry, your browser does not support HTML5");
                        }
           // alert("success");
           
        }
        else
        {
           // alert("failed");
        $("#user_input").modal('show');
        document.getElementById("screenname").value = screenname;
        $("#social").hide();
        $("#email_register").hide();
        document.getElementById("email").value = email_id ;
             
             //alert("Facebook register coming soon");
        }
                   // window.location.href="index.html";
                 
    }); 
       
    }
    else
    {
        console.log("not valid");
        //$("#user_input").modal('show');
    }
     // alert("Login successful");
     // alert(email_id);  
    //alert(email_id);
  /*   $.getJSON("Facebook_login", {"command" : "login", "email": email_id , "first_name" : first_name , "last_name" : last_name , "nick_name" : nick_name, "gender" : gender }, function(data){ 
			console.log(data);
                        
                       if(data.result === "success")
        {
                          if(typeof(Storage) !== "undefined") 
                         {
                             if (sessionStorage.username)
                             {
                             sessionStorage.username = email_id;
                             }
                             else
                             {
                              sessionStorage.username = email_id;
                             }
                            window.location.href = "home.html";
                         } 
                        else 
                        {
                            
                            alert("Sorry, your browser does not support HTML5");
                        }
           // alert("success");
           
        }
        else
        {
           // alert("failed");
         /*  $("#login_form").hide();
           $("#Forgotpassword").hide();
           $("#login").hide();
           var fb_register = document.getElementById("fb_register");
           fb_register.style.visibility = "visible";
             $('#login_popup1').modal('hide');
             $('#login_popup2').modal('show');
             
             //alert("Facebook register coming soon");
        }
                   // window.location.href="index.html";
                    }); */
    }); 
    
   
        
  }
  
  function nickname()
  {
       nick_name = document.getElementById("snname").value;
       var fpassword = "abc1234";
       var register =  email_id +" "+fpassword + " "+ first_name + " "+last_name + " "+nick_name + " "+ gender+" "+"5000.0";
       var info = document.getElementById("error_message2");
       info.innerHTML = "Verifying Nickname existence";
      // alert("in the servlet");
      $.getJSON("/Socialwebsite_userregistration", {"command" : "register", "register":register }, function(data){ 
			
                      console.log(data);
                        
                       if(data.result === "success")
             {
                  $.getJSON("/Facebook_login", {"command" : "login", "email": email_id , "first_name" : first_name , "last_name" : last_name , "nick_name" : nick_name, "gender" : gender }, 
                  function(data){ 
                      
             		console.log(data);
         
                          if(typeof(Storage) !== "undefined") 
                         {
                             if (sessionStorage.username)
                             {
                             sessionStorage.username = email_id;
                             }
                             else
                             {
                              sessionStorage.username = email_id;
                             }
                              window.location.href = "home.html";
                         } 
                     });
                 }
                        else 
                        {
                            
                            alert("Nickname already used");
                             var info = document.getElementById("error_message2");
                            info.innerHTML = "Please choose another Nickname";
                        }
           // alert("success");
           
        }
                          // window.location.href="index.html";
   );
 }
 
function fb_share(url,message,name)
{
    FB.ui({
      method: 'feed',
      app_id: '1551537831798758',
      place: '1011070518957670',
      link: url,
      picture: 'http://www.racingpoker.com/images/racingpoker-logo9.png',
      name: name,
      caption: 'Racing Poker Tournament Results',
      description: message
    },
    function(response){
        console.log(response);
      if(response && response.post_id) {
       // self.location.href = 'http://www.thomaspynchon.com/inherent-vice.html'
       //increase_credits("fbshare");
      }
      else {
       // self.location.href = 'http://www.google.com/'
      }
    });
}
function share()
{
    var url= "https://apps.facebook.com/racingpoker";
     var message = screenname+" "+" just played a Racing poker &trade; tournament" + " and achieved a new level. Please click here to look into tournament results.";
     var heading = screenname+"'s new Achievement";    
     fb_share(url,message,heading);
    
}