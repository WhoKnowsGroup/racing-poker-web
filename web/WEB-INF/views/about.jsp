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
                <div class="row">
                    <br/>
                </div>
                <div class="row">
                    <div>
                        <div class="container bg-row">
                            <div class="container">
                                <div class="">
                                    <div class="row" style="text-align:justfy">
                                        <div class="">
                                            <br/> 
                                            <strong style="font-size:18">  The Story So Far </strong> 
                                            <br/>
                                            <br/>
                                            <p> We are a Software Development Company that is dedicated to 
                                                providing fun games therefore <br/>giving people an alternative 
                                                in Poker based games. We are proud of our innovative exciting <br/>
                                                games and invite you to join us in the fun.<br/>
                                            <p>For more information please contact us at:
                                                biz@racingpoker.com
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <br/>
                </div>
                <div class="row">
                    <div class="container bg-row">
                        <div style="">
                            <div class="container">
                                <div class="col-md-4" >
                                    <h3>Online Poker Game </h3>
                                    <p style="font-size:14;text-align: justify;"> Racing Poker&trade; is a game based on most of the rules of poker and played using a 52 card deck.This game is only for amusement purposes and not for real money<br/>
                                        <button type="button" class="btn btn-default" >Read more...</button>
                                    </p>
                                </div>
                                <div class="col-md-4">
                                    <h3>Tournaments </h3>
                                    <p style="font-size:14px;text-align: justify">  Racing Poker&trade; Tournament runs for the pre defined number of games in a tournament. Wide range of tournaments , varying from High level to Entry level tournaments.<br/>
                                        <button type="button" class="btn btn-default" >Read more...</button> 
                                    </p>
                                </div>
                                <div class="col-md-4">
                                    <h3> Bonuses </h3>
                                    <p style="font-size:14px;text-align: justify">  The winners receive accolades, level increases, Racing Poker® Tournament Credits and or Racing Poker Bitlet Coins. You can have chance for winning 95 Racing Poker  Bitlet Coins.<br/>
                                        <button type="button" onclick="navigate()" class="btn btn-default" >Click here</button> for top shot players.
                                    </p>
                                </div>
                            </div>
                        </div>
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