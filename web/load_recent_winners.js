/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var recent_winners = [];
var recent_level = [];
var recent_rank = [];
var count ;
var list_length =0;
$(document).ready(function(){
    
    console.log("recent");
    $.getJSON("/Recent_winners", { "command" : "Recent_winners" }, function(data){ 
        
        console.log(data.Players);
        
      //  recent.innerHTML = "";
        recent_winners = data.Players.split(",");
        recent_level =  data.level.split(",");
        recent_rank  =  data.rank.split(",");
        
        list_length = recent_winners.length ;
        count = list_length -2 ;
       display();
       setInterval(function()
       { 
          display();
       },3000);
    });
    
});
function display()
{
	if (! document.getElementById("recent4")) {
		return;
	}
    var credits = recent_winners[count];
    var level = parseInt(recent_level[count]);
    var rank = parseInt(recent_rank[count]) + 1;
    if(rank == 1)
    rank="1st";
    if(rank == 2)
    rank="2nd";
    if(rank == 3)
    rank="3rd";
    var rank_word = "";
   // credits[1] = parseInt(credits[1]);
    var recent = document.getElementById("recent4");
    recent.innerHTML =  credits +" "+"ranked "+rank + " in a tournament " +"and reached  level " + ":" +"&nbsp;" +level ;
    count --;
    if(count == 0)
    {
        count = list_length - 2;
    }
    
}