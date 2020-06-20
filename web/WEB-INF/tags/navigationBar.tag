<%@ taglib tagdir="/WEB-INF/tags" prefix="rp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="navbar-header">
	<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
	    <span class="icon-bar"></span>                        
	</button>
	<a class="navbar-brand" href="#" style="color:#ffffff" >Racing Poker&trade;</a>
   	<div class="pull-right hidden-md hidden-lg nav navbar-nav" >
        <!-- Dynamic buttons depending upon login state (1) -->
        <c:if test="${ empty user }">
        	<rp:guestNavLinks_narrowFormat />
    	</c:if>
		<c:if test="${ ! empty user }">
      		<rp:userNavLinks />
    	</c:if>
    </div>
</div>
<!-- FIXME:  duplicate navbar content here!!! -->
<div id="myNavbar" class="collapse navbar-collapse">
	<ul class="nav navbar-nav">
    	<li class=""><a href="/learn_game.html" > Game Rules</a></li>
       	<li><a href="/promotions.html"> Promotions</a></li>
        <li><a href="/Support.html">Support</a></li>
        <li><a href="/Aboutus.html">About us</a></li>
	</ul>
	<form class="navbar-form navbar-right" >
		<!-- Dynamic buttons depending upon login state (2) -->
		<c:if test="${ empty user }">
    		<rp:guestNavLinks_wideFormat />
		</c:if>
		<c:if test="${ ! empty user }">
			<div id="user_profile" style="color:white">
   				<rp:userNavLinks />
   			</div>
		</c:if>
	</form>         
</div>