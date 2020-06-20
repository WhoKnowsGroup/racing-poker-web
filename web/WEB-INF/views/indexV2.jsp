<%@ page isELIgnored="false" %>
<%@ taglib tagdir='/WEB-INF/tags' prefix='rp' %>
<%@ taglib tagdir='/WEB-INF/tags/v2' prefix='v2' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en-us">
    <head>
        <title>Racing Poker | online poker</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="keywords" content="Poker,racing poker,online poker,poker tournaments,players">
        <meta name="application-name" content="Racing Poker">
        <meta name="author" content="Pokerace Team">
        <link rel="icon" href="/images/racingpoker-logo9.png" />
        <link rel="stylesheet" href="/css/bootstrap_min.css" />
        <link rel="stylesheet" href="/templates/PageStyleSheets.css" />
        <link rel="stylesheet" href="/templates/PageLayout.css" />
        <v2:basicHeader />
        <v2:gameplayStyles />
        <v2:commonScripts />
        <style>
        	.btn-big {
        		padding: 15px;
        		font-weight: bold;
        	}
        	.btn.text-left {
        		font-weight: bold;
        	}
        </style>
        <script src="/Jquery/bootstrap_min.js"></script>    
    </head>
    <body>
        <!-- define common page elements here (nav menus, headers, footers, etc.) -->
        <!-- page wrapper -->
        <div class="page-wrapper">
            <v2:preloginNav />
            <!-- main -->
            <main class="main clearfix">
            	<!-- hero -->
                <div class="hero">
                    <div class="grid-container hero-content text-center">
                        <h1>Bet on the best hand of poker against the clock.</h1>
                        <a href="/r/guestModeV2" class="btn btn-orange btn-big">Play Now For Free</a>
                        <a href="javascript:void(0)" onclick="$('.overlay-log-in').show();" class="mobileLogin btn btn-green btn-big" data-toggle="modal" data-target="#login_popup1"> <span class="glyphicon glyphicon-log-in"></span> Log In</a>
                    </div>
                </div>
                <!-- /hero -->

                <!-- login-mobile 
                <div class="popup-form-log-in popup-mode3 mobile-show login-mobile-static">
                    <div class="popup-form-log-in-inner popup-mode3-inner">
                        <a href="#" class="btn btn-facebook pull-left"><span class=fb-logo></span>LOGIN</a>
                        <a href="/r/registrationPage" class="btn btn btn-custom pull-right">Sign Up</a>
                        <form class="contact-form clear clearfix popup-form" action="#">
                            <input type="text" class="name" placeholder="Username">
                            <input type="password" class="pass" placeholder="Password">
                            <input class="btn" type="submit" value="LOGIN">
                        </form>
                        <a href="#" class="forgot-link js-forgot-password">Forgot Password?</a>
                        <a href="#" class="btn btn-orange full">Try Me</a>
                        <p class="disclaimer">By logging in or creating an account you agree to our Terms and Conditions. Racingpoker.com is an adult site intended for players aged 18 or over. We do not offer real money gambling or an opportunity to win real money or prizes. Practice or success does not imply future success at real money gambling. All rights reserved Poker Ace Pty Ltd. Racing Poker® is a registered trademark.</p>
                    </div>
                </div>
                /login-mobile -->

                <!-- main-content -->
                <div class="main-content row mobile-hide">
                    <div class="grid-container">
                        <!-- main-content-info -->
                        <div class="main-content-info col-7">
                            <p class="main-content-info-intro">Racing poker is a revolutionary new game that has the excitement of horse racing fused with poker, live around the world. <br>
                            If you've never played before, or love the high stakes games, racing poker lets you test your skills and play the odds.</p>
                            <div class="main-content-info-steps clearfix">
                                <p class="step-1"><span>1</span>Create your account</p>
                                <p class="step-2"><span>2</span>Join a game</p>
                                <p class="step-3"><span>3</span>Start winning</p>
                            </div>
                            <a href="/r/registrationPage" class="btn btn-green text-left">Create Account Now</a>
                        </div>
                        <!-- /main-content-info -->

                        <!-- main-content-tracking -->
                        <div class="main-content-tracking offset-1 col-4">
                            <p class="main-content-tracking-title">Online Now</p>
                            <div class="main-content-tracking-counter clearfix">
                                <p class="players"><span>${ numUsers }</span> Players</p>
                                <p class="tournaments"><span>${ numTournaments }</span> Tournaments</p>
                            </div>

                            <p class="main-content-tracking-title">Top Players</p>

                            <div class="tabs clearfix">
                                <div class="tabs-nav">
                                    <p class="js-tabs-tab auto-switch nav-tab-active " data-tab-active="1" onmouseup="clearInterval(window.autoTabs);">All Time</p>
                                    <p class="js-tabs-tab auto-switch" data-tab-active="2" onmouseup="clearInterval(window.autoTabs);">Weekly</p>
                                    <p class="js-tabs-tab auto-switch" data-tab-active="3" onmouseup="clearInterval(window.autoTabs);">Daily</p>
                                    <p class="js-tabs-tab auto-switch" data-tab-active="4" onmouseup="clearInterval(window.autoTabs);">Shots</p>
                                </div>
                                <hr>
                                <div>
                                    <div id="tab-1" class="tabs-tab custom-scroll">
                                        <div class="game-stats">
                                            <div class="game-stats-row-title-holder column-3 clearfix">
                                                <p class="game-stats-row-title">Rank</p>
                                                <p class="game-stats-row-title">Name</p>
                                                <p class="game-stats-row-title">Level</p>
                                            </div>
                                            <div class="table-holder">
                                                <div class="table-holder-inner custom-scroll">
                                                    <table class="game-stats-table column-3 allTimeBest">
                                                    	<!-- FIXME:  add table rows -->
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="tab-2" class="tabs-tab custom-scroll hidden">
                                        <div class="game-stats">
                                            <div class="game-stats-row-title-holder column-3 clearfix">
                                                <p class="game-stats-row-title">Rank</p>
                                                <p class="game-stats-row-title">Name</p>
                                                <p class="game-stats-row-title">Level</p>
                                            </div>
                                            <div class="table-holder">
                                                <div class="table-holder-inner custom-scroll">
                                                    <table class="game-stats-table column-3 weeklyBest">
                                                    	<!-- FIXME:  add table rows -->
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="tab-3" class="tabs-tab custom-scroll hidden">
                                        <div class="game-stats">
                                            <div class="game-stats-row-title-holder column-3 clearfix">
                                                <p class="game-stats-row-title">Rank</p>
                                                <p class="game-stats-row-title">Name</p>
                                                <p class="game-stats-row-title">Level</p>
                                            </div>
                                            <div class="table-holder">
                                                <div class="table-holder-inner custom-scroll">
                                                    <table class="game-stats-table column-3 dailyBest">
														<!-- FIXME:  add table rows -->
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="tab-4" class="tabs-tab custom-scroll hidden">
                                        <div class="game-stats">
                                            <div class="game-stats-row-title-holder column-4 clearfix">
                                                <p class="game-stats-row-title">Rank</p>
                                                <p class="game-stats-row-title">Name</p>
                                                <p class="game-stats-row-title">Shot</p>
                                                <p class="game-stats-row-title">No.</p>
                                            </div>
                                            <div class="table-holder">
                                                <div class="table-holder-inner custom-scroll">
                                                    <table class="game-stats-table column-4 shotsTable">
                                                    	<!-- FIXME:  add table rows -->
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /main-content-tracking -->

                    </div>
                </div>
                <!-- /main-content -->

                <!-- media-boxes -->
                <div class="media-boxes mobile-hide">
                    <div class="grid-container row">

                        <div class="media-box col-4">
                            <a href="/r/registrationPage"><img src="/images/v2/home-pic1.jpg" alt="banner-image"></a>
                            <a href="/r/registrationPage"><h5>Free to play</h5></a>
                            <p>Play solo for free and earn rewards. Get free credits when you sign up and 5,000 more when you share to facebook.</p>
                        </div>
                        <div class="media-box col-4">
                            <a href="/r/registrationPage"><img src="/images/v2/home-pic2.jpg" alt="banner-image"></a>
                            <a href="/r/registrationPage"><h5>No downloads, play anywhere</h5></a>
                            <p>Play on all devices, with no downloads needed. Our games are multi-platform, played with the your credits and winnings on any device.</p>
                        </div>
                        <div class="media-box col-4">
                            <a href="/r/registrationPage"><img src="/images/v2/home-pic3.jpg" alt="banner-image"></a>
                            <a href="/r/registrationPage"><h5>Level up and become a master</h5></a>
                            <p>Test your skill and earn big points and rewards against the best players in the competition. Compete against players at all levels in our Tournament buy-ins.</p>
                        </div>
                        <div class="media-box col-4">
                            <a href="/r/registrationPage"><img src="/images/welcome-logo2.jpg" alt="banner-image"></a>
                            <a href="/r/registrationPage"><h5>Track your progress</h5></a>
                            <p>Track your progress to the big games with our daily leaderboards that show your ranking, history and experience.</p>
                        </div>
                        <div class="media-box col-4">
                            <a href="/r/registrationPage"><img src="/images/image-2.png" alt="banner-image"></a>
                            <a href="/r/registrationPage"><h5>In game bonuse features</h5></a>
                            <p>Earn Credits, Gold, XP points and by sharing, entering tournaments and playing pot poker against the rest of the pack.</p>
                        </div>
                        <div class="media-box col-4">
                            <a href="/r/registrationPage"><img src="/images/welcome-logo2.jpg" alt="banner-image"></a>
                            <a href="/r/registrationPage"><h5>Hedge your bets to play the odds</h5></a>
                            <p>Bet on the best hand of poker to win. Learn to play the odds and hedge your bets, to play the best in the competition.</p>
                        </div>

                    </div>
                </div>
                <!-- /media-boxes -->
            </main>
            <v2:footerNav />
            <!-- page-wrapper -->
        </div>
        
        <script>
        	$(document).ready(function() {
        		$("body").addClass("home");
        		$(".custom-scroll").removeClass("hidden");
        		$(".custom-scroll").hide();
        		$(".custom-scroll").eq(0).show();
        		$(".table-holder-inner.custom-scroll").show();
        	});
        </script>
	    <script type="text/javascript" src="/load_top_players.js" > </script>
	    <script src="/age_check.js" > </script>
    </body>
</html>