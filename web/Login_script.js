/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var error_count = 0 ;
var error_message = "";

$("#password_login").keyup(function(event){
    if(event.keyCode == 13){
        login();
    }
});

$('#register_button').click(function(){
      //Some code
     // alert("register_button");
 });
 

function forgot_load()
 {
    $('#login_popup1').modal('hide');
    $('#forgot').modal('show');
 }
 
 function email_password()
             {
                // alert("in the mail");
                // var emailRegex = /^[A-Za-z0-9._]*\@[A-Za-z]*\.[A-Za-z]{2,5}$/;
                 var email =$("#email_forgot").val();
               //  alert(email);
                  if (email === "" )
 {
   document.getElementById("email_forgot").focus();
   document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />"+" Please enter your email address";
   return false;
  }else
  {
      //document.getElementById("email_forgot").focus();
         var x = email;
         var atpos = x.indexOf("@");
         //alert(atpos);
         var dotpos = x.lastIndexOf(".");
        // alert(dotpos);
        // alert(x.length);
         if (atpos < 1 || dotpos < atpos+2 || dotpos+2 >= x.length) {
        //alert("Not a valid e-mail address");
        document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />"+" Please enter your valid email address";
        return false;
         }
     }
     $.getJSON("/Forgotpassword", {"email" : email , "command" : "Forgotpassword" }, function(data){ 
         
                         if(data.result === "success")
                         {registrationPage
                        document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/correct.jpg\" width=\"15px\" heigth=\"15px\"  />"+" An email is sent to your email address with your login details" ;
                        $("#email_forgot_message").hide();
                         }else
                         {
                             document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />"+"You are not a registered user." + " Please <a href=\"/r/registrationPage\" id=\"Register.html\">click here</a> to register" + ".";
                         }
                                
    });
          }
