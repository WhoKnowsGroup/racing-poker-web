<%@ taglib tagdir="/WEB-INF/tags" prefix="rp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<a href="/u/profile" class="btn btn-success"><span class="glyphicon glyphicon-user"></span>${ user.nickname }</a>
<a href="/history.html" class="btn btn-primary"><span class="glyphicon glyphicon-user"></span>History</a>
<c:if test="${ ! empty isAdmin }">
	<!-- FIXME:  compute/expose 'isAdmin' on server -->
	<a href="/ipaddress_filter.html" class="btn btn-primary"><span class="glyphicon glyphicon-user"></span>Admin</a>
</c:if>
<button type="button" onclick="if (window.logout) { logout } else { window.location.href = '/r/logout'; }" class="btn btn-danger">Logout</button>