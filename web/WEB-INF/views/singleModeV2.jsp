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
        	.guestMode {
        		display: none !important;
        	}
        	.dealButton {
			    display: inline-block;
			}
			.mobileDealButton {
				display: none;
			}
			.inGameTimer {
        		display: inline-block !important;
        	}
        	.mobileInGameTimer {
        		display: none !important;
        	}
        	.header-profile-options .btn-danger {
        		display: none;
        	}
        	
        	.currentPlayer .fastForwardButton button {
			    right: 120px;
			    top: 34px;
			}
			
			@media (max-width: 991px) {
				.mobileDealButton {
	    			display: inline-block;
				}
				.mobileInGameTimer {
					display: inline-block !important;
					position: absolute !important;
    				top: 33px !important;
    				right: 157px !important;
				}
			}
			
			@media (max-width: 575px) {
				.mobileDealButton {
				    display: inline-block;
				    top: 12px;
				}
				/*.mobileInGameTimer {
					top: 17px !important;
				}*/
				p.inGameTimer.mobileInGameTimer, .mobileDealButton {
				    top: 29px !important;
				}
			}
			
			@media (max-width: 400px) {
				.mobileInGameTimer {
					display: none !important;
				}
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
			        <div class="stats clearfix pull-right">
			            <!-- profile-stats -->
			            <div class="profile-stats row phablet-hide" style="position: relative;">
			            	<div class="tutorialOverlay tutorialImage tutorialImageFullres">
			                	<img src="/images/v2/rp_tutorial_stats_fullres.png" />
			                </div>
			                <div class="profile-stats-progress clearfix currentPlayer">
			                    <a href="/u/profile"><img class="currentUserAvatar" src="//placehold.it/200x200" alt="profile-image"></a>
			                    <a href="/u/profile"><p><span class="currentUserName">${ user.nickname }</span> <br> <span class="currentLevelName">${ user.levelName }</span></p></a>
			                    <p class="pull-right gameButton fastForwardButton" style="display: none;"><button>Skip</button></p>
			                    <a href="javascript:void(0)" class="pull-right profile-stats-progress-link exitGame">Exit game</a>
			                    <div class="profile-stats-progress-bar">
			                        <p>Next Unlock: <span class="nextLevel">${ user.nextLevelName }</span></p>
			                    <p class="pull-right profile-stats-progress-link">Chips:<span class="currentBalance">$${ user.creditsFormatted }</span></p><br>
			                    <p class="pull-right profile-stats-progress-link">Gold:<span class="currentBitlets">${ user.bitletsIntFormatted }</span></p>
			                        <br>
			                        <div>
			                            <span class="progress-bar" style="width: 70%"></span>
			                        </div>
			                    </div>
			                </div>
			                <div class="profile-stats-credits second tablet-hide">
			                	<p>Balance<br /><span class="currentBalance">$${ user.creditsFormatted }</span></p>
			                    <p>Outlay<br /><span class="currentOutlay">$0</span></p>
			                    <p>Game<br /><span class="gameNumber">1 of 20</span></p>
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
			                    <p class="js-tabs-tab nav-tab-active" data-tab-active="1">Game Stats</p>
		                    	<!-- remove 'position' for single player? -->
			                    <p class="special" style="display: none;"><b>Position:</b> 1 of 1</p>
			                </div>
			                <hr>
			                <div>
			                    <div id="tab-1" class="tabs-tab">
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
			
			        <v2:gameTable balance="$${ user.creditsFormatted }" numGames="20" />
			
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
            </main>
            
			<v2:footerNav />
		
		<!-- page-wrapper -->
		</div>
		
		<!--  <script type="text/javascript" src="/fb_guestmode.js" > </script> -->
		<script>
			//XXX:  we should define this *before* we load the gameplay script; this is super important!!!
			window.options = {	loadResponsiveVoice: false, 
				loadFbGuestMode: false,
				isGuestMode: false,
				audioOn: ${ user.speechEnabled },
				helpOn: ${ user.speechEnabled },
				isSinglePlayer: true,
				playerName: "${ user.nickname }", 
				username: "${ user.email }",
				tournamentId: "Solo-games",
				socketHost: window.location.host, 
				socketPath: 'Single_player_websocket'
			};
		</script>
		<script src="/Jquery/responsivevoice.js"></script>
		<script src="/Gamesocket.js"></script>
		
		<!-- single-mode specific gameplay logic -->
		<script>
		  	$(document).ready(function() {
				//XXX:  this call actually happens automatically inside of the gameplay code itself!!!
		  		//start the game
				//RP.start_game();
		  		if ($(".overlay-loading-v2 .progress").css("width") != "100%") {
		  			$(".overlay-loading-v2 .progress").css("width", "50%");
		  		}
		  	
		  		var avatar = '//www.gravatar.com/avatar/' + $.md5(options.username) + '.jpg?d=identicon';
		  		$(".currentUserAvatar").attr("src", avatar);
		  	
		  		var progress = Math.floor(${ user.levelProgress } * 100);
		  		$(".progress-bar").css("width", progress + "%");
		  		
		  		<c:if test="${ user.speechEnabled }">
		  			RP.setAudioEnabled(true);
		  			RP.setHelpState(true);
		  		</c:if>
		  		
		  		//mobile .scrollTo game UI
		  		setTimeout(function() {
					$([document.documentElement, document.body]).animate({
					    scrollTop: $(".profile-stats-credits.tablet-show").eq(0).offset().top - 100
					}, 100);	
				}, 1000);
			});
		  	
		  	$(".dealButton input").click(function() {
		  		if ($(this).hasClass("disabled")) {
		  			return;
		  		}
		  		
		  		RP.forceDeal();
		  		$(this).addClass("disabled");
		  	});
		  	
		  	$(".helpButton input").click(function() {
		  		$(".tutorialOverlay").addClass("tutorialOverlayVisible");
		  	});
		  	
		  	$(".tutorialOverlay").click(function() {
		  		$(".tutorialOverlay").removeClass("tutorialOverlayVisible");
		  	});
		  	
		  	document.addEventListener(RP.eventTypes.startTimer, function(evt) {
		  		$(".dealButton input").removeClass("disabled");
			});

			document.addEventListener(RP.eventTypes.stopTimer, function(evt) {
				$(".dealButton input").addClass("disabled");
			});
			
			$(".currentPlayer .fastForwardButton button").click(function() {
				RP.fastForward();
				$(".overlay-skip-v2").show();	//XXX:  will disappear automatically when cards deal
			});
		</script>
		
		<!-- core gameplay logic, shared by all game types -->
		<v2:coreGameplay />
	</body>
</html>