function hand()
{
    //alert("in the hand function"); 
    $.getJSON("/FrontControl", {"hand" : "hand", "command" : "hand" }, function(data){ 
			//alert("in the servlet");
                        //alert(data.hand);
                    });
}
function register()
{
   // alert("register_button");
    
    var register="";
    var emailRegex = /^[A-Za-z0-9._]*\@[A-Za-z]*\.[A-Za-z]{2,5}$/;
    var email =$("#email_register").val();
    var fpassword=$("#password_register").val();
    var cpassword=$("#cpassword").val();
    var fname=$("#fname").val();
    var lname=$("#lname").val();
    var nname=$("#nname").val();
    var gender=$("#gender").val();
    var birthYear = $("#birthYear").val();
  
    if (email === "" )
 {
   document.getElementById("email_register").focus();
   document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />"+" Please enter your email address";
   return false;
  }else
  {
      document.getElementById("email_register").focus();
         var x = email;
         var atpos = x.indexOf("@");
         //alert(atpos);
         var dotpos = x.lastIndexOf(".");
         //alert(dotpos);
         //alert(x.length);
         if (atpos < 1 || dotpos < atpos+2 || dotpos+2 >= x.length) {
        //alert("Not a valid e-mail address");
        document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />"+" Please enter your valid email address";
        return false;
    }
  }
   if(fpassword === "")
  {
      document.getElementById("password_register").focus();
     document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />"+"Please enter your password";
     return false;
  }
  else
  {
      if(fpassword.length < 7)
      {
     document.getElementById("password_register").focus();
     document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />"+"Please enter your password with 7 - 10 characters";
     return false;
      }    
     else
     {
      if(cpassword === "")
      {
     document.getElementById("cpassword").focus();
     document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />"+"Confirm password cannot be empty";
     return false;
      }   
      else
      {
          if(cpassword !== fpassword)
          {
              document.getElementById("cpassword").focus();
              document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />"+"Mismatch between password and confirm password";
               return false;
          }
      }
     }
  }
  if(fname === "")
  {
     document.getElementById("fname").focus();
     document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />"+"Please enter your first name";
     return false;
   }
    if( lname === "" )
   {
    // document.form.Name.focus() 
     document.getElementById("lname").focus();
     document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />"+"Please enter your Last name";
     return false;
   }
   if( nname === "" )
   {
    // document.form.Name.focus() ;
     document.getElementById("nname").focus();
     document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />"+"Please enter your nick name";
     return false;
   }
     if( document.getElementById("age").checked)
    {
        
    }
    else
    {
        document.getElementById("age").focus();
        document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />"+" You have to be 18 years old.";
        return false;
    }
    var command="register";
    register =  email +" "+fpassword + " "+ fname + " "+lname + " "+nname + " "+ gender + " " + birthYear;
    
    $("#register_form").find("input,select,a,button").attr("disabled", "disabled").addClass("disabled");
    $.post("/FrontControl", {"register" : register , "command" : command }, function(data){ 
    	$("#register_form").find("input,select,a,button").removeAttr("disabled").removeClass("disabled");
			//alert(data.result);
                       // alert("wait");
                         console.log(data.result);
                         if(data.result === "success")
                         {
                        document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/correct.jpg\" width=\"15px\" heigth=\"15px\"  />"+"Your  registeration is successful. In a moment, you will be redirected to home Page. Please be paitent." ;
                        
                               if (sessionStorage.username)
                                       {
                                       sessionStorage.username = email;
                                       }
                                      else
                                       {
                                      sessionStorage.username = email;
                                       }
                                 setTimeout(function() 
                                  {
                                       
                                      window.location.href="/u/home";
                                  
                                  }, 2000);
                         }else
                         {
                             if(data.message == "nickname")
                             {
                                 document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />"+"Nickname already exists. Try adding 1 to nickname." ;
                                 
                             }
                             else
                             {
                             document.getElementById("message").innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />"+"You are already a registered user."+ " Please <a href='javascript:void(0)' onclick=\"$('.loginButton').trigger('click');\">click here</a> to login.";
                           }
                         }
                    },"json");
	
}
function login()
{
    //alert("in login");
    var email = $("#email_login").val();
    var password = $("#password_login").val();
    var login = email+" "+password;
    var userAgent1 = navigator.userAgent;
    //alert(login);
    $.post("/FrontControl", {"login" : login, "command":"login", "userAgent": userAgent1, "email": email, "password": password }, function(data){ 
			//alert("in the servlet")
                       // alert(data.result);
                        console.log(data);
                        if(data.result === "success")
                        {
                         //$("#login1_popup").modal('hide');
                        //alert(data.user_type);
                         if(typeof(Storage) !== "undefined") 
                         {
                             if (sessionStorage.username)
                             {
                             sessionStorage.username = email;
                             }
                             else
                             {
                              sessionStorage.username = email;
                             }
                         } 
                        else {
                            alert("Sorry, your browser does not support HTML5");
                        }
                        console.log(data.user_type);
                        if(data.user_type === "normaluser")
                        {
                         document.getElementById("login_form").submit();
                           window.location.href = "/u/home";                                         
                        }
                        if(data.user_type === "adminuser")
                        window.location.href= "bootstrap_home_admin.html";                        
                        if(data.user_type === "semiuser")
                        window.location.href= "/u/home"; 
                        }
                         else
                        {
                            var message = " Username or Password is incorrect";
                            error_count = parseInt(error_count) + 1;
                            if(error_count === 1)
                              message = " Username or Password is incorrect";
                            if(error_count >= 2 )
                              message = " mmm, we seem to be having some difficulty. You can try a few more times";
                            if(error_count === 4 )
                             message = "Okay this doesn't seem to be getting better at all. How about 1 more try?";
                            if(error_count >= 10)
                            {   
                             message = "Please reset your password. Click forgot password";
                             
                             }
                            //alert("1");
                            error_message = message ;
                            error(message);
                        }
                       // alert(data.hand);
                    },"json");
}
function error(msg)
{
   // alert(msg);
     var divchild = document.getElementById("error_message");
     divchild.innerHTML = "&nbsp" + "<img  src=\"/images/Delete.png\" width=\"15px\" heigth=\"15px\"  />" + error_message;
     //alert(msg);
}

