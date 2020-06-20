<%@ taglib tagdir="/WEB-INF/tags" prefix="rp" %>
<%@ taglib tagdir="/WEB-INF/tags/v2" prefix="v2" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- footer -->
<footer class="footer">
    <div class="grid-container">
        <!-- footer-content -->
        <div class="content-holder row">

            <div class="footer-logo col-2">
                <a class="official-logo" href="javascript:void(0)"></a>
            </div>

            <div class="footer-nav col-6">
                <ul class="footer-nav-list-1 col-4">
                    <li><a href="/r/learnGame">Game Rules</a></li>
                    <li><a href="/r/support">Support</a></li>
                    <li><a href="/r/about">About Us</a></li>
                </ul>
                <ul class="footer-nav-list-2 col-4">
                	<c:if test="${ empty user }">
	                    <li><a href="javascript:void(0)" onclick="$('.registerButton').trigger('click');">Sign Up</a></li>
	                    <li><a href="javascript:void(0)" onclick="window.scrollTo(0, 0); $('.loginButton').trigger('click');">Log In</a></li>
                    </c:if>
                    <c:if test="${ ! empty user }">
	                    <li><a href="/r/logout">Log Out</a></li>
                    </c:if>
                    <li><a href="/r/legals?selectedTab=terms">Terms</a></li>
                    <li><a href="/r/legals?selectedTab=privacy">Privacy</a></li>
                </ul>
                <ul class="footer-nav-list-3 col-4">
                    <li><a href="/r/support">Contact Us</a></li>
                    <li><a href="https://www.facebook.com/racingpoker/" target="_blank">Follow us on Facebook</a></li>
                </ul>
            </div>

            <div class="footer-link col-3 offset-1">
            	<c:if test="${ empty user }">
                	<a href="/r/indexPage"></a>
                </c:if>
                <c:if test="${ ! empty user }">
                	<a href="/u/home"></a>
                </c:if>
            </div>

        </div>
        <!-- /footer-content -->

        <!-- footer-copyright -->
        <p class="footer-copyright clearfix">© Copy rights (1999 - 2018) reserved by Pokerace Pty Ltd</p>
        <!-- /footer-copyright -->
    </div>
</footer>
<!-- /footer -->