<!-- this page serves as a template for setting up new pages with the V2 UI styles -->
<%@ page isELIgnored="false" %>
<%@ taglib tagdir='/WEB-INF/tags' prefix='rp' %>
<%@ taglib tagdir='/WEB-INF/tags/v2' prefix='v2' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en-us">
	<head>
		<title>Racing Poker | Online Poker</title>
        <meta charset='utf-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <meta name='keywords' content='Poker,racing poker,online poker,poker tournaments,players'>
        <meta name='application-name' content='Racing Poker'>
        <meta name='author' content='Pokerace Team'>
        <link rel='icon' href='/images/racingpoker-logo9.png' />
        <link rel='stylesheet' href='/css/bootstrap_min.css' />
        <link rel='stylesheet' href='/templates/PageStyleSheets.css' />
        <link rel='stylesheet' href='/templates/PageLayout.css' />
        <link rel='stylesheet' type='text/css' href='/css/highslide.css' />
        <v2:basicHeader />
        <v2:gameplayStyles />
        <v2:commonScripts /> 

        <!-- Slick Carousel -->
        <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>			
		<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
          
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
        	.row.game-level {
        		padding-left: 40px !important;
        		padding-right: 40px !important;
        	}
        	.slick-next:before {
			    content: url('/images/arrow-next.png') !important;
			}
			.slick-prev:before {
			    content: url('/images/arrow-prev.png') !important;
			}
			.tournament.prize-distribution {
				display: none;
			}
			/*@media (max-width: 650px) {
				.slick-slide {
				   min-height: 150px;
				}
				.slick-slide img {
				   min-height: 150px;
				}
			}*/
        </style>
        <script src='/Jquery/bootstrap_min.js'></script>      
	</head>
	<body>
		<!-- page wrapper -->
        <div class="page-wrapper">
            <v2:preloginNav />

            <!-- main -->
            <main class="main clearfix">
            	<div class="grid-container">
                    <!-- profile-stats -->
                    <div class="profile-stats row">
                        <div class="profile-stats-progress clearfix">
                            <a href="/u/profile"><img src="${ user.avatarUrl }" alt="profile-image"></a>
                            <a href="/u/profile"><p>${ user.nickname } <br> ${ user.levelName }</p></a>
                            <div class="profile-stats-progress-bar pull-right">
                                <p>Next Unlock: <span>${ user.nextLevelName }</span></p>
                                <br>
                                <div>
                                    <span class="progress-bar" style="width: 1%"></span>
                                </div>
                            </div>
                        </div>
                        <div class="profile-stats-credits second">
                            <p>Chips:<span>$${ user.creditsFormatted }</span></p>
                            <!--<p class="bit">Bitlets:<span>20</span></p>-->
                            <p>Gold:<span>${ user.bitletsIntFormatted }</span></p>
                            <!--<p class="bonuses">Bonuses:<span>5000</span></p>-->
                        </div>
                    </div>
                    <!-- /profile-stats -->
                    
                    <a href="/u/home" class="back-link"><  Back to game type</a>

                    <h2 id="levelSelectHeader">Select a Level</h2>

                    <div class="row game-level js-game-level">
                    	<c:forEach var="game" items="${ games }" varStatus="status">
                    		<div class="game-level-info clearfix col-3">
                    			<div class="img-holder">
                    				<c:if test="${ status.count == 1 }">
	                                	<img src="/images/v2/chip1.png" alt="">
	                                </c:if>
	                                <c:if test="${ status.count == 2 }">
	                                	<img src="/images/v2/chip2.png" alt="">
	                                </c:if>
	                                <c:if test="${ status.count ge 3 }">
	                                	<img src="/images/v2/chip3-4.png" alt="">
	                                </c:if>
	                            </div>
	                            <div class="game-level-info-helper">
	                                <div class="game-level-info-triger">
	                                    <h5>${ game.name }</h5>
	                                    <p class="game-level-info-title-info first clearfix"><!--Buy-in: <br> --><span class="pull-left">Required Chips: $${ game.startingCreditsFormatted }</span></p>
	                                    <p class="game-level-info-title-info second">Required Gold: ${ game.bitletsRequired }</p>
	                                </div>
	                                <div class="game-level-info-description js-drop-down">
	                                    <p>Max Players <span>${ game.maxPlayers }</span></p>
	                                    <p>Number of Games <span>${ game.numGames }</span></p>
	                                    <c:set var="eligible" value="true"/>
	                                    <c:if test="${ user.credits lt game.startingCredits || user.bitletsInt lt game.bitletsRequired }">
                                    		<c:set var="eligible" value="false"/>
                                    	</c:if>
                                    	
	                                    <c:if test="${ mode == 'pot' }">
	                                    	<c:if test="${ status.count gt 1 && empty hasPayments }">
	                                    		<c:set var="eligible" value="false"/>
	                                    	</c:if>
	                                    </c:if>
	                                    <c:if test="${ mode != 'pot' }">
	                                    	<c:if test="${ status.count gt 3 && empty hasPayments }">
	                                    		<c:set var="eligible" value="false"/>
	                                    	</c:if>
	                                    </c:if>
	                                    
	                                    <c:if test="${ eligible == 'true' }">
	                                    	<p>Eligibility <span class="eli-check"></span></p>
	                                    </c:if>
	                                    <c:if test="${ eligible != 'true' }">
	                                    	<p>Eligibility <span class="eli-uncheck"></span></p>
	                                    </c:if>
	                                    <table class="prize-distribution ${ mode }">
	                                        <caption>Prize Distribution</caption>
	                                        <tr class="prize-distribution-subtitle">
	                                            <th>Rank</th>
	                                            <th>Chips</th>
	                                            <th>Gold</th>
	                                        </tr>
	                                        <tr>
	                                            <td>1st</td>
	                                            <td>$${ game.firstPlaceCreditsFormatted }</td>
	                                            <td>${ game.firstPlaceBitletsFormatted }</td>
	                                        </tr>
	                                        <tr>
	                                            <td>2nd</td>
	                                            <td>$${ game.secondPlaceCreditsFormatted }</td>
	                                            <td>${ game.secondPlaceBitletsFormatted }</td>
	                                        </tr>
	                                        <tr>
	                                            <td>3rd</td>
	                                            <td>$${ game.thirdPlaceCreditsFormatted }</td>
	                                            <td>${ game.thirdPlaceBitletsFormatted }</td>
	                                        </tr>
	                                    </table>
	                                    
	                                    <c:if test="${ eligible == 'true' }">
	                                    	<button class="btn" onclick="window.location.href='/u/multiMode?tournamentId=' + encodeURIComponent('${ game.name }');">Play now</button>
	                                    </c:if>
	                                    <c:if test="${ eligible != 'true' }">
	                                    	<button class="btn" disabled>Play now</button>
                                    		<button class="btn add-chips" onclick="window.location.href='/u/addChips';">Get Chips and Gold</button>
	                                    </c:if>
	                                </div>
	                            </div>
                    		</div>
                    	</c:forEach>
                    </div>
                </div>
            </main>
            
			<v2:footerNav />
		
		<!-- page-wrapper -->
		</div>
		
		<script>
			$(document).ready(function() {
				$("body").addClass("landing-v2");
				
				$(".row.game-level").slick({
				  dots: false,
				  infinite: false,
				  speed: 300,
				  slidesToShow: 4,
				  slidesToScroll: 1,
				  responsive: [
				    {
				      breakpoint: 1024,
				      settings: {
				        slidesToShow: 3,
				        slidesToScroll: 1
				      }
				    },
				    {
				      breakpoint: 767,
				      settings: {
				        slidesToShow: 1,
				        slidesToScroll: 1
				      }
				    },
				    {
				      breakpoint: 600,
				      settings: {
				        slidesToShow: 1,
				        slidesToScroll: 1
				      }
				    }
				  ]
				});
				
				setTimeout(function() {
					$([document.documentElement, document.body]).animate({
					    scrollTop: $("h2#levelSelectHeader").offset().top
					}, 100);	
				}, 1000);
			});
			
		</script>
	</body>
</html> 