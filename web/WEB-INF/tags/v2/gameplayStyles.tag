<%@ taglib tagdir="/WEB-INF/tags" prefix="rp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
		.pulsate-fwd {
			-webkit-animation: pulsate-fwd 1s linear infinite both;
			        animation: pulsate-fwd 1s linear infinite both;
		}
		
		/**
		 * ----------------------------------------
		 * animation pulsate-fwd
		 * ----------------------------------------
		 */
		@-webkit-keyframes pulsate-fwd {
		  0% {
		    -webkit-transform: scale(1);
		            transform: scale(1);
		  }
		  50% {
		    -webkit-transform: scale(1.1);
		            transform: scale(1.1);
		  }
		  100% {
		    -webkit-transform: scale(1);
		            transform: scale(1);
		  }
		}
		@keyframes pulsate-fwd {
		  0% {
		    -webkit-transform: scale(1);
		            transform: scale(1);
		  }
		  50% {
		    -webkit-transform: scale(1.1);
		            transform: scale(1.1);
		  }
		  100% {
		    -webkit-transform: scale(1);
		            transform: scale(1);
		  }
		}
		
		.pulse-red {
    		-webkit-animation: pulse-red 2s infinite;
		}
		@-webkit-keyframes pulse-red {
		  0% {
		    background-color: rgba(192, 0, 0, 0.65);
		  }
		  50% {
		    background-color: rgba(192, 0, 0, 0.65);
		  }
		  100% {
		    background-color: rgba(192, 0, 0, 0.0);
		  }
		}
		
		.pulse-white {
    		-webkit-animation: pulse-white 500ms infinite;
		}
		@-webkit-keyframes pulse-white {
		  0% {
		    background-color: rgba(255, 255, 255, 0.65);
		  }
		  25% {
		    background-color: rgba(255, 255, 255, 0.65);
		  }
		  100% {
		    background-color: rgba(255, 255, 255, 0.0);
		  }
		}
		
		.spin {
    		-webkit-animation: spin 2500ms infinite;
    		-webkit-animation-timing-function: linear;
		}
		@-webkit-keyframes spin {
		  /*0% {
		  	transform: rotate(0deg);
		  }
		  50% {
		  	transform: rotate(180deg);
		  }
		  100% {
		  	transform: rotate(359deg);
		  }*/
		  
		  /*0% { transform: rotateY(0deg); }
   		  100% { transform: rotateY(360deg); }*/
		}
		
		p.mobileInGameTimer {
		    margin: 0;
		}
		
		.profiles-table-mobile li {
		    position: relative;
		}
		
		.profiles-table li {
		    margin: 6px 0;
		}
		
		
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

       	dfn {
       		font-style: normal;
       	}
       	.card-holder .result {
       		min-width: 160px;
       	}
       	.card-holder .cards .card img {
       		vertical-align: inherit;
       	}
       	.currentPlayer {
       		background-color: rgba(0, 96, 0, 0.5);
		    padding-top: 5px;
		    padding-bottom: 5px;
		    padding-right: 15px;
		    margin-right: -15px !important;
       	}
       	.popup-mode1 .inlineButton {
       		display: inline-block;
       		width: auto;
       		min-width: 130px;
       		color: white;
       	}
       	.disabledChip {
       		opacity: 0.20;
       		cursor: inherit;
       	}
       	.disabledChip:hover {
       		color: #525252 !important;
       		background-color: #fff !important;	
       	}
       	.submit-bid[disabled] {
		    background-color: #ccc;
		    opacity: 0.5;
		}
		.submit-bid[disabled]:hover {
		    background-color: #ccc;
		    opacity: 0.5;
		    transform: none;
		}
		.handLabel {
		    display: inline-block;
		    position: relative;
		    top: -30px;
		    padding-right: 10px;
		    font-weight: bold;
		    font-size: 15px;
		    height: 0px;
		}
		.main-table-list-item .cards {
			cursor: pointer;
		}
		.advertising {
			background-color: rgba(0,0,0, 0.3);
			min-height: 50px;
			line-height: 50px;
			text-align: center;
		}
		.topBannerAd {
		    margin-top: -10px;
		    margin-bottom: 10px;
		    max-width: 1170px;
		    margin-left: auto;
		    margin-right: auto;
		}
		.bottomBannerAd {
			width: 100%;
		    max-width: 1170px;
		    position: fixed;
		    bottom: 20px;
		    left: 50%;
		    transform: translateX(-50%);
		    z-index: 100;
		}
		.rightColumnAd {
		    margin-bottom: 15px;
		    min-height: 150px;
		    line-height: 150px;
		}
       	
       	.horse {
		    position: absolute;
		    left: 10px;
		    display: none;
		}
		.horse1 {
		    top: 70px;
		}
		.horse2 {
		    top: 90px;
		}
		.horse3 {
		    top: 110px;
		}
		.horse4 {
		    top: 130px;
		}
		.horse5 {
		    top: 150px;
		}
		.horse6 {
		    top: 170px;
		}
		
		.fastForwardButton button {
		    background-color: #f26522;
		    border-radius: 4px;
		    border: none;
		    position: absolute;
		    top: 17px;
		    right: 74px;
		    font-weight: normal;
		    text-transform: uppercase;
		}
		
		.fastForwardButton button::after {
   			/*content: "\23ed";*/
   			content: url('/images/v2/skip-icon.png');
		}
		
		.dealButton input.disabled {
		    opacity: 0.25;
		    cursor: default;
		}
		
		.btn {
			padding: 8px 16px;
		}
		.overlay {
			z-index: 50;
		}
		.overlay-close {
			float: right;
			cursor: pointer;
		}
		.player {
			padding-top: 28px;
		}
		
		#social_media {
			margin-top: 10px;
		}
		#fb-root {
			margin-bottom: 4px;
		}
		.in-game .main .main-table>img {
		    float: left;
		    width: 100%;
		    height: 208px !important;
		}
		.popup-bet-content .card-holder p {
		    display: inline-block;
		    float: right;
		    font-size: 16px;
		    margin-right: 30px;
		    margin-top: 5px;
		    max-width: 155px;
		    max-height: 105px;
		}
		.timer-holder.clearfix {
			display: none;
		}
		.inGameTimer {
		    width: 75px !important;
		    position: absolute !important;
		    top: 29px !important;
		    left: 48%;
		    right: 52%;
		}
		/*.inGameTimer span {
			font-size: 14px;
			max-height: 19px;
			height: 19px;
			display: inline-block;
			line-height: 14px;
		}*/
		@media (max-width: 575px) {
			.header-wrapper {
				height: 65px;
			}
		}
		.tabs .buttons.dealButton {
			display: none !important;
		}
		.tutorialBackground {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			background-color: black;
			z-index: 2345;
			opacity: 0.5;
		}
		.tutorialImage {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			z-index: 3456;
		}
		.tutorialImage img {
			width: 100%;
			height: 100%;
			max-width: 100%;
			max-height: 100%;
		}
		.tutorialOverlay {
			display: none;
			cursor: pointer;
		}
		.tutorialOverlayVisible {
			display: block;
		}
		.timer-holder.helpButton {
			top: 35px;
    		left: -20px;
		}
		.timer-holder.helpButton input.btn {
			width: 100px;
   			padding-top: 3px;
    		padding-bottom: 3px;
		}
		.itemHolder {
			display: none;
		}
		.mobile-menu {
			z-index: 5000 !important;
		}
		.trackImage {
		    position: relative;
		    z-index: 1;
		}
		.track img {
		    z-index: 1;
		}
		.tutorialOptIn {
    		-webkit-appearance: checkbox;
    		position: relative;
    		top: 2px;
		}
		.overlay .interactiveTutorial {
			font-size: 14px;
			color: #bbb;
		}
		.card-holder .bid {
			max-width: 100px;
    		white-space: nowrap;
		}
		@media (max-width: 1142px) {
			.interactiveTutorial,
			.interactiveTutorialItem {
				display: none !important;
			}
			.tutorialImageFullres {
				display: none !important;
			}
			.timer-holder.helpButton {
				display: none !important;
			}
		}
</style>