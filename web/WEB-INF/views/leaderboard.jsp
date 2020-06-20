<!-- this page serves as a template for setting up new pages with the V2 UI styles -->
<%@ page isELIgnored="false" %>
<%@ taglib tagdir='/WEB-INF/tags' prefix='rp' %>
<%@ taglib tagdir='/WEB-INF/tags/v2' prefix='v2' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en-us">
	<head>
		<title>Racing Poker</title>
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
        	pre {
        		white-space: pre-wrap;
        	}
        	.game-stats .table-holder-inner {
        		min-height: 400px !important;
        	}
        </style> 
        <script src="/Jquery/bootstrap_min.js"></script>     
	</head>
	<body>
		<!-- page wrapper -->
        <div class="page-wrapper">
            <v2:preloginNav />

            <!-- main -->
            <main class="main row">
                <div class="main-inner col-10 offset-1">

                <h1 class="title">Leaderboards</h1>

                    <!-- tabs -->
                    <div class="tabs clearfix">
                        <div class="tabs-nav">
	                        <p class="js-tabs-tab auto-switch nav-tab-active " data-tab-active="1" onmouseup="clearInterval(window.autoTabs);">All Time</p>
	                        <p class="js-tabs-tab auto-switch" data-tab-active="2" onmouseup="clearInterval(window.autoTabs);">Weekly</p>
	                        <p class="js-tabs-tab auto-switch" data-tab-active="3" onmouseup="clearInterval(window.autoTabs);">Daily</p>
	                        <p class="js-tabs-tab auto-switch" data-tab-active="4" onmouseup="clearInterval(window.autoTabs);">Shots</p>
	                    </div>
	                    <hr>
	                    <div>
	                        <div id="tab-1" class="tabs-tab tabs-body-tab custom-scroll">
	                            <div class="game-stats">
	                                <div class="game-stats-row-title-holder column-3 clearfix">
	                                    <p class="game-stats-row-title">Rank</p>
	                                    <p class="game-stats-row-title">Name</p>
	                                    <p class="game-stats-row-title">XPs</p>
	                                </div>
	                                <div class="table-holder">
	                                    <div class="table-holder-inner custom-scroll">
	                                        <table class="game-stats-table column-3 allTimeBest">
	                                        </table>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        <div id="tab-2" class="tabs-tab tabs-body-tab custom-scroll hidden">
	                            <div class="game-stats">
	                                <div class="game-stats-row-title-holder column-3 clearfix">
	                                    <p class="game-stats-row-title">Rank</p>
	                                    <p class="game-stats-row-title">Name</p>
	                                    <p class="game-stats-row-title">XPs</p>
	                                </div>
	                                <div class="table-holder">
	                                    <div class="table-holder-inner custom-scroll">
	                                        <table class="game-stats-table column-3 weeklyBest">
	                                        </table>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        <div id="tab-3" class="tabs-tab tabs-body-tab custom-scroll hidden">
	                            <div class="game-stats">
	                                <div class="game-stats-row-title-holder column-3 clearfix">
	                                    <p class="game-stats-row-title">Rank</p>
	                                    <p class="game-stats-row-title">Name</p>
	                                    <p class="game-stats-row-title">XPs</p>
	                                </div>
	                                <div class="table-holder">
	                                    <div class="table-holder-inner custom-scroll">
	                                        <table class="game-stats-table column-3 dailyBest">
	                                        </table>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        <div id="tab-4" class="tabs-tab tabs-body-tab custom-scroll hidden">
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
	                                        </table>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
                    </div>
                    <!-- /tabs -->

                </div>
            </main>
            
			<v2:footerNav />
		
		<!-- page-wrapper -->
		</div>
		
		<script>
			$(document).ready(function() {
				$("body").addClass("legals");
				
				$(".custom-scroll").removeClass("hidden");
        		$(".custom-scroll").hide();
        		$(".custom-scroll").eq(0).show();
        		$(".table-holder-inner.custom-scroll").show();
			});
			
		</script>
		<script type="text/javascript" src="/load_top_players.js" > </script>
	</body>
</html> 