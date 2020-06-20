<!-- popup-login -->
<style>
	.overlay-login label {
		width: 80px;
	}
	@media (min-width:1400px) {
    	.tutorialVideo {
       		width: 1280px;
       		height: 720px;	 	
    	}
    	.popup-mode1.popup-video {
    		width: 1360px;
    	}
    }
    @media (min-width:800px) and (max-width:1399px) {
    	.tutorialVideo {
       		width: 640px;
       		height: 480px;	 	
    	}
    	.popup-mode1.popup-video {
    		width: 720px;
    	}
    }
    @media (min-width:500px) and (max-width:799px) {
     	.tutorialVideo {
       		width: 480px;
       		height: 320px;	 	
    	}
    	.popup-mode1.popup-video {
    		width: 520px;
    	}
    }
    @media (max-width:499px) {
     	.tutorialVideo {
       		width: 256px;
       		height: 144px;	 	
    	}
    	.popup-mode1.popup-video {
    		width: 296px;
    	}
    }
</style>
<div class="overlay overlay-profile-updated">
    <div class="popup-name popup-mode1">
        <p class="popup-mode1-title">Purchase Updated <i class="fa fa-times-circle overlay-close" onclick="$('.overlay-profile-updated').hide();" aria-hidden="true"></i></p>
        <div class="popup-mode1-content">
        	Your profile was updated successfully!
        </div>
        <a href="javascript:void(0)" onclick="$('.overlay-profile-updated').hide();" class="btn btn-green inlineButton">Okay</a>
    </div>
</div>
<div class="overlay overlay-purchase-canceled">
    <div class="popup-name popup-mode1">
        <p class="popup-mode1-title">Purchase Canceled <i class="fa fa-times-circle overlay-close" onclick="$('.overlay-purchase-canceled').hide();" aria-hidden="true"></i></p>
        <div class="popup-mode1-content">
        	Your purchase was canceled successfully.
        </div>
        <a href="javascript:void(0)" onclick="$('.overlay-purchase-canceled').hide();" class="btn btn-green inlineButton">Okay</a>
    </div>
</div>
<div class="overlay overlay-purchase-completed">
    <div class="popup-name popup-mode1">
        <p class="popup-mode1-title">Purchase Successful <i class="fa fa-times-circle overlay-close" onclick="$('.overlay-purchase-completed').hide();" aria-hidden="true"></i></p>
        <div class="popup-mode1-content">
        	Your purchase was successful. If you don't see your new credits yet, don't panic!<br />
        	<br />
        	Your account balance will update upon final confirmation from Paypal.  This usually only takes a few seconds!
        </div>
        <a href="javascript:void(0)" onclick="$('.overlay-purchase-completed').hide();" class="btn btn-green inlineButton">Okay</a>
    </div>
</div>
<div class="overlay overlay-tutorial">
    <div class="popup-name popup-mode1 popup-video">
        <p class="popup-mode1-title">Video Tutorial <i class="fa fa-times-circle overlay-close" onclick="stopTutorialVideo(); $('.overlay-tutorial').hide();" aria-hidden="true"></i></p>
        <div class="popup-mode1-content">
        	<!-- 
        	<iframe class="tutorialVideo" src="https://www.youtube.com/embed/tu_KWNZk8zY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        	 -->
        	 <div class="tutorialVideo" id="tutorialVideo"></div>
        </div>
    </div>
</div>

