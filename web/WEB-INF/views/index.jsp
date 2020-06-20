<!DOCTYPE HTML>
<%@ page isELIgnored="false" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="rp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
 <title>Racing Poker | online poker</title>
 <meta charset="utf-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <meta name="keywords" content="Poker,racing poker,online poker,poker tournaments,players">
 <meta name="application-name" content="Racing Poker">
 <meta name="author" content="Pokerace Team">
 <meta property="og:image" content="/images/racingpoker-logo9.png">     
 <link rel="icon" href="/images/racingpoker-logo9.png" />
 <link rel="stylesheet" href="/css/bootstrap_min.css" />
 <link rel="stylesheet" href="/templates/PageStyleSheets.css" />
 <link rel="stylesheet" href="/templates/PageLayout.css" />
 <script src="/Jquery/jquery_min.js"></script>
 <script src="/Jquery/bootstrap_min.js"></script>
 
</head>
<body>
  	<!--header--->   
  	<div class="jsonResult" style="display: none">
  		${ json }
  	</div>
  	
  	<!-- FIXME:  Probably there are more relative URL's that need fixing still -->
  	<div class="navbar navbar-custom navbar-fixed-top" >
	    <div class="navbar-inner header">
		    <div class="container">
			    <rp:navigationBar />
		    </div>
	    </div>
	</div>
  	<!---body content---->
  	<br/>
  	<br/>
  	<br/>
  	<br/>
  <!--http://images.cooltext.com/4447343.png--->
  <div class="container">
      <div class="col-md-3">
          <div id="logo"> <span ><img src="/images/Logo_type.png"  class="center-block"     alt="Racing Poker" /> </span> </div> </div>
      <div class="col-md-4"></div>
      <div class="col-md-5">
          <div class="block-online hidden-sm hidden-xs" style="text-align: right">  
          	<h5>
          		Online now:
          		<span id="online" class="online">
          			<em>
          				<span> &nbsp;${ numUsers }</span>
          			</em> &nbsp;Players&nbsp;
          			<em>
          				<span> &nbsp;${ numTournaments }</span>
          			</em> &nbsp;Tournaments&nbsp;</span>
          	</h5>
          </div>
      </div>
  </div>
  
   <br/>
   <br/>
   <div class="">
    <div>
        <div class="container" style="">
            
          
            <div class="col-md-4" >  
                 <div style=" border-radius: 16px;border: 1px;font-size:16; background:url('/images/tail-cont.png'); text-align: center;color:#ffffff;padding :15">
                     <br/>
                     <p>    <span>  <img src="/images/win.png" width="40" height="40"/> </span> <span>Today's top ranking players </span>  </p>
                 
                <div id="recent1" style="border: 1px ;border-radius: 16px;background:url('/images/tail-row-top.png'); text-align: center;color:#ffffff;">
        
                    <div class="row bg-row" style="border-radius: 16px;">
                    <div class="col-xs-1" id="img">
                      
                    </div> 
                    <div class="col-xs-10" id="recent" style="padding:5" >
                        <div id="recent4" style="text-align: left;"></div>
                        <div id="recent5" style="text-align:left;" ></div>
                        <div id="recent6" style="text-align: left;"></div>
                    </div>
                    </div>
                </div>
                
                <div id="top_players" >
                    <p> Today's top players </p> 
                    <div id="top_players" style="border: 1px; border-radius: 16px;background:url('/images/tail-row-top.png'); text-align: center;color:#ffffff;" >
                        
                        <div id="top_play"  class="row bg-row" style="border-radius: 16px;" >
                            <div class="col-xs-1">
                                
                            </div>
                            <div class="col-xs-10">
                                <table id="players_list" style="color:#ffffff;float:center">
                                <thead style="color:#ffffff;float:center;">
                                    <th style=" text-align: center"> S.no: &nbsp;</th>
                                    <th style=" text-align: center">Player name &nbsp; </th>
                                   <th style=" text-align: center">Player level &nbsp;</th>		
                                                         
                                </thead>
                                
                                <tbody id="player_ids"  style="font-size:12;font-family: sans-serif;">                                        
                                </tbody>
                                
                            </table>
                                </div>
                            </div> 
                            
                        </div>    
                        
                    </div>
                    
                    <br/>
                    
                    
                
               </div>
                
            </div>
        
           <div class="col-md-8"  style="">
               <div id="myCarousel" class="carousel slide" data-ride="carousel">
   
  <ol class="carousel-indicators">
    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#myCarousel" data-slide-to="1"></li>
    <li data-target="#myCarousel" data-slide-to="2"></li>
  </ol>

   
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img src="/images/welcome-logo2.jpg" class="img-responsive"  height="400" alt="Chania">
      <div class="carousel-caption">
        <h3>Welcome to Racing Poker &trade;</h3>
        <p> The only thing that matters is your opinion </p>
      </div>
    </div>

      <div class="item">
      <img src="/images/welcome-logo2.jpg" class="img-responsive" alt="Chania">
      <div class="carousel-caption" style="">
          <h4>Do you like playing Texas Holdem?Then we are sure you will love playing Racing Poker &trade;.</h4>
            <p> Please join us in the fun  <span> <a href="/r/registrationPage" class="btn btn-success">Sign up </a> </span></p>
      </div>
    </div>
     <div class="item">
      <img src="/images/image-2.png" class="img-responsive"  alt="Chania">
      <div class="carousel-caption" style="">
        <h4>Learn More</h4>
      </div>
    </div>
   
  </div>

   
  <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
           </div>
          
       </div>   
           
    </div>
    
    </div> 
  
   <div> <br/> </div>
   
   <!----Jumbtron-->
   
   <div class="">
        <div class="container" style="">
        <div style="color:#ffffff;border-radius: 16px;background-image: url('/images/tail-cont.png');" class="">
            <br/>
            <div class="container">
                <div class="col-md-3" >
                    <h3>Online Poker Game </h3>
                    <img src="/images/page1-img2.jpg" class="img-responsive" />
                    <p style="font-size:14;text-align: justify;"> Racing Poker&trade; is a game based on most of the rules of poker and played using a 52 card deck.This game is only for amusement purposes and not for real money<br/>
                         <a href="/learn_game.html"  onclick="navigate()" class="btn btn-info" >Click here for more</a>
                     
                    
                    </p>
                </div>
                
                <div class="col-md-3">
                    <h3>Tournaments </h3>
                     <iframe style="overflow: hidden;width: 100%;height: 100%;border:0px"
                            src="https://www.youtube.com/embed/zMh0OCBzSJ0">
                     </iframe> 
                    <p style="font-size:14;text-align: justify"> Racing Poker™ Tournament runs for the pre-defined number of games in a tournament. There is a wide range of tournaments varying from High level to Entry level tournaments  <br/>
                         <a href="/learn_game.html"  onclick="navigate()" class="btn btn-info" >Click here for more</a>
                        
                      
                </div>
                <div class="col-md-3">
                    <h3> Bonuses </h3>
                    <img src="/images/page1-img1.jpg" class="center-block" />
                    <p style="font-size:14;text-align: justify"> The winners receive accolades, level increases, Racing Poker&trade; Tournament Credits and / or Racing Poker&trade; Bitlet Coins. You have a chance of winning 95 Racing Poker Bitlet Coins. <br/>
            
                         <a href="/Top_shots.html"  onclick="navigate()" class="btn btn-info" >Click here for top players</a>  </p>
                         
                        
                    
                </div>
                <div class="col-md-2">
                   <h3> Guest mode </h3>
                   <p style="font-size:14;text-align: justify"> Please check out game in guest mode. If you like our game, then signup for real game.  <br/>
            
                         <a href="/r/guestModeV2"  onclick="navigate()" class="btn btn-info" >Click here for guest mode</a>  </p>
                </div>
                
                <div class="col-md-1"></div>
            </div>
        </div>
    </div>
    </div>
  
    <br/>
    
   <!--- Login Modal --->
   <div class="modal fade" id="login_popup1" tabindex="-1" role="dialog" aria-labelledby="login_popup1" aria-hidden="true">
    <div class="modal-md modal-dialog" style="background:#070D0D" >
              
        <script type="text/javascript" src="/facebooklogin_script.js" > </script>
        <div class="modal-content">
            <div class="modal-header" >
            <button type="button"  class="close" data-dismiss="modal" >x</button>
            <h4 class="modal-title" id="myModalLabel" style="color:#ffffff"> Racing Poker&trade; Login</h4>
            <div id="error_message"> </div>
            </div>
            <div class="modal-body" >
                <div class="row">
                    <div class="col-sm-6"> 
                        <div  id="form_login" class="form-group">
                            <form id='login_form' autocomplete="on" action="Login_form">
                            <label for="email_login">Email:</label>
                           <input  type="email" class="form-control" name="email_login" id="email_login" placeholder="Email" value="">
                           <br>
                         
                           <label for="password_login" >Password:</label>
                           <input  type="password" class="form-control" name="password_login" id="password_login" value="" autocomplete="off">
                          
                           </form>  
                            <br/>
                            <div class="row">
                                <div class="col-xs-4">
                                     <button type="button" class="btn btn-success" id="login" onclick="login()"  > Login </button>
                                </div>
                                <div class="col-xs-6">
                                    <a href="/r/registrationPage" class="">&nbsp; &nbsp;Sign up ? </a> <br>
                                    <a id="Forgotpassword" class="btn" onclick="forgot_load()" style="color:#B80D0D" > Forgot Password ? </a> 
                                </div>
                                
                            </div>
                           <br/>
                            
                            
                              
                        </div>
                    </div>
                    <div class="col-sm-1 hidden-xs">
                        <p>|</p>
                        <p>|</p>
                        <p>|</p>
                        <p>|</p>
                        <p>|</p>
                        <p>|</p>
                        <p>|</p>
                     
                    </div>
                     <div class="col-sm-1 visible-xs">
                         <hr/>                     
                    </div>
                    
                    <div class="col-sm-5">
                        <h4> Social Media Login </h4>
                        
                        
                         
                        <div id="social_media" class="btn">
                  
                            <div id="fb-root" class="">  
                         <fb:login-button  data-scope="publish_actions,email,public_profile" onlogin="checkLoginState();" data-rows="2" data-size="large" > Log in with Facebook
                         </fb:login-button> </div>
                          <br/>
                          <button id="google_plus" class="btn" style="background:#d34836;color:white;" onclick="handleAuthClick()">  <span> <img src="/images/google_plus.png" /></span> &nbsp;Log in with Google+</button>
                       
                        </div>
                        
                 
                    </div>
                    
                                       
                </div>
            </div>
            
    </div>
  </div>
