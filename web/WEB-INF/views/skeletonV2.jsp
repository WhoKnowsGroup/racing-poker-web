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
        <meta property='og:image' content='https://www.racingpoker.com/images/racingpoker-logo9.png'>
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
        </style>
        <script src='/Jquery/bootstrap_min.js'></script>           
	</head>
	<body>
		<!-- page wrapper -->
        <div class="page-wrapper">
            <v2:preloginNav />

            <!-- main -->
            <main class="main clearfix">
            </main>
            
			<v2:footerNav />
		
		<!-- page-wrapper -->
		</div>
		
		<script>
			$(document).ready(function() {
				$("body").addClass("skeleton");
			});
		</script>
	</body>
</html> 