<!--  popup-log-in -->
<div class="overlay overlay-log-in">
	<script type="text/javascript" src="/facebooklogin_script.js" > </script>
    <div class="popup-form-log-in popup-mode3 custom-scroll">
    	<div class="loginHeader" style="margin-top: 10px; position: relative;">
    		<i class="fa fa-times-circle overlay-close" onclick="$('.overlay-log-in').hide();" aria-hidden="true" style="position: absolute; top: 3px; right: 3px;"></i>
        	<img src="/images/v2/singup-photo.jpg" alt="chips-photo">
        </div>
        <div id="error_message"> </div>
        <div class="popup-form-log-in-inner popup-mode3-inner">
            <div class="fb-login-button" data-width="287" data-max-rows="1" data-size="large" data-button-type="login_with" data-show-faces="false" data-auto-logout-link="false" data-use-continue-as="false" data-onlogin="checkLoginState();"></div>
            <a id="google_plus" onclick="handleAuthClick()" href="javascript:void(0)" class="btn full" style="background-color: #4285f4; text-align: left; margin-top: 4px; border-radius: 4px; padding-left: 7px; font-weight: normal; font-size: 16px; max-width: 288px;"><span><img src="/images/v2/google_signin_logo.png" /></span>
            	<span class="googleSignin" style="margin-left: 44px; color: white !important;">Log in with Google</span>
            </a>
            <form id='login_form' class="contact-form clear clearfix popup-form" action="Login_form" method="post" onsubmit="return false;">
                <input type="text" name="email_login" id="email_login" class="name" placeholder="Email address">
                <input type="password" name="password_login" id="password_login" class="pass" placeholder="Password">
                <input class="btn" type="submit" onclick="login();" value="Login">
            </form>
            <a href="javascript:void(0)" class="forgot-link js-forgot-password" onclick="$('.overlay-log-in').hide(); $('#forgot').modal('show');">Forgot Password?</a>
            <a href="/r/registrationPage" class="btn full" style="background-color: #3291ea; margin-bottom: 5px;">Sign Up</a>
            <a href="/r/guestModeV2" class="btn btn-orange full">Try Me</a>
            <p class="disclaimer">By logging in or creating an account you agree to our Terms and Conditions. Racingpoker.com is an adult site intended for players aged 18 or over. We do not offer real money gambling or an opportunity to win real money or prizes. Practice or success does not imply future success at real money gambling. All rights reserved Poker Ace Pty Ltd. Racing Poker® is a registered trademark.</p>
        </div>
    </div>
</div>
<!--  popup-log-in -->
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
                     <p>We would like to send an email to help you recover your account</p>
                 </div>
             <div class="row">
                 <div class="col-xs-3"> 
                     <p>Email Address:</p>
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
<!-- 
<div class="overlay overlay-forgot">
    <div class="popup-name popup-mode1">
        <p class="popup-mode1-title">Racing Poker&trade; Login <i class="fa fa-times-circle overlay-close" onclick="$('.overlay-forgot').hide();" aria-hidden="true"></i></p>
        <div class="popup-mode1-content">
        	<div id="error_message"> </div>
        	<div class="row container" id="message">
                        
            </div>
            <div id="email_forgot_message" class="row container">
                <p> We would like to send an email to your email address to help you recover your password.</p>
            </div>
            <div class="row">
                <div class="col-xs-3"> 
                    <p>Email Address:</p>
                </div>
                <div class="col-xs-9">
                    <input  type="email"  id="email_forgot" placeholder="Email" value="" style="color:#000000">
                    <button type="button"  onclick="email_password()" class="btn btn-success"> Send </button>
                </div>
            </div>
        </div>
    </div>
</div>
-->
<script type="text/javascript" src="/Google_signin.js" > </script>
<script src="https://apis.google.com/js/platform.js?onload=handleClientLoad"></script>
<!-- FIXME:  handleClientLoad will not be called 
<script src="//www.google.com/jsapi?key=AIzaSyCTiOaoXN_cL4gkwUjV32B_gsj1-B_1M-U&onload=handleClientLoad" -->
<!-- <script src="/client.js?onload=handleClientLoad"></script> -->
<script type="text/javascript" src="/Login_script.js" > </script>
<script>
	// 2. This code loads the IFrame Player API code asynchronously.
	var tag = document.createElement('scr' + 'ipt');

	tag.src = "https://www.youtube.com/iframe_api";
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

	// 3. This function creates an <iframe> (and YouTube player) after the API code downloads.
	var player;
	function onYouTubeIframeAPIReady() {
  		player = new YT.Player('tutorialVideo', {
  			//width: $(".tutorialVideo").width() + '',
  		    //height: $(".tutorialVideo").height() + '',
    		videoId: 'tu_KWNZk8zY',
    		events: {
      			'onReady': onPlayerReady,
      			'onStateChange': onPlayerStateChange
    		}
  		});
	}

	// 4. The API will call this function when the video player is ready.
	function onPlayerReady(event) {
  		//event.target.playVideo();
	}

	// 5. The API calls this function when the player's state changes.
	//    The function indicates that when playing a video (state=1),
	//    the player should play for six seconds and then stop.
	//var done = false;
	function onPlayerStateChange(event) {
	  //if (event.data == YT.PlayerState.PLAYING && !done) {
	  //  setTimeout(stopVideo, 6000);
	  //  done = true;
	  //}
	}

	window.stopTutorialVideo = function() {
		if (player) {
			player.stopVideo();
		}
	};
</script>
<!-- /popup-login -->