</div>
  
  
  <!--Login Registration facebook-->
  
   <div class="modal fade" id="login_popup2" tabindex="-1" role="dialog" aria-labelledby="login_popup2" aria-hidden="true">
    <div class="modal-md modal-dialog" style="background:#070D0D" >
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h4 class="modal-title" id="myModalLabel" style="color:#E77817"> Setting up Account</h4>
            <div id="error_message2"> </div>
            </div>
            <div class="modal-body">
                <h3> Please choose screen name </h3>
                <div class="row">
                    
                                 <div class="col-xs-4">
                                     <label for="snname" > &nbsp; &nbsp; Screen Name:</label> </div>
                            <div class="col-xs-8">    
                                <input  type="text" name="snname" id="snname" placeholder="Screen name" value="" style="color:#000000"> </div>
                           <br>
                            </div>
                <br/>
                 <label> <input id="age"  type="checkbox" onChange="display_register()" value="age_accept" /> I am over 18/21 years of age whichever is permitted by my country/state law and I am permitted to play games of chance for fun </label> <br/>
                   &nbsp; &nbsp; &nbsp;   <label> <input id="terms"  type="checkbox" onChange="display_register()" value="terms_accept" /> I accept the <a href="" style="text-decoration: underline" data-toggle="modal" data-target="#terms_modal"  > Terms and  Conditions </a> , <a href="" style="text-decoration: underline" data-toggle="modal" data-target="#privacy_modal"  > Privacy policy </a>  and <a href="" style="text-decoration: underline" data-toggle="modal" data-target="#social_modal"  > Social policy </a>   as required by Pokerace Pty Ltd.</label> 
                   
              
            </div>
             <div class="modal-footer">
                 
                <button class="btn btn-danger"> Cancel </button>       
                <button class="btn btn-primary" onclick="nickname()"> Submit  </button>
             </div>
    </div>
  </div>
