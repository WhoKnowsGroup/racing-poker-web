<%@ taglib tagdir="/WEB-INF/tags" prefix="rp" %>
<%@ taglib tagdir="/WEB-INF/tags/v2" prefix="v2" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ attribute name="audioPlayer" required="false" %>
<%@ attribute name="speechEnabled" required="false" %>
<%@ attribute name="fixedHeader" required="false" %>
<c:if test="${ ! empty fixedHeader }">
	<!-- fixed-position header -->
	<div class="header-wrapper">
</c:if>
<!-- header -->
<header class="header clearfix">
	<div class="tutorialOverlay tutorialBackground tutorialBackgroundHeader">
	</div>
	<!-- header-logo -->
	<c:if test="${ empty user }">
		<a href="/r/indexPage" class="header-logo official-logo pull-left"></a>
	</c:if>
	<c:if test="${ ! empty user }">
		<a href="/u/home" class="header-logo official-logo pull-left"></a>
	</c:if>
	<!-- /header-logo -->

	<!-- only when playing a game -->
  	<p class="inGameTimer mobileInGameTimer">
  		<span>
  			<b class="profile-stats-credits-spec">
  				<span class="timerSecs">0</span> 
  			</b> sec
  		</span>
  	</p>
	<span class="buttons dealButton mobileDealButton">
		<input type="submit" href="javascript:void(0)" class="btn btn-orange deal disabled" value="Deal">
	</span>
    <span class="toggle-nav"></span>
    <c:if test="${ ! empty numUsers }">
	    <span class="headerStats">
	    	Online now:
		    <em>
		    <span> &nbsp;${ numUsers }</span>
		    </em> &nbsp;Players&nbsp;
	        <em>
	        <span> &nbsp;${ numTournaments }</span>
	        </em> &nbsp;Tournaments&nbsp;</span>
	    </span>
    </c:if>

    <div class="header-content-holder pull-right">
        <!-- profile-options -->
        <div class="header-profile-options">
        	<c:if test="${ ! empty user }">
        		<a href="/u/profile" class="btn btn-green " style="max-width: 125px; overflow: hidden; text-overflow: ellipsis;"><span class="glyphicon glyphicon-user"></span>${ user.nickname }</a>
            	<a href="/u/addChips" class="btn btn-orange">Add chips</a>
            	<!-- only when playing a game -->
            	<p class="inGameTimer">
            		<span>
            			<b class="profile-stats-credits-spec">
            				<span class="timerSecs">0</span> 
            			</b> sec
            		</span>
            	</p>
            	<span class="buttons dealButton">
            		<!-- only used for single-player games -->
					<input type="submit" href="javascript:void(0)" class="btn btn-orange deal disabled" value="Deal">
				</span>
            	<c:if test="${ ! empty isAdmin }">
					<!-- FIXME:  compute/expose 'isAdmin' on server -->
					<a href="/ipaddress_filter.html" class="btn btn-blue"><span class="glyphicon glyphicon-user"></span>Admin</a>
				</c:if>
            	<a href="/r/logout" class="btn btn-danger">Logout</a>
            </c:if>
            <c:if test="${ empty user }">
            	<a href="javascript:void(0)" onclick="$('.overlay-log-in').show();" class="btn btn-green loginButton" data-toggle="modal" data-target="#login_popup1"> <span class="glyphicon glyphicon-log-in"></span> Log In</a>
				<a href="/r/registrationPage" class="btn btn-green"><span class="glyphicon glyphicon-user registerButton"></span> Register</a> 
				<c:if test="${ empty audioPlayer && empty speechEnabled }">
					<a href="/r/guestModeV2" style="color:white" class="btn btn-orange" >Try Me</a>
				</c:if>
				<!-- only when playing a game -->
            	<p class="inGameTimer">
            		<span>
            			<b class="profile-stats-credits-spec">
            				<span class="timerSecs">0</span> 
            			</b> sec
            		</span>
            	</p>
            </c:if>
        </div>
        <!-- /profile-options -->
    </div>

	<c:if test="${ ! empty audioPlayer }">
   		<div class="player">
			<c:if test="${ ! empty speechEnabled }">
		        <div class="player-one player-controls">
		            <audio class="audio" id="audioplayer-one" style="display: none;" controls>
		
		            <p>Your Browser do not support audio</p>
		            </audio>
		
		            <span class="volume-icon active"></span>
		            <div class="volume player-one-volume" title="Set volume"></div>
		        </div>
	        </c:if>
		
	        <div class="player-two player-controls">
	            <audio class="audio" id="audioplayer-two" style="display: none;" controls>
	                <source src="/music/player-2/Jazz_Lounge.mp3" type="audio/mpeg">
	                <source src="/music/player-2/Luxury.mp3" type="audio/mpeg">
	                <source src="/music/player-2/Night_Casino_4.mp3" type="audio/mpeg">
	                <source src="/music/player-2/Optimistic_and_Carefree.mp3" type="audio/mpeg">
	                <source src="/music/player-2/Rich_and_Luxury.mp3" type="audio/mpeg">
	                <source src="/music/player-2/Richness.mp3" type="audio/mpeg">
	                <p>Your Browser does not support audio</p>
	            </audio>
	
	            <span class="audio-icon active"></span>
	            <div class="volume player-two-volume" title="Set volume"></div>
	        </div>
  		</div>
	</c:if>
