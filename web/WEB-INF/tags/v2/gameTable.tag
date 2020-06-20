<%@ taglib tagdir="/WEB-INF/tags" prefix="rp" %>
<%@ taglib tagdir="/WEB-INF/tags/v2" prefix="v2" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ attribute name="balance" required="true" %>
<%@ attribute name="numGames" required="true" %>
		<!-- main-table -->
        <div class="main-table pull-left" style="position: relative;">
        	<img src="/images/v2/track.jpg" alt="horse-track" class="trackImage">
        	<div class="track" style="position: absolute; top: 0px; width: 100%;">
            	<img src="/images/0111.gif" class="horse horse1" />
            	<img src="/images/0222.gif" class="horse horse2" />
            	<img src="/images/0333.gif" class="horse horse3" />
            	<img src="/images/0444.gif" class="horse horse4" />
            	<img src="/images/0555.gif" class="horse horse5" />
            	<img src="/images/0666.gif" class="horse horse6" />
            </div>
            <div class="main-table-list-holder clearfix" style="position: relative;">
            	<div class="tutorialOverlay tutorialImage tutorialImageFullres">
                	<img src="/images/v2/rp_tutorial_hands_fullres.png" />
                </div>
                <!-- mobile use -->
                <div class="main-table-nav tablet-show clearfix">
                    <p id="toggle-leaderboar" class="leaderboard-trigger">View leaderboard</p>
                    <p class="mobile-position"><b>Position:</b> 1 of 1</p>
                </div>
                <div class="profile-stats-credits tablet-show second" style="white-space: nowrap !important;">
                    <p style="display: inline-block !important; max-width: 30% !important; width: 30% !important;">Balance<br /><span class="currentBalance">${ balance }</span></p>
                    <p style="display: inline-block !important; max-width: 30% !important; width: 30% !important;">Outlay<br /><span class="currentOutlay">$0</span></p>
                    <p style="display: inline-block !important; max-width: 30% !important; width: 30% !important;">Game<br /><span class="gameNumber">1 of ${ numGames }</span></p>
                    <div class="timer-holder clearfix">
                        <p class="js-timer js-deal-trigger">Last Bets<span><br><b class="profile-stats-credits-spec"><span class="timerSecs">0</span> </b> sec</span></p>
                        <!--
                        FIXME:  implement deal button for non-guest games 
                        <span class="deal-button js-deal js-deal-trigger">Deal</span>
                         -->
                    </div>
                </div>
                <!-- /mobile use -->

                <div class="main-table-list-holder-helper">
                    <!-- main-table-list -->
                    <ul class="main-table-list card-holder clear">
                        <li class="main-table-list-item">
                        	<p class="handLabel color-2-txt">1.</p>
                            <div class="cards">
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                            </div>
                            <p class="result color-2-txt"><span class="handType"><!-- <hand-num>. <hand-type> --></span></p>
                            <p class="bid"><dfn class="bidOdds"><!-- $4.70 --></dfn><br><span class="bet">Bet: $0</span><br><span class="return">Return: $0</span></p>
                            <button type="submit" class="submit-bid js-submit-bid color-2-bck">BET</button>
                        </li>
                        <hr>
                        <li class="main-table-list-item">
                        	<p class="handLabel color-1-txt">2.</p>
                            <div class="cards">
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                            </div>
                            <p class="result color-1-txt"><span class="handType"><!-- <hand-num>. <hand-type> --></p>
                            <p class="bid"><dfn class="bidOdds"><!-- $4.70 --></dfn><br><span class="bet">Bet: $0</span><br><span class="return">Return: $0</span></p>
                            <button type="submit" class="submit-bid js-submit-bid color-1-bck">BET</button>
                        </li>
                        <hr>
                        <li class="main-table-list-item">
                        	<p class="handLabel color-3-txt">3.</p>
                            <div class="cards">
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                            </div>
                            <p class="result color-3-txt"><span class="handType"><!-- <hand-num>. <hand-type> --></p>
                            <p class="bid"><dfn class="bidOdds"><!-- $4.70 --></dfn><br><span class="bet">Bet: $0</span><br><span class="return">Return: $0</span></p>
                            <button type="submit" class="submit-bid js-submit-bid color-3-bck">BET</button>
                        </li>
                        <hr>
                        <li class="main-table-list-item">
                        	<p class="handLabel color-4-txt">4.</p>
                            <div class="cards">
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                            </div>
                            <p class="result color-4-txt"><span class="handType"><!-- <hand-num>. <hand-type> --></p>
                            <p class="bid"><dfn class="bidOdds"><!-- $4.70 --></dfn><br><span class="bet">Bet: $0</span><br><span class="return">Return: $0</span></p>
                            <button type="submit" class="submit-bid js-submit-bid color-4-bck">BET</button>
                        </li>
                        <hr>
                        <li class="main-table-list-item">
                        	<p class="handLabel color-5-txt">5.</p>
                            <div class="cards">
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                            </div>
                            <p class="result color-5-txt"><span class="handType"><!-- <hand-num>. <hand-type> --></p>
                            <p class="bid"><dfn class="bidOdds"><!-- $4.70 --></dfn><br><span class="bet">Bet: $0</span><br><span class="return">Return: $0</span></p>
                            <button type="submit" class="submit-bid js-submit-bid color-5-bck">BET</button>
                        </li>
                        <hr>
                        <li class="main-table-list-item">
                        	<p class="handLabel color-6-txt">6.</p>
                            <div class="cards">
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                                <span class="card"></span>
                            </div>
                            <p class="result color-6-txt"><span class="handType"><!-- <hand-num>. <hand-type> --></p>
                            <p class="bid"><dfn class="bidOdds"><!-- $4.70 --></dfn><br><span class="bet">Bet: $0</span><br><span class="return">Return: $0</span></p>
                            <button type="submit" class="submit-bid js-submit-bid color-6-bck">BET</button>
                        </li>
                    </ul>
                    <!-- /main-table-list -->

                    <!-- profiles-table mobile-use -->
                    <ul class="profiles-table profiles-table-mobile custom-scroll tablet-show">
                    </ul>
                    <!-- /profiles-table mobile-use-->
                </div>
            </div>
        </div>
        <!-- /main-table -->