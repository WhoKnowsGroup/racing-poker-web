<%@ taglib tagdir="/WEB-INF/tags" prefix="rp" %>
<%@ taglib tagdir="/WEB-INF/tags/v2" prefix="v2" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- popup-bet v-1 -->
<div class="overlay overlay-bet">
    <div class="popup-bet popup-mode2">
        <div class="popup-bet-head popup-mode2-head clearfix">
            <p class="popup-mode2-head-title">QUICK BET</p>
            <p class="popup-mode2-head-info">Balance: <dfn class="currentBalance">$3,000</dfn></p>
            <p class="inGameTimer">
			    <span>
			        <b class="profile-stats-credits-spec">
			            <span class="timerSecs">0</span> 
			        </b> sec
			    </span>
			</p>
            <p class="popup-bet-head-extra">Last bet: <span class="lastBetAmount">$0</span></p>
        </div>
        <div class="popup-bet-content popup-mode2-content">
            <div class="card-holder">
                <div class="cards clearfix betCards">
             		<!-- current hand -->
                </div>
                <p><span class="betType"><!--  1: Pair--></span> <br><span class="betOdds"><!--  $5.00--></span></p>
            </div>

            <p><b>Select & add an amount to bet:</b></p>
            <form action="javascript:void(0)" class="bet-form" onsubmit="return false;">
                <div class="bet-amounts">
                    <label  class="bet-amounts-chip"><input type="checkbox" value="5">5</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="10">10</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="50">50</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="100">100</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="250">250</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="500">500</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="750">750</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="1000">1000</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="5000">5000</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="10000">10000</label>
                </div>

                <p class="total"><b>Total bet:</b> <span class="betTotal"><!-- $100,000 --></span></p>
                <p class="total"><b>Expected return</b> <span class="betReturn"><!-- $200,000 --></span></p>

                <div class="buttons">
                    <input type="submit" href="javascript:void(0)" class="btn btn-transparent clearBet" value="CLEAR">
                    <input type="submit" href="javascript:void(0)" class="btn btn-suscess placeBet" value="CONFIRM">
                </div>
            </form>
        </div>
        <span class="close-button closeBets cancelButton">Cancel</span>
    </div>
</div>
<!-- /popup-bet v-1-->

<!-- popup-bet v-2 -->
<div class="overlay overlay-bet-2">
    <div class="popup-bet-2 popup-mode2">
        <div class="popup-bet-2-head popup-mode2-head clearfix">
            <p class="popup-mode2-head-title">QUICK BET</p>
            <p class="popup-mode2-head-info">Balance: <dfn class="currentBalance">$3000</dfn></p>
            <p class="inGameTimer">
			    <span>
			        <b class="profile-stats-credits-spec">
			            <span class="timerSecs">0</span> 
			        </b> sec
			    </span>
			</p>
            <p class="popup-bet-2-head-extra">Last bet: <span class="lastBetAmount">$0</span></p>
        </div>
        <div class="popup-bet-2-content popup-mode2-content">
            <div class="card-holder">
                <div class="cards clearfix betCards">
                    <!-- current hand -->
                </div>
                <p><span class="betType"><!-- 1: Pair --></span> <br><span class="betOdds"><!-- $5.00 --></span></p>
            </div>

            <p><b>Select & add an amount to bet:</b></p>
            <form action="javascript:void(0)" class="bet-form" onsubmit="return false;">
                <div class="bet-amounts">
                    <label  class="bet-amounts-chip"><input type="checkbox" value="5">5</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="10">10</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="50">50</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="100">100</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="250">250</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="500">500</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="750">750</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="1000">1000</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="5000">5000</label>
                    <label  class="bet-amounts-chip"><input type="checkbox" value="10000">10000</label>
                </div>

                <p class="total"><b>Total bet:</b> <span class="betTotal"><!-- $100,000 --></span></p>
                <p class="total"><b>Expected return</b> <span class="betReturn"><!-- $200,000 --></span></p>

                <div class="buttons">
                    <input type="submit" href="javascript:void(0)" class="btn btn-transparent clearBet" value="CLEAR">
                    <input type="submit" href="javascript:void(0)" class="btn btn-suscess placeBet" value="CONFIRM">
                </div>
            </form>
        </div>
        <span class="close-button closeBets cancelButton">Cancel</span>
    </div>
</div>
<!-- /popup-bet v-2-->

