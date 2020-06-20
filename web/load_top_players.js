/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var top_players = [];
var players_level = [];
var count_rows =0;
var table_rows =0;
var levels_length = 0;
var sub_list_not_displayed =0;
var level_rows =0;
var hitCount =0;
$(document).ready(function(){
    
             $.getJSON("/Top_players", {  }, function(data){ 
                 
                 
                 console.log(data);
                 if (! data) {
                	 return;
                 }
                 
                 players_level = data.Levels.split(",") ;
                 top_players = data.Names.split(",") ;
                 hitCount = data.HitCount;
                 
                 var top10 = data.topPlayers;			//[{name: '', level: '', avatar: ''}, ...]
                 var topWeekly = data.weeklyPlayers;
                 var topDaily = data.dailyPlayers;
                 var topShots = data.topShots;			//[{name: '', shotType: '', numShots: ''}, ...]
                 
                 /*for (var index = 0; index < top_players.length; index++) {
                	 var entry = {name: top_players[index], level: players_level[index]};
                	 if (top10.length < 10) {
                		 top10.push(entry);
                	 }
                	 else if (topWeekly.length < 10) {
                		 topWeekly.push(entry);
                	 }
                	 else if (topDaily.length < 10) {
                		 topDaily.push(entry);
                	 }
                	 else {
                		 break;
                	 }
                 }*/
                 
                 drawPlayerList(top10, ".allTimeBest");
                 drawPlayerList(topWeekly, ".weeklyBest");
                 drawPlayerList(topDaily, ".dailyBest");
                 
                 drawShotList(topShots, ".shotsTable");
                 
                 //alert(levels_length);
                // display();
                 var url = window.location.pathname;
                console.log(url);
                var hitCount_div = document.getElementById("IndexPageHits");
                if(! hitCount_div || url == "/index.html" || url == "/" || url == "/r/indexPage") {
                    setInterval(function()
                   { 
                      display();
                   },4000);
                } else {
                    
                    hitCount_div.innerHTML = "HitCount:" + hitCount ;
                }
                   
             });
             
             function drawShotList(list, selector) {
            	 var table = $(selector);
            	 table.html("");
            	 
            	 for (var index = 0; index < list.length; index++) {
            		 var rank = index + 1;
            		 var entry = list[index];
            		 var row = $("<tr></tr>");
            		 
            		 row.append("<td>" + rank + "</td>");
            		 row.append("<td>" + entry.name + "</td>");
            		 row.append("<td>" + entry.shotType + "</td>");
            		 row.append("<td>" + parseInt(entry.numShots, 10) + "</td>");
            		 
            		 table.append(row);
            	 }
             }
             
             function drawPlayerList(list, selector) {
            	 var table = $(selector);
            	 table.html("");
            	 
            	 for (var index = 0; index < list.length; index++) {
            		 var rank = index + 1;
            		 var entry = list[index];
            		 var row = $("<tr></tr>");
            		 
            		 row.append("<td>" + rank + "</td>");
            		 row.append("<td>" + entry.name + "</td>");
            		 row.append("<td>" + entry.level + "</td>");
            		 
            		 table.append(row);
            	 }
             }
             
             function display()
             {
            	 if (! document.all("players_list")) {
            		 return;
            	 }
              
                if(count_rows > 0)
                delete_row();
              
                for(var j = 0 ; j < 5 ; j++)
                 {
                      var newRow = document.all("players_list").insertRow(); 
                      newRow.style.textAlign = "center";
                      var oCell = newRow.insertCell();
                      oCell.innerHTML = count_rows+1;
                      var oCell1 = newRow.insertCell();
                      newRow.style.textAlign = "left";
                      oCell1.innerHTML = top_players[count_rows];
                      var oCell2 = newRow.insertCell();
                      oCell2.innerHTML = players_level[count_rows];
                      count_rows++ ; 
                 }
                 
             }
             
             
                                 
                  
             
             function delete_row()
             {
                 
                 for(var j=0;j< 5; j++)
                 {
                      document.getElementById("players_list").deleteRow(1);
                 } 
                 //table_rows =0;
                 if(count_rows >= 49)              
                 {
                     count_rows =0;
                 }
             }
});