</div>
  <!--- 18 and over --->
   <div class="modal fade" id="age_accept" tabindex="-1" role="dialog" aria-labelledby="age_accept" aria-hidden="true">
    <div class="modal-lg modal-dialog"  >
        <div class="modal-content">
            <div class="modal-header">
           
            </div>
            <div class="modal-body">
                <p> Please declare that I am over 18/21 years of age whichever is permitted by my country/state law and that I am permitted to play games of chance for fun  </p>         
            </div>
             <div class="modal-footer">
                 
               
             </div>
    </div>
  </div>
</div>
  
  <!--Login Registration google+ -->
   <div class="modal fade" id="login_popup3" tabindex="-1" role="dialog" aria-labelledby="login_popup2" aria-hidden="true">
    <div class="modal-md modal-dialog" style="background:#070D0D" >
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h4 class="modal-title" id="myModalLabel" style="color:#E77817"> Setting up Account</h4>
            <div id="error_message3"> </div>
            </div>
            <div class="modal-body">
                <h3> Please choose nickname </h3>
                <br/>
                <div class="row">
                                 <div class="col-xs-4">
                                     <label for="gnname" > &nbsp; &nbsp; Screen Name:</label> </div>
                            <div class="col-xs-8">    
                                <input  type="text" name="gnname" id="gnname" placeholder="Screen name" value="" style="color:#000000"> </div>
                           <br>
                            </div>
                <br/>
              
            </div>
             <div class="modal-footer">
                 
                <button class="btn btn-danger"> Cancel </button>       
                <button class="btn btn-primary" onclick="gnickname()"> Submit  </button>
             </div>
    </div>
  </div>