<!-- popup-winner -->
<div class="overlay overlay-winner">
    <div class="popup-winner popup-mode2">
        <div class="popup-winner-head popup-mode2-head clearfix">
            <p class="popup-mode2-head-title">WINNER</p>
            <p class="popup-mode2-head-info">You've won $<span class="winAmount">5,000</span></p>
        </div>
        <div class="popup-winner-content popup-mode2-content">
            <p class="popup-winner-content-title text-center"><b>Winning hand</b></p>
            <p class="popup-winner-content-subtitle text-center winningHandType">Straight</p>
            <div class="card-holder text-center">
                <div class="cards clearfix winningCards">
                </div>
            </div>
            <div class="popup-winner-content-info">
                <p class="popup-winner-content-info-first special"><b>Paying: <span class="lastOdds">$5.00</span></b></p>
                <p class="popup-winner-content-info-second special"><!--  <b>Bonuses:</b>-->&nbsp;</p>
                <p class="popup-winner-content-info-first"><b>Bet:</b> <span class="lastBet">$1,000</span></p>
                <p class="popup-winner-content-info-second"><!--<b>Gold:</b> $105,000-->&nbsp;</p>
                <p class="popup-winner-content-info-first"><b>Return:</b> <span class="lastReturn">$5,000</span></p>
                <p class="popup-winner-content-info-second"><!--<b>Shot:</b> $105,000-->&nbsp;</p>
                <p class="popup-winner-content-info-first"><b>Balance:</b> <span class="currentBalance">$100,000</span></p>
            </div>
            <p class="multiplayerRank"><b>Current position: <span class="rank">2</span> of <span class="numPlayers">7</span></b></p>
            <div class="buttons">
                <span class="btn btn-transparent close-button cancelButton">Close</span>
            </div>
        </div>
    </div>
</div>
<!-- /popup-winner-->

<!-- popup-purchase -->
<div class="overlay overlay-purchase">
    <div class="popup-purchase popup-mode2">
        <div class="popup-purchase-head popup-mode2-head clearfix">
            <p class="popup-mode2-head-title">Purchase credits</p>
            <p class="popup-mode2-head-info">Current balance $115,000</p>
        </div>
        <div class="popup-purchase-content popup-mode2-content">
            <div class="button-helper">
                <a href="javascript:void(0)" class="btn btn-fb">
                    <span class="fb-logo"></span>Like racing poker <span class="pull-right">1,000 Credits</span>
                </a>
                <a href="javascript:void(0)" class="btn btn-fb disabled">
                    <span class="fb-logo"></span>Like racing poker <span class="pull-right">1,000 Credits</span>
                </a>
                <p class="popup-fb-info active"><span>23:59:59s</span> before you can like again</p>
            </div>
            <div class="button-helper">
                <a href="javascript:void(0)" class="btn btn-fb">
                    <span class="fb-logo"></span>Share racing poker<span class="pull-right">5,000 Credist</span>
                </a>
                <a href="javascript:void(0)" class="btn btn-fb disabled">
                    <span class="fb-logo"></span>Share racing poker<span class="pull-right">5,000 Credist</span>
                </a>
                <p class="popup-fb-info active"><span>23:59:59s</span> before you can share again</p>
            </div>
            <a href="/u/addChips" class="btn btn-orange">BUY CREDITS</a>
            <span class="close-button cancelButton">Cancel</span>

            <div class="terms-link">
                <a href="javascript:void(0)">Terms</a>
                <a href="javascript:void(0)">Privacy</a>
            </div>
        </div>
    </div>
</div>
<!-- /popup-purchase-->

<!-- popup-bonus -->
<div class="overlay overlay-bonus">
    <div class="popup-bonus popup-mode1">
        <p class="popup-mode1-title">Bonus</p>
        <div class="popup-mode1-content">
            <p>Join now and receive a 10,000 Chip welcome bonus - straight up</p>
        </div>
        <a href="/r/registrationPage" class="btn btn-green inlineButton">Register</a>
        <a href="javascript:void(0)" class="btn btn-orange cancelButton inlineButton">Cancel</a>
    </div>
</div>
<!-- /popup-bonus -->

<!-- popup-name -->
<div class="overlay overlay-name">
    <div class="popup-name popup-mode1">
        <p class="popup-mode1-title">Choose a Screenname</p>
        <div class="popup-mode1-content">
            <p>Please enter a screenname:</p>
            <input type="text" value="Guest" placeholder="guest" class="userScreenname" />
            <br>
            <br>
			<div class="interactiveTutorial">
				<input class="tutorialOptIn" type="checkbox" checked="true"> View Instructions
			</div>
        </div>
        <a href="javascript:void(0)" onclick="processScreenname();" class="btn btn-green">Submit</a>
    </div>
</div>
<!-- /popup-name -->

