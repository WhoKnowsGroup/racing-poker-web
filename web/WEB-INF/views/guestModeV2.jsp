<%@ page isELIgnored="false" %>
<%@ taglib tagdir='/WEB-INF/tags' prefix='rp' %>
<%@ taglib tagdir='/WEB-INF/tags/v2' prefix='v2' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en-us">
	<head>
        <link rel="icon" href="/images/racingpoker-logo9.png" />
        <link rel="stylesheet" href="/css/bootstrap_min.css" />
        <link rel="stylesheet" href="/templates/PageStyleSheets.css" />
        <link rel="stylesheet" href="/templates/PageLayout.css" />
        <v2:basicHeader />
        <v2:gameplayStyles />
        <v2:commonScripts />   
        <script src="/Jquery/bootstrap_min.js"></script>     
        
        <style>
        	.inGameTimer {
        		display: inline-block !important;
        	}
        	.mobileInGameTimer {
        		display: none !important;
        	}
        	@media (max-width: 991px) {
				.mobileInGameTimer {
					display: inline-block !important;
					position: absolute !important;
    				top: 33px !important;
    				right: 80px !important;
				}
			}
			@media (max-width: 575px) {
				/*.mobileInGameTimer {
					top: 17px !important;
				}*/
				p.inGameTimer.mobileInGameTimer, .mobileDealButton {
				    top: 29px !important;
				}
			}
			
			/* Interactive Tutorial */
			.interactiveTutorialItem,
			.profile-stats div.interactiveTutorialItem {
			    position: absolute;
			    border: 1px solid #7f7f7f;
			    min-width: 260px;
			    min-height: 100px;
			    max-width: 300px;
			    padding: 10px;
			    z-index: 999999;
			    background-color: white;
			}
			.profile-stats div.interactiveTutorialItem div {
				 background-color: white;
			}
			.interactiveTutorialItem img {
			    max-width: 280px;
			}
			.interactiveTutorialItem .arrow,
			.in-game .main .stats .profile-stats div.interactiveTutorialItem .arrow {
			    position: absolute;
			    top: 20px;
			    width: 21px;
			    height: 41px;
			}
			.interactiveTutorialItem .title {
			    font-weight: bold;
			    font-size: 12px;
			    padding-bottom: 8px;
			    color: black;
			}
			.interactiveTutorialItem .content {
			    font-size: 11px;
			    color: #7f7f7f;
			    padding-bottom: 40px;
			}
			.interactiveTutorialItem .tutorialPrev {
			    position: absolute;
			    padding: 10px;
			    bottom: 0px;
			    left: 0px;
			    cursor: pointer;
			}
			.interactiveTutorialItem .tutorialNext {
			    position: absolute;
			    padding: 10px;
			    bottom: 0px;
			    right: 0px;
			    cursor: pointer;
			}
			.interactiveTutorialItem .tutorialExit {
			    position: absolute;
			    padding-top: 5px;
			    padding-right: 10px;
			    top: 0px;
			    right: 0px;
			}
			.interactiveTutorialItem .tutorialPrev:hover,
			.interactiveTutorialItem .tutorialNext:hover {
			    background-color: #efefef;
			}
			.interactiveTutorialItem a {
			   text-decoration: none;
			   font-size: 14px;
			   color: #6666ff !important;
			}
			.interactiveTutorialItem a i {
				color: #666 !important;
			}
			.interactiveTutorialItem .arrow {
			    background-color: rgba(0,0,0,0) !important;
			}
			.leftArrow .arrow {
			    transform: none;
			    left: -21px;
			    background-image: url('/images/v2/tooltip_arrow_left.png');
			}
			.rightArrow .arrow {
			   transform: none;
			   right: -21px;
			   background-image: url('/images/v2/tooltip_arrow_right.png');
			}
			.topArrow .arrow {
			    transform: rotate(90deg);
			    background-image: url('/images/v2/tooltip_arrow_left.png');
			    top: -31px !important;
			    left: 15px;
			}
        </style>
	</head>
	<body>
		<!-- define common page elements here (nav menus, headers, footers, etc.) -->
		<!-- page wrapper -->
        <div class="page-wrapper" style="position: relative;">
        	<div class="tutorialOverlay tutorialBackground"></div>

            <v2:preloginNav audioPlayer="true" speechEnabled="true" fixedHeader="true" />

            <!-- main -->
            <main class="main clearfix">
            	<div class="advertising topBannerAd">
            		<a class="videoTutorialLink" href="javascript:void(0)">Watch the tutorial</a>
            	</div>
            
				<div class="grid-container">
			        <!-- stats -->
			        <div class="stats clearfix pull-right" >
			            <!-- profile-stats -->
			            <div class="profile-stats row phablet-hide" style="position: relative;">
			            	<div class="tutorialOverlay tutorialImage tutorialImageFullres">
			                	<img src="/images/v2/rp_tutorial_stats_fullres.png" />
			                </div>
			                <div class="profile-stats-progress clearfix">
			                    <a href="/u/profile"><img class="currentUserAvatar" src="//placehold.it/200x200" alt="profile-image"></a>
			                    <a href="/u/profile"><p><span class="currentUserName">Guest</span> <br> <span class="currentLevelName">Plankton</span></p></a>
			                    <a href="javascript:void(0)" class="pull-right profile-stats-progress-link exitGame">Exit game</a>
			                    <div class="profile-stats-progress-bar">
			                        <p>Next Unlock: <span class="nextLevel">Sardine</span></p>
			                    <p class="pull-right profile-stats-progress-link">Chips:<span class="currentBalance">$3,000</span></p><br>
			                    <p class="pull-right profile-stats-progress-link">Gold:<span class="currentBitlets">0</span></p>
			                        <br>
			                        <!-- FIXME: draw progress bar for logged-in games
			                        <div>
			                            <span class="progress-bar" style="width: 70%"></span>
			                        </div>
			                         -->
			                    </div>
			                </div>
			                <div class="profile-stats-credits second tablet-hide">
			                	<p>Balance<br /><span class="currentBalance">$3,000</span></p>
			                    <p>Outlay<br /><span class="currentOutlay">$0</span></p>
			                    <p>Game<br /><span class="gameNumber">1 of 3</span></p>
			                    <div class="timer-holder clearfix">
			                        <p class="js-timer js-deal-trigger">Last Bets<span><br><b class="profile-stats-credits-spec"><span class="timerSecs">0</span> </b> sec</span></p>
			                    </div>
			                    <div class="timer-holder helpButton">
				                    <input type="submit" href="javascript:void(0)" class="btn btn-success help" value="Help">
				                </div>
			                </div>
			            </div>
			            <!-- /profile-stats -->
			            
			            <div class="advertising rightColumnAd">
		            		<a class="videoTutorialLink" href="javascript:void(0)">Watch the tutorial</a>
		            	</div>
			
			            <!-- tabs -->
			            <div class="tabs clearfix phablet-hide">
			                <div class="tabs-nav">
			                    <p class="js-tabs-tab nav-tab-active" data-tab-active="1">Leaderboard</p>
			                    <p class="js-tabs-tab" data-tab-active="2">Game Stats</p>
			                    <p class="special"><b>Position:</b> 1 of 1</p>
			                </div>
			                <hr>
			                <div>
			                    <div id="tab-1" class="tabs-tab">
			                        <!-- profiles-table -->
			                        <ul class="profiles-table custom-scroll">
			                        </ul>
			                        <!-- /profiles-table -->
			                    </div>
			                    <div id="tab-2" class="tabs-tab hidden">
			                        <div class="game-stats">
			                            <p class="game-stats-title">Current bets</p>
			                            <div class="game-stats-row-title-holder column-3 clearfix">
			                                <p class="game-stats-row-title">Hand</p>
			                                <p class="game-stats-row-title">Bet</p>
			                                <p class="game-stats-row-title">Return</p>
			                            </div>
			                            <div class="table-holder">
			                                <div class="table-holder-inner custom-scroll">
			                                    <table class="game-stats-table currentGameBets column-3">
			                                    	<!-- FIXME:  display bets here -->
			                                    </table>
			                                </div>
			                            </div>
			                        </div>
			                        <div class="game-stats">
			                            <p class="game-stats-title">Previous Game Results</p>
			                            <div class="game-stats-row-title-holder clearfix column-5">
			                                <p class="game-stats-row-title">Game</p>
			                                <p class="game-stats-row-title">Winning Hand</p>
			                                <p class="game-stats-row-title">Bets</p>
			                                <p class="game-stats-row-title">Return</p>
			                                <p class="game-stats-row-title">Shots</p>
			                            </div>
			                            <div class="table-holder">
			                                <div class="table-holder-inner custom-scroll">
			                                    <table class="game-stats-table previousGameResults column-5">
			                                    	<!-- FIXME:  display stats here -->
			                                    </table>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			            <!-- /tabs -->
			        </div>
			        <!-- /stats -->
			
			        <v2:gameTable balance="$3,000" numGames="3" />
			
			        <!-- game-stats mobile -->
			        <div class="game-stats-holder game-stats-mobile clear">
			            <div class="game-stats">
			                <p class="game-stats-title">Current bets</p>
			                <div class="game-stats-row-title-holder column-3 clearfix">
			                    <p class="game-stats-row-title">Hand</p>
			                    <p class="game-stats-row-title">Bet</p>
			                    <p class="game-stats-row-title">Return</p>
			                </div>
			                <div class="table-holder">
			                    <div class="table-holder-inner custom-scroll">
			                        <table class="game-stats-table currentGameBets column-3">
			                        	<!-- FIXME:  populate withe bets -->
			                        </table>
			                    </div>
			                </div>
			            </div>
			            <div class="game-stats">
			                <p class="game-stats-title">Previouse Game Results</p>
			                <div class="game-stats-row-title-holder clearfix column-5">
			                    <p class="game-stats-row-title">Game</p>
			                    <p class="game-stats-row-title">Winning Hand</p>
			                    <p class="game-stats-row-title">Bets</p>
			                    <p class="game-stats-row-title">Return</p>
			                    <p class="game-stats-row-title">Shots</p>
			                </div>
			                <div class="table-holder">
			                    <div class="table-holder-inner custom-scroll">
			                        <table class="game-stats-table previousGameResults column-5">
			                        	<!-- FIXME:  populate with game/bet stats -->
			                        </table>
			                    </div>
			                </div>
			            </div>
			        </div>
			        <!-- /game-stats mobile -->
					
			    </div>
			    
			    <v2:gamePopups />
			    
			    <div class="advertising bottomBannerAd" style="display: none !important;">
			    	<a class="close" onclick="$('.bottomBannerAd').fadeOut(); return false;" href="#" style="opacity: 0.8; margin-top: 3px; margin-right: 5px;"><i class="fa fa-times-circle"></i></a>
            		<a class="videoTutorialLink" href="javascript:void(0)">Watch the tutorial</a>
            	</div>
            	
            	<div class="itemHolder" style="display: none;">
				    <div class="interactiveTutorialItem leftArrow">
				        <div class="arrow"></div>
				
				        <div class="title">Title</div>
				        <div class="content">
				            &nbsp;
				        </div>
				
				        <div class="tutorialPrev">
				            <a href="javascript:void(0)" class="prevButton">Prev</a>
				        </div>
				        <div class="tutorialNext">
				            <a href="javascript:void(0)" class="nextButton">Next</a>
				        </div>
				        <div class="tutorialExit">
				            <a href="javascript:void(0)" class="exitButton"><i class="fa fa-times-circle overlay-close" aria-hidden="true"></i></a>
				        </div>
				    </div>
				</div>
            </main>
            
			<v2:footerNav />
		
		<!-- page-wrapper -->
		</div>
		
		<!--  <script type="text/javascript" src="/fb_guestmode.js" > </script> -->
		<script>
			var music = false;
			var speech = false;
			if (window.localStorage && localStorage.getItem("rp.music.enabled")) {
		    	music = true;
	        }
			if (window.localStorage && localStorage.getItem("rp.speech.enabled")) {
		    	speech = true;
	        }
			
			if (music) {
				$(".audio-icon").removeClass("active");
			}
			if (speech) {
				$(".volume-icon").removeClass("active");
			}
			
			//XXX:  we should define this *before* we load the gameplay script; this is super important!!!
			window.options = {	loadResponsiveVoice: false, 
				loadFbGuestMode: false,//true, 
				isGuestMode: true,
				audioOn: speech,	//true
				helpOn: speech,	//true
				isSinglePlayer: false,
				playerName: "Guest", 
				username: "guestuser@racingpoker.com",
				tournamentId: "guest_mode",
				socketHost: window.location.host, 
				socketPath: 'game_websocket'
			};
		</script>
		<script src="/Jquery/responsivevoice.js"></script>
		<script src="/Gamesocket.js"></script>
		
		<!-- guest-mode specific gameplay logic -->
		<script>
			//guest-mode specific
			function processScreenname() {
		  		var enteredVal = $(".userScreenname").val().trim();
		  		if (enteredVal.length > 0) {
		  			options.playerName = enteredVal;
		  			options.username = enteredVal + "@racingpoker.com";
		  		}
		  		
		  		$(".currentUserName").html(options.playerName);
		  		$(".currentUserAvatar").attr("src", '//www.gravatar.com/avatar/' + $.md5(options.username) + '.jpg?d=identicon');
		  		
		  		RP.setCurrentPlayerInfo(options.username, options.playerName);
		  		
		  		var tutorial = $(".tutorialOptIn:visible:checked").length > 0;
			    if (tutorial) {
			    	showTutorial();
			    }
			    else {
			    	beginGame();
			    }
		  	    
		  	  	$('.overlay-name').hide();
		  	}
			
			window._gameStarted = false;
			function beginGame() {
				if (! _gameStarted) {
					_gameStarted = true;
					RP.start_game(true);
				}
			}
  	
		  	function get_screenname() {
		  		//display modal dialog for choosing a screen-name 
		  		//FIXME:  try to determing name from Facebook
		  		$('.overlay-name').show();
		  	};
		  	
		  	//tutorial things
		  	window.tutorialSection = 0;			//run
			window.tutorialSubsection = 0;		//step
			
			window.tutorialContent = {
				"0.0": {
			    	"arrow": "left",
			        "container": ".main-table-list-holder",
			        "top": "246px",
			        "left": "300px",
			        "title": "The Cards",
			        "content": "Cards are dealt to all six hands. Only high cards or cards that can be used to create a winning hand are kept. Each hand is matched to a horse by colour. The horses indicate which poker hand is in the lead."
			    },
			    "0.1": {
			    	"arrow": "left",
			        "container": ".main-table-list-holder",
			        "top": "246px",
			        "left": "300px",
			        "title": "Hands that Win",
			        
			        //FIXME:  replace w/ first-party image link
			        "content": "To make the best decision on each hand you must know what a winning hand in poker looks like, you won't become the champ with anything less than these top hands:<br /><br /><img src='https://i.imgur.com/nQIopvv.png' />"
			    },
			    /*"0.2": {
			    	"arrow": "left",
			        "container": ".main-table-list-holder",
			        "top": "246px",
			        "left": "395px",
			        "title": "The Standings",
			        "content": "When the cards are dealt, you will see the standings of each of the six hands available. (This will help you determine what's winning and what could win by the end of the round)."
			    },*/
			    "0.2": {
			    	"arrow": "left",
			        "container": ".main-table-list-holder",
			        "top": "246px",
			        "left": "555px",
			        "title": "The Odds",
			        "content": "Racing Poker is a game designed around risk management and reading odds. The game only uses 1 deck of cards for all of six hands.<br /><br />The Return shows which hand has the best odds of winning  using decimal odds. It also keeps track of how much you've bet on each hand."
			    },
			    /*"0.4": {
			    	"arrow": "left",
			        "container": ".main-table-list-holder",
			        "top": "246px",
			        "left": "555px",
			        "title": "The Return",
			        "content": "This shows which hand has the best odds of winning (shown using decimal odds). It also keeps track of how much you have bet and the return if that hand wins."
			    },
			    "0.5": {
			    	"arrow": "left",
			        "container": ".main-table-list-holder",
			        "top": "246px",
			        "left": "555px",
			        "title": "How It's Calculated",
			        "content": "The odds are determined by which hand at the end of each dealing round has the highest chance of winning. The odds will be determined by the likelihood of that hand to beat the other 5 hands with the cards that are yet to be dealt."
			    },
			    "0.6": {
			    	"arrow": "top",
			        "container": ".main-table-list-holder",
			        "top": "192px",
			        "left": "100px",
			        "title": "The Race is on!",
			        "content": "Each hand is matched to a horse by colour. The horses show which poker hand is in the lead. When the winning hand is determined that horse will reach the finish line and the bets will be paid out."
			    },*/
			    "0.3": {
			    	"arrow": "left",
			        "container": ".main-table-list-holder",
			        "top": "246px",
			        "left": "636px",
			        "title": "Betting",
			        "content": "Click the 'Bet' button on the row of the horse you wish to back.  Choose how much you wish to bet and click CONFIRM, or CLEAR if you want to change the amount."
			    },
			    /*"0.8": {
			    	"arrow": "left",
			        "container": ".main-table-list-holder",
			        "top": "246px",
			        "left": "636px",
			        "title": "Betting",
			        "content": "After clicking the 'BET' button, you'll be asked to choose how much you wish to bet.<br /><br />Click the amount you want to bet. For multiples of a certain bet, click an option multiple times.<br /><br />Once you're happy with the amount you wish to bet, click 'CONFIRM', or 'CLEAR' if you wish to choose another amount."
			    },
			    "0.9": {
			    	"arrow": "right",
			        "container": ".header",
			        "top": "2px",
			        "right": "123px",
			        "title": "The Clock",
			        "content": "The clock will count down from 30 seconds after each deal. You have 30 seconds to view the hands, assess the odds and place your bets. Once the time elapses you will no longer be able to place a bet until the cards are dealt again.<br /><br />Click Next to get started! Your game will start when this tutorial ends!"
			    },
			    "1.0": {
			    	"arrow": "left",
			        "container": ".main-table-list-holder",
			        "top": "246px",
			        "left": "300px",
			        "title": "About the Deck",
			        "content": "Remember there are only 52 cards in each deck, 13 of each suit and 4 of the same face value. Cards will only be used in each hand if they can be used to build a winning hand. Otherwise they will be discarded back into the deck and randomly distributed at the beginning of the next round."
			    },
			    "1.1": {
			    	"arrow": "left",
			        "container": ".main-table-list-holder",
			        "top": "246px",
			        "left": "555px",
			        "title": "Tips",
			        "content": "Always bet on the hand that they you think has the most chance of being the highest possible hand at the end of the game. Hint: this may not always be the hand with the best odds after the first round of dealing. Weigh the risk, evaluate the odds and only go ALL IN when the situation warrants it."
			    },
			    "1.2": {
			    	"arrow": "left",
			        "container": ".main-table-list-holder",
			        "top": "246px",
			        "left": "555px",
			        "title": "Extra Help",
			        "content": "Consider the risk you are taking with your spread of bets. It may not be wise to bet all your chips on the hand with the highest odds, and betting on the same hand as you did at the start is not a good idea if it looks lie it may lose to a better hand. This is a good opportunity to learn that, in poker, your hand may not always be the best one!"
			    },
			    "1.3": {
			    	"arrow": "left",
			        "container": ".main-table-list-holder",
			        "top": "246px",
			        "left": "636px",
			        "title": "Hedging Bets",
			        "content": "After the second deal you have the chance to bet again. This can be a great chance to double down on your first bet or hedge with a new hand you think might be better. Always remember that you have the ability to do nothing, or CHECK, as it's known on a real poker table."
			    },*/
			    "0.4": {
			    	"arrow": "top",
			        "container": ".profile-stats-progress",
			        "top": "90px",
			        "left": "87px",
			        "title": "Bonuses - Shots/Streaks",
			        "content": "You can only win shots by playing tournaments. Shots are awarded to users for a winning streak of two or more rounds of profit, up to a maximum of 10. Shots allow you to gain extra credits, extra gold and extra levels."
			    }/*,
			    "2.1": {
			    	"arrow": "top",
			        "container": ".profile-stats-progress",
			        "top": "90px",
			        "left": "87px",
			        "title": "Bonuses - Shots/Streaks",
			        "content": "You can only win shots by playing tournaments. Shots are awarded to users for a winning streak of two or more games up to a maximum of 10. Shots allow you to gain extra credits, extra gold and extra levels."
			    }*/
			};
			
			window.startTutorial = function() {
				tutorialSection = 0;
			    tutorialSubsection = 0;
			    
			    showTutorial();
			};
			
			window.nextTutorial = function() {
				tutorialSubsection++;
			    var key = tutorialSection + "." + tutorialSubsection;
			    if (! tutorialContent[key]) {
			    	tutorialSubsection = 0;
			        tutorialSection++;
			    }
			    
			    showTutorial();
			};
			
			window.prevTutorial = function() {
				tutorialSubsection--;
			    if (tutorialSubsection < 0) {
			    	tutorialSubsection = 0;
			        tutorialSection--;
			    	if (tutorialSection < 0) {
			        	tutorialSection = 0;
			            tutorialSubsection = 0;
			        }
			        else {
			        	var key = tutorialSection + "." + tutorialSubsection;
			            while (tutorialContent[key]) {
			            	tutorialSubsection++;
			                key = tutorialSection + "." + tutorialSubsection;
			            }
			            tutorialSubsection--;
			        }
			    }
			    
			    showTutorial();
			};
			
			window.endTutorial = function() {
				tutorialSection = "a";
			    tutorialSubsection = "a";
			    
			    showTutorial();
			};
			
			window.showTutorial = function() {
				var key = tutorialSection + "." + tutorialSubsection;
			    
			    var content = tutorialContent[key];
			    if (! content) {
			    	//end of tutorial
			        if (localStorage) {
			        	localStorage.rpTutorial = "true";
			        }
			    	$(".interactiveTutorialItem").hide();
			        $(".tutorialBackground").removeClass("tutorialOverlayVisible");
			        
			        beginGame();
			        
			        return;
			    }
			    
			    $(".interactiveTutorialItem").removeClass("leftArrow");
			    $(".interactiveTutorialItem").removeClass("rightArrow");
			    $(".interactiveTutorialItem").removeClass("topArrow");
			    
			    $(".interactiveTutorialItem").addClass(content.arrow + "Arrow");
			    
			    $(".interactiveTutorialItem .title").html(content.title);
			    $(".interactiveTutorialItem .content").html(content.content);
			    $(content.container).append($(".interactiveTutorialItem"));
			    
			    $(".interactiveTutorialItem").css("left", "auto");
			    $(".interactiveTutorialItem").css("right", "auto");
			    $(".interactiveTutorialItem").css("top", content.top);
			    if (content.left) {
			    	$(".interactiveTutorialItem").css("left", content.left);
			    }
			    else {
			    	$(".interactiveTutorialItem").css("right", content.right);
			    }
			    
			    //$(".interactiveTutorialItem").show();
			    $(".tutorialBackground").addClass("tutorialOverlayVisible");
			    
			    if (tutorialSubsection == 0 && tutorialSection == 0) {
			    	$(".interactiveTutorialItem .tutorialPrev").hide();
			    }
			    else {
			    	$(".interactiveTutorialItem .tutorialPrev").show();
			    }
			};
			
			$(".interactiveTutorialItem .tutorialPrev").click(prevTutorial);
			$(".interactiveTutorialItem .tutorialNext").click(nextTutorial);
			$(".interactiveTutorialItem .exitButton").click(endTutorial);
		  	
		  	$(document).ready(function() {
		  		//ensure elements display correctly
        		$(".hidden").hide();
        		$(".hidden").removeClass("hidden");
		  		
				//start the game
				get_screenname();
				
				//mobile .scrollTo game UI
		  		setTimeout(function() {
					$([document.documentElement, document.body]).animate({
					    scrollTop: $(".profile-stats-credits.tablet-show").eq(0).offset().top - 100
					}, 100);	
				}, 1000);
			});
		  	
		  	document.addEventListener(RP.eventTypes.connectedPlayers, function(evt) {
				var state = evt.detail;
				
				//var leaderboard = $(".profiles-table");
				var leaderboard = $(".profiles-table:visible");
				//leaderboard.html("");		//FIXME:  reuse existing rows if/when present
				
				$(".numPlayers").html(state.players.sorted_connected_players.length);
				
				var joinedPercent = 0;
				var numJoined = state.players.sorted_connected_players.length;
				if (numJoined <= 7) {
					joinedPercent = Math.floor(85 * (numJoined / 7));			//first 7 players get us to 85%
				}
				else {
					joinedPercent = 85 + Math.floor(14 * (numJoined / 100));	//max 99% progress @ 100 players
					if (joinedPercent > 99) {
						joinedPercent = 99;
					}
				}
				if ($(".overlay-loading-v2 .progress").css("width") != "100%" && $(".overlay-loading-v2 .progress").width() != $(".overlay-loading-v2 .loadingBar").width()) {
					$(".overlay-loading-v2 .progress").css("width", joinedPercent + "%");
				}
				
				
				//draw the leaderboard
				for (var j = 0; j < state.players.sorted_connected_players.length; j++) {
					var playerName = state.players.sorted_connected_players[j];
					var playerRank = assignedLevels[playerName] ? assignedLevels[playerName] : randomLevel();
					var playerProfile = "#";							//FIXME:  provide profile links for non-bot players
					var playerAvatar = '//www.gravatar.com/avatar/' + $.md5(playerName + '@racingpoker.com') + '.jpg?d=identicon';
					var playerBalance = parseInt(state.players.sorted_connected_players_points[j]).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					
					if (state.players.sorted_connected_players[j] === state.user.current_player) {
			            playerRank = "Plankton";
			            playerAvatar = '//www.gravatar.com/avatar/' + $.md5(state.options.username) + '.jpg?d=identicon';
			            
						//display the current player's position
						$(".mobile-position,.tabs .special").html("<b>Position:  </b>" + (j + 1) + " of " + state.players.sorted_connected_players.length);
						$(".popup-position").html((j + 1) + " of " + state.players.sorted_connected_players.length);
						$(".rank").html((j + 1));
					}
					
					var existingDiv = leaderboard.find("img[src='" + playerAvatar + "']").parents("li").eq(0);
					if (! existingDiv || existingDiv.length < 1) {
						var playerDiv = $("<li class='clearfix'></li>");
						
						playerDiv.append('<a href="' + playerProfile + '"><img src="' + playerAvatar + '" alt="profile-image"></a>');
						playerDiv.append('<a href="' + playerProfile + '"><p>' + playerName + '<br><span>' + 
										 playerRank + '</span></p></a>');
						playerDiv.append('<p class="pull-right gameButton fastForwardButton" style="display: none;"><button>Skip</button></p>');
						playerDiv.append('<p class="amount pull-right"><span>' + playerBalance + '</span></p>');
						
						if (state.players.sorted_connected_players[j] === state.user.current_player) {
				            playerDiv.addClass("currentPlayer");
				            playerDiv.find(".fastForwardButton button").click(function() {
								RP.fastForward();
								$(".overlay-skip-v2").show();	//XXX:  will disappear automatically when cards deal
							});
						}
						
						existingDiv = playerDiv;
					}
					
					existingDiv.find(".amount span").html(playerBalance);
					
					assignedLevels[playerName] = playerRank;
					leaderboard.append(existingDiv);
				}
			});
		  	
		  	$(".helpButton input").click(function() {
		  		$(".tutorialOverlay").addClass("tutorialOverlayVisible");
		  	});
		  	
		  	$(".tutorialOverlay").click(function() {
		  		$(".tutorialOverlay").removeClass("tutorialOverlayVisible");
		  	});
		  	$(".tutorialBackground").click(endTutorial);
		  	
		  	//interactive tutorial
		  	$(document).ready(function() {
				if (localStorage && localStorage.rpTutorial) {
			    	//tutorial already completed; do not show again by default
			        $(".tutorialOptIn").removeAttr("checked");
			    }
			});
		</script>
		
		<!-- core gameplay logic, shared by all game types -->
		<v2:coreGameplay />
	</body>
</html> 