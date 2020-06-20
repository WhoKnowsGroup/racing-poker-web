/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function()
{
    

var username="";
             if(typeof(Storage) !== "undefined") 
                         {
                             if (sessionStorage.username)
                             {
                               username = sessionStorage.username;
                               console.log(username);
                             }
                             else
                             {
                              //sessionStorage.username = email;
                               //window.location.href = "index.html"; 
                             }
                         } 
                        else {
                            alert("Sorry, your browser does not support HTML5");
                        }
            // alert(username);
          
            
             $.getJSON("/FrontControl", {"username" : username, "command" : "verify" }, function(data){ 
                 
                 if(data.result === "success")
                 {
                 // alert("success")   ;
                 }
                 
                else
                {
                   // connection_check();
                    //window.location.href="index.html";
                    return false;
                }
                 
             });
             
             $.getJSON("/FrontControl", {"username" : username, "command" : "user_details" }, function(data){ 
			//alert("in the servlet");
                       // alert(data.result);
                       // alert(data.user_detail);
                        var user_split = data.user_detail.split(",");
                        var user_credit = user_split[1];
                        var user_fname = user_split[2];
                        var user_lname = user_split[3];
                        var user_nname = user_split[0];
                        
                        var user_coins = user_split[6];
                        var user_level = parseFloat(user_split[7]);
                        var user_wins = "2";
                        
                      
;                        var div1 = document.getElementById("user_profile");
                        div1.innerHTML = "<a href=\"/u/profile\"class=\"btn btn-success\"><span class=\"glyphicon glyphicon-user\"></span>"+user_nname +"</a>" +" " +  "<button  type=\"button\" onclick=\"logout()\" class=\"btn btn-danger\">" + "Logout" + "</button>";
                      
                        
             });        
});