<!-- popup-bonus-img -->
<div class="overlay overlay-bonus-img">
    <div class="popup-bonus-img popup-mode1">
        <p class="popup-mode1-title">Bonus</p>
        <div class="popup-mode1-content">
            <img src="/images/v2/bonus-img.jpg" alt="bonus">
            <p class="popup-bonus-img-inner-title">Congratulations!!</p>
            <div class="popup-bonus-img-info">
                <p>Bonus Type: <span class="bonusType">2shot</span></p>
                <p>Bonus Amount: <span class="bonusCredits">80</span></p>
                <p>Gold Won: <span class="bonusGold">0</span></p>
                <p>Player level won: <span class="bonusLevel">0</span></p>
            </div>
            <p class="popup-bonus-img-bottom-text">Profit Again for a higher level bonus!</p>
            <span class="btn btn-blue close-button cancelButton">Close</span>
        </div>
    </div>
</div>
<!-- /popup-bonus-img -->

<!-- popup-achievements -->
<div class="overlay overlay-achievements">
    <div class="popup-achievements popup-mode1">
        <p class="popup-mode1-title">Achievements</p>
        <div class="popup-mode1-content">
            <p style="text-align: left;">Congratulations!!! You just made the highest profit from all the bets you've placed in all the tournaments you've played!</p>
            <p>Now your highest profit is <br> <span class="number achievementProfit">1,015</span></p>
        </div>
        <span class="btn btn-blue close-button cancelButton">Close</span>
    </div>
</div>
<!-- /popup-achievements -->

<!-- popup-results -->
<div class="overlay overlay-results">
    <div class="popup-results popup-mode1">
        <p class="popup-mode1-title">Results</p>
        <div class="popup-mode1-content popup-results-content">
            <div class="popup-results-content-info">
                <p class="first">Your Rank:</p><p class="rank">1</p>
                <p class="first">Current Chips:</p><p class="currentBalance">3885</p>
                <p class="first resultsXp">Player XPs:</p><p class="second resultsXp"><span class="playerLevel">1</span> + <span class="levelGained">0</span></p>
            </div>
            <div class="share-fb">
                <p>Please Share your Win!</p>
                <a href="javascript:void(0)" class="btn btn-facebook"><span></span>Share on Facebook</a>
            </div>

            <div class="register guestMode">
                <p>If you like playing real tournaments, please Sign Up here</p>
                <a href="/r/registrationPage">Click Here to Sign Up</a>
            </div>

        </div>
        <span class="btn btn-blue close-button cancelButton closeResults">Close</span>
    </div>
</div>
<!-- /popup-results -->

<!-- V2 POPUPS -->
<style>
	.overlay-v2 .popup-mode2,
	.overlay-v2 .popup-mode2-head,
	.overlay-v2 .popup-mode2-content {
	    background-color: black;
	    width: 450px;
	    text-align: center;
	}
	.overlay-v2 .popup-mode2-head {
	    padding: 0;
	}
	.overlay-v2 .btn.close-button {
	    color: white !important;
	    border: none !important;
	    background-color: #5cb85c !important;
	    padding-top: 5px;
	    padding-bottom: 5px;
	}
	.overlay-v2 .btn.registerButton {
		background-color: #f26522 !important;
		border: none !important;
	    padding-top: 5px;
	    padding-bottom: 5px;
	}
	.overlay-v2 .wideButton {
		width: 230px !important;
	}
	.overlay-v2 .btn.blueButton {
		background-color: #005789 !important;
    	margin-bottom: 30px;
	}
	.overlay-v2 .bonus-text {
	  font-size: 16px;
	  font-weight: normal;
	  font-style: normal;
	  font-stretch: normal;
	  letter-spacing: normal;
	  color: #ffffff;
	}
	.overlay-v2 .bonus-text-small {
		font-size: 13px;
	}
	.overlay-v2 .popup-mode2 p {
	    display: block;
	    text-align: center;
	}
	.overlay-v2 .popup-label {
	    color: white;
	    margin-right: 3px;
	    min-width: 140px;
	    display: inline-block;
	}
	.overlay-v2 .popup-value {
	    color: #e7a741;
	}
	.overlay-v2 .popup-mode2 .winningHandType,
	.popup-bonus-v2 .winningHandType {
	    color: white;
	    font-size: 16px;
	}
	.overlay-v2 .popup-mode2 .popup-winner-content-info,
	.popup-bonus-v2 .popup-winner-content-info {
	    margin-top: 25px;
	}
	.overlay-v2 .popup-mode2 .section-summary,
	.popup-bonus-v2 .section-summary {
	    margin-bottom: 12px;
	}
	.overlay-v2 .popup-mode2 .bonus-footer,
	.popup-bonus-v2 .bonus-footer {
	    margin-top: 25px;
	}
	.overlay-v2 .btn.shareButton {
		background-color: #3b5998;
	    padding-top: 5px;
	    padding-bottom: 5px;
	    background-image: url(/images/v2/fb-logo.png);
	    background-repeat: no-repeat;
	    background-position-x: 5px;
	    background-position-y: 4px;
	    position: relative;
	    top: -10px;
	}
	.overlay-v2 .popup-mode2 {
	    max-width: 80%;
	    overflow: hidden;
	}
	.overlay-v2 .popup-mode2 > div {
	    max-width: 100%;
	}
	.overlay-v2 img.spin {
		max-width: 124px;
	}
	.overlay-v2 .centerImage {
		padding-top: 60px;
		padding-bottom: 20px;
	}
	.overlay-v2 .loadingBar {
	    width: 80%;
    	border-radius: 12px;
   		border: 1px solid white;
    	margin-left: auto;
   		margin-right: auto;
    	height: 20px;
    	margin-top: 20px;
    	margin-bottom: 30px;
    	text-align: left;
    }
    .overlay-v2 .progress {
  		display: inline-block;
    	height: 100%;
    	width: 0%;		/*adjust to fill progress - $(".progress").css("width", "30%");*/
    	background-color: white;
    }
    .overlay-v2 .popup-trans, 
    .overlay-v2 .popup-trans > div {
    	background-color: rgba(0,0,0,0);
    }