</header>
<c:if test="${ ! empty fixedHeader }">
	<!-- /fixed-position header -->
	</div>
</c:if>
<!-- /header -->
            
<!-- mobile-menu -->
<nav class="mobile-menu">
    <div class="mobile-menu-content">
        <div class="mobile-menu-content-header">
            <span class="official-logo light"></span>
            <a href="javascript:void(0)" class="close-menu pull-right"></a>
            <c:if test="${ ! empty audioPlayer }">
	            <div class="player mobile-player">
	                <div class="player-two player-controls">
	                    <span class="volume-icon active"></span>
	                </div>
	
					<c:if test="${ ! empty speechEnabled }">
	                    <div class="player-one player-controls">
	                        <span class="audio-icon active"></span>
	                    </div>
                	</c:if>
            	</div>
            </c:if>
		</div>
        <div class="mobile-menu-content-body">
            <ul class="mobile-menu-content-body-nav">
            	<c:if test="${ ! empty speechEnabled && ! empty audioPlayer }">
	                <li class="mobile-menu-content-body-nav-item">
	                    <a href="javascript:void(0)" onclick="$('.exitGame').trigger('click');">Quit current game</a>
	                </li>
                </c:if>
                <c:if test="${ empty user }">
                	<li class="mobile-menu-content-body-nav-item">
                		<a href="javascript:void(0)" onclick="$('.overlay-log-in').show();" data-toggle="modal" data-target="#login_popup1"><span class="glyphicon glyphicon-log-in"></span> Log In</a>
                	</li>
                	<li class="mobile-menu-content-body-nav-item">
                		<a href="/r/registrationPage">Sign Up</a>
                	</li>
                </c:if>
                <c:if test="${ ! empty user }">
                	<li class="mobile-menu-content-body-nav-item">
	                    <a href="/u/profile">Profile</a>
	                </li>
	                <!-- 
	                <li class="mobile-menu-content-body-nav-item">
	                    <a href="/u/addChips">Get chips and gold</a>
	                </li>
	                <li class="mobile-menu-content-body-nav-item">
	                    <a href="javascript:void(0)">Leaderboards</a>
	                </li>
	                -->
                </c:if>
                <li class="mobile-menu-content-body-nav-item">
                    <a href="/r/learnGame">Rules</a>
                </li>
                <li class="mobile-menu-content-body-nav-item">
                    <a href="/r/support">Support</a>
                </li>
                <li class="mobile-menu-content-body-nav-item">
                    <a href="/r/about">About Us</a>
                </li>
                <li class="mobile-menu-content-body-nav-item">
                    <a href="/r/legals?selectedTab=terms">Legal policies</a>
                </li>
                <c:if test="${ ! empty user }">
	                <li class="mobile-menu-content-body-nav-item">
	                    <a href="/r/logout">Log out</a>
	                </li>
                </c:if>
                <c:if test="${ empty user && empty audioPlayer && empty speechEnabled }">
                	<li class="mobile-menu-content-body-nav-item">
						<a href="/r/guestModeV2" >Try Me</a>
					</li>
				</c:if>
            </ul>
            <div class="mobile-menu-content-body-buttons">
                <a href="https://www.facebook.com/racingpoker/" target="_blank" class="btn fb-follow"><span></span>Follow us</a>
                <c:if test="${ ! empty user }">
                	<a href="/u/addChips" class="btn btn-orange">Buy Credits</a>
            	</c:if>
            </div>

            <div class="terms-link">
                <a href="/r/legals?selectedTab=terms">Terms</a>
                <a href="/r/legals?selectedTab=privacy">Privacy</a>
            </div>
        </div>
    </div>
</nav>
<!-- /mobile-menu -->

<v2:globalPopups />