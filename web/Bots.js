/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var bot_firstname ;
var bot_lastname ;
var bot_credits ;
var bot_playerlevel;
 $.getJSON("/Bots", { "command" :"bot_details" }, function(data){ 
			alert("in the servlet");
                    });