</style>


<!-- popup-loading-v2; displayed when the game is loading players at the start of a match -->
<div class="overlay overlay-loading-v2 overlay-v2">
    <div class="popup-loading-v2 popup-mode2 popup-trans">
        <div class="popup-loading-v2-head popup-mode2-head clearfix" style="position: relative;">
        	<div class="centerImage">
            	<img class="spin" src="/images/v2/popup/chip.gif" />
            </div>
        </div>
        <div class="popup-mode2-content">
            <div class="loadingBar">
            	<span class="progress"></span>
            </div>
        </div>
    </div>
</div>
<!-- /popup-loading-v2-->
<!-- popup-skip-v2; displayed when the user skips to the end of a hand -->
<div class="overlay overlay-skip-v2 overlay-v2">
    <div class="popup-skip-v2 popup-mode2 popup-trans">
        <div class="popup-skip-v2-head popup-mode2-head clearfix" style="position: relative;">
        	<div class="centerImage">
            	<img src="/images/v2/popup/racing-poker-shuffle.gif" />
            </div>
        </div>
    </div>
</div>
<!-- /popup-skip-v2-->
<!-- popup-bonus-v2; displayed when the user ends the round with a bonus (shot), in place of the normal summary popup; only available in tournament and pot-poker modes -->
<div class="overlay overlay-bonus-v2 overlay-v2">
    <div class="popup-bonus-v2 popup-mode2">
        <div class="popup-bonus-v2-head popup-mode2-head clearfix">
            <img src="/images/v2/popup/header_bonus.png" />
        </div>
        <div class="popup-winner-content popup-mode2-content">
            <p class="popup-winner-content-title text-center">Winning hand:</p>
            <p class="popup-winner-content-subtitle text-center winningHandType">Straight</p>
            <div class="card-holder text-center">
                <div class="cards clearfix winningCards">
                </div>
            </div>
            <div class="bonus-text">
            	Your play earned you <b>a Bonus!</b>
            </div>
            <div class="popup-winner-content-info">
            	<p class="section-summary">Summary:</p>
            	
                <p class="section-item"><span class="popup-label">Bonus Type:</span> <span class="popup-value numShots">0</span></p>
                <p class="section-item"><span class="popup-label">Bonus Amount Won:</span> <span class="popup-value bonusChips">0</span></p>
                <p class="section-item"><span class="popup-label">Gold Won:</span> <span class="popup-value bonusGold">0</span></p>
                
                <p class="section-spacer">&nbsp;</p>
                
                <p class="section-item"><span class="popup-label">Amount Bet:</span> <span class="popup-value totalBets">0</span></p>
                <p class="section-item"><span class="popup-label">Total Winnings:</span> <span class="popup-value totalWinnings">0</span></p>
                <p class="section-item"><span class="popup-label">Total Profit:</span> <span class="popup-value totalProfit">0</span></p>
            </div>
            <div class="bonus-footer popup-bonus-img-bottom-text">
            	Profit again and you will earn a higher level bonus!
            </div>
            <div class="buttons">
                <span class="btn btn-transparent close-button cancelButton">Close</span>
            </div>
        </div>
    </div>
