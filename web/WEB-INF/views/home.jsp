<!DOCTYPE HTML>
<%@ page isELIgnored='false' %>
<%@ taglib tagdir='/WEB-INF/tags' prefix='rp' %>
<html lang='en'>
<head>
 <title>Racing Poker | Online Poker</title>
 <meta charset='utf-8'>
 <meta name='viewport' content='width=device-width, initial-scale=1'>
 <meta name='keywords' content='Poker,racing poker,online poker,poker tournaments,players'>
 <meta name='application-name' content='Racing Poker'>
 <meta name='author' content='Pokerace Team'>
 <meta property='og:image' content='https://www.racingpoker.com/images/racingpoker-logo9.png'>     
 <link rel='icon' href='/images/racingpoker-logo9.png' />
 <link rel='stylesheet' href='/css/bootstrap_min.css' />
 <link rel='stylesheet' href='/templates/PageStyleSheets.css' />
 <link rel='stylesheet' href='/templates/PageLayout.css' />
 <script src='/Jquery/jquery_min.js'></script>
 <script src='/Jquery/bootstrap_min.js'></script>
 <link rel='stylesheet' type='text/css' href='/css/highslide.css' />
 <link rel='stylesheet' href='' />
 <style>
     @media (min-width:1200px)
     {
        .container {
                         
                   }
     }
     em {
          color:#f6a828;
     }  
     a:hover {
         color:#ffffff;
     }
     a{
         color:#ffffff;
     }
  
  .high_room:hover{
     background-color: #2F4F4F;
     text-decoration: transparent;
  }
  .mid_room:hover{
     background-color: #561420;
     text-decoration: transparent;
  }
  .entry_room:hover{
     background-color:#5B7290;
     text-decoration: transparent;
  }
  .one_room:hover{
      background-color: #777777;
     text-decoration: transparent;
  
  }
  
 
 </style>
 
 <script>
 var credits_user = 0.0; 
 var flash_div ;
 var flash_count =0;
 var user_coins = 0;
 var user_level = 0.0;
 var verifiedEmail = false;
 var user_nname = '';
 var user_credits = 0.0;
 var user_credit = 0.0;
 var payments_length = 0.0;
 $(document).ready(function(){
 //alert('in the tournament');
 //$('#login_popup1').modal('show');
 $('[data-toggle="popover"]').popover(); 
 var chart;
 var tournaments_length = 0;
 var high_tournaments_length =0;
 var mid_tournaments_length =0;
 var entry_tournaments_length =0;
 var one_tournaments_length =0;
 var newdata = [];
 var username = '${ user.email }';
 
             
             $.getJSON('/FrontControl', {'username' : username, 'command' : 'verify' }, function(data){ 
                 
                 if(data.result === 'success')
                 {
                  //alert('success')   ;
                  $.getJSON('/Payment_history', {'Username' : username}, function(data){
                       if(data.result === 'success') {
                           payments_length = 1.0;
                       }
                  });
                 }
                 
                else
                {
                    connection_check();
                    //window.location.href='index.html';
                    return false;
                }
                 
             });
             
             
             $.getJSON('/FrontControl', {'username' : username, 'command' : 'user_details' }, function(data){ 
			//alert('in the servlet');
                       // alert(data.result);
                       // alert(data.user_detail);
                       // alert(data.user_detail);
                        var user_split = data.user_detail.split(',');
                        user_credit = user_split[1];
                        credits_user = parseFloat(user_credit);
                        user_credits = parseFloat(user_credit);
                        var user_fname = user_split[2];
                        var user_lname = user_split[3];
                        user_nname = user_split[0];
                        
                         user_coins = parseInt(user_split[6]);
                         user_level = parseInt(user_split[7]);
                        var user_wins = '2';
                        
                        if(user_split[18] == 'true' || '${ user.status }' == 'active')
                            verifiedEmail = true; 
                        else
                        	$('#verifyEmailModal').modal('show');
                        
                        if(sessionStorage.help_popup)
                        {
                           
                        }
                       else
                       {
                         if(parseInt(user_split[5]) < 10)
                         $('#help_popup').modal('show');
                       
                        sessionStorage.help_popup = 'true';
                       }
                        newdata.push(parseInt(user_split[5]));
                        newdata.push(parseInt(user_split[6]));
                        newdata.push(parseInt(user_split[7]));
                        newdata.push(parseInt(user_split[8])); 
                        newdata.push(parseInt(user_split[9]));
                        newdata.push(parseInt(user_split[10]));
                        newdata.push(parseInt(user_split[11]));
                        newdata.push(parseInt(user_split[12]));
                        newdata.push(parseInt(user_split[13]));
                         newdata.push(parseInt(user_split[14]));
                          newdata.push(parseInt(user_split[15]));
                         newdata.push(parseInt(user_split[16]));
                         newdata.push(parseInt(user_split[17]));
                        console.log(data.user_detail);
                        console.log(newdata);
                        var div1 = document.getElementById('user_profile');
                        if(user_split[4] === 'normaluser')
                        div1.innerHTML = '<a href=\'/u/profile\'class=\'btn btn-success\'><span class=\'glyphicon glyphicon-user\'></span>'+user_nname +'</a>' +' '+'<a href=\'/history.html\'class=\'btn btn-primary\'><span class=\'glyphicon glyphicon-user\'></span>' +'History'+'</a>'+' '+'<button  type=\'button\' onclick=\'logout()\' class=\'btn btn-danger\'>' + 'Logout' + '</button>';
                        else
                        div1.innerHTML = '<a href=\'/u/profile\'class=\'btn btn-success\'><span class=\'glyphicon glyphicon-user\'></span>'+user_nname +'</a>' +' '+'<a href=\'/history.html\'class=\'btn btn-primary\'><span class=\'glyphicon glyphicon-user\'></span>' +'History'+'</a>'+' '+'<a href=\'/ipaddress_filter.html\'class=\'btn btn-primary\'><span class=\'glyphicon glyphicon-user\'></span>' +'Admin'+'</a>'+' '+'<button  type=\'button\' onclick=\'logout()\' class=\'btn btn-danger\'>' + 'Logout' + '</button>';
                        
                        var div2 = document.getElementById('welcome');
                        div2.innerHTML =  'Please select one below to enter into tournament room.' +'<br/> <br/>';
                        var div3 = document.getElementById('credits');
                        div3.innerHTML = '<em>' + parseInt(user_credit) +'&nbsp; Credits' +'</em>';
                        var div4 = document.getElementById('bitlets');
                        div4.innerHTML = '<em>' + parseInt(user_coins) +'&nbsp; Bitlets' +'</em>';
                         var div5 = document.getElementById('level');
                        div5.innerHTML = '<em>' + parseInt(user_level) +'&nbsp; Level' +'</em>';
                        
                                       //  + '<em>' + parseInt(user_coins) + '</em>' + '&nbsp;'+'Coins'+ '&nbsp; &nbsp;'
                                       //  +  '<em>' + user_level + '</em>' + '&nbsp;'+'Level'+ '&nbsp; &nbsp;</span>';
                        //flash_div = setInterval(flash,500);
                         chart = new Highcharts.Chart({
				chart: {
					renderTo: 'stats',
					defaultSeriesType: 'bar',
                                        backgroundColor: '#ffffff',
                                        height:500
				},
				title: {
					text: 'Story so far'
				},
				subtitle: {
					text: ''
				},
				xAxis: {
					categories: ['No: of tournaments', 'No: of Bitlet coins', 'Player Level','No: of Bonuses','No: of 2shots','No: of 3shots','No: of 4shots','No: of 5shots','No: of 6shots', 'No: of 7shots','No: of 8shots','No: of 9shots', 'No: of 10shots'],
					title: {
						text: null
					}
				},
				yAxis: {
					min: 0,
					title: {
						text: '',
						align: 'high'
					}
				},
				tooltip: {
					formatter: function() {
						return '<b>'+ this.x +'</b><br/>'+
							 this.series.name +': '+ this.y ;
					}
				},
				plotOptions: {
					bar: {
						dataLabels: {
							enabled: true,
							color: 'auto'
						}
					}
				},
				legend: {
					layout: 'vertical',
					style: {
						left: '50px',
						bottom: '50px',
						right: '50px',
						top: '50px'
					},
					
				},
				credits: {
					enabled: false
				},
			        series: [{
                                        name:'Your score',
                                        data: newdata
				} ]
			});
		           $('#stats').hide();

                       // div3.innerHTML += '<button> Add Credit </button>'
                    });
                     function connection_check()
             {
                  $.getJSON('/connect_check', {"command" : "check"}, function(data){ 
                   // alert(data.result);
                   if(data.result === "success")
                   console.log("true");
                   else
                   {
                    //window.location.href = "index.html";
                   }
                });
                
             }
 });
 function flash()
 {
     console.log(flash_count);
     if(flash_count == 3)
     {
         $(".high_room").css("background-color","#2f4f4f");
         $(".mid_room").css("background-color","transparent");
         $(".entry_room").css("background-color","transparent");
         $(".one_room").css("background-color","transparent");
         flash_count = 0;
        // alert(flash_count);
     }
     else if(flash_count == 2)
     {
         $(".mid_room").css("background-color","#561420");
         $(".entry_room").css("background-color","transparent");
         $(".one_room").css("background-color","transparent");
          $(".high_room").css("background-color","transparent");
         flash_count = 3;
     }
     else if(flash_count == 1)
     {
         $(".entry_room").css("background-color","#5B7290");
         $(".high_room").css("background-color","transparent");
         $(".mid_room").css("background-color","transparent");
           $(".one_room").css("background-color","transparent");
         
         flash_count = 2;
     }
     else if (flash_count == 0)
     {
         $(".one_room").css("background-color","#777777");
          $(".entry_room").css("background-color","transparent");
         $(".high_room").css("background-color","transparent");
         $(".mid_room").css("background-color","transparent");
         flash_count = 1;
     }
     
 }
 function clicked_tournament(id)
            {
                var click = id ;
                 console.log(click);
               id = id.replace(/"/gi,"");
               //alert(id);
               //alert("in the result");
               var username = "${ user.email }";
                $.getJSON("/FrontControl", {"clicked" : id, "command" : "clicked" }, function(data){ 
                     //alert(data.result);
                    //return false;
                     if(typeof(Storage) !== "undefined") 
                         {
                                 sessionStorage.clicked = id;
                                 if(verifiedEmail)
                                 	window.location.href = "/u/multiMode?tournamentId=" + encodeURIComponent(id);
                                 else
                                 	$('#verifyEmailModal').modal('show');
                         } 
                        else {
                            alert("Sorry, your browser does not support HTML5");
                            }
                        
                    //alert("loki") ;
                    //window.location.href = "bootstrap_tournament_details.html";
                });
                //alert("JSON failed") ;
               
            }
            
   function next_help()
            
    {
        window.location.href = "/Demo.html";
    }
    
    function selected_room(id)
    {
        //alert(id);
         var  High_level;
         var  Mid_level;
         var  Entry_level;
         var  One_level;
         var  Pot_level;
         var length;
         var tournament_credits = [];
         var tournaments_list = [];
         var allowed_players = [];
         var no_of_games = [];
         var bitlet = [];
          stopFlash(id);
        if(id == "pot_level")
        {
            $(".selected_color").css("background-color","2F4F4F");
           $("#selected_tournaments").css("visibility","visible");
           $("#tournaments").css("color","ffffff");
           $('html,body').animate({ 
               scrollTop:$("#tournaments").offset().top
            },1000);
           var tournaments_div = document.getElementById("tournaments");
           tournaments_div.innerHTML = "<div class=\"row container\" > <br/> <p>" + "Racing Poker &reg; Pot Tournaments: <br/> <br/>" +"</p> </div>";
           $.getJSON("/Tournament_list", { "command" : "tournament_list" }, function(data){ 
           High_level = data.Pot_list;
           length = High_level.length ;
           console.log(High_level);     
           for(var i=0; i< length ; i++)
           {
            var split_coins = High_level[i].split(",");
            tournament_credits[i] = parseInt(split_coins[1]);
            tournaments_list[i] = split_coins[0];
            allowed_players[i] = parseInt(split_coins[2]);
            no_of_games[i] = parseInt(split_coins[3]);
            bitlet[i] = parseInt(split_coins[4]);
           }
           var col = parseInt(9 /length );
           var x ;
           for(var j=0; j <length ; j++)
           {
              if(j == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Tournament Name: </div>";
              x += "<div class=\"col-xs-" + col+ "\">"+"Racing Poker &reg;"+"<br/>" ;
              if(j == 0)
              x += "Pot Tournament-Entry" + "</div>";
              if(j == 1)
              x += "Pot Tournament-Mid" + "</div>";
              if(j == 2)
              x += "Pot Tournament-High" + "</div>";   
             }
           tournaments_div.innerHTML +=  x +"</div>" +"<br/>";
           for(var k=0 ; k< length ; k++)
           {
              if(k == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Required Credits: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+tournament_credits[k]+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var k=0 ; k< length ; k++)
           {
              if(k == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Required Bitlets: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+bitlet[k]+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           
           for(var l=0; l< length ; l++)
           {
               
              if(l == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Max. allowed players: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+ allowed_players[l]+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var m=0; m< length ; m++)
           {
               
              if(m == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> No. of games: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+ no_of_games[m]+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var m=0;m<=length ; m++)
           {
               if(m == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Pot Size: </div>"; 
              if(m == 1)
              x += "<div class=\"col-xs-" + col+ "\">"+ "10000" +"</div>" ;
              if(m == 2 )
              x += "<div class=\"col-xs-" + col+ "\">"+ "50000" +"</div>" ;   
              if(m == 3)
              x += "<div class=\"col-xs-" + col+ "\">"+ "100000" +"</div>" ;    
           }    
            tournaments_div.innerHTML += x + "</div>" + "<br/>";
             for(var m=0; m<= length ; m++)
           {
                           if(m == 0) 
                           x = "<div class=\"row\" > <div class=\"col-xs-3\"> First Prize: </div>";
                           if(m == 1)
                           x += "<div class=\"col-xs-" + col+ "\">"+ "5000/25" +"</div>" ;
                           if(m == 2)
                           x += "<div class=\"col-xs-" + col+ "\">"+ "25000/50" +"</div>" ;
                           if(m == 3)
                           x += "<div class=\"col-xs-" + col+ "\">"+ "50000/100" +"</div>" ;
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           
            for(var m=0; m<= length ; m++)
           {
              if(m == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Second Prize: </div>";  
               if(m == 1)
               x += "<div class=\"col-xs-" + col+ "\">"+ "2500/13" +"</div>" ;
               if(m == 2)
               x += "<div class=\"col-xs-" + col+ "\">"+ "12500/25" +"</div>" ;
               if(m == 3)
               x += "<div class=\"col-xs-" + col+ "\">"+ "25000/50" +"</div>" ;
            
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           
            for(var m=0; m<= length ; m++)
           {
               
              if(m == 0)
               x = "<div class=\"row\" > <div class=\"col-xs-3\"> Third Prize: </div>"; 
               if(m == 1)
               x += "<div class=\"col-xs-" + col+ "\">"+ "1500/7" +"</div>" ;
               if(m == 2)
               x += "<div class=\"col-xs-" + col+ "\">"+ "7500/15" +"</div>" ;
               if(m == 3)
               x += "<div class=\"col-xs-" + col+ "\">"+ "15000/30" +"</div>" ;
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var n=0; n<= length ; n++)
           {
             console.log(parseInt(tournament_credits[n]));              
              if(n == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Your eligibility </div>"; 
              if ( n > 1 ) {
                   if( user_coins >= bitlet[n - 1] && credits_user >= parseInt(tournament_credits[n - 1]) && payments_length)
                      x += "<div class=\"col-xs-" + col+ "\">"+ "<img src=\"/images/correct.png\" class=\"img-responsive\"  />"+"</div>" ; 
                   else
                      x += "<div class=\"col-xs-" + col+ "\">"+ "<img  src=\"/images/wrong.png\" class=\"img-responsive\" />"+"</div>" ;

              }
              else if ( n == 1) {
                  if( user_coins >= bitlet[n - 1] && credits_user >= parseInt(tournament_credits[n - 1]))
                       x += "<div class=\"col-xs-" + col+ "\">"+ "<img src=\"/images/correct.png\" class=\"img-responsive\"  />"+"</div>" ; 
                  else
                       x += "<div class=\"col-xs-" + col+ "\">"+ "<img  src=\"/images/wrong.png\" class=\"img-responsive\" />"+"</div>" ;
            
              }
             
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
            
           for(var o=0; o<= length ; o++)
           {
               
              if(o == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Your action </div>"; 
              if (o == 1) {
                  if( user_coins >= bitlet[o - 1] && credits_user >= parseInt(tournament_credits[o - 1]))
                   x += "<div class=\"col-xs-" + col+ "\">"+ "<button id=\"" + tournaments_list[o - 1]+"\" onclick=\"clicked_tournament(this.id)\" class=\"btn btn-success\" >"+"<span><img src=\"/images/start-icon.png\" /></span>"+"Play now"+"</button>" +"</div>" ; 
                  else
                   {
                  x += "<div class=\"col-xs-" + col+ "\">"+"<a href=\"/u/addChips\" class=\"btn btn-default\" > Buy Credits </a>"+"</div>" ;
                  $("#ineligibleModal").modal('show');
                   }
              } else if(o > 1) {
                    if( user_coins >= bitlet[o - 1] && credits_user >= parseInt(tournament_credits[o - 1]) && payments_length > 0)
                   x += "<div class=\"col-xs-" + col+ "\">"+ "<button id=\"" + tournaments_list[o - 1]+"\" onclick=\"clicked_tournament(this.id)\" class=\"btn btn-success\" >"+"<span><img src=\"/images/start-icon.png\" /></span>"+"Play now"+"</button>" +"</div>" ; 
                  else
                   {
                  x += "<div class=\"col-xs-" + col+ "\">"+"<a href=\"/u/addChips\" class=\"btn btn-default\" > Buy Credits </a>"+"</div>" ;
                  $("#ineligibleModal").modal('show');
                   }
              }
            
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>" + "<br/>";
           
           tournaments_div.innerHTML += "Note: Pot tournaments are paid only to players ranking 1st,2nd or 3rd in a tournament. Buyins will be deducted once Play Now button is hit. To play high and mid level pot tournaments, you have to buy credits atleast once."+"<br/>";
           
           console.log(tournaments_div);
            });   
        }
        if(id == "multi_level")
        {
           $(".selected_color").css("background-color","2F4F4F");
           $("#selected_tournaments").css("visibility","visible");
           $("#tournaments").css("color","ffffff");
           $('html,body').animate({ 
               scrollTop:$("#tournaments").offset().top
            },1000);
           var tournaments_div = document.getElementById("tournaments");
           tournaments_div.innerHTML = "<div class=\"row container\" > <br/> <p>" + "Multi player Tournaments <br/>" +"</p> </div>";
           $.getJSON("/Tournament_list", { "command" : "tournament_list" }, function(data){ 
           High_level = data.Multi_list;
           length = High_level.length ;
           console.log(High_level);     
           for(var i=0; i< length ; i++)
           {
            var split_coins = High_level[i].split(",");
            tournament_credits[i] = parseInt(split_coins[1]);
            tournaments_list[i] = split_coins[0];
            allowed_players[i] = parseInt(split_coins[2]);
            no_of_games[i] = parseInt(split_coins[3]);
           }
           var col = parseInt(9 /length );
           var x ;
           for(var j=0; j <length ; j++)
           {
              if(j == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Tournament Name: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+tournaments_list[j].replace(/-/gi," ")+"</div>" ;
           }
           tournaments_div.innerHTML +=  x +"</div>" +"<br/>";
           for(var k=0 ; k< length ; k++)
           {
              if(k == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Required Credit Points: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+tournament_credits[k]+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var l=0; l< length ; l++)
           {
               
              if(l == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Max. allowed players: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+ allowed_players[l]+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var m=0; m< length ; m++)
           {
               
              if(m == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> No. of games: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+ no_of_games[m]+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var n=0; n< length ; n++)
           {
               
              if(n == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Your eligibility </div>"; 
              
              if (n > 3 ) {
                  if( credits_user >= tournament_credits[n] && payments_length > 0)
                      x += "<div class=\"col-xs-" + col+ "\">"+ "<img src=\"/images/correct.png\" class=\"img-responsive\"  />"+"</div>" ; 
                  else
                      x += "<div class=\"col-xs-" + col+ "\">"+ "<img  src=\"/images/wrong.png\" class=\"img-responsive\" />"+"</div>" ;          
              }
              else {
                  if ( n >= 0) {
                       if( credits_user >= tournament_credits[n])
                      x += "<div class=\"col-xs-" + col+ "\">"+ "<img src=\"/images/correct.png\" class=\"img-responsive\"  />"+"</div>" ; 
                      else
                      x += "<div class=\"col-xs-" + col+ "\">"+ "<img  src=\"/images/wrong.png\" class=\"img-responsive\" />"+"</div>" ;
            
                  }
                 
              }
              
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
            
           for(var o=0; o< length ; o++)
           {
               
              if(o == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Your action </div>"; 
              
              if (o > 2) {
                  if( credits_user >= tournament_credits[o] && payments_length > 0)
                      x += "<div class=\"col-xs-" + col+ "\">"+ "<button id=\"" + tournaments_list[o]+"\" onclick=\"clicked_tournament(this.id)\" class=\"btn btn-success\" >"+"<span><img src=\"/images/start-icon.png\" /></span>"+"Play now"+"</button>" +"</div>" ; 
                   else
                   {
                        x += "<div class=\"col-xs-" + col+ "\">"+"<a href=\"/u/addChips\" class=\"btn btn-default\" > Buy Credits </a>"+"</div>" ;
                 
                       $("#ineligibleModal").modal('show');
                   }
              } else {
                 if ( o >= 0)  {
                      if( credits_user >= tournament_credits[o])
                       x += "<div class=\"col-xs-" + col+ "\">"+ "<button id=\"" + tournaments_list[o]+"\" onclick=\"clicked_tournament(this.id)\" class=\"btn btn-success\" >"+"<span><img src=\"/images/start-icon.png\" /></span>"+"Play now"+"</button>" +"</div>" ; 
                      else
                       {
                        x += "<div class=\"col-xs-" + col+ "\">"+"<a href=\"/u/addChips\" class=\"btn btn-default\" > Buy Credits </a>"+"</div>" ;
                 
                       $("#ineligibleModal").modal('show');
                       }
                  }
                   
              }           
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>" + "<br/>";
           
           tournaments_div.innerHTML += "Note: Buyins will be deducted once Play Now button is hit" + "<br/>";
           
           //console.log(tournaments_div);
            });
        }
        if(id == "mid_level")
        {
           /*$(".selected_color").css("background-color","#561420");
           $("#selected_tournaments").css("visibility","visible");
           $("#tournaments").css("color","ffffff");
           $('html,body').animate({ 
               scrollTop:$("#tournaments").offset().top
            },1000);
           var tournaments_div = document.getElementById("tournaments");
           tournaments_div.innerHTML = "<div class=\"row container\" > <br/> <p>" + "Mid Level Tournaments <br/>" +"</p> </div>";
           $.getJSON("/Tournament_list", { "command" : "tournament_list" }, function(data){ 
           High_level = data.Mid_list;
           length = High_level.length ;
           console.log(High_level);     
           for(var i=0; i< length ; i++)
           {
            var split_coins = High_level[i].split(",");
            tournament_credits[i] = parseInt(split_coins[1]);
            tournaments_list[i] = split_coins[0];
            allowed_players[i] = parseInt(split_coins[2]);
            no_of_games[i] = parseInt(split_coins[3]);
           }
           var col = parseInt(9 /length );
           var x ;
           for(var j=0; j <length ; j++)
           {
              if(j == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Tournament Name: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+tournaments_list[j]+"</div>" ;
           }
           tournaments_div.innerHTML +=  x +"</div>" +"<br/>";
           for(var k=0 ; k< length ; k++)
           {
              if(k == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Required Credit Points: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+tournament_credits[k]+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var l=0; l< length ; l++)
           {
               
              if(l == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Max. allowed players: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+ allowed_players[l]+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var m=0; m< length ; m++)
           {
               
              if(m == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> No. of games: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+ no_of_games[m]+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var n=0; n< length ; n++)
           {
               
              if(n == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Your eligibility </div>"; 
              if( credits_user >= tournament_credits[n])
              x += "<div class=\"col-xs-" + col+ "\">"+ "<img  src=\"/images/correct.png\" class=\"img-responsive\"  />"+"</div>" ; 
              else
              {
              x += "<div class=\"col-xs-" + col+ "\">"+ "<img  src=\"/images/wrong.png\" class=\"img-responsive\" />"+"</div>" ;
              $("#ineligibleModal").modal('show');
              }
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
            
           for(var o=0; o< length ; o++)
           {
               
              if(o == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Your action </div>"; 
              if( credits_user >= tournament_credits[o])
              x += "<div class=\"col-xs-" + col+ "\">"+ "<button id=\"" + tournaments_list[o]+"\" onclick=\"clicked_tournament(this.id)\" class=\"btn btn-success\" >"+"<span><img src=\"/images/start-icon.png\" /></span>"+"Play now"+"</button>" +"</div>" ; 
              else
              x += "<div class=\"col-xs-" + col+ "\">"+ "Not Eligible"+"</div>" ;
            
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>" + "<br/>";
           
           tournaments_div.innerHTML += "Note: By clicking on play , your credits will be transfered to your tournament credits to play tournament." + "<br/>";
           
           console.log(tournaments_div);
            }); */
        }
        if(id == "entry_level")
        {
           /* $(".selected_color").css("background-color","#5B7290");
            $("#selected_tournaments").css("visibility","visible");
           $("#tournaments").css("color","ffffff");
           $('html,body').animate({ 
               scrollTop:$("#tournaments").offset().top
            },1000);
           var tournaments_div = document.getElementById("tournaments");
           tournaments_div.innerHTML = "<div class=\"row container\" > <br/> <p>" + "Entry Level Tournaments <br/>" +"</p> </div>";
           $.getJSON("/Tournament_list", { "command" : "tournament_list" }, function(data){ 
           High_level = data.Low_list;
           length = High_level.length ;
           console.log(High_level);     
           for(var i=0; i< length ; i++)
           {
            var split_coins = High_level[i].split(",");
            tournament_credits[i] = parseInt(split_coins[1]);
            tournaments_list[i] = split_coins[0];
            allowed_players[i] = parseInt(split_coins[2]);
            no_of_games[i] = parseInt(split_coins[3]);
           }
           var col = parseInt(9 /length );
           var x ;
           for(var j=0; j <length ; j++)
           {
              if(j == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Tournament Name: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+tournaments_list[j]+"</div>" ;
           }
           tournaments_div.innerHTML +=  x +"</div>" +"<br/>";
           for(var k=0 ; k< length ; k++)
           {
              if(k == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Required Credit Points: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+tournament_credits[k]+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var l=0; l< length ; l++)
           {
               
              if(l == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Max. allowed players: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+ allowed_players[l]+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var m=0; m< length ; m++)
           {
               
              if(m == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> No. of games: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+ no_of_games[m]+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var n=0; n< length ; n++)
           {
               
              if(n == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Your eligibility </div>"; 
              if( credits_user >= tournament_credits[n])
              x += "<div class=\"col-xs-" + col+ "\">"+ "<img  src=\"/images/correct.png\" class=\"img-responsive\"  />"+"</div>" ; 
              else
              {
              x += "<div class=\"col-xs-" + col+ "\">"+ "<img  src=\"/images/wrong.png\" class=\"img-responsive\" />"+"</div>" ;
              $("#ineligibleModal").modal('show');
              }
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
            
           for(var o=0; o< length ; o++)
           {
               
              if(o == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Your action </div>"; 
              if( credits_user >= tournament_credits[o])
              x += "<div class=\"col-xs-" + col+ "\">"+ "<button id=\"" + tournaments_list[o]+"\" onclick=\"clicked_tournament(this.id)\" class=\"btn btn-success\" >"+ "<span><img src=\"/images/start-icon.png\" /></span>"+"Play now"+"</button>" +"</div>" ; 
              else
              x += "<div class=\"col-xs-" + col+ "\">"+ "Not Eligible"+"</div>" ;
            
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>" + "<br/>";
           
           tournaments_div.innerHTML += "Note: By clicking on play , your credits will be transfered to your tournament credits to play tournament." + "<br/>";
           
           console.log(tournaments_div);
            }); */
        }
        if(id == "one_level")
        {
            $(".selected_color").css("background-color","777777");
            $("#selected_tournaments").css("visibility","visible");
           $("#tournaments").css("color","ffffff");
           $('html,body').animate({ 
               scrollTop:$("#tournaments").offset().top
            },1000);
           var tournaments_div = document.getElementById("tournaments");
           tournaments_div.innerHTML = "<div class=\"row container\" > <br/> <p>" + "One Player practice Tournaments <br/>" +"</p> </div>";
           $.getJSON("/Tournament_list", { "command" : "tournament_list" }, function(data){ 
           High_level = data.One_list;
           length = High_level.length ;
           console.log(High_level);     
           for(var i=0; i< length ; i++)
           {
            var split_coins = High_level[i].split(",");
            tournament_credits[i] = parseInt(split_coins[1]);
            tournaments_list[i] = split_coins[0];
            allowed_players[i] = parseInt(split_coins[2]);
            no_of_games[i] = parseInt(split_coins[3]);
           }
           var col = parseInt(9 /length );
           var x ;
           for(var j=0; j <length ; j++)
           {
              if(j == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Tournament Name: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+tournaments_list[j].replace(/-/gi," ")+"</div>" ;
           }
           tournaments_div.innerHTML +=  x +"</div>" +"<br/>";
           for(var k=0 ; k< length ; k++)
           {
              if(k == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Minimum Credit Points: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+credits_user+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var l=0; l< length ; l++)
           {
               
              if(l == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Max. allowed players: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+ allowed_players[l]+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var m=0; m< length ; m++)
           {
               
              if(m == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> No. of games: </div>"; 
              x += "<div class=\"col-xs-" + col+ "\">"+ no_of_games[m]+"</div>" ; 
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
           for(var n=0; n< length ; n++)
           {
               
              if(n == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Your eligibility </div>"; 
              
              x += "<div class=\"col-xs-" + col+ "\">"+ "<img  src=\"/images/correct.png\" class=\"img-responsive\"  />"+"</div>" ; 
              
            
            
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>";
            
           for(var o=0; o< length ; o++)
           {
               
              if(o == 0)
              x = "<div class=\"row\" > <div class=\"col-xs-3\"> Your action </div>"; 
              
              x += "<div class=\"col-xs-" + col+ "\">"+ "<button id=\"" + tournaments_list[o]+"\" onclick=\"practice(this.id)\" class=\"btn btn-success\" >"+ "<span><img src=\"/images/start-icon.png\" /></span>"+"Start Play"+"</button>" +"</div>" ; 
             
            
            
           }
           tournaments_div.innerHTML += x + "</div>" + "<br/>" + "<br/>";
           
           tournaments_div.innerHTML += "Note: By clicking on play , you can play as many games as you want" + "<br/>";
           
           console.log(tournaments_div);
            });
        }
        
        }
        function stopFlash(id)
        {
            console.log("stopFlash");
            clearInterval(flash_div);
            // $(".selected_color").css("background-color","transparent");
             $(".high_room").css("background-color","transparent"); 
             $(".mid_room").css("background-color","transparent");
             $(".entry_room").css("background-color","transparent");
             $(".one_room").css("background-color","transparent"); 
         if(id == "high_level")
         {
            $(".high_room").css("background-color","#2F4F4F"); 
         }
         if(id == "mid_level")
         {
             $(".mid_room").css("background-color","#561420");
         }
         if(id == "entry_level")
         {
             $(".entry_room").css("background-color","#5B7290");
         }
         if(id == "one_level")
         {
             $(".one_room").css("background-color","#777777");
         }
        }
        
        function startFlash(id)
        {
            if(id == "high_level")
            flash_count = 1;
            if(id == "mid_level")
            flash_count = 2;
            if(id == "entry_level")
            flash_count = 3;
            if(id == "one_level")
            flash_count = 0;
            //flash_div = setInterval(flash,500);
        }
        
          function fbshare()
            {
                var url = window.location.href.split(/\/[ur]\//gi)[0];
                var message = "Try your skill to top the Leader Board in this new poker game.";
                var heading = "10,000 Tournament Credit Joining Bonus";
                fb_share(url,message,heading);
            }
        
          function practice(id)
          {
             var click = id ;
                 console.log(click);
               id = id.replace(/"/gi,"");
               //alert(id);
               //alert("in the result");
               var username = "${ user.email }";
                $.getJSON("/FrontControl", {"clicked" : id, "command" : "clicked" }, function(data){ 
                     //alert(data.result);
                    //return false;
                     if(typeof(Storage) !== "undefined") 
                         {
                                 sessionStorage.clicked = id;
                                 if(verifiedEmail)
                                 window.location.href = "/u/singleMode";
                                 else
                                  $('#verifyEmailModal').modal('show');
                       
                                
                         } 
                        else {
                            alert("Sorry, your browser does not support HTML5");
                            }
                        
                    //alert("loki") ;
                    //window.location.href = "bootstrap_tournament_details.html";
                });
                //ale1
                
             
                  
          }
          function resendLink() {
             $.getJSON("/Resendlink", {"username" : username }, function(data){ 
                 
                 $('#verifyEmailModal').modal('hide');
                 
                 console.log(data.result);
                 if(data.result == "success") {
                     $("#resendEmail").modal('show');
                 }
                 else {
                     $("#resendEmailFailed").modal('show');
                 }
    
         });
         }
             function change_show()
                {
                   //
                    var div_status = document.getElementById("div_status").value;
                    if(div_status == "Show")
                    {
                     $("#stats").show();
                     document.getElementById("div_status").value = "Hide";
                    }
                    else
                    {
                     $("#stats").hide();
                     document.getElementById("div_status").value = "Show";
                   }
                }
 </script>
</head>
<body>
 <div class="navbar navbar-custom navbar-fixed-top" >
    <div class="navbar-inner header">
    <div class="container">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
        <a class="navbar-brand" href="/u/home" > Racing Poker&trade; </a> 
    </div>
    <div id="myNavbar" class="collapse navbar-collapse">
      <ul class="nav navbar-nav">
        <li class=""><a href="/learn_game.html" style=""> Game Rules</a></li>
        <li><a href="/promotions.html">Promotions</a></li>
        <li><a href="/Support.html">Support</a></li>
        <li><a href="/Aboutus.html">About us</a></li>
         
      </ul>
      <form class="navbar-form navbar-right" >
            <div id="user_profile" style="color:white">
            </div>
        </form>      
                 
    </div>
    </div>
    </div>
   </div>
    <br/>
    <br/>
    <br/>
    <br/>
    <div class="">
        <div class="container bg-row selected_color">
            
            <h4>  <span> <img src="/images/wallet-icon.png" /> </span>Your Wallet
                <span> </span> 
                <span class="pull-right"> <a href="#" data-toggle="modal" data-target="#promotionsModal" class="btn bg-3" ><span> <img src="/images/coins-add-icon.png" /> </span><span>Add Credits</span></a></span> </h4>
            
            <div class="row">
            <div  class="col-sm-4">
                <p> <span> <img src="/images/credits-icon.png" /> </span> <span id="credits" class="online"></span> </p>
            </div>
            <div  class="col-sm-4" >
                 <p> <span> <img src="/images/bitlets-icon.png" /> </span> <span id="bitlets" class="online"></span> </p>
            </div>
            <div  class="col-sm-4">
                  <p> <span><img src="/images/level-icon.png" /></span> <span id="level" class="online"></span> </p>
            </div> 
            </div>
        </div>
    </div>
       <br/> 
     <div class="row" >
         <div  class="container selected_color bg-row" style="border-radius: 16px;border: 1px;font-size:16;">
             <h4><span> <img src="/images/poker-room-icon.png" /> </span>Tournament rooms 
                
             </h4>
             <div id="welcome" style="color:#ffffff"></div> 
              
             <div class="row">
                 <div  class="">
                      <a href="#"  id="one_level" onmouseover="" onmouseout="" onclick="selected_room(this.id)"> 
                 <div  class="col-md-4 one_room" style="border-radius:12px;border: 1px grey solid;">
                       <h4 style="text-align: center"> Solo Game  </h4>
                        <img class="center-block img-responsive" src="/images/logo_tour.png" />                   </div></a> 
                      <a href="#"  id="multi_level" onmouseover="" onmouseout="" onclick="selected_room(this.id)">
                     <div class="col-md-4 multi_room" style="border-radius:12px;border: 1px grey solid;" >
                      <h4 style="text-align: center"> Multi player Tournaments  </h4> 
                         <img class="center-block img-responsive" src="/images/logo_tour.png"  />                      </div> </a> 
                 <a href="#"  id="pot_level" onmouseover="" onmouseout="" onclick="selected_room(this.id)"  >
                  <div  class="col-md-4 pot_room" style="border-radius:12px;border: 1px grey solid;">
                     <h4 style="text-align: center"> Pot Poker Tournaments  </h4>
                     <img class="center-block img-responsive" src="/images/logo_tour.png" />     </div> </a> 
                    
                  
                         
                 </div>
                 <br/>
             </div>
             <br/>
         </div>
         
     </div> 
       <br/>
       <div id="selected_tournaments" class="row" style="visibility:hidden;">
           <div id="tournaments" class="container selected_color" style="border-radius: 16px;border: 1px ;font-size:16;">
              
           </div>
       </div>
       
       <div  class="row">
           <div  class="container selected_color bg-row" style="border-radius: 16px;border: 1px;font-size:16;">
               <h4> <span> <img src="/images/stats-icon.png" /> </span>Your Stats
                   <span> </span>
                   <span class="pull-right"> 
                       <input type="button" id="div_status"  class="btn bg-3" onclick="change_show()" value="Show" />
                   </span> 
               
               </h4>
                  <div id="stats" style="">
                       
                   <br/>  
                   </div>
               <br/>
           </div>
          
       </div>
       
       <br/>
       <!-- Buy Credits -->
        <div id="promotionsModal" class="modal" role="dialog">
       <div class="modal-dialog">
       <div class="modal-content">
      <div class="modal-header selected_color">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" style="color:#ffffff">Promotions</h4>
      </div>
      <div class="modal-body selected_color" style="color:#ffffff">
         
        <p> You can increase your credits in three ways. </p>
        <p> 1. To get 1000 credits Share and like us on Facebook.
        <span id="fblike" class="fb-like" 
        data-href="https://www.facebook.com/racingpoker" 
        data-layout="button_count" 
        > </span> </p>
        
        <div id="share-fb" class="row"> <p> 2.Let all your friends know about racing poker and receive 5000 credits. 
                   
                <span onclick="fbshare()"><img src="/images/fb_share.png" /></span> </p>
       
                   <p> Please note that only 2 shares per day are allowed.</p>
                 
                </div>
        <p> 3. Buy Credits and enjoy benefits of premium membership. <a href="/u/addChips" class="btn btn-default" > Buy Credits </a>  </p>
        <p>Buy credits now to gain access to mid and high level tournaments</p>
        <br/>
          <p> 4. Conversion of bitlets to credits.  <a href="#" class="btn btn-default" data-toggle="modal" data-target="#convertModal" > Convert Bitlets </a> </p>
        <br/>
         <p> By clicking on above buttons, you  accept the  <a href="" style="text-decoration: underline" data-toggle="modal" data-target="#terms_modal"  > Terms and  Conditions </a> , <a href="" style="text-decoration: underline" data-toggle="modal" data-target="#privacy_modal"  > Privacy policy </a>  and <a href="" style="text-decoration: underline" data-toggle="modal" data-target="#social_modal"  > Social policy </a>  of Pokerace Pty Ltd.</p> 
      
      
      </div>
      <div class="modal-footer selected_color">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
      </div>
      </div>
    </div>
     <!-- convert Modal -->
     <script>
         function convert_bitlets()
         {
            // alert("convert");
             var convert_amount = document.getElementById("convert_amount").value;
             var credits = document.getElementById("converted_amount");
             if(convert_amount >= 3)
             {
                 if(user_coins >= convert_amount)
                 {
                   var conversion_rate = convert_amount / 3 ;
                   var converted_amount = conversion_rate * 1000 ;
                   converted_amount = parseInt(converted_amount);
                   credits.value = converted_amount ;
                   document.getElementById("message_conversion").innerHTML = "";
                 }
                 else
                 {
                     document.getElementById("message_conversion").innerHTML = "You don't have enough bitlets";
                 }
             }
             else
             {
                 document.getElementById("message_conversion").innerHTML = "Minimum 3 bitlets are required for conversion";
             }
             
         }
         function conversion_submit()
         {
              var convert_amount = document.getElementById("convert_amount").value;
             var credits = document.getElementById("converted_amount");
             if(convert_amount >= 3)
             {
                 if(user_coins >= convert_amount)
                 {
                   var conversion_rate = convert_amount / 3 ;
                   var converted_amount = conversion_rate * 1000 ;
                   converted_amount = parseInt(converted_amount);
                   credits.value = converted_amount ;
                   document.getElementById("message_conversion").innerHTML = "";
                   $.getJSON("/Convert_bitlets", {"username" : username, "Bitlets": convert_amount , "Credits": converted_amount }, function(data){ 
                 
                 if(data.result === "success")
                 {
                  //alert("success")   ;
                   document.getElementById("message_conversion").innerHTML = " Successfully converted to credits. Now you are credits are " + parseInt(credits_user + converted_amount)  ;
                    var div3 = document.getElementById("credits");
                        div3.innerHTML = "<em>" + parseInt(credits_user + converted_amount) +"&nbsp; Credits" +"</em>";
                        var div4 = document.getElementById("bitlets");
                        div4.innerHTML = "<em>" + parseInt(user_coins - convert_amount) +"&nbsp; Bitlets" +"</em>";
                         var div5 = document.getElementById("level");
                        div5.innerHTML = "<em>" + parseInt(user_level) +"&nbsp; Level" +"</em>";
                   credits_user = parseInt(credits_user + converted_amount) ;
                   user_coins = parseInt(user_coins - convert_amount) ;
                 }
                 
                else
                {
                   document.getElementById("message_conversion").innerHTML = "Some thing went wrong . Try after some time .";
                }
                 
             });
                   
                 }
                 else
                 {
                     document.getElementById("message_conversion").innerHTML = "You don't have enough bitlets";
                 }
             }
             else
             {
                 document.getElementById("message_conversion").innerHTML = "Minimum 3 bitlets are required for conversion";
             }
         }
         
     </script>
     <div id="convertModal" class="modal" role="dialog">
       <div class="modal-dialog">
       <div class="modal-content">
      <div class="modal-header selected_color">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" style="color:#ffffff">Conversion of bitlets to credits</h4>
      </div>
      <div class="modal-body selected_color" style="color:#ffffff">
          
          <br/>
          <p id="message_conversion"></p>
          <div>
              <p>  <span> Convert :</span> <span><input onkeydown="return false" type="number" min="3" onChange="convert_bitlets()" id="convert_amount"  value="3" style="color:#000000"></span> <span> Bitlets </span> </p>
                      <p> To: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span><input  type="number"  id="converted_amount"  value="1000" style="color:#000000" disabled></span>
                          <span id="converted"> Credits </p>
                          <br/>
                          <button class="btn btn-success"  onClick="conversion_submit()" style="">Submit </button>
                          
          </div>
          <br/>
          <p> Please note that minimum 3 bitlets are required for conversion </p>
      </div>
      <div class="modal-footer selected_color">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
      </div>
      </div>
    </div>
       <!--Add Credits Modal -->
    <div id="ineligibleModal" class="modal" role="dialog">
       <div class="modal-dialog">
       <div class="modal-content">
      <div class="modal-header selected_color">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" style="color:#ffffff">Buy Credits</h4>
      </div>
      <div class="modal-body selected_color" style="color:#ffffff">
          <p><span><img  src="/images/wrong.png" class="" /></span> Buy credits now to gain access to mid and high level tournaments</p>
        <p> You can increase your credits in three ways. </p>
        <p> 1. To get 1000 credits Share and like us on Facebook.
        <span id="fblike" class="fb-like" 
        data-href="https://www.facebook.com/racingpoker" 
        data-layout="button_count" 
        > </span> </p>
        
        <div id="share-fb" class="row"> <p> 2.Let all your friends know about racing poker and receive 5000 credits.
                   
                <span onclick="fbshare()"><img src="/images/fb_share.png" /></span> </p>
       
                   <p> Please note that only 2 shares per day are allowed.</p>
                 
                </div>
        <p> 3. Buy Credits and enjoy benefits of premium membership. <a href="/u/addChips" class="btn btn-default" > Buy Credits </a>  </p>
       <p> Please check the <a href="" style="text-decoration: underline" data-toggle="modal" data-target="#terms_modal"  > Terms and  Conditions </a> , <a href="" style="text-decoration: underline" data-toggle="modal" data-target="#privacy_modal"  > Privacy policy </a>  and <a href="" style="text-decoration: underline" data-toggle="modal" data-target="#social_modal"  > Social policy </a>   as required by Pokerace Pty Ltd.</p> 
      </div>
      <div class="modal-footer selected_color">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
      </div>
      </div>
    </div>
       
       <div class="modal fade" id="terms_modal" tabindex="-1" role="dialog" aria-labelledby="terms_modal" aria-hidden="true">
    <div class="modal-md modal-dialog" style="background:#070D0D" >
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h4 class="modal-title" id="myModalLabel" style="color:#E77817"> Terms and Conditions</h4>
            <div id="error_message"> </div>
            </div>
            <div class="modal-body">  
                <div class="row" style="text-align: justify; overflow-y:scroll; height:240; font-size: 10 ">
                    <p>
                   Please read these Terms & Conditions of Service, our Privacy Policy and other Additional Terms including our Social Policy {Hyperlink] carefully before using Pokerace Service/s. Whenever you use the Service/s you agree to be bound by all of these Terms & Conditions of Service. If you don't agree to all the Terms & Conditions of Service you must not use our Service/s. References to "Racing Poker", "Pokerace", "Us" or "We" mean Pokerace Pty Ltd and Pokerace's Corporate Group of Companies. In all cases "Racing Poker", "Pokerace", "Us", "Our" or "We" includes the owners, employees, subsidiaries, holding companies, independent contractors, agents, attorneys, and assigns of Pokerace Pty Ltd. 

1. DEFINITIONS "Account" means an account you create when you access the Service/s. "Additional Terms" means any other rules related to specific Service/s like platforms and APIs, , forums, contests, subscriptions, applications for mobile devices or loyalty programs that We may publish which apply to your use of those specific Service/s and state they are part of these Terms. "Offers" means special programs, including offers, excursions, and special gifts, both digital and tactile, that Pokerace may offer from time to time to certain eligible players. "Service/s" refers to products, games, Service/s, content and/or the other domains provided by Pokerace namely Racingpoker.com. "Terms of Service" or "Terms" means these terms of service. "User Content" means all the data that you upload or transmit on or through the Service. This includes things like your profile picture or your in-game chat. "Virtual Items" means (a) virtual currency, including but not limited to Bitlets" virtual coins, credits, cash, tokens, or points, all for use in the Service and (b) virtual in-game items. "Pokerace Corporate Group" refers to Pokerace Pty Ltd subsidiaries, parent companies, joint ventures and other corporate entities under common ownership and/or any of their directors, officers, employees, agents, consultants. "Pokerace Affiliates" refers to the Pokerace Corporate Group plus Pokerace and the Pokerace Corporate Group's third-party content providers, distributors, licensees or licensors. 

2. CHANGES TO TERMS We reserve the right to change, modify, add or remove portions of the Terms, Social Policy, Additional Terms (if applicable) and Privacy Policy at any time by posting the amendments to such items on our sites or within the Service. We may provide additional notice via e-mail or a message within the Service/s, of any material changes. Unless We state otherwise, changes are effective when posted. If you continue to use the Service/s after the changes are posted you agree to the changes. New versions of the Terms, the Social Policy and the Privacy Policy and any other policies, codes or rules will be accessible at www.racingpoker.com or from within the Service/s. If you have a dispute with Pokerace, the version of the Terms, the Social Policy, Additional Terms, and the Privacy Policy in effect at the time Pokerace received actual notice of the dispute will apply to such dispute. However, if you keep using the Service after the changes are posted, you are agreeing that the changes apply to your continued use of the Service/s. Changes to the Terms, Social Policy, Additional Terms, or Privacy Policy cannot be made by you unless both you and Pokerace sign a written amendment of the particular term. If the Terms or the Privacy Policy have provisions that conflict with other Pokerace Terms or policies, the provisions in these Terms and the Privacy Policy win. 

3. ACCOUNT INFORMATION AND SECURITY In order to use our Service/s, We may ask you to create an Account and select a password and/or provide Us with certain personal information, which may include your name, birth date, e-mail address, and, in some cases, payment information. This information will be held and used in accordance with Pokerace's Privacy Policy. You agree to provide Pokerace with accurate, complete, and updated information, particularly your email address. You must use a current email address that you access for your login if not using a Social Platform. You are responsible for maintaining the security of your Account. You mustn't share your login or password with others. You are solely responsible for any activity in your Account whether or not authorized by you, including purchases made using any payment instrument e.g. PayPal. You must inform Us immediately of any actual or suspected loss, theft, fraud, or unauthorized use of your Account or Account password. 

4. PRIVACY Pokerace's Privacy Policy tells you how We collect and use information about you and your computer or mobile device as well as how you use the Service/s to share such information with others. You understand that through your use of our Service/s you acknowledge the collection, use and sharing of this information as described in Pokerace's Privacy Policy. If you don't agree with the Privacy Policy, then you must stop using our Service/s. 

5. USING OUR SERVICE/S You may not use our Service if: 
1) You cannot enter into a binding contract with Pokerace; 
2) You are under 18 years of age, in which case you must not create an Account, use any part of the Service, or submit personal information through the Service or to Pokerace (for example, name, email address); 
3) You are not allowed to play mock gaming Service/s via software 
4) You are a convicted sex offender; or 
5) You have previously been banned from playing any Pokerace game or using any Pokerace Service. 
If you use our Service, you must follow the Pokerace Social Policy and all other Additional Terms that may apply. These additional rules and terms apply in addition to these Terms and are important. Please read them. If you access the Service from a social network or download the Service from another platform, such as Apple or Google, you must also comply with its terms of service/use as well as these Terms. To access or play our games or create an account with Us, you may need an account with a social network, like Facebook, and, if you are using our mobile Service, an account with the company that provides your mobile applications, like an iTunes account. You may need to update third party software from time to time to receive the Service and play Pokerace's Games. We provide the games. You provide the equipment (computer, phone, tablet, etc.) and pay any fees to connect to the Internet and app stores, or for data or cellular usage to download and use the Service. The Service is evolving and We may require that you accept updates to the Service as well as to the Terms, Social Policy, and the Pokerace Privacy Policy. From time to time we may make you update the game or your software to continue to use Our Service/s. We may perform these updates remotely including to Pokerace software residing on your computer or mobile device, without notifying you. Pokerace reserves the right to stop offering and/or supporting the Service or a particular game or part of the Service at any time either permanently or temporarily, at which point your license to use the Service or any part of it will be automatically terminated or suspended. If that happens, Pokerace is not required to provide refunds, benefits or other compensation to players in connection with discontinued elements of the Service or for virtual goods previously earned or purchased. You may stop using the Service at any time and may request that We stop making active use of your data at any time by following the instructions in the Privacy Policy. Unless the local law where you are located requires otherwise, We are not required to provide refunds, benefits or other compensation if you request deletion of your Account. POKERACE MAY, IN ITS SOLE DISCRETION LIMIT, SUSPEND, TERMINATE, MODIFY, OR DELETE ACCOUNTS OR ACCESS TO THE SERVICE OR ANY PORTION OF IT AND PROHIBIT ACCESS TO OUR GAMES AND SITES, AND THEIR CONTENT, SERVICE/S AND TOOLS, DELAY OR REMOVE HOSTED CONTENT AND POKERACE IS UNDER NO OBLIGATION TO COMPENSATE YOU FOR ANY SUCH LOSSES OR RESULTS. 

6. OWNERSHIP; LIMITED LICENCE Games and Service: The Service is comprised of works offered by Pokerace Pty Ltd, and it is protected by copyright, trademark, trade dress, patent and other US and non-US intellectual property and other applicable laws, rules & regulations. Pokerace owns, has licensed, or otherwise has rights to use all of the content that appears in the Service. These Terms do not grant you or any other party any right, title or interest in the Service or any content in the Service. So long as you abide by these Terms and any other rules, including the Social Policy, Pokerace grants you a non-exclusive, non-transferable, revocable limited license subject to the limitations in these Terms, to access and use the Service using a Pokerace supported web browser or mobile device solely for your own non-commercial entertainment purposes. You agree not to use the Service for any other purpose. If you violate these Terms, or any of Our other terms that apply to you, We may take action against you, up to and including permanently suspending your account. In addition, you may be breaking the law, including violations of Pokerace's intellectual property rights. ANY ATTEMPT BY YOU TO DISRUPT OR INTERFERE WITH THE SERVICE INCLUDING WITHOUT LIMITATION UNDERMINING OR MANIPULATING THE LEGITIMATE OPERATION OF ANY POKERACE GAME IS A VIOLATION OF POKERACE POLICY AND MAY BE A VIOLATION OF CRIMINAL AND CIVIL LAWS. Your Account and Virtual Items: Regardless of what anything else says in these Terms, the Social Policy, or any other Additional Terms that apply to features you may choose to use, you do not own the Account that you create on Our Service, including in Our games, and your Account is not your property. This also applies to other things, like in-game currency or items, regardless of whether you "earned" those items in a game or "purchased" them. Your account and any related items are owned by Pokerace. Pokerace gives you a limited license to use your account and the related items while We offer the Service/s WE MAY DELETE OR TERMINATE ACCOUNTS THAT ARE INACTIVE (I.E., NOT LOGGED INTO) FOR 180 DAYS. IF YOU WANT US TO DELETE YOUR ACCOUNT, YOU CAN GO TO HERE FOR INSTRUCTIONS ON HOW TO MAKE THAT REQUEST. (Coming Soon) email privacy@racingpoker.com You are not allowed to transfer Virtual Items outside of the Service (i.e., in the "real world"), for example by selling, gifting, or trading them. We won't recognize those transfers as legitimate. You are not allowed to sublicense, trade, sell or attempt to sell in-game Virtual Items for "real" money, or exchange Virtual Items for value of any kind outside of a game. Any such transfer or attempted transfer is prohibited and void, and We may terminate your Account because of it. User Content: If you transmit or upload User Content on the Service, you agree that it will be: 1) accurate; 2) not confidential; 3) not in violation of the law; 4) not in violation of contractual restrictions or other parties' rights, and that you have permission from any other party whose personal or other information or intellectual property is contained within the User Content; 
5) free of viruses, adware, spyware, worms or other malicious code; 
6) in compliance with the Pokerace Social Policy. Your User Content will be processed by Pokerace in accordance with its Privacy Policy. You own your User Content, but you give Pokerace a perpetual and irrevocable (other than as provided below), worldwide, fully paid-up and royalty free, non-exclusive, license to use your User Content and any modified and derivative works thereof in connection with the Service, including in marketing and promotions. To the extent allowed by applicable laws, you waive any moral rights you may have in any User Content (like the right to be identified as the author of the User Content or the right to object to a certain use of that User Content). Pokerace's license to your User Content ends when you request deletion of your User Content by submitting a request to privacy@racingpoker.com User Content submitted in response to Pokerace promotions (which will be subject to the terms of the promotion: Additional Terms); User Content either shared with others which they have not deleted or already used publicly as allowed under these Terms; and User Content subject to a separate license with Pokerace (which will be subject to the terms of such license). If you request deletion of your User Content we will take reasonable steps to remove your User Content from active use, which may include suppression of your User Content in our systems. However, User Content may persist in our systems, including back-up copies. We may also retain copies of User Content if we are legally required to do so. When you post your observations and comments on the Service such as in forums, blogs and chat features, We cannot guarantee that other players will not use the ideas and information that you share. If you have an idea or information that you would like to keep confidential and/or don't want others to use, don't post it. POKERACE IS NOT RESPONSIBLE FOR ANY OTHER PERSON'S USE OR APPROPRIATION OF ANY CONTENT OR INFORMATION YOU POST IN ANY FORUMS, BLOGS AND CHAT ROOMS. 

7. MONITORING USE OF SERVICE AND USER CONTENT We have no obligation to monitor User Content and We are not responsible for monitoring the Service for inappropriate or illegal User Content or conduct by other players. That said, We have the right, in our sole discretion, to edit, refuse to post, or remove any User Content. We may also, at our discretion, choose to monitor and/or record your interaction with the Service or your communications with Pokerace or other players (including without limitation chat text and voice communications) when you are using the Service. We are not responsible for information, materials, products or Service/s provided by other players (for instance, in their profiles). However, if someone is violating these Terms or misusing the Service, please let Us know by using a "Report Abuse" link provided in the Service or contact Us at Customer Support. 

8. YOUR DEALINGS WITH OTHER PLAYERS You are responsible for your interactions with other players. If you have a problem with another player, We are not required to get involved, but We can if We desire. If you have a dispute with another player, you release Pokerace and its officers, directors, agents, subsidiaries, parent companies, joint ventures, and employees, and all Pokerace Affiliates from responsibility, claims, demands and/or damages (actual or consequential) of every kind and nature, whether known or unknown, resulting from that dispute or connected to that dispute. This includes damages for loss of profits, goodwill, use or data. 

9. PAYMENT TERMS We provide a service in the form of access to games and Virtual Items. In the Service you may use "real world" money to obtain a limited license to use Virtual Items and/or other goods or Service/s. How it Works: You get a limited license to Virtual Items by visiting the purchase page in one of our games, providing your billing information, confirming your request and re-affirming your agreement to these Terms. On Racingpoker.com, the payment page will let you know what you can use to pay when you make your purchase. We may change what you can use to pay from time to time, at Our sole discretion. Virtual Items purchased in Our games on other platforms such as Facebook, Apple iOS, or Android will be subject to those platforms' payment Terms & Conditions of Service. Pokerace does not control how you can pay on those platforms. Please review those platforms' terms of service for additional information. When you get a limited license to use Virtual Items from our Service/s on racingpoker.com, We may send you a confirmation email or text that will have details of the items you have ordered. Please check that the details in the confirmation message are correct as soon as possible and keep a copy of it for your records. Pokerace keeps records of transactions in order to deal with any future questions about that transaction. For Virtual Items, your order will represent an offer to Us to obtain a limited license for the relevant service(s) or virtual in-game item(s) which will be accepted by Us when We make the Virtual Items available in your account for you to use in our games or debit your credit card or other account through which you paid, whichever comes first. Your limited licence to Virtual Items for use in Pokerace games is a service provided by Pokerace that starts when We accept your payment or redemption of third party virtual currency (if applicable). For orders to obtain a limited licence to use Virtual Items, by clicking the button on the purchase window or page you: 1) agree that We may start to supply your purchased Virtual Items immediately after you have clicked that button; and 2) if you reside in the European Union, you acknowledge that you will therefore no longer have the right to cancel under the EU's Consumer Rights Directive (as implemented by the law of the country where you are located) once we start to supply the Virtual Item. You understand that while you may "earn" "buy" or "purchase" Virtual Items in our Service/s, You do not legally "own" the Virtual Items and the amounts of any Virtual Item do not refer to any credit balance of real currency or its equivalent. Any "virtual currency" balance shown in your Account does not constitute a real-world balance or reflect any stored value, but instead constitutes a measurement of the extent of your limited license. ALL SALES ARE FINAL: YOU ACKNOWLEDGE THAT POKERACE IS NOT REQUIRED TO PROVIDE A REFUND FOR ANY REASON, AND THAT YOU WILL NOT RECEIVE MONEY OR OTHER COMPENSATION FOR UNUSED VIRTUAL ITEMS WHEN AN ACCOUNT IS CLOSED, WHETHER SUCH CLOSURE WAS VOLUNTARY OR INVOLUNTARY, OR WHETHER YOU MADE A PAYMENT THROUGH POKERACE.COM OR ANOTHER PLATFORM SUCH AS APPLE, GOOGLE, FACEBOOK, OR ANY OTHER SITES OR PLATFORMS WHERE WE OFFER OUR SERVICE/S. Third Party Virtual Currency: You may also obtain a limited licence to use Virtual Items by redeeming Pokerace third party virtual currency. PURCHASES OR REDEMPTIONS OF THIRD PARTY VIRTUAL CURRENCY TO ACQUIRE A LICENSE TO USE VIRTUAL ITEMS ARE NON-REFUNDABLE TO THE FULLEST EXTENT ALLOWED BY LAW. If you purchase third party currency or choose to make a payment in our Service/s through a third party (like Facebook, Apple, or Google), you are agreeing to the third party's payment terms, and Pokerace is not a party to the transaction. Additional Payment Terms: You agree to pay all fees and applicable taxes incurred by you or anyone using an Account registered to you. Pokerace may revise the pricing for the goods and Service/s it licenses to you through the Service at any time. Subscriptions (if available) are also subject to additional terms, which can be found at Subscription Terms when they are available. Billing Support: For billing support please email admin@racingpoker.com 

10. PROMOTIONS AND OFFERS From time to time, We may offer limited time promotions. Please review the official rules (if any) associated with the promotion. They will apply in addition to these Terms. In addition, from time to time, We may promote Offers. We are not required to give, and players are not required to accept, any Offer. Offers are not transferable, redeemable or exchangeable for other things of value outside of the Service/s. If you accept any Offer, you may have to sign a declaration of eligibility and liability release, or agree to Additional Terms in order to get the Offer. Some Offers will be subject to taxes and other charges, travel, or activities outside of the virtual world, all of which will be disclosed before You accept the offer. If you accept an Offer you also assume all liability associated with the Offer. 

11.THIRD PARTY ADVERTISING Our Service and our games may feature advertisements from Us or other companies. Our Privacy Policy explains what information We share with advertisers. Please read it. Sometimes We provide links in Our games or on the Service to other companies' websites or to companies who invite you to participate in a promotional offer and offer you some feature of the Service or upgrade (such as in-game currency) in exchange. Any charges or obligations you take on in dealing with these other companies are your responsibility. We make no representation or promises about any content, goods or Service/s these other companies provide, even if linked to or from Our Service or games. Also, just because We allow a link to be included in Our games or Service does not mean We endorse that linked site. We are not liable for any claim relating to any content, goods and/or Service/s of third parties. Please also note that the linked sites are not under our control and may collect data or ask you to provide them with your personal or other information, or they may automatically collect information from you. When you use other companies' Service/s like these, the other company's service may (or may not) ask you for permission to access your information and content. We are not responsible for these other companies' content, business practices or privacy policies, or for how they collect, use or share the information they get from you. Your relationship with that other company will control how it can use, store, and share your information. 

12. COPYRIGHT NOTICES/COMPLAINTS We respect the intellectual property rights of others and ask that you should, too. We respond to notices of alleged copyright infringement that comply with the Digital Millennium Copyright Act ("DMCA") and similar or equivalent local laws that may apply. We reserve the right to terminate any player's access to the Service if We determine that the player is a "repeat infringer." We do not have to notify the player before We do this. We also accommodate and do not interfere with standard technical measures copyright owners use to protect their materials. 

13. FEEDBACK AND UNSOLICTED IDEAS Any idea, information or feedback you submit to us with or without Our specific request will be deemed as non-confidential and non-proprietary. We may use the information as we see fit without any compensation to you or any third party irrespective of whether We use it or not. 

14. WARRANTY DISCLAIMER; SERVICE/S AVAILABLE ON AN "AS IS" BASIS Neither Pokerace nor any Pokerace Affiliate makes any promise or guarantee that the Service will be uninterrupted or error-free. USE OF THE SERVICE IS AT YOUR SOLE RISK. IT IS PROVIDED ON AN "AS IS" BASIS. TO THE EXTENT PERMITTED BY APPLICABLE LAW, POKERACE AND ANY POKERACE AFFILIATE MAKE NO WARRANTIES, CONDITIONS OR OTHER TERMS OF ANY KIND, EITHER EXPRESS OR IMPLIED, ABOUT THE SERVICE/S. POKERACE AND ANY POKERACE AFFILIATE DISCLAIM ANY WARRANTIES OF TITLE OR IMPLIED WARRANTIES, CONDITIONS OR OTHER TERMS OF NON-INFRINGEMENT, MERCHANTABILITY, QUIET ENJOYMENT OR FITNESS FOR A PARTICULAR PURPOSE. If your state or country does not allow these disclaimers, they do not apply to you. If your state or country requires a certain period for which a warranty applies, it will be either the shorter of 30 days from your first use of the Service or the shortest period required by law. 

15. LIMITATIONS; WAIVERS OF LIABILITY YOU ACKNOWLEDGE THAT THE WE AND POKERACE AFFILIATES ARE NOT LIABLE 
1) FOR ANY INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES, INCLUDING FOR LOSS OF PROFITS, GOODWILL OR DATA, IN ANY WAY WHATSOEVER ARISING OUT OF THE USE OF, OR INABILITY TO USE, THE SERVICE; 
2) IF YOU USE THE SERVICE AND IT IS ILLEGAL FOR YOU TO DO SO IN YOU JURISTICTION; 
3) IF YOU LIE TO US ABOUT YOUR AGE; OR 
4) FOR THE CONDUCT OF THIRD PARTIES, INCLUDING OTHER USERS OF THE SERVICE AND OPERATORS OF EXTERNAL SITES. THE RISK OF USING THE SERVICE AND EXTERNAL SITES RESTS ENTIRELY WITH YOU AS DOES THE RISK OF INJURY FROM THE SERVICE AND EXTERNAL SITES. TO THE FULLEST EXTENT ALLOWED BY ANY LAW THAT APPLIES, THE DISCLAIMERS OF LIABILITY IN THESE TERMS APPLY TO ALL DAMAGES OR INJURY CAUSED BY THE SERVICE, OR RELATED TO USE OF, OR INABILITY TO USE, THE SERVICE, UNDER ANY CAUSE OF ACTION IN ANY JURISDICTION, INCLUDING, WITHOUT LIMITATION, ACTIONS FOR BREACH OF WARRANTY, BREACH OF CONTRACT OR TORT (INCLUDING NEGLIGENCE). TO THE MAXIMUM EXTENT PERMISSIBLE UNDER APPLICABLE LAWS, THE TOTAL LIABILITY OF POKERACE AND/OR THE POKERACE AFFILIATES IS LIMITED TO THE TOTAL AMOUNT YOU HAVE PAID POKERACE AND/OR THE POKERACE AFFILIATE IN THE ONE HUNDRED AND EIGHTY DAYS (180) DAYS IMMEDIATELY PRECEDING THE DATE ON WHICH YOU FIRST ASSERT ANY SUCH CLAIM. IF YOU HAVE NOT PAID POKERACE OR ANY POKERACE AFFILIATE ANY AMOUNT IN THE ONE HUNDRED AND EIGHTY DAYS (180) DAYS IMMEDIATELY PRECEDING THE DATE ON WHICH YOU FIRST ASSERT ANY SUCH CLAIM, YOUR SOLE AND EXCLUSIVE REMEDY FOR ANY DISPUTE WITH POKERACE AND/OR ANY POKERACE AFFILIATE IS TO STOP USING THE SERVICE AND TO CANCEL YOUR ACCOUNT. Some states or countries do not allow the exclusion of certain warranties or the limitations/exclusions of liability described above. So these limitations/exclusions may not apply to you if you reside in one of those states or countries. 

16. INDEMNITY If you use or misuse the Service, or if you violate these Terms or any other applicable rules, including the Social Policy or Additional Terms, and that results in loss or damage or in a claim or liability against Pokerace or any Pokerace Affiliate, you agree to indemnify, defend and hold harmless Pokerace and/or the Pokerace Affiliate (which means you agree to compensate Pokerace and/or the Pokerace Affiliate on a "dollar for dollar" basis) for that loss, damage, claim or liability, including compensating Pokerace and/or the applicable Pokerace Affiliate for our legal fees or expenses. If Pokerace or the Pokerace Affiliate wants to, they are allowed to take exclusive charge of the defence of any case on which you are required to compensate or reimburse them, and it will be at your expense. You also have to cooperate in Pokerace's and/or the Pokerace Affiliate's defense of these cases. Pokerace and/or the Pokerace Affiliate will use reasonable efforts to let you know if they learn of any claim on which you have to compensate or reimburse them. This will apply even if you stop using the Service/s or your account is deleted. 

17. AGREEMENT TO ARBITRATE AND CLASS ACTION WAIVER Before bringing a formal legal case, please first try contacting our Customer Support team at admin@pokerace.com.au or try to find a resolution on one of our forums. Most disputes can be resolved that way. If we can't resolve our dispute through Customer Service or on our forums (coming soon), you and Pokerace or any member of the Pokerace Corporate Group all agree to resolve any claims relating to the Terms, the Privacy Policy, Social Policy, Additional Terms or Pokerace's Service/s through final and binding arbitration. This applies to all kinds of claims under any legal theory, unless the claim fits in one of the exceptions in the Exceptions to Agreement to Arbitrate sub-section. It also applies even after you stopped using your Pokerace account or deleted it. An arbitration proceeding is before a neutral arbitrator instead of a judge and jury, so we are all giving up our right to a trial before a judge and jury. Arbitrations have different rules than lawsuits in court. They are less formal than lawsuits in courts, and provide limited opportunity to force the other side to share information relevant to the dispute; a process called discovery. The arbitrator can award the same damages and relief on an individual basis that a court can award to an individual. But, if any of us does not like the arbitrator's decision, the courts only have a limited ability to change the outcome of arbitration or make the arbitrator reconsider his or her decision. If we have a dispute about whether this agreement to arbitrate can be enforced or applies to our dispute, we all agree that the arbitrator will decide that, too. Exceptions to Agreement to Arbitrate We all agree that we will go to court to resolve disputes relating to: Your, Pokerace's, or a Pokerace Corporate Group member's intellectual property (for example, trademarks, patents, domain names, trade secrets or copyright); or your violation of the Social Policy. For more information about which court we can go to for resolving these types of disputes, see Section 19 (Venue for Legal Disputes Not Subject to Arbitration). Also, any of us can bring a claim in small claims court either in Sydney, New South Wales or some other place we both agree on, if it qualifies to be heard in that court. In addition, if you, Pokerace or a Pokerace Corporate Group member brings a claim in court that should be arbitrated or any of us refuses to arbitrate a claim that should be arbitrated, the other of us can ask a court to force us to go to arbitration to resolve the claim (i.e., compel arbitration). You, Pokerace or the Pokerace Corporate Group member may also ask a court to halt a court proceeding while an arbitration proceeding is ongoing. No Class Actions We all agree that we can only bring a claim against each other on an individual basis. That means: 1) Neither you nor Pokerace nor any member of the Pokerace Corporate Group can bring a claim as a plaintiff or class member in a class action, consolidated action or representative action. 2) The arbitrator cannot combine more than one person's claim into a single case, and cannot preside over any consolidated, class or representative arbitration proceeding (unless we both agree to change this). 

18. APPLICABLE LAW Apart from that these Terms our relationship will be governed by New South Wales law in Australia, except for its conflicts of laws principle. 

19. VENUE FOR LEGAL DISPUTES NOT SUBJECT TO ARBITRATION You and Pokerace both consent to venue and personal jurisdiction in Sydney New South Wales Australia. 

20. SEVERABILITY Except as described in Section 17 under the "No Class Actions" heading, if any part of these Terms, Additional Terms, Social Policy or the Privacy Policy is not enforceable, the rest of these Terms, Additional Terms, Social Policy and the Privacy Policy still applies and is binding and any unenforceable term will be substituted reflecting our intent as closely as possible. 

21. ASSIGNMENT We may give our rights, or Our obligations, under these Terms, Additional Terms, Social Policy, or our Privacy Policy to any person or entity at any time with or without your consent. You may not give your rights or your obligations under these Terms, Additional Terms, Social Policy, or our Privacy Policy without first getting Pokerace's written consent, and any attempt to do so without our consent is void. 

22. ENTIRE AGREEMENT These Terms, and any other policies or rules We reference in these Terms, make up the entire agreement between you and Us relating to the subject matter of these Terms, and (except in the case of fraud or made a fraudulent misstatement) supersede all prior understandings of the parties relating to the subject matter of these Terms, whether those prior understandings were electronic, oral or written, or whether established by custom, practice, policy or precedent, between you and Us. 

23. LANGUAGE OF THE TERMS If We provide a translated version of these Terms, Additional Terms, the Social Policy, the Pokerace Privacy Policy, or any other terms or policy, it is for informational purposes only. If the translated version means something different than the English version, then the English meaning will be the one that applies. 

24. NO WAIVER If We do not enforce a provision of these Terms, Additional Terms, the Social Policy, or our Privacy Policy, that does not waive our right to do so later. And, if We do expressly waive a provision of these Terms, Additional Terms, the Social Policy or our Privacy Policy that does not mean it is waived for all time in the future. Any waiver must be in writing and signed by both you and Us to be legally binding. 

25. NOTICES We may notify you by posting something on Our Service domain for the Pokerace game(s) you play, and sending you an e-mail or using other ways of communicating with you based on the contact information you provide to Us. If you are a player in the United States, and you have to give Us notice of something according to the Terms, Additional Terms, Social Policy, or our Privacy Policy, the notice must be in writing and addressed to Pokerace Inc., Attn: LEGAL DEPARTMENT, biz@pokerace.com.au , unless we have provided a more specific method way of notifying us. Any attempted notice that does not follow these rules has no legal effect. 

26. EQUITABLE REMEDIES You agree that given the unique and irreplaceable nature of the rights granted and obligations made under these Terms and the Social Policy, if you breach these Terms, Additional Terms, Social Policy and/or our Privacy Policy, or intend to breach these Terms, Additional Terms, Social Policy or Privacy Policy, money damages alone will not be enough to repair the harm to Pokerace. Therefore, for disputes that are not required to be resolved through arbitration as described in Section 17, Pokerace may seek injunctive or other equitable relief (e.g., get a court order to make you stop doing whatever you're doing that is causing harm) if you breach or intend to breach these Terms, Additional Terms, Social Policy or our Privacy Policy and Pokerace does not have to post any bond or surety or submit proof of damages. You agree to limit your claims to claims for money damages, as limited by Section 15 (Limitations; Waivers of Liability). And, you agree not to seek injunctive or equitable relief or otherwise seek to stop Us from operating any aspect of the Service or any Pokerace Game. 

27. FORCE MAJEURE We are not liable for any changes or problems out of our control, for example changes or problems caused by like natural disasters, war, terrorism, riots, embargoes, acts of civil or military authorities, fire, floods, accidents, network infrastructure failures, strikes, or shortages of transportation facilities, fuel, energy, labour or materials.
 </p>
                </div>
            </div>
             <div class="modal-footer">
                 <button type="button"  class="btn btn-primary" data-dismiss="modal"> Close </button>
                
             </div>
    </div>
  </div>
</div>
       
       <div class="modal fade" id="privacy_modal" tabindex="-1" role="dialog" aria-labelledby="privacy_modal" aria-hidden="true">
    <div class="modal-md modal-dialog" style="background:#070D0D" >
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h4 class="modal-title" id="myModalLabel" style="color:#E77817"> Pokerace Pty Ltd. Privacy policy </h4>
            <div id="error_message"> </div>
            </div>
            <div class="modal-body">  
                <div class="row" style="text-align: justify; overflow-y:scroll; height:240; font-size: 10 ">
                    <p>
                      POKERACE PTY LTD - PRIVACY POLICY.

Pokerace Pty Ltd develops and provides games for the web and other devices. "Pokerace" refers to Pokerace Pty Ltd and the Pokerace Group in this Privacy Policy. The Pokerace Group means Pokerace Pty Ltd's subsidiaries, parent companies, joint ventures and other corporate entities under common ownership or licensing arrangements and/or any of their agents, consultants, employees, officers and directors. 

This Privacy Policy applies whenever you play Pokerace's games or otherwise access any of our other products, services, content, RacingPoker.com, Pokerace.com.au and/or the other domains provided by Pokerace, together referred to as "Services". 

This Privacy Policy describes:
-	what information Pokerace collects, how it collects the information, and why;
-	how Pokerace uses that information and with whom it shares the information;
-	where the information will be stored;
-	who can access that information;
-	how you can access and update that information;
-	the choices you can make about how Pokerace collects, uses, and shares your information;
-	how Pokerace protects the information it stores about you;
-	how you can contact Pokerace to complain.

If you do not wish Pokerace to collect, store, use or share your information, you should not play Racing Poker, Pokerace's games or use Pokerace's Services.


Collecting personal information about you.
Information provided to Pokerace by customers, contractors and other third parties might be considered private or personal. Without these details Pokerace would not be able to carry on its business and provide its Services to you. Pokerace will only collect such personal information if it is necessary for one of its functions or activities.


The kinds of personal information we hold.
Pokerace may collect and store some or all of the following information provided by you or the social network:
-	your first and last name;
-	your profile picture, avatar or its URL;
-	your birthday and/or age range; 
-	your gender;
-	your physical location and  the devices you use to access its Services;
-	your login email or the login e-mail you provided to the social network when you registered;
-	your social network ID number (e.g. your Facebook ID number) which is linked to publicly-available information e.g. your name and profile photo;
-	the social network ID numbers and other public data for your friends;
-	other publicly-available information on the social network; and/or
-	any other information that you or the social networks share with Pokerace.

If you access Pokerace's Services from a social network, you should also read that social network's Terms of Service and Privacy Policy.
If you are unclear about what information a social network is sharing with Pokerace, please go to the social network where you play Pokerace's games to find out more about their privacy settings.


How that personal information is collected and stored or held.
If you play Pokerace's games or access any of its other Services on a social network like Facebook, Pokerace receives certain information about you from the social network automatically. Depending on the Pokerace game you are playing determines the information it receives, the social network, and your privacy settings and your friends' privacy settings on that social network.
For example, Pokerace may collect and store some or all of the following information provided by the social network:
-	your first and last name;
-	your profile picture or its URL;
-	your social network ID number (like your Facebook ID number), which is linked to publicly-available information like your name and profile photo;
-	the social network ID numbers and other public data for your friends;
-	the login e-mail you provided to that social network when you registered;
-	your physical location and that of the devices you use to access Pokerace's Services;
-	your gender;
-	your birthday and/or age range;
-	other publicly-available information on the social network; and/or
-	any other information that you or the social networks share with Pokerace;
-	to allow you to connect with users on Facebook so you can invite them or create times for tournaments with your friends. 

Pokerace also uses log files, tags, and tracking technologies to collect and analyse certain kinds of technical information, including:
-	IP addresses;
-	the type of computer or mobile device you are using;
-	your operating system version;
-	your mobile device's identifiers, like your MAC Address, Identifier For Advertising (IDFA), and/or International Mobile Equipment Identity (IMEI);
-	your browser types;
-	your browser language;
-	referring and exit pages, and URLs;
-	platform type;
-	the number of clicks on a page or feature;
-	domain names;
-	landing pages;
-	pages viewed and the order of those pages;
-	the amount of time spent on particular pages; and
-	game state and the date and time of activity on our websites or games.

In certain instances, Pokerace will connect this information with your social network ID.

Other Information from Your Mobile Device
Pokerace may also collect the following information when you play Pokerace's games on your mobile device:
-	the name you have associated with your device;
-	your telephone number;
-	your country; and
-	your specific geolocation;
-	your mobile contacts (as further described below in "Information About Your Contacts"; and
-	information about other third party Apps you have on your device.

Information About You That You Share With Us Directly.
When you use Pokerace's Services (either through the social network or through Pokerace directly), Pokerace will collect the information you give Pokerace when you are setting up your account and Pokerace will store that information on its systems and use it for the purposes described in this Privacy Policy.

Our games or some of Pokerace's Services may require a more traditional registration or account set-up process where you may be asked to give Pokerace some or all of the following information:
-	your age or birthday;
-	your first and last names;
-	your e-mail address;
-	a password; and
-	other information that helps Pokerace make sure it is you accessing your account or assists Pokerace to improve its services.

Pokerace may also allow you to create a player profile, separate from your social networking site profile (for example, your Facebook profile), which other Pokerace players can see. Your player profile may include information such as:
-	a profile photo;
-	game username(s);
-	your gender;
-	biographic details (like your age or age range);
-	approximate location information that you provide;
-	links to your profiles on various social network;
-	details about the games you play; and
-	a Pokerace player ID number that is created by Pokerace and used to identify your profile.

The following information will be publicly accessible on Pokerace's websites which offers direct access to Pokerace games, including:
-	the Pokerace player ID;
-	your first and last names; and
-	your player profile picture.

Your Pokerace player ID number will be used to identify your account and player profile will appear in the URL of your profile page. It will only allow access to information you make public in your settings.

Information About Your Contacts.
Pokerace may also allow you to import your address book contacts or manually enter them so that you can locate your contacts on Pokerace and invite them to join you in Pokerace's games or other aspects of its Services. You are responsible for getting your contacts' permission if you choose to give Pokerace their contact details. Pokerace may also get information about you from other Pokerace users importing or entering their contacts. Pokerace may use and may store this contact information to help you and your contacts connect through its Services. If you want to remove your contacts stored by Pokerace, follow the instructions provided in the game to request that Pokerace remove them from its systems. Pokerace does not store passwords which are required to enable Pokerace to access your address book.

Information You Generate Using Our Communications Features.
When you participate in some of Pokerace's games, Pokerace will allow you to communicate or share information with other Pokerace players. These include:
-	participating in player forums and message boards;
-	posting public comments to other players' profiles or game boards;
-	sending private messages or invitations to other players, either directly on Pokerace's websites or to their e-mail accounts;
-	chatting with other players; and/or
-	posting photos or drawings.

Accordingly, you acknowledge and expressly authorise Pokerace to access in real-time, record and/or store archives of these communications, comments, photos and drawings on Pokerace's servers so Pokerace can utilise the information to protect the safety and well-being of its players and Pokerace's rights and property in relation to its Services; to conduct research; to operate, improve, personalize and optimize Pokerace's Services and its players' experiences, including through the use of analytics as well as to manage and deliver contextual advertising.

Payment Information.
If you purchase a license to use in-game virtual currency or virtual items in a game you play on Pokerace's sites, Pokerace's third party payment processor will collect your billing and financial information to process your transactions.  The information Pokerace collects and stores may include your name, postal address, billing address, e-mail address, items purchased, payment and financial information which does not include credit card numbers even when your purchase is processed by third parties (e.g. Facebook, Apple or Google) while you are playing a game on a social network or that you downloaded on your mobile device. Please refer to Pokerace's Terms of Service  which sets out Pokerace's policies and terms regarding its charges, billing practices, third party credits and virtual currencies. Any purchases of third party credits or currencies may also be subject to those third parties' policies.

Customer Support Correspondence
Any communications you have with Pokerace's Customer Support team  will be collected and stored (e.g. your name and e-mail address) including information about your game play or activity on its Services, and your Pokerace player and/or social network ID number in order to improve Pokerace's support.

Information You Give Us For Text Messaging Services.
Any information you provide (e.g. your mobile telephone number) in response to Pokerace's SMS messages will also be collected and stored.

Game Toolbars or Game Bars (when available).
You may have installed a Pokerace-branded toolbar ("Pokerace Toolbar") when playing its games. 

The Pokerace Toolbar will automatically update improvements on your browser and in doing so, may collect information (e.g. your social network ID). Other Pokerace Toolbar features may allow you to provide personal information (e.g. Contact form, Tell-a-friend). Pokerace may also retain statistics regarding how players use its Toolbar collectively. 

Other Sources.
Pokerace may collect or receive information about you from other sources like third party information providers to enable Pokerace to assist you and your friends to connect or to provide advertising that is more tailored to your interests.

Your information will be held on Pokerace's servers in Melbourne, Australia.

Using and disclosing your personal information.
The purpose for which Pokerace collects and holds personal information and how Pokerace uses and discloses it.

The information Pokerace collects and stores is to enable Pokerace to provide you with a better gaming experience.  The other uses for which Pokerace collects and stores your information include:
-	to operate, improve and optimize Pokerace's Services and its players' experiences;
-	to create your game accounts and allow you to play Pokerace's games;
-	to identify and suggest connections with other Pokerace players and personalize its Services to you;
-	to enable players to communicate with each other;
-	to provide technical support and respond to player inquiries;
-	to protect the safety and well-being of Pokerace's players;
-	to protect Pokerace's rights and property in connection with its Services;
-	to prevent fraud or potentially illegal activities, and to enforce Pokerace's Terms of Service;
-	to manage and deliver contextual and behavioural advertising;
-	to notify players of in-game updates, new products or promotional offers;
-	to administer rewards, surveys, sweepstakes, contests, or other promotional activities or events sponsored or managed by Pokerace or its business partners;
-	to comply with Pokerace's legal obligations, resolve any disputes it may have with you or other players, and to enforce Pokerace's agreements with third parties; and
-	to conduct research.

One important use of your information is communication. If you have provided your e-mail address to Pokerace, we will use it to respond to customer support inquiries, and keep you informed of your in-game activity, including comments from friends, let you know about in-game status such as bonuses as well as tell you about gift and friend requests. Some messages, like invites for friends to join you in a game, may include your name and profile photo. We may also send promotional e-mail messages and promotional SMS messages (e.g. text messages) ("Promotional Communications") directly or in partnership with other parties, in accordance with your marketing preferences. Each Promotional Communication will offer you choices about receiving additional messages.

Storage and security of your personal information. 
Pokerace will take reasonable steps to keep any personal information it holds about you secure.  However, except to the extent liability cannot be excluded due to the operation of the statute, Pokerace excludes all liability (including in negligence) for the consequences of any unauthorised access to your personal information.  Please notify Pokerace immediately if you become aware of any breach of security.

Pokerace may store your personal information in hard copy or electronically in Cloud in Melbourne, Australia or the servers of third parties within Australia.
Pokerace implements a range of physical and electronic security measures to protect the personal information that it holds, including:
-	restricted access to our offices;
-	mandatory password protection on all computers (users are required to change their passwords at regular intervals);
-	hardware encryption on desktops, laptops and portable storage devices;
-	secure hard copy document storage, secure electronic storage media and hardware, and secure document disposal procedures;
-	firewall and antivirus/malware software; and
-	systems and application access controls implemented to restrict access to information (on a need to know basis).
Cookies and Automated Information Collection
Pokerace and its service providers (e.g.Google Analytics) store log files and use tracking technologies such as:
-	cookies (being small pieces of data) to transfer information to your mobile device or computer for record-keeping purposes;
-	web beacons, which notifies Pokerace if a certain page was visited or whether an e-mail was opened;
-	tracking pixels to allow Pokerace or its advertising partners to advertise more efficiently and effectively; and
-	local shared objects or flash cookies to assist Pokerace to reduce fraud, recall your in-game preferences and speed upload times.

Access to your personal information.
Personal Information is displayed and can be updated under Your User Account which is visible once you have logged into your account.

Complaints. 
If you wish to make a complaint, please contact Pokerace in writing to the e-mail address, privacy@racingpoker.com.

Disclosing and storing personal information overseas.
In the event Pokerace sells or licenses to a third party outside Australia, Pokerace may provide them with details of its users.
However, Pokerace will not send personal information about an individual outside Australia without:
-	obtaining the consent of the individual (in some cases this consent will be implied); or
-	otherwise taking all reasonable steps to ensure such third parties comply with the Australian Privacy Principles or other applicable privacy legislation.
The countries in which these third parties are located will depend on the circumstances and includes our administration support services.
Pokerace may also store personal information in the "Cloud" and other third party Cloud storage facilities, which may mean that it resides on servers which are situated outside Australia.  As these Cloud storage services are provided by independent third parties, the actual location of these servers may change from time to time and is outside Pokerace's knowledge or control.

Changes to Our Privacy Policy.
From time to time it may be necessary for Pokerace to review and revise its Privacy Policy.  Pokerace reserves the right to change its Privacy Policy at any time.  Pokerace may notify you and other players of any change to its Privacy Policy by placing a notice on Pokerace.com.au or its equivalent RacingPoker.com in-game, or by sending you a notice to your e-mail address noted in its records prior to the change becoming effective or by otherwise informing you that a revised copy of our Privacy Policy is available on request. Pokerace may supplement this process by placing notices on game blogs, social network pages, and/or forums and on other Pokerace websites. You should periodically check www.pokerace.com.au  and this privacy page for updates.

Privacy Policies of Linked Third Party Services and Advertisers.
Pokerace's websites and games may contain advertisements from Third Party Services who may link to their own websites, online services or mobile applications. Pokerace takes no responsibility for the privacy practices or the content of these Third Party Services. If you have any questions about how these Third Party Services use your information, you should review their policies and contact them directly.

                    </p>
                </div>
            </div>
             <div class="modal-footer">
                 <button type="button"  class="btn btn-primary" data-dismiss="modal"> Close </button>
                
             </div>
    </div>
  </div>
</div>
     <div class="modal fade" id="social_modal" tabindex="-1" role="dialog" aria-labelledby="social_modal" aria-hidden="true">
    <div class="modal-md modal-dialog" style="background:#070D0D" >
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h4 class="modal-title" id="myModalLabel" style="color:#E77817"> Social  Policy</h4>
            <div id="error_message"> </div>
            </div>
            <div class="modal-body">  
                <div class="row" style="text-align: justify; overflow-y:scroll; height:240; font-size: 10 ">
                    <p>
                        Pokerace Pty Ltd - Social Policy

Our Social Policy forms part of the Terms you're agreeing to which is governed by the Law, the Platform Terms of Service on which you play e.g. via Facebook, and these Rules. 

You agree you will not, under any circumstances: 
1) Use the Service or do anything that breaches any applicable law or regulation; or 
2) Engage in any act that We deem, at Our sole discretion, to be in conflict with any policy terms, or the spirit of the Service offered. 

You agree that you will not, under any circumstances: 
1) Collect or harvest other user's content or information, 
2) Try to get login information or access an account belonging to other players, 
3) Upload or transmit or attempt to upload or transmit, without Pokerace's express permission, anything that acts as an information collection or transmission mechanism: including, without limitation, 1x1 pixels, graphics interchange formats ("gifs"), cookies, web bugs or other similar software technologies. 

You agree that you will not, under any circumstances: 
1) Post any content that contains nudity, expresses violence, offensive subject matter or that contains a link to such content; 
2) Post any content that is abusive, threatening, obscene, defamatory, libellous, or racially, sexually, religiously, is otherwise objectionable or offensive; or violates any applicable law or regulation. 
3) Harass, abuse, or harm, or advocate or incite harassment, abuse or harm towards another person, group, including without limitation to Pokerace directors, owners, employees and customer service representatives, affiliates; Account Creation and Use. 

The following rules govern your account's creation and use: 
1) You may not have more than one account, per platform or social network and must not create an account using a false email or as someone other than yourself; 
2) You must not sublicense, rent, lease, sell, gift, trade, bequeath or otherwise transfer your account or any Virtual Items belonging to your account to anyone without Pokerace's written permission; any such transfer is prohibited and will be void; 
3) You must not access or use an account or Virtual Items that belong to another person; 
4) Post content that violates or infringes some else's rights; or 5) Impersonate another person, including without limitation, a Pokerace employee. Unauthorized Use of the Service. 

You agree that you will not, under any circumstances: 
1) Attempt to gain unauthorized access to the Service, user accounts registered to others or to the any computer or server used to offer or support the Service or any Pokerace game environment (each a "Server") or networks connected to the service by any means other than the user interface provided by Pokerace, including but not limited to circumventing, modifying or causing to be modified , attempting to circumvent, modify, encourage, or assisting any other person to circumvent or modify any security, technology, device or software that is part of the service; 
2) Use or design cheats, automation software, hacks, bots, mods or any unauthorized third party or other software designed to modify or interfere with the service of any Pokerace game; 
3) Initiate, execute, aide, encourage or become involved in any type of attack, including without limitation denial of service attacks (DOS) , distribution of a virus to the service or other attempts to disrupt the Service or any other person's use of the Service; 
4) Use, facilitate, create, or maintain any unauthorized connection to the Service, including without limitation: 
	(1) any connection to an unauthorized server that attempts to emulate, or emulates any part of Our Service; 	
	(2) any connection using software tools not expressly approved by Pokerace; 
	(3) A Virtual Private Network located in a different country to yourself; 
5) Use any unauthorized software that accesses, intercepts or otherwise collects information from the Service or data that is in transit to facilitate the Service, including, without limitation, any software that reads the content of RAM or data streams (network traffic) used by the Service to facilitate the game play and playing environment of the Service. Pokerace may, at its sole and absolute discretion, allow the use of certain third party user interfaces; 
6) Make any automated use of the Service or perform any action that imposes or may impose (in our sole discretion) a disproportionate load on our Server or network resources, or 
7) Intercept, examine or otherwise observe any communications used by a client, a server, or the Service through the use of any network analyser, packet sniffer or other tools; 
8) Interfere or try to interfere with the proper functioning of the Service. Connect to or use the Service in a manner not expressly granted by the Terms of Service:  including disrupting, assisting in or encouraging the disruption of any server or the use of any Pokerace game by another person; 
9) Make improper use of Pokerace's support services, including by submitting untrue abuse reports or use abusive language in your communications with our personnel; 
10) Bypass any measures We employ to restrict access to the Service or use any software or a device to send messages or content outside of the Service eg scrape, harvest, manipulate the data or crawl the Service; 
11) Except where permitted by law or relevant open-source licences you will not try to modify, reverse engineer, decompile, decipher, disassemble or otherwise try to extract the source code from us. Nor try to obtain any information, from the Service, using any method not expressly permitted by Pokerace; or 
12) Copy, modify or distribute content from any Pokerace site or game, or Pokerace's copyrights, patents or trademarks or copy or distribute any content of the Service except as specifically authorized by Pokerace eg a Social Platform. 