</div>
  
   <div class="modal fade" id="forgot" tabindex="-1" role="dialog" aria-labelledby="forgot" aria-hidden="true">
       <div class="modal-md modal-dialog" style="background:#070D0D" >
           <div class="modal-content">
           <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
               <h4 class="modal-title" id="myModalLabel" style="color:#E77817"> Racing Poker&trade; Login</h4>
            <div id="error_message_forgot"> </div>
            </div>
                <div class="modal-body">
                    
                    <div class="row container" id="message">
                        
                    </div>
                    <div id="email_forgot_message" class="row container">
                        <p> We would like to send an email to your email address with login credentials </P>
                    </div>
                <div class="row">
                    <div class="col-xs-3"> 
                        <p>  Email Address: </p>
                        
                    </div>
                    <div class="col-xs-9">
                        <input  type="email"  id="email_forgot" placeholder="Email" value="" style="color:#000000">
                        <button type="button"  onclick="email_password()" class="btn btn-success"> Send </button>
                    </div>
                    
                </div>
                    <div class="row container" >
                        
                    </div>
                </div>      
           </div>
       </div>
   </div>
  
  
  <!--footer---------->
   <div class="row"> 
   <div class="footer" >
      <div class="container" >
          <p class="text-muted" style="color:#fff;text-align: center;"> <span> <kbd> 18+ </kbd> &nbsp;</span> <span> | </span> <span> Secured by  <img src="/images/paypal_curved.png"  height="30"/> </span> | <span> &COPY;</span> <span> Copy rights (1999 - 2016) reserved by Pokerace Pty Ltd </span> </p>
      </div>
    </div>
    </div>
     <script type="text/javascript" src="/Login_script.js" > </script>
    <script type="text/javascript" src="/load_recent_winners.js" > </script>
    <script type="text/javascript" src="/load_top_players.js" > </script>
    <script type="text/javascript" src="/Google_signin.js" > </script>
    <script src="/age_check.js" > </script>
    <script src="https://apis.google.com/js/platform.js?onload=handleClientLoad"></script>
    <!-- FIXME:  handleClientLoad will not be called 
    <script src="//www.google.com/jsapi?key=AIzaSyCTiOaoXN_cL4gkwUjV32B_gsj1-B_1M-U&onload=handleClientLoad" -->
    <!-- <script src="/client.js?onload=handleClientLoad"></script> -->
</body>
</html>