</div>
<!-- /popup-result-loss-v2-->
<!-- popup-result-loss-v2; displayed when the user ends the round with a loss -->
<div class="overlay overlay-result-loss-v2 overlay-v2">
    <div class="popup-result-loss-v2 popup-mode2">
        <div class="popup-result-loss-v2-head popup-mode2-head clearfix">
            <img src="/images/v2/popup/header_result_loss.png" />
        </div>
        <div class="popup-winner-content popup-mode2-content">
            <p class="popup-winner-content-title text-center">Winning hand:</p>
            <p class="popup-winner-content-subtitle text-center winningHandType">Straight</p>
            <div class="card-holder text-center">
                <div class="cards clearfix winningCards">
                </div>
            </div>
            <div class="bonus-text">
            	Sorry, you didn't make a profit this round.<br />
            	Better luck next time!
            </div>
            <div class="popup-winner-content-info">
            	<p class="section-summary">Summary:</p>
                <p class="section-item"><span class="popup-label">Amount Bet:</span> <span class="popup-value totalBets">0</span></p>
                <p class="section-item"><span class="popup-label">Total Losses:</span> <span class="popup-value totalLosses">0</span></p>
            </div>
            <div class="bonus-footer">
            	<!-- FIXME:  show the tutorial popup here (and close the current popup?) -->
            	Learn the basics of the game, <a class="videoTutorialLink" href="javascript:void(0)">watch the tutorial</a>.
            </div>
            <div class="buttons">
                <span class="btn btn-transparent close-button cancelButton">Close</span>
            </div>
        </div>
    </div>
</div>
<!-- /popup-result-loss-v2-->
<!-- popup-result-win-v2; displayed when the user ends the round with a profit -->
<div class="overlay overlay-result-win-v2 overlay-v2">
    <div class="popup-result-win-v2 popup-mode2">
        <div class="popup-result-win-v2-head popup-mode2-head clearfix">
            <img src="/images/v2/popup/header_result_loss.png" />
        </div>
        <div class="popup-winner-content popup-mode2-content">
            <p class="popup-winner-content-title text-center">Winning hand:</p>
            <p class="popup-winner-content-subtitle text-center winningHandType">Straight</p>
            <div class="card-holder text-center">
                <div class="cards clearfix winningCards">
                </div>
            </div>
            <div class="bonus-text">
            	Your play earned you <b>a profit!</b>
            </div>
            <div class="popup-winner-content-info">
            	<p class="section-summary">Summary:</p>
                <p class="section-item"><span class="popup-label">Amount Bet:</span> <span class="popup-value totalBets">0</span></p>
                <p class="section-item"><span class="popup-label">Total Winnings:</span> <span class="popup-value totalWinnings">0</span></p>
                <p class="section-item"><span class="popup-label">Total Profit:</span> <span class="popup-value totalProfit">0</span></p>
            </div>
            <div class="bonus-footer noGuestMode">
            	Profit next time and you will earn a bonus!
            </div>
            <div class="buttons">
                <span class="btn btn-transparent close-button cancelButton">Close</span>
            </div>
        </div>
    </div>
</div>
<!-- /popup-result-win-v2-->
<!-- popup-no-chips-guest-v2; displayed when a guest-mode user has no chips at the start of a round -->
<div class="overlay overlay-no-chips-guest-v2 overlay-v2">
    <div class="popup-no-chips-guest-v2 popup-mode2">
        <div class="popup-no-chips-guest-v2-head popup-mode2-head clearfix" style="position: relative;">
        	<i class="fa fa-times-circle overlay-close" onclick="$('.overlay-no-chips-guest-v2').hide();" aria-hidden="true" style="position: absolute; top: 3px; right: 3px;"></i>
            <img src="/images/v2/popup/header_play_again_loss.png" />
        </div>
        <div class="popup-winner-content popup-mode2-content">
            <div class="bonus-text">
            	<!-- FIXME:  take bonus amount from config -->
            	On no!  You've run out of chips.<br />
            	<br />
            	Sign up for your free account and keep playing with 10,000 free chips on us!
            </div>
            <div class="buttons">
                <span class="btn btn-transparent close-button registerButton registerButtonWide wideButton exitButton registerButton">Register</span>
            </div>
            <div class="bonus-text bonus-text-small">
            	Already have an account? Login now to keep playing.
            </div>
            <div class="buttons">
                <span class="btn btn-transparent close-button cancelButton cancelButtonWide wideButton loginButton">Login</span>
            </div>
        </div>
    </div>
