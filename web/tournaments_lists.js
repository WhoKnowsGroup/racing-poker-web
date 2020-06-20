/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(){
   list() ;
});
function clicked(id)
{
    //alert(id);
    window.location.href=id;
}
function logout()
{
    //alert("logout");
    var username="";
             //var cookie_username="";
             
  //FIXME:  taking username from cookie; should be passed in from server
    		var cook=document.cookie.split(";");
             var length=cook.length;
             for(var i=0;i<length;i++)
             {
              // alert(cook[i]);
               var split = cook[i].split("=");
               if(split[0] === "username")
               username = split[1]; 
       }
     $.getJSON("/FrontControl", { "command" : "logout", "email" : username }, function(data){
        
        if(data.result === "success")
        {
           // alert("success");
            window.location.href = "index.html";
        }
        else
        {
           // alert("failed");
        }
    
      });
}
function list()
{
 var tournaments_length =0;
            // alert("in the servlet");
               $.getJSON("/Tournament_list", { "command" : "tournament_list" }, function(data){ 
                
                  var ul_high =  document.getElementById('high_list');
         var ul_mid =  document.getElementById('mid_list');
         var ul_entry =  document.getElementById('entry_list');
         var ul_one = document.getElementById('one_list');
         var list = data.tournament_list.split(" ");
         var length = list.length;
         //console.log(length);
          if(length > tournaments_length )
               for ( var i = 0 ; i< length  ; i++)
               {
                // alert(length);
                list[i].replace(/"/gi,"");
                var list_split = list[i].split(",");
               // console.log(list_split);
                
                 var high_list = document.createElement('li');
                 var a = document.createElement('a');
                  a.setAttribute('href',"");
                  a.setAttribute('id',list_split[0]);
                  a.setAttribute('onclick',"clicked_link(this.id)");
                  a.innerHTML = list_split[0].replace(/-/gi," ");
                  high_list.appendChild(a);
                  //console.log(high_list);
                  if(list_split[1] >= 5000)
                  {
                  $(ul_high).append(high_list);
                  }
                  if(list_split[1] >= 2000 && list_split[1] < 5000)
                  {
                  $(ul_mid).append(high_list);
                  }
                  if(list_split[1] == 1000)
                  {
                  $(ul_one).append(high_list);
                  }
                   if(list_split[1] < 1000)
                  {
                  $(ul_entry).append(high_list);
                  }
                  
                 
               }
         
 
               });
           
           }           
            function clicked_link(id)
            {
               // alert(id);
               // document.cookie = "tournament_id" + "=" + id;
               id = id.replace(/"/gi,"");
                $.getJSON("/FrontControl", {"clicked" : id, "command" : "clicked" }, function(data){ 
                   // alert(data.result);
                    window.location.href = "Tournament_details.html";   
                });
                 
            }
          