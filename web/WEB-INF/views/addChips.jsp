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
        	
        	@media (max-width: 650px) {
        		.add-chips .main-inner .tabs-nav p {
			    	padding-left: 15px !important;
			    	padding-right: 15px !important;
				}
			}
        	
        	@media (max-width: 610px) {
	        	.chips-table-4-col tr td:nth-child(2),
				.chips-table-4-col tr th:nth-child(2) {
				    display: none !important;
				}
	        	.chips-table-5-col tr td:nth-child(3),
				.chips-table-5-col tr th:nth-child(3) {
				    display: none !important;
				}
				.add-chips .main-inner .tabs-body-tab .chips-table tr td.gold-coin:before {
				    content: none !important;
				}
			}
        </style>
        <script src='/Jquery/bootstrap_min.js'></script>           
	</head>
	<body>
		<!-- page wrapper -->
        <div class="page-wrapper">
            <v2:preloginNav />

            <!-- main -->
            <main class="main clearfix">
            	<div class="main-inner col-10 offset-1">
                <a href="javascript:history.back()" class="back-link">< Back</a>
                    <div class="banner">
                        <img src="/images/v2/banner3.jpg" alt="banner">
                    </div>

                    <!-- tabs -->
                    <div class="tabs clearfix">
                        <div class="tabs-nav">
                        	<c:if test="${ ! empty chipsProducts }">
                            	<p class="js-tabs-tab nav-tab-active" data-tab-active="1">Game Chips</p>
                            </c:if>
                            <c:if test="${ ! empty goldProducts }">
                            	<p class="js-tabs-tab" data-tab-active="2">Game Gold</p>
                            </c:if>
                            <c:if test="${ ! empty comboProducts }">
                            	<p class="js-tabs-tab" data-tab-active="3">Combo Packs</p>
                            </c:if>
                        </div>
                        <hr>
                        <div class="tabs-body">
                        	<c:if test="${ ! empty chipsProducts }">
	                            <div id="tab-1" class="tabs-tab tabs-body-tab">
	                                <table class="chips-table chips-table-4-col">
	                                	<thead>
	                                		<tr>
	                                			<th style="text-align: center;"></th>
	                                			<th style="text-align: center;"></th>
	                                			<th style="text-align: center;">Price (USD)</th>
	                                			<th style="text-align: center;"></th>
	                                		</tr>
	                                	</thead>
	                                	<c:forEach var="prod" items="${ chipsProducts }">
	                                		<c:if test="${ ! empty prod['bestValue'] || ! empty prod['mostPopular'] }">
	                                			<tr class="special">
			                                        <td class="gold-coin">${ prod['purchaseAmount'] }</td>
			                                        <c:if test="${ ! empty prod['bestValue'] }">
			                                        	<td><img src="/images/v2/spec1.png" alt="spec-offer"></td>
			                                        </c:if>
			                                        <c:if test="${ empty prod['bestValue'] }">
			                                        	<td><img src="/images/v2/spec2.png" alt="spec-offer"></td>
			                                        </c:if>
			                                        <td>${ prod['formattedCost'] }</td>
			                                        <td class="text-right"><a href="javascript:void(0)" onclick="$(this).parents('tr').find('.paypalForm').submit();" class="btn btn-green">BUY NOW</a></td>
			                                        <form id="paypal_${ prod['paypalId'] }" class="paypalForm" action="${ prod['purchaseActionUrl'] }" method="post" target="_top" style="display: none;">
														<input type="hidden" name="cmd" value="_s-xclick">
														<input type="hidden" name="hosted_button_id" value="${ prod['paypalId'] }">
														<input type="hidden" name="custom" value="${ user.email }@@${ prod['paypalId'] }" />
														<input type="hidden" name="notify_url" value="${ serverHome }/paypal/verifyIPN" />
														<!--  <input type='hidden' name='rm' value='1'>  -->
														<button type="button" style="background: #444444; display: none !important;"><img src="https://www.paypalobjects.com/en_AU/i/btn/btn_buynowCC_LG.gif"></button>
					                               		<img alt="" border="0" src="https://www.paypalobjects.com/en_AU/i/scr/pixel.gif" width="1" height="1">
						                        	</form>
			                                    </tr>
	                                		</c:if>
	                                		<c:if test="${ empty prod['bestValue'] && empty prod['mostPopular'] }">
	                                			<tr>
			                                        <td class="gold-coin">${ prod['purchaseAmount'] }</td>
		                                        	<td></td>
			                                        <td>${ prod['formattedCost'] }</td>
			                                        <td class="text-right"><a href="javascript:void(0)" onclick="$(this).parents('tr').find('.paypalForm').submit();" class="btn btn-green">BUY NOW</a></td>
			                                        <form id="paypal_${ prod['paypalId'] }" class="paypalForm" action="${ prod['purchaseActionUrl'] }" method="post" target="_top" style="display: none;">
														<input type="hidden" name="cmd" value="_s-xclick">
														<input type="hidden" name="hosted_button_id" value="${ prod['paypalId'] }">
														<input type="hidden" name="notify_url" value="${ serverHome }/paypal/verifyIPN" />
														<input type="hidden" name="custom" value="${ user.email }@@${ prod['paypalId'] }" />
														<!--  <input type='hidden' name='rm' value='1'>  -->
														<button type="button" style="background: #444444; display: none !important;"><img src="https://www.paypalobjects.com/en_AU/i/btn/btn_buynowCC_LG.gif"></button>
					                               		<img alt="" border="0" src="https://www.paypalobjects.com/en_AU/i/scr/pixel.gif" width="1" height="1">
						                        	</form>
			                                    </tr>
	                                		</c:if>
	                                	</c:forEach>
	                                </table>
	                            </div>
                            </c:if>
                            <c:if test="${ ! empty goldProducts }">
	                            <div id="tab-2" class="tabs-tab tabs-body-tab hidden">
	                                <table class="chips-table chips-table-4-col">
	                                	<thead>
	                                		<tr>
	                                			<th style="text-align: center;"></th>
	                                			<th style="text-align: center;"></th>
	                                			<th style="text-align: center;">Price (USD)</th>
	                                			<th style="text-align: center;"></th>
	                                		</tr>
	                                	</thead>
	                                    <c:forEach var="prod" items="${ goldProducts }">
	                                		<c:if test="${ ! empty prod['bestValue'] || ! empty prod['mostPopular'] }">
	                                			<tr class="special">
			                                        <td class="gold-coin">${ prod['purchaseAmount'] }</td>
			                                        <c:if test="${ ! empty prod['bestValue'] }">
			                                        	<td><img src="/images/v2/spec1.png" alt="spec-offer"></td>
			                                        </c:if>
			                                        <c:if test="${ empty prod['bestValue'] }">
			                                        	<td><img src="/images/v2/spec2.png" alt="spec-offer"></td>
			                                        </c:if>
			                                        <td>${ prod['formattedCost'] }</td>
			                                        <td class="text-right"><a href="javascript:void(0)" onclick="$(this).parents('tr').find('.paypalForm').submit();" class="btn btn-green">BUY NOW</a></td>
			                                        <form id="paypal_${ prod['paypalId'] }" class="paypalForm" action="${ prod['purchaseActionUrl'] }" method="post" target="_top" style="display: none;">
														<input type="hidden" name="cmd" value="_s-xclick">
														<input type="hidden" name="hosted_button_id" value="${ prod['paypalId'] }">
														<input type="hidden" name="notify_url" value="${ serverHome }/paypal/verifyIPN" />
														<input type="hidden" name="custom" value="${ user.email }@@${ prod['paypalId'] }" />
														<!--  <input type='hidden' name='rm' value='1'>  -->
														<button type="button" style="background: #444444; display: none !important;"><img src="https://www.paypalobjects.com/en_AU/i/btn/btn_buynowCC_LG.gif"></button>
					                               		<img alt="" border="0" src="https://www.paypalobjects.com/en_AU/i/scr/pixel.gif" width="1" height="1">
						                        	</form>
			                                    </tr>
	                                		</c:if>
	                                		<c:if test="${ empty prod['bestValue'] && empty prod['mostPopular'] }">
	                                			<tr>
			                                        <td class="gold-coin">${ prod['purchaseAmount'] }</td>
		                                        	<td></td>
			                                        <td>${ prod['formattedCost'] }</td>
			                                        <td class="text-right"><a href="javascript:void(0)" onclick="$(this).parents('tr').find('.paypalForm').submit();" class="btn btn-green">BUY NOW</a></td>
			                                        <form id="paypal_${ prod['paypalId'] }" class="paypalForm" action="${ prod['purchaseActionUrl'] }" method="post" target="_top" style="display: none;">
														<input type="hidden" name="cmd" value="_s-xclick">
														<input type="hidden" name="hosted_button_id" value="${ prod['paypalId'] }">
														<input type="hidden" name="notify_url" value="${ serverHome }/paypal/verifyIPN" />
														<input type="hidden" name="custom" value="${ user.email }@@${ prod['paypalId'] }" />
														<!--  <input type='hidden' name='rm' value='1'>  -->
														<button type="button" style="background: #444444; display: none !important;"><img src="https://www.paypalobjects.com/en_AU/i/btn/btn_buynowCC_LG.gif"></button>
					                               		<img alt="" border="0" src="https://www.paypalobjects.com/en_AU/i/scr/pixel.gif" width="1" height="1">
						                        	</form>
			                                    </tr>
	                                		</c:if>
	                                	</c:forEach>
	                                </table>
	                            </div>
                            </c:if>
                            <c:if test="${ ! empty comboProducts }">
                            	<div id="tab-3" class="tabs-tab tabs-body-tab hidden">
	                                <table class="chips-table chips-table-5-col">
	                                	<thead>
	                                		<tr>
	                                			<th style="text-align: center;">Chips</th>
	                                			<th style="text-align: center;">Gold</th>
	                                			<th style="text-align: center;"></th>
	                                			<th style="text-align: center;">Price (USD)</th>
	                                			<th style="text-align: center;"></th>
	                                		</tr>
	                                	</thead>
	                                    <c:forEach var="prod" items="${ comboProducts }">
	                                		<c:if test="${ ! empty prod['bestValue'] || ! empty prod['mostPopular'] }">
	                                			<tr class="special">
			                                        <td class="gold-coin">${ prod['purchaseAmountChips'] }</td>
			                                        <td class="gold-coin">${ prod['purchaseAmountGold'] }</td>
			                                        <c:if test="${ ! empty prod['bestValue'] }">
			                                        	<td><img src="/images/v2/spec1.png" alt="spec-offer"></td>
			                                        </c:if>
			                                        <c:if test="${ empty prod['bestValue'] }">
			                                        	<td><img src="/images/v2/spec2.png" alt="spec-offer"></td>
			                                        </c:if>
			                                        <td>${ prod['formattedCost'] }</td>
			                                        <td class="text-right"><a href="javascript:void(0)" onclick="$(this).parents('tr').find('.paypalForm').submit();" class="btn btn-green">BUY NOW</a></td>
			                                        <form id="paypal_${ prod['paypalId'] }" class="paypalForm" action="${ prod['purchaseActionUrl'] }" method="post" target="_top" style="display: none;">
														<input type="hidden" name="cmd" value="_s-xclick">
														<input type="hidden" name="hosted_button_id" value="${ prod['paypalId'] }">
														<input type="hidden" name="notify_url" value="${ serverHome }/paypal/verifyIPN" />
														<input type="hidden" name="custom" value="${ user.email }@@${ prod['paypalId'] }" />
														<!--  <input type='hidden' name='rm' value='1'>  -->
														<button type="button" style="background: #444444; display: none !important;"><img src="https://www.paypalobjects.com/en_AU/i/btn/btn_buynowCC_LG.gif"></button>
					                               		<img alt="" border="0" src="https://www.paypalobjects.com/en_AU/i/scr/pixel.gif" width="1" height="1">
						                        	</form>
			                                    </tr>
	                                		</c:if>
	                                		<c:if test="${ empty prod['bestValue'] && empty prod['mostPopular'] }">
	                                			<tr>
			                                        <td class="gold-coin">${ prod['purchaseAmountChips'] }</td>
			                                        <td class="gold-coin">${ prod['purchaseAmountGold'] }</td>
		                                        	<td></td>
			                                        <td>${ prod['formattedCost'] }</td>
			                                        <td class="text-right"><a href="javascript:void(0)" onclick="$(this).parents('tr').find('.paypalForm').submit();" class="btn btn-green">BUY NOW</a></td>
			                                        <form id="paypal_${ prod['paypalId'] }" class="paypalForm" action="${ prod['purchaseActionUrl'] }" method="post" target="_top" style="display: none;">
														<input type="hidden" name="cmd" value="_s-xclick">
														<input type="hidden" name="hosted_button_id" value="${ prod['paypalId'] }">
														<input type="hidden" name="notify_url" value="${ serverHome }/paypal/verifyIPN" />
														<input type="hidden" name="custom" value="${ user.email }@@${ prod['paypalId'] }" />
														<!--  <input type='hidden' name='rm' value='1'>  -->
														<button type="button" style="background: #444444; display: none !important;"><img src="https://www.paypalobjects.com/en_AU/i/btn/btn_buynowCC_LG.gif"></button>
					                               		<img alt="" border="0" src="https://www.paypalobjects.com/en_AU/i/scr/pixel.gif" width="1" height="1">
						                        	</form>
			                                    </tr>
	                                		</c:if>
	                                	</c:forEach>
	                                </table>
	                            </div>
                            </c:if>
                        </div>
                    </div>
                    <!-- /tabs -->

                    <!-- share-text -->
                    <div class="share-text">
                        <p>Share on Facebook to earn <span>5,000 Chips</span></p>
                        <c:if test="${ user.secondsUntilNextShare le 0 }">
	                        <div class="button-helper">
	                            <a href="#" class="btn btn-fb"><span class="fb-logo"></span>Share on Facebook
	                            </a>
	                            <p class="share-popup active" style="display: none;"><span class="secondsCountdown">23:59:59s</span> before you can share again</p>
	                        </div>
                        </c:if>
                        <c:if test="${ user.secondsUntilNextShare gt 0 }">
	                        <div class="button-helper">
	                            <a href="#" class="btn btn-fb disabled"><span class="fb-logo"></span>Share on Facebook
	                            </a>
	                            <p class="share-popup active"><span class="secondsCountdown">23:59:59s</span> before you can share again</p>
	                        </div>
                        </c:if>
                    </div>
                    <!-- /share-text -->

                    <!-- bottom-info -->
                    <div class="bottom-info">
                        <img src="/images/v2/paypal.png" alt="paypal-image">
                        <p>All Purchases subject to Racing Poker <a href="/r/legals">Terms of Service</a></p>
                    </div>
                    <!-- /bottom-info -->
                </div>
            </main>
            
			<v2:footerNav />
		
		<!-- page-wrapper -->
		</div>
		
		<script>
			window.pad = function(text) {
				text = text + "";
				if (text.length < 2) {
					return "0" + text;
				}
				return text;
			}
			
			window.shareCountdown = function(seconds) {
				$("p.share-popup").show();
				$(".share-text .btn-fb").addClass("disabled");
				
				//countdown until the user can share again
				var target = new Date().getTime() + (seconds * 1000);
				window.shareInterval = setInterval(function(){
					var secondsRemaining = Math.floor((target - new Date().getTime()) / 1000);
					if (secondsRemaining < 0) {
						$("p.share-popup").hide();
						$(".share-text .btn-fb").removeClass("disabled");
						
						clearInterval(window.shareInterval);
						return;
					}
					
					//23:59:59s
					var hours = Math.floor(secondsRemaining / 60 / 60);
					secondsRemaining = secondsRemaining - (hours * 60 * 60); 
					
					var minutes = Math.floor(secondsRemaining / 60);
					secondsRemaining = secondsRemaining - (minutes * 60);
					
					var text = "";
					if (hours == 0 && minutes == 0) {
						text = secondsRemaining + "s"
					}
					else if (hours == 0) {
						text = minutes + ":" + pad(secondsRemaining) + "s";
					}
					else {
						text = hours + ":" + pad(minutes) + ":" + pad(secondsRemaining) + "s";
					}
					
					$(".secondsCountdown").html(text);
					
				}, 100);
			};
		
			$(document).ready(function() {
				$("body").addClass("add-chips");
				
				$(".hidden").hide();
				$(".hidden").removeClass("hidden");
				
				$(".share-text .btn-fb").click(function() {
					if ($(this).hasClass("disabled")) {
						return;
					}
					var url = window.location.href.split(/\/[ur]\//gi)[0];
	                var message = "Try your skill to top the Leader Board in this new poker game.";
	                var heading = "10,000 Tournament Credit Joining Bonus";
	                fb_share(url,message,heading);
				});
				
				var seconds = ${ user.secondsUntilNextShare };
				if (seconds > 0) {
					shareCountdown(seconds);
				}
			});
		</script>
	</body>
</html> 