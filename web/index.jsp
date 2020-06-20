<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
	<head>
		<script>
			window.location.href = "/r/indexPage";
		</script>
		<%
			try {
				response.sendRedirect(au.com.suncoastpc.conf.Configuration.getServerAddress() + "/r/indexPage");
		  	}
			catch (Throwable ignored) {
			
			}
		%>
	</head>
	<body>
		Redirecting, please wait...
	</body>
</html>