</div>
<!-- /popup-no-chips-guest-v2-->
<c:if test="${ ! empty user }">
	<!-- popup-no-chips-user-v2; displayed when a regular user has no chips at the start of a round -->
	<div class="overlay overlay-no-chips-user-v2 overlay-v2">
	    <div class="popup-no-chips-user-v2 popup-mode2">
	        <div class="popup-no-chips-user-v2-head popup-mode2-head clearfix" style="position: relative;">
	        	<i class="fa fa-times-circle overlay-close" onclick="$('.overlay-no-chips-user-v2').hide();" aria-hidden="true" style="position: absolute; top: 3px; right: 3px;"></i>
	            <img src="/images/v2/popup/header_play_again_loss.png" />
	        </div>
	        <div class="popup-winner-content popup-mode2-content">
	            <div class="bonus-text">
	            	On no!  You've run out of chips.<br />
	            	To keep playing you will need to top up your balance chips.
	            </div>
	            <div class="buttons">
	                <span class="btn btn-transparent close-button registerButton registerButtonWide wideButton exitButton creditsButton">Buy Credits</span>
	            </div>
	            <div class="bonus-text bonus-text-small">
	            	<!-- FIXME:  take bonus amount from config -->
	            	Share to Facebook and earn 5,000 chips to keep playing.  (Bonus limited to one share per 24 hours):
	            </div>
	            <div class="buttons">
	            	<c:if test="${ user.secondsUntilNextShare le 0 }">
				      <div class="button-helper">
				          <a href="#" class="btn btn-fb shareButton sharebuttonWide wideButton"><span class="fb-logo"></span>Share Racing Poker
				          </a>
				          <p class="share-popup active" style="display: none;"><span class="secondsCountdown">23:59:59s</span> before you can share again</p>
				      </div>
				    </c:if>
				    <c:if test="${ user.secondsUntilNextShare gt 0 }">
				      <div class="button-helper">
				          <a href="#" class="btn btn-fb disabled shareButton sharebuttonWide wideButton"><span class="fb-logo"></span>Share Racing Poker
				          </a>
				          <p class="share-popup active"><span class="secondsCountdown">23:59:59s</span> before you can share again</p>
				      </div>
				    </c:if>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- /popup-no-chips-user-v2-->
	<!-- popup-play-again-user-v2; displayed when a regular user has chips remaining at the end of a tournament -->
	<div class="overlay overlay-play-again-user-v2 overlay-v2">
	    <div class="popup-play-again-user-v2 popup-mode2">
	        <div class="popup-play-again-user-v2-head popup-mode2-head clearfix" style="position: relative;">
	        	<i class="fa fa-times-circle overlay-close" onclick="$('.overlay-play-again-user-v2').hide();" aria-hidden="true" style="position: absolute; top: 3px; right: 3px;"></i>
	            <img src="/images/v2/popup/header_play_again_win.png" />
	        </div>
	        <div class="popup-winner-content popup-mode2-content">
	            <div class="bonus-text">
	            	Game over.<span class="great-job">  Great job!</span><br />
	            	<br />
	            	Would you like to play again?
	            </div>
	            <div class="popup-winner-content-info">
	            	<p class="section-summary">Tournament Summary</p>
	            	<!-- requested:  Position, Winnings, Shots, Gold Bonus -->
	            	<!-- implemented:  Position, ending balance -->
	            	<div class="single-guest-results">
		            	<p class="section-item"><span class="popup-label" style="text-align: left;">Position:</span> <span class="popup-value popup-position" style="display: inline-block; min-width: 60px;">1 of 1</span></p>
		            	<p class="section-item"><span class="popup-label label-ending-balance" style="text-align: left;">Ending Balance:</span> <span class="popup-value currentBalance" style="display: inline-block; min-width: 60px;">0</span></p>
	            	</div>
	            	<div class="multi-results" style="display: none;">
	            		<p class="section-item"><span class="popup-label" style="text-align: left;">Position:</span> <span class="popup-value popup-position" style="display: inline-block; min-width: 60px;">1 of 1</span></p>
		            	
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Chips Won:</span> <span class="popup-value credits-rank-1 creditsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Chips Won:</span> <span class="popup-value credits-rank-2 creditsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Chips Won:</span> <span class="popup-value credits-rank-3 creditsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Chips Won:</span> <span class="popup-value credits-rank-other creditsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
		            	
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Gold Won:</span> <span class="popup-value gold-rank-1 bitletsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Gold Won:</span> <span class="popup-value gold-rank-2 bitletsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Gold Won:</span> <span class="popup-value gold-rank-3 bitletsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Gold Won:</span> <span class="popup-value gold-rank-other bitletsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
	            	</div>
	            </div>
	            <div class="buttons">
	                <span class="btn btn-transparent close-button blueButton blueButtonWide wideButton exitButton tournamentButton">Play a Tournament</span>
	                <span class="btn btn-transparent close-button blueButton blueButtonWide wideButton exitButton potPokerButton">Play Pot Poker</span>
	                <span class="btn btn-transparent close-button blueButton blueButtonWide wideButton exitButton singlePlayerButton">Play for Fun</span>
	            </div>
	            <div class="bonus-text bonus-text-small">
	            	<!-- FIXME:  take bonus amount from config -->
	            	Share to Facebook and earn 5,000 chips to keep playing.  (Bonus limited to one share per 24 hours):
	            </div>
	            <div class="buttons">
	            	<c:if test="${ user.secondsUntilNextShare le 0 }">
				      <div class="button-helper">
				          <a href="#" class="btn btn-fb shareButton sharebuttonWide wideButton"><span class="fb-logo"></span>Share Racing Poker
				          </a>
				          <p class="share-popup active" style="display: none;"><span class="secondsCountdown">23:59:59s</span> before you can share again</p>
				      </div>
				    </c:if>
				    <c:if test="${ user.secondsUntilNextShare gt 0 }">
				      <div class="button-helper">
				          <a href="#" class="btn btn-fb disabled shareButton sharebuttonWide wideButton"><span class="fb-logo"></span>Share Racing Poker
				          </a>
				          <p class="share-popup active"><span class="secondsCountdown">23:59:59s</span> before you can share again</p>
				      </div>
				    </c:if>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- /popup-play-again-user-v2-->
	<!-- popup-play-again-user-loss-v2; displayed when a regular user has no chips at the start of a round -->
	<div class="overlay overlay-play-again-user-loss-v2 overlay-v2">
	    <div class="popup-play-again-user-v2 popup-mode2">
	        <div class="popup-play-again-user-v2-head popup-mode2-head clearfix" style="position: relative;">
	        	<i class="fa fa-times-circle overlay-close" onclick="$('.overlay-play-again-user-loss-v2').hide();" aria-hidden="true" style="position: absolute; top: 3px; right: 3px;"></i>
	            <img src="/images/v2/popup/header_play_again_loss.png" />
	        </div>
	        <div class="popup-winner-content popup-mode2-content">
	            <div class="bonus-text">
	            	Game over.<br />
	            	<br />
	            	Would you like to play again?
	            </div>
	            <div class="popup-winner-content-info">
	            	<p class="section-summary">Tournament Summary</p>
	            	<!-- requested:  Position, Winnings, Shots, Gold Bonus -->
	            	<!-- implemented:  Position, ending balance -->
	            	<div class="single-guest-results">
		            	<p class="section-item"><span class="popup-label" style="text-align: left;">Position:</span> <span class="popup-value popup-position" style="display: inline-block; min-width: 60px;">1 of 1</span></p>
		            	<p class="section-item"><span class="popup-label label-ending-balance" style="text-align: left;">Ending Balance:</span> <span class="popup-value currentBalance" style="display: inline-block; min-width: 60px;">0</span></p>
	            	</div>
	            	<div class="multi-results" style="display: none;">
	            		<p class="section-item"><span class="popup-label" style="text-align: left;">Position:</span> <span class="popup-value popup-position" style="display: inline-block; min-width: 60px;">1 of 1</span></p>
		            	
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Chips Won:</span> <span class="popup-value credits-rank-1 creditsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Chips Won:</span> <span class="popup-value credits-rank-2 creditsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Chips Won:</span> <span class="popup-value credits-rank-3 creditsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Chips Won:</span> <span class="popup-value credits-rank-other creditsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
		            	
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Gold Won:</span> <span class="popup-value gold-rank-1 bitletsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Gold Won:</span> <span class="popup-value gold-rank-2 bitletsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Gold Won:</span> <span class="popup-value gold-rank-3 bitletsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
		            	<p class="section-item" style="display: none;"><span class="popup-label label-ending-balance" style="text-align: left;">Gold Won:</span> <span class="popup-value gold-rank-other bitletsFormat" style="display: inline-block; min-width: 60px;">0</span></p>
	            	</div>
	            </div>
	            <div class="buttons">
	                <span class="btn btn-transparent close-button blueButton blueButtonWide wideButton exitButton tournamentButton">Play a Tournament</span>
	                <span class="btn btn-transparent close-button blueButton blueButtonWide wideButton exitButton potPokerButton">Play Pot Poker</span>
	                <span class="btn btn-transparent close-button blueButton blueButtonWide wideButton exitButton singlePlayerButton">Play for Fun</span>
	            </div>
	            <div class="bonus-text bonus-text-small">
	            	<!-- FIXME:  take bonus amount from config -->
	            	Share to Facebook and earn 5,000 chips to keep playing.  (Bonus limited to one share per 24 hours):
	            </div>
	            <div class="buttons">
	            	<c:if test="${ user.secondsUntilNextShare le 0 }">
				      <div class="button-helper">
				          <a href="#" class="btn btn-fb shareButton sharebuttonWide wideButton"><span class="fb-logo"></span>Share Racing Poker
				          </a>
				          <p class="share-popup active" style="display: none;"><span class="secondsCountdown">23:59:59s</span> before you can share again</p>
				      </div>
				    </c:if>
				    <c:if test="${ user.secondsUntilNextShare gt 0 }">
				      <div class="button-helper">
				          <a href="#" class="btn btn-fb disabled shareButton sharebuttonWide wideButton"><span class="fb-logo"></span>Share Racing Poker
				          </a>
				          <p class="share-popup active"><span class="secondsCountdown">23:59:59s</span> before you can share again</p>
				      </div>
				    </c:if>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- /popup-play-again-user-loss-v2-->
