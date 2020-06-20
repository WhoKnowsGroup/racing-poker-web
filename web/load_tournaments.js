/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var High_list;
var Mid_list;
var Low_list = [];
var Single_player = [];

$.getJSON("/Tournament_list", { "command" : "tournament_list" }, function(data){ 
    
   console.log(data);
  var  High_level = data.High_list ? data.High_list : data.Mid_list;
  var  Mid_level = data.Mid_list;
  var  Low_level = data.Low_list;
  var  one_level = data.One_list;
  var hitCount = data.HitCount;
  
   var hitCount_div = document.getElementById("HomePageHits");
   if (hitCount_div) {
	   hitCount_div.innerHTML = "HomePageCount:" + hitCount ;
   }
   
   $.post("/a/listGuestUsers",{}, function(data){ 
    console.log(data);
    console.log(window.JSON.parse(data));
    data = window.JSON.parse(data);
    var hitCount = data.HitCount;
    console.log(hitCount);
   var hitCount_div = document.getElementById("GuestPageHits");
   if (hitCount_div) {
	   hitCount_div.innerHTML = "GuestCount:" + hitCount ;
   }
   });
  if(data.result == "success" && High_level)   
  {
      var length = High_level.length;
      var coins = [];
      var tournaments_list = [];
      
      for(var i=0; i< length ; i++)
      {
          var split_coins = High_level[i].split(",");
          coins[i] = parseInt(split_coins[1]);
          tournaments_list[i] = split_coins[0];
      }
      sort_list(coins,tournaments_list,length);
      High_list = tournaments_list.slice();
      coins =[];
      tournaments_list =[];
      length = Mid_level.length;
      for(var i=0; i< length ; i++)
      {
          var split_coins = Mid_level[i].split(",");
          coins[i] = parseInt(split_coins[1]);
          tournaments_list[i] = split_coins[0];
      }
      sort_list(coins,tournaments_list,length);
      
      
      Mid_list = tournaments_list.slice();
      length = Low_level.length;
      coins =[];
      tournaments_list =[];
      
      for(var i=0; i< length ; i++)
      {
          var split_coins = Low_level[i].split(",");
          coins[i] = parseInt(split_coins[1]);
          tournaments_list[i] = split_coins[0];
      }
      sort_list(coins,tournaments_list,length);
      Low_list = tournaments_list.slice();
      
      length = one_level.length;
      coins =[];
      tournaments_list =[];
      
      for(var i=0; i< length ; i++)
      {
          var split_coins = one_level[i].split(",");
          coins[i] = parseInt(split_coins[1]);
          tournaments_list[i] = split_coins[0];
      }
      sort_list(coins,tournaments_list,length);
      Single_player = tournaments_list.slice();

      //alert(High_list);
      //alert(Mid_list);
     // alert(Low_list);
     // alert(Single_player);
      
      add("high_list",High_list);
      add("mid_list",Mid_list);
      add("entry_list",Low_list);
      add("one_list",Single_player);
}     
});

function sort_list(coins,tournaments_list,length)
{
   // console.log(tournaments_list);
   // console.log(coins);
    for(var i=0; i < length; i++)
    {
         console.log(tournaments_list);
         console.log(coins);
        
        for(var j= 0 ; j < (length - i -1) ; j++)
        {
            if(coins[j] < coins[j+1])
            {
                var swap_coin = coins[j];
                var swap_tournament = tournaments_list[j];
                coins[j] = coins[j+1];
                tournaments_list[j] = tournaments_list[j+1];
                tournaments_list[j+1] = swap_tournament;
                coins[j+1] = swap_coin;
            }
        }
       
    }
    
    //console.log(tournaments_list);
    
}
function add(element,list)
{
    var ul_one = document.getElementById(element);
    if (! ul_one) {
    	console.log("WARN:  Expected element id not found:  " + element, element, list);
    	return;
    }
    ul_one.style.textAlign = "left";
    for(var i=0; i < list.length ; i++)
    {
        
                list[i].replace(/"/gi,"");
               // var list_split = list[i].split(",");
                 var high_list = document.createElement('li');
                 var a = document.createElement('a');
                  a.setAttribute('href',"#");
                  a.setAttribute('id',list[i]);
                  a.setAttribute('onclick',"clicked_link(this.id)");
                  a.innerHTML = list[i].replace(/-/gi," ");
                  high_list.appendChild(a);
                  ul_one.appendChild(high_list);
    }
    
}
