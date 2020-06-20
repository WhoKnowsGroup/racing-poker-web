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
        </style>
        <script src="/Jquery/bootstrap_min.js"></script>
    </head>
    <body>
        <!-- page wrapper -->
        <div class="page-wrapper">
            <v2:preloginNav />
            <!-- main -->
            <main class="main clearfix">
                <br/>
                <br/>  
                <!--body--->
                <div class="row">
                    <div class="container bg-row">
                        <h4> Support </h4>
                        <p> If you experience any issues with our software please let us know by emailing us
                            at  <a href="mailto:support@racingpoker.com" > support@racingpoker.com </a>  <br/> <br/>
                            Please try to take a screen shot and send it on over explaining the problem, 
                            Also please try to include the tournament ID which can be found on the left hand side of the screen for our website or at the top of the page on our Mobile/smaller device version.
                            If you have any suggestions for us please feel free to email us on
                            <a href="mailto:support@racingpoker.com" > support@racingpoker.com </a> as we welcome your feedback
                            <br/> <br/>
                            Please email us at <a href="mailto:biz@racingpoker.com" > biz@racingpoker.com </a>  for all other inquiries
                            <br/>
                            Want to do business with us?
                            please email <a href="mailto:biz@racingpoker.com" > biz@racingpoker.com </a>  <br/>
                            Looking forward to hearing from you
                            <br/> <br/>
                            Kind regards
                            <br/>
                            The Racing Poker Team
                        </p>
                    </div>
                </div>
                <br />
                <br />
            </main>
            <v2:footerNav />
            <!-- page-wrapper -->
        </div>
    </body>
</html>