</c:if>
<!-- popup-play-again-guest-loss-v2; displayed when a guest-mode user has no chips at the start of a round -->
<div class="overlay overlay-play-again-guest-loss-v2 overlay-v2">
    <div class="popup-play-again-guest-loss-v2 popup-mode2">
        <div class="popup-play-again-guest-loss-v2-head popup-mode2-head clearfix" style="position: relative;">
        	<i class="fa fa-times-circle overlay-close" onclick="$('.overlay-play-again-guest-loss-v2').hide();" aria-hidden="true" style="position: absolute; top: 3px; right: 3px;"></i>
            <img src="/images/v2/popup/header_play_again_loss.png" />
        </div>
        <div class="popup-winner-content popup-mode2-content">
            <div class="bonus-text">
            	Game over.<br />
            	<br />
            	Would you like to play again?
            </div>
            <div class="buttons">
                <span class="btn btn-transparent close-button blueButton blueButtonWide wideButton exitButton guestButton">Play Again</span>
            </div>
            <div class="bonus-text bonus-text-small">
            	<!-- FIXME:  take bonus amount from config -->
            	Sign up for your free account and start with 10,000 free chips on us!
            </div>
            <div class="buttons">
                <span class="btn btn-transparent close-button registerButton registerButtonWide wideButton exitButton registerButton">Register</span>
            </div>
        </div>
    </div>
