<%@ page isELIgnored="false" %>
<%@ taglib tagdir='/WEB-INF/tags' prefix='rp' %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"	prefix="decorator"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en-us">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		
		<!-- meta -->
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
        <meta name="viewport" content="initial-scale=1, width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta name="description" content="" />
        <!-- /meta -->
        
        <!-- facebook meta -->
        <meta property="fb:app_id" content="1551537831798758" />
        <meta property="og:type" content="website">
        <meta property="og:url" content="https://racingpoker.com" />
        <meta property="og:site_name" content="Racing Poker" />
        <meta property="og:title" content="A fresh alternative to poker" />
        <meta property="og:image" content="https://racingpoker.com/images/v2/rp-share-image.jpg" />
        <meta property="og:description" content="Racing Poker® is a fresh, fun and exciting alternative to poker.  It is based on 6 hands of cards being dealt and it's up to you to decide which hand is most likely to win. Each game is made up of a series of deals where the odds of each hand change as their likelihood of winning changes as the game progresses.  If you want to have fun and think you have what it takes, jump in and join! It's Free to Play!" />
        <!-- /facebook meta -->

        <!-- twitter meta -->
        <meta name="twitter:card" content="summary_large_image" />
        <meta name="twitter:site" content="" />
        <meta name="twitter:creator" content="" />
        <meta name="twitter:title" content="" />
        <meta name="twitter:description" content="" />
        <meta name="twitter:image" content="" />
        <!-- /twitter meta -->

        <!-- favicons generated with //realfavicongenerator.net/ -->
        <!--  <link rel="apple-touch-icon" sizes="180x180" href="/images/v2/favicons/apple-touch-icon.png" />
        <link rel="icon" type="image/png" href="/images/v2/favicons/favicon-32x32.png" sizes="32x32" />
        <link rel="icon" type="image/png" href="/images/v2/favicons/favicon-16x16.png" sizes="16x16" />
        <link rel="manifest" href="/images/v2/favicons/manifest.json" />
        <link rel="mask-icon" href="/images/v2/favicons/safari-pinned-tab.svg" color="#5bbad5" />
        <meta name="theme-color" content="#ffffff" /> -->
        <!-- /favicons -->

        <!-- style -->
        <link rel="stylesheet" href="/css/v2/style.css" />
        <link rel="stylesheet" href="/css/v2/selectordie.css" />
        <link rel="stylesheet" href="//code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
        <link rel="stylesheet" href="/css/v2/slick.css" type="text/css" />
        <link rel="stylesheet" href="/css/v2/slick-theme.css" type="text/css" />
        
        <!--[if lt IE 9]>
        <script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="//oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->

        <rp:googleAnalytics />
		
		<!-- the next line includes the <head> section from the page being rendered -->
		<decorator:head /> 
	</head>
	
	<body>
		<!-- common-js -->
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script>
            window.jQuery || document.write('<script src="/Jquery/jquery_min/jquery.min.js"><\/script>')
        </script>
        <script src="/js/lib/plugins.js"></script>
        <script src="/js/main.js"></script>
        <script type="text/javascript" src="/js/slick.min.js"></script>
        <script src="//code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <!-- /common-js -->
	
		<!-- define common page elements here (nav menus, headers, footers, etc.) -->
		<!-- page wrapper -->
        <div class="page-wrapper">

            <!-- header -->
            <header class="header clearfix">

                <!-- header-logo -->
                <a href="/r/indexPage" class="header-logo official-logo pull-left"></a>
                <!-- /header-logo -->

                <span class="toggle-nav"></span>

				<!-- 
				FIXME:  post-login only?
                <a href="/u/addChips" class="btn btn-orange mobile-show mobile-add-credits">Add chips</a>
                -->

                <div class="header-content-holder pull-right">
                    <!-- navigation -->
                    <nav class="header-navigation">
                        <ul class="col-6 offset-3">
                            <li>
                                <a href="index.html">Home</a>
                            </li>
                            <li>
                                <a href="landing-v1.html">Landing V1</a>
                            </li>
                            <li>
                                <a href="landing-v2.html">Landing V2</a>
                            </li>
                            <li>
                                <a href="in-game.html">In Game</a>
                            </li>
                        </ul>
                    </nav>
                    <!-- /navigation -->

                    <!-- profile-options -->
                    <!-- 
					FIXME:  post-login only?
                    <div class="header-profile-options">
                        <a href="/u/addChips" class="btn btn-orange">Add chips</a>
                        <p><a href="/u/profile">Kervball</a><button class="search-options"></button></p>
                    </div>
                    -->
                    <!-- /profile-options -->
                </div>

                <div class="player">

                    <div class="player-one player-controls">
                        <audio class="audio" id="audioplayer-one" style="display: none;" controls>

                        <p>Your Browser do not support audio</p>
                        </audio>

                        <span class="volume-icon active"></span>
                        <div class="volume player-one-volume" title="Set volume"></div>
                    </div>

                    <div class="player-two player-controls">
                        <audio class="audio" id="audioplayer-two" style="display: none;" controls>
                            <source src="/music/player-2/Jazz_Lounge.mp3" type="audio/mpeg">
                            <source src="/music/player-2/Luxury.mp3" type="audio/mpeg">
                            <source src="/music/player-2/Night_Casino_4.mp3" type="audio/mpeg">
                            <source src="/music/player-2/Optimistic_and_Carefree.mp3" type="audio/mpeg">
                            <source src="/music/player-2/Rich_and_Luxury.mp3" type="audio/mpeg">
                            <source src="/music/player-2/Richness.mp3" type="audio/mpeg">
                            <p>Your Browser do not support audio</p>
                        </audio>

                        <span class="audio-icon active"></span>
                        <div class="volume player-two-volume" title="Set volume"></div>
                    </div>
                </div>

            </header>
            <!-- /header -->

            <!-- mobile-menu -->
            <nav class="mobile-menu">
                <div class="mobile-menu-content">
                    <div class="mobile-menu-content-header">
                        <span class="official-logo light"></span>
                        <a href="#" class="close-menu pull-right"></a>
                        <div class="player mobile-player">
                            <div class="player-two player-controls">
                                <span class="volume-icon active"></span>
                            </div>

                            <div class="player-one player-controls">
                                <span class="audio-icon active"></span>
                            </div>
                        </div>
                    </div>
                    <div class="mobile-menu-content-body">
                        <ul class="mobile-menu-content-body-nav">
                            <li class="mobile-menu-content-body-nav-item">
                                <a href="#">Quit current game</a>
                            </li>
                            <li class="mobile-menu-content-body-nav-item">
                                <a href="#">Profile</a>
                            </li>
                            <li class="mobile-menu-content-body-nav-item">
                                <a href="#">My balance</a>
                            </li>
                            <li class="mobile-menu-content-body-nav-item">
                                <a href="#">Leaderboards</a>
                            </li>
                            <li class="mobile-menu-content-body-nav-item">
                                <a href="#">Rules</a>
                            </li>
                            <li class="mobile-menu-content-body-nav-item">
                                <a href="#">Support</a>
                            </li>
                            <li class="mobile-menu-content-body-nav-item">
                                <a href="#">Legal policies</a>
                            </li>
                            <li class="mobile-menu-content-body-nav-item">
                                <a href="#">Log out</a>
                            </li>
                        </ul>
                        <div class="mobile-menu-content-body-buttons">
                            <a href="#" class="btn fb-follow"><span></span>Follow us</a>
                            <a href="#" class="btn btn-orange">BUY CREDITS</a>
                        </div>

                        <div class="terms-link">
                            <a href="#">Terms</a>
                            <a href="#">Privacy</a>
                        </div>
                    </div>
                </div>
            </nav>
            <!-- /mobile-menu -->

            <!-- main -->
            <main class="main clearfix">
            	<!-- the next line includes the <body> section from the page being rendered -->
				<decorator:body />
            </main>
            
            <!-- footer -->
            <footer class="footer">
                <div class="grid-container">
                    <!-- footer-content -->
                    <div class="content-holder row">

                        <div class="footer-logo col-2">
                            <a class="official-logo" href="#"></a>
                        </div>

                        <div class="footer-nav col-6">
                            <ul class="footer-nav-list-1 col-4">
                                <li><a href="#">Game Rules</a></li>
                                <li><a href="#">Support</a></li>
                                <li><a href="#">About Us</a></li>
                            </ul>
                            <ul class="footer-nav-list-2 col-4">
                                <li><a href="#">Sign Up</a></li>
                                <li><a href="#">Log In</a></li>
                                <li><a href="legals.html">Terms</a></li>
                                <li><a href="legals.html">Privacy</a></li>
                            </ul>
                            <ul class="footer-nav-list-3 col-4">
                                <li><a href="#">Contact Us</a></li>
                                <li><a href="#">Follow us on Facebook</a></li>
                            </ul>
                        </div>

                        <div class="footer-link col-3 offset-1">
                            <a href="index.html"></a>
                        </div>

                    </div>
                    <!-- /footer-content -->

                    <!-- footer-copyright -->
                    <p class="footer-copyright clearfix">© Copy rights (1999 - 2018) reserved by Pokerace Pty Ltd</p>
                    <!-- /footer-copyright -->
                </div>
            </footer>
            <!-- /footer -->
		
		<!-- page-wrapper -->
		</div>
	</body>
</html> 