Commercial Activity. 
You agree that under no circumstances will you: 
1) Use the Service for performing in-game services, such as Credits, Bitlets, in exchange for payment outside the Service. 
2) Use the Service for any unauthorized commercial purpose, including but not limited to 
	(1) communicating or facilitating any commercial advertisement or solicitation eg spam or 
	(2) gathering or transferring virtual items for sale;  </p>
                </div>
            </div>
             <div class="modal-footer">
                 <button type="button"  class="btn btn-primary" data-dismiss="modal"> Close </button>
                
             </div>
    </div>
  </div>
</div>
       <!----- resend email----->
       <div id="resendEmail" class="modal" data-backdrop="static" data-keyboard="false" role="dialog">
       <div class="modal-dialog">
       <div class="modal-content">
      <div class="modal-header selected_color">
       
        <h4 class="modal-title" style="color:#ffffff">Email verification</h4>
      </div>
      <div class="modal-body selected_color" style="color:#ffffff">
          <p><span><img  src="/images/correct.png" class="" /></span> A new verification link has been sent to your email address. </p>
          <p>Please confirm the verification link sent to your email address. After confirmation process, please refresh page to enter into the tournaments. </p>
      </div>
      <div class="modal-footer selected_color">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
      </div>
      </div>
    </div>
       <!--- resend email failed---->
        <div id="resendEmailFailed" class="modal" data-backdrop="static" data-keyboard="false" role="dialog">
       <div class="modal-dialog">
       <div class="modal-content">
      <div class="modal-header selected_color">
       
        <h4 class="modal-title" style="color:#ffffff">Email verification</h4>
      </div>
      <div class="modal-body selected_color" style="color:#ffffff">
          <p><span><img  src="/images/correct.png" class="" /></span> Already, your email address has been verified . </p>
          <p> Please refresh the page to continue</p> </div>
      <div class="modal-footer selected_color">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
      </div>
      </div>
    </div>
       <!-------Verfication email -------->
       <div id="verifyEmailModal" class="modal" data-backdrop="static" data-keyboard="false" role="dialog">
       <div class="modal-dialog">
       <div class="modal-content">
      <div class="modal-header selected_color">
       
        <h4 class="modal-title" style="color:#ffffff">Email verification</h4>
      </div>
      <div class="modal-body selected_color" style="color:#ffffff">
          <p><span><img  src="/images/wrong.png" class="" /></span> Your email address has not been verified. So, game play is not possible.</p>
          <br/><p> Please confirm the verification link sent to your email address. After confirmation process, please refresh page to enter into the tournaments. </p>
          <p> If you have not received an email verification request then please click here to request another one.<span> 
           <button type="button" class="btn btn-default" onclick="resendLink()">Resend</button>    </span></p>
          <p> If you are unable to verify your email then please re-register with your correct email address.</p>
      </div>
      <div class="modal-footer selected_color">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
      </div>
      </div>
    </div>
    <!----footer--->
     <div class="row"> 
   <div class="footer" >
      <div class="container" >
          <p class="text-muted" style="color:#fff;text-align: center;"> <span> <kbd> 18+ </kbd> &nbsp;</span> <span> | </span> <span> Secured by <img src="/images/paypal_curved.png"  height="30"/> </span> | <span> &COPY;</span> <span> Copy rights (1999 - 2016) reserved by Pokerace Pty Ltd </span> </p>
      </div>
    </div>
    </div>
 <script type="text/javascript" src="/user_details.js" > </script>
 <script type="text/javascript" src="/facebooklogin_script.js" > </script>
 <script type="text/javascript" src="/load_tournaments.js" > </script>
 <script type="text/javascript" src="/Jquery/highcharts.js"></script>
 <script type="text/javascript" src="/Jquery/highslide-full.min.js"></script>
 <script type="text/javascript" src="/Jquery/highslide.config.js" charset="utf-8"></script>

</body>
</html>