</div>
<!-- /popup-play-again-guest-loss-v2-->
<!-- popup-play-again-guest-v2; displayed when a guest-mode user has no chips at the start of a round -->
<div class="overlay overlay-play-again-guest-v2 overlay-v2">
    <div class="popup-play-again-guest-v2 popup-mode2">
        <div class="popup-play-again-guest-v2-head popup-mode2-head clearfix" style="position: relative;">
        	<i class="fa fa-times-circle overlay-close" onclick="$('.overlay-play-again-guest-v2').hide();" aria-hidden="true" style="position: absolute; top: 3px; right: 3px;"></i>
            <img src="/images/v2/popup/header_play_again_win.png" />
        </div>
        <div class="popup-winner-content popup-mode2-content">
            <div class="bonus-text">
            	Game over.  <span class="great-job">  Great job!</span><br />
            	<br />
            	Would you like to play again?
            </div>
            <div class="buttons">
                <span class="btn btn-transparent close-button blueButton blueButtonWide wideButton exitButton guestButton">Play Again</span>
            </div>
            <div class="bonus-text bonus-text-small">
            	<!-- FIXME:  take bonus amount from config -->
            	Sign up for your free account and start with 10,000 free chips on us!
            </div>
            <div class="buttons">
                <span class="btn btn-transparent close-button registerButton registerButtonWide wideButton exitButton registerButton">Register</span>
            </div>
        </div>
    </div>
</div>
<!-- /popup-play-again-guest-v2-->

<!-- /V2 POPUPS -->

<script>
$("body").on("click", ".videoTutorialLink", function() {
	$(this).parents(".overlay").hide();
	$(".overlay-tutorial").show();
});

$(".overlay-results .btn-facebook").click(function() {
	var rank = $(".overlay-results .rank").html();
	
	var suffix = "th";
	if (parseInt(rank, 10) == 1) {
		suffix = "st"; 
	}
	if (parseInt(rank, 10) == 2) {
		suffix = "nd"; 
	}
	if (parseInt(rank, 10) == 3) {
		suffix = "rd"; 
	}
	rank += suffix;
	
	var url = window.location.href.split(/\/[ur]\//gi)[0];
    var message = "I just placed " + rank + " in a tournament!  Try your skill and top the Leader Board in this new poker game.";
    var heading = "10,000 Tournament Credit Joining Bonus";
    fb_share(url,message,heading);
});

window.pad = function(text) {
	text = text + "";
	if (text.length < 2) {
		return "0" + text;
	}
	return text;
}

window.shareCountdown = function(seconds) {
	$("p.share-popup").show();
	$(".overlay-v2 .btn-fb").addClass("disabled");
	
	//countdown until the user can share again
	var target = new Date().getTime() + (seconds * 1000);
	window.shareInterval = setInterval(function(){
		var secondsRemaining = Math.floor((target - new Date().getTime()) / 1000);
		if (secondsRemaining < 0) {
			$("p.share-popup").hide();
			$(".overlay-v2 .btn-fb").removeClass("disabled");
			
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

<c:if test="${ ! empty user }">
	$(".overlay-v2 .btn-fb").click(function() {
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
</c:if>
</script>