<%@ taglib tagdir="/WEB-INF/tags" prefix="rp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- style -->
<link rel="stylesheet" href="/css/v2/style.css" />
<link rel="stylesheet" href="/css/v2/selectordie.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/css/v2/slick.css" type="text/css" />
<link rel="stylesheet" href="/css/v2/slick-theme.css" type="text/css" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">

<!--[if lt IE 9]>
<script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="//oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
<style>
	.overlay {
		z-index: 5100 !important;
	}
	html, body {
		min-width: 320px !important;
		background-color: #202020;
	}
	.popup-mode1.popup-video {
		max-height: 100% !important;
	}
</style>
<!-- Mobile layout fixes submitted by Theo -->
<style>
	@media screen and (max-width: 767px) {
	    .overlay-close {
			/*only required on narrow screens*/
	    	position: relative;
	    	right: 25px;
		}
	    .profile .main .tabs-body-tab .profile-info {
	        padding-left: 5px;
	        padding-right: 5px;
	        width: 100%;
	    }
	
	    .form-profile-rewrite .row, .form-profile-rewrite {
	        width: 100%;
	    }
	
	    .profile .main .tabs-nav p {
	        margin-right: 0;
	        padding-left: 10px;
	        padding-right: 10px;
	        flex-basis: 23%;
	        text-align: center;
	    }
	
	    .profile .main .tabs-nav {
	        display: flex;
	        justify-content: space-between;
	    }
	
	    .landing-v1 .main .one-third-boxes .one-third .img-holder {
	        float: none;
	        display: table-cell;
	        width: 40%;
	        position: relative;
	        border-bottom-left-radius: 5px;
	    }
	
	    .landing-v1 .main .one-third-boxes .one-third .img-holder img {
	        height: 130px;
	        width: auto;
	        position: absolute;
	        left: 0;
	        top: 0;
	        bottom: 0;
	        float: none;
	        max-width: none;
	    }
	
	    .landing-v1 .main .one-third-boxes .one-third .info-holder {
	        padding: 15px 25px 15px 15px;
	        display: table-cell;
	        vertical-align: middle;
	        position: relative;
	        border-top-left-radius: 0;
	        border-bottom-left-radius: 0;
	        width: 240px;
	    }
	
	    .landing-v1 .main .one-third-boxes .one-third .info-holder a span {
	        position: absolute;
	        right: 4px;
	        top: 50%;
	        transform: translateY(-50%);
	    }
	
	    .profile-stats .profile-stats-progress {
	        height: auto;
	        padding-bottom: 15px;
	    }
	
	    .profile-stats .profile-stats-progress-bar {
	        float: none !important;
	        margin-right: 0;
	        width: 100%;
	        height: auto;
	    }
	
	    .profile-stats-progress-bar div {
	        width: 100%;
	    }
	
	    .profile-stats-progress-bar p {
	        margin-top: 10px;
	    }
	
	    .profile-stats-credits p {
	        width: 100%;
	        float: none;
	        display: block;
	        text-align: left;
	        margin: 10px 0;
	    }
	
	    .profile-stats .profile-stats-credits {
	        height: auto;
	    }
	}
</style>