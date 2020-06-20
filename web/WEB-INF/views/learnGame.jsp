<!-- this page serves as a template for setting up new pages with the V2 UI styles -->
<%@ page isELIgnored="false" %>
<%@ taglib tagdir='/WEB-INF/tags' prefix='rp' %>
<%@ taglib tagdir='/WEB-INF/tags/v2' prefix='v2' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en-us">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="keywords" content="Poker,racing poker,online poker,poker tournaments,players">
        <meta name="application-name" content="Racing Poker">
        <meta name="author" content="Pokerace Team">
        <link rel="icon" href="/images/racingpoker-logo9.png" />
        <link rel="stylesheet" href="/css/bootstrap_min.css" />
        <link rel="stylesheet" href="/templates/PageStyleSheets.css" />
        <link rel="stylesheet" href="/templates/PageLayout.css" />
        <link rel="stylesheet" type="text/css" href="https://www.highcharts.com/highslide/highslide.css" />
        <link rel="stylesheet" href="" />
        <v2:basicHeader />
        <v2:gameplayStyles />
        <v2:commonScripts />
        <style>
            .page-wrapper {
            	overflow: hidden;
            }
            .footer {
            	height: auto;
            }
            .headerStats {
            	display: inline-block;
            	position: relative;
            	top: 44px;
            	left: 44px;
            }
            .learnPages {
            	max-width: 220px;
            	margin-right: 20px;
            	padding-bottom: 15px !important;
            	position: relative;
            	top: 3px;
            }
            .learnPages a {
            	cursor: pointer;
            }
            .activeTab {
            	color: white;
            	font-weight: bold;
            }
            #heading {
            	font-weight: bold;
            }
        </style>
        <script src="/Jquery/bootstrap_min.js"></script>
        <script>
            var count =0;
            $(document).ready(function(){
            	//alert("in the tournament");
            	$('#help_popup').modal('show');
            	change_list("game_rules");
            });
            
            function change_list(id)
            {
            	$(".learnPages a").removeClass("activeTab");
            	$("#" + id).addClass("activeTab");
                if(id == "demo_link")
                {
                     $("#playlink").hide();
                     $("#levels_bonuses").hide();
                     $("#gamerules").hide();
                     $("#demo").show();
                      var heading = document.getElementById("heading");
                    heading.innerHTML = "Levels";
                }
                
                if(id == "game_rules")
                {
                    //alert(count);
                    $("#playlink").hide();
                     if(count > 0)
                     $('#help_popup').modal('hide');
                     $("#demo").hide();
                     $("#levels_bonuses").hide();
                    
                    $("#gamerules").show();
                     var heading = document.getElementById("heading");
                    heading.innerHTML = "How to play";
                    count++;
                }
                if(id == "play_link")
                {
                    $("#gamerules").hide();
                    $("#playlink").show();
                     $("#levels_bonuses").hide();
                     $("#demo").hide();
                     $('#help_popup').modal('hide');
                    var heading = document.getElementById("heading");
                    heading.innerHTML = "Shots";
                    
                    
                }
                
                if( id == "levels")
                {
                    $("#gamerules").hide();
                    $('#help_popup').modal('hide');
                    $("#playlink").hide();
                    $("#demo").hide();
                    $("#levels_bonuses").show();
                     var heading = document.getElementById("heading");
                    heading.innerHTML = "Levels and Bonuses";
                }
            }
        </script>      
    </head>
    <body>
        <!-- page wrapper -->
        <div class="page-wrapper">
            <v2:preloginNav />
            <!-- main -->
            <main class="main clearfix">
                <br/>
                <br/>
                <div class="row">
                    <div class="container">
                        <div class="col-md-3 bg-row learnPages" style=" border-radius: 16px; border: 1px white solid;">
                            <h4 style="text-align: center;color:white;;"> Get Started </h4>
                            &nbsp;&nbsp; <a  id="game_rules" class="active" onclick="change_list(this.id)" ><span class="glyphicon glyphicon-tasks active" > </span> How to play</a>  <br/>
                            &nbsp;&nbsp; <a  id="play_link" class="active" onclick="change_list(this.id)" ><span class="glyphicon glyphicon-tasks active" > </span> Shots</a>  <br/>
                            &nbsp;&nbsp; <a  id="demo_link" class="active" onclick="change_list(this.id)" ><span class="glyphicon glyphicon-tasks active" > </span> Levels</a>  <br/>
                            <!-- &nbsp;&nbsp; <a  id="levels" class="active" onclick="change_list(this.id)" ><span class="glyphicon glyphicon-tasks active" > </span>  Levels and Bonuses </a><br/> -->
                        </div>
                        <div class="col-md-9 bg-row" style="border-radius: 16px;color:#ffffff;">
                            <br/>
                            <div id="heading" style="font-size:16px">  How to play </div>
                            <div id="gamerules" style="text-align: justify;">
                                <iframe class="videoPlayerSmall" width="640" height="480" src="https://www.youtube.com/embed/tu_KWNZk8zY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                            	<hr />
                            	<div class="gameRulesText">
                            		<div class="rulesSection">
                            			<h5>How to Play/Rules of the Game</h5>
                            			<div class="rules">
                            				<p>
                            					Racing Poker&reg; is the world's newest poker game, where you bet on the best hand of poker and race against the clock to place your bets on which hand/s you think will win.  The odds you place your bets at is what those bets pay on regardless of how they may change as the game progresses.
                            				</p>
                            				<p>
                            					Racing Poker® uses Popups, please disable any Popup Blocker you have running prior to playing the game.
                            				</p>
                            				<p>
                            					There are 3 play modes:
                            				</p>
                            				<ul>
                            					<li>Solo mode where you control when the game deals,</li>
                            					<li>The Club (Tournament Play), where you select your Buy-in and play along with other players against the clock, and</li>
                            					<li>Racing 'Pot' Poker&trade;: Which is similar to the Club but only the first 3 places of a Tournament are paid from the Pot: 50% for 1st, 30% for 2nd and 15% for 3rd. Game Gold is required to play Racing 'Pot' Poker&trade;  Game Gold can be won or bought.</li>
                            				</ul>
                            				<p>
                            					It is a game based on most of the rules of poker using a standard 52-card deck. (See below)
                            				</p>
                            				<p>
                            					The goal is to profit on each game, doing so will get you shots, the more shots you get in a tournament the more you level up.
                            				</p>
                            			</div>
                            		</div>
                            		<div class="rulesSection">
                            			<h5>How to play</h5>
                            			<div class="rules">
                            				<p>
                            					Initially, every player is given Racing Poker&reg; Chips after registering to become a member.
                            				</p>
                            				<p>
                            					You can check your Chips on the screen at any time. 
                            				</p>
                            				<img src="/images/v2/tutorial/1.jpg" />
                            			</div>
                            		</div>
                            		<div class="rulesSection">
                            			<h5>Useful cards and useless cards</h5>
                            			<div class="rules">
	                            			<p>
	                            				Useless cards are determined based on the following rules:
	                            			</p>
	                            			<ul>
	                            				<li>Aces are always high.</li>
	                            				<li>Higher singles will be kept.</li>
	                            				<li>A pair is thrown in favour of a possible flush or double ended straight.</li>
	                            			</ul>
                            				<p>
                            					Suit hierarchy is Hearts, Diamonds, Clubs, and Spades.
                            				</p>
                            				<p>
                            					All other combinations such as a pair, two pairs and three of a kind are not considered to be a winning hand.
                            				</p>
                            			</div>
                            		</div>
                            		<div class="rulesSection">
                            			<h5>Commence Play</h5>
                            			<div class="rules">
                            				<p>
                            					Wait for 20 seconds for other players to join in the tournament
                            				</p>
                            				
                            				<p>
                            					Racing Poker&reg; starts with a random deal of six hands where every hand consists of 5 cards.  You can bet on every hand, and after every deal, you will be given 30 seconds time to place your bet.
                            				</p>
                            				
                            				<p>
                            					In the first step, 30 random cards will be dealt and useless cards are thrown back into deck.
                            				</p>
                            				
                            				<img src="/images/v2/tutorial/2.jpg" />
                            				
                            				<p>
                            					The example below demonstrates useful cards after useless cards are discarded.
                            				</p>
                            				
                            				<img src="/images/v2/tutorial/3.jpg" />
                            				
                            				<p>
                            					Hand hierarchy determines the winner:
                            				</p>
                            				
                            				<ul class="handRankings">
                            					<li>
                            						Royal Flush<br />
                            						<img src="/images/v2/tutorial/4.jpg" />
                            					</li>
                            					<li>
                            						Straight Flush<br />
                            						<img src="/images/v2/tutorial/5.jpg" />
                            					</li>
                            					<li>
                            						Four of a Kind<br />
                            						<img src="/images/v2/tutorial/6.jpg" />
                            					</li>
                            					<li>
                            						Full House<br />
                            						<img src="/images/v2/tutorial/7.jpg" />
                            					</li>
                            					<li>
                            						Flush<br />
                            						<img src="/images/v2/tutorial/8.jpg" />
                            					</li>
                            					<li>
                            						Straight<br />
                            						<img src="/images/v2/tutorial/9.jpg" />
                            					</li>
                            				</ul>
                            			</div>
                            		</div>
                            		<div class="rulesSection">
                            			<h5>Placing bets</h5>
                            			<div class="rules">
                            				<p>
                            					You are given 30 seconds to place your bets on each hand. To place a bet, please click on the bet button located on the right hand side of each hand.
                            				</p>
                            				
                            				<p>
                            					Choose your bet by clicking the Bet button next to each hand.
                            				</p>
                            				
                            				<p>
                            					The Quick Bet screen shows how to bet on any number of hands with any bet you choose, provided you have sufficient Chips to place a bet. 
                            				</p>
                            				
                            				<img src="/images/v2/tutorial/10.jpg" />
                            			</div>
                            		</div>
                            		<div class="rulesSection">
                            			<h5>Winning hands and payouts</h5>
                            			<div class="rules">
                            				<p>
                            					After 30 seconds, the remaining cards in the deck will be used for the next deal. If you have any winning hands, your bets will be paid out accordingly.  
                            				</p>
                            				
                            				<p>
                            					If you win your bet, the payout is the return amount on the winning hand.
                            				</p>
                            				
                            				<img src="/images/v2/tutorial/11.jpg" />
                            			</div>
                            		</div>
                            		<div class="rulesSection">
                            			<h5>Tournament rankings</h5>
                            			<div class="rules">
                            				<p>
                            					You can check your tournament rank on the leaderboards located under the Main Menu.
                            				</p>
                            			
                            				<p>
                            					At the end of tournament, results pop up to indicate your position in the tournament.
                            				</p>
                            				
                            				<img src="/images/v2/tutorial/12.jpg" />
                            			</div>
                            		</div>
                            		<div class="rulesSection">
                            			<h5>Gain XP's (Experience Points) to Level Up</h5>
                            			<div class="rules">
                            				<p>
                            					To gain XP's you have to play in The Club or the High Roller games.
                            				</p>
                            				
                            				<p>
                            					Gain XPs by getting Shots (where you win more than you bet or profit in a game).  Winning Shots will reward you with Game Gold that allows you to play the High Roller game Racing 'Pot' Poker&trade;.
                            				</p>
                            			</div>
                            		</div>
                            	
                            	</div>
                            </div>
                            <div id="playlink_DEFUNCT" style="text-align: justify; display: none;">
                                <p> Initially,Each player is given Racing Poker&trade; Tournament Credits after registering to become a member.</p>
                                <p> Please check your credits in current player section as described in below image. </p>
                                <img class="img-responsive" src="/images/Current_player.JPG" />
                                <p> Please wait for 20 seconds for other players to join in to the tournament </p>
                                <p> After every deal, you will be given 30 seconds time to place your bet. </p>
                                <p> To place bets, please click on the hand, who you want to place bet and it opens a bet box. </p>
                                <img class="img-responsive" src="/images/Betbox.JPG" />
                                <p> Please check your current bets in current bets section in web page. </p>
                                <img class="img-responsive" src="/images/Current_bets.JPG" />
                                <p> If you win your bet, it pays you the return amount on winning hand </p>
                                <img class="img-responsive" src="/images/Winning_hand.JPG" />
                                <p> You can observe your rank in the tournament in connected Player section </p>
                                <img class="img-responsive" src="/images/Connected_players.JPG" />
                                <p> At the end of tournament,  results pop up  to indicate your position in tournament.</p>
                                <img class="img-responsive" src="/images/Result.JPG" />
                            </div>
                            <div id="playlink" style="text-align: justify; ">
                            	<p>If you make a profit in a game more than once you will get a Shot. The more games you profit on in The Club or High Roller games the more Shots you win.</p>
                            	<p>Shots pay the following bonus depending how many you can get. A Shot is paid at the end of each game.</p>
                                <p> 2shot --- extra 10% win Chips </p>
                                <p> 3shot --- extra 20% win Chips </p>
                                <p> 4shot --- extra 30% win Chips, 1 Gold </p>
                                <p> 5shot --- extra 40% win Chips, 2 Gold, 1 XP (Experience Point) </p>
                                <p> 6shot --- extra 50% win Chips, 3 Gold, 1 XP </p>
                                <p> 7shot --- extra 60% win Chips, 4 Gold, 1 XP</p>
                                <p> 8shot --- extra 70% win Chips, 5 Gold, 1 XP</p>
                                <p> 9shot --- extra 80% win Chips,30 Gold, 3 XPs</p>
                                <p> 10shot -- extra 90% win Chips,50 Gold, 5 XPs</p>
                            </div>
                            <div id="demo" style="text-align: justify;" >
                                <p>Gain	XP's (Experience Points) to	Level Up.</p>
                                <p>To gain XP's you have to play in The Club or the High Roller games.</p>
                                <p>Gain XP's by topping tournaments	or by getting Shots (where you win more than you bet or profit in a game). Winning Shots will reward you with Game Gold	that allows you to play the High Roller game Racing 'Pot' Poker&trade;</p>
                                <p>Levels are matched to player ranks as described below:</p>
                                <p><span class="levelNum" style="display: inline-block; width: 40px;">0+</span> - Plankton<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">2</span> - Sardine<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">5</span> - Small Fry<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">10</span> - Mullet<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">20</span> - Snapper<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">35</span> - Tuna<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">60</span> - Marlin<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">100</span> - Reef Shark<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">150</span> - Bull Shark<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">225</span> - Tiger Shark<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">325</span> - Hammerhead Shark<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">450</span> - Grey Nurse Shark<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">575</span> - Great White Shark<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">725</span> - Whale<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">900</span> - Whale Shark<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">1100</span> - Killer Whale<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">1400</span> - Sea Monster<br />
                                <span class="levelNum" style="display: inline-block; width: 40px;">1800</span> - The Kraken</p>
                            </div>
                        </div>
                    </div>
                </div>
                <br />
                <br />
            </main>
            <v2:footerNav />
            <!-- page-wrapper -->
        </div>
    </body>
</html>