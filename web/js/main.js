/*
    Main JS
*/

function detectSize() {

    var windowWidth = $(window).width();

    if (windowWidth < 576) {
        $('body').removeClass('phablet').addClass('mobile');
    } else if (windowWidth > 575 && windowWidth < 767) {
        $('body').removeClass('mobile').addClass('phablet');
    } else if (windowWidth > 766 && windowWidth < 991) {
        $('body').removeClass('phablet').addClass('tablet');
    } else {
        $('body').removeClass('mobile').removeClass('phablet').removeClass('tablet');
    }

    // level select
    if ($('.js-drop-down').length > 0) {
        if (windowWidth <= 752) {
            $('.js-drop-down').hide();
        } else {
            $('.js-drop-down').show();
        }
    }

    if ($('.profiles-table-mobile').length > 0) {
        if (windowWidth > 991) {
            $('.profiles-table-mobile').removeClass('active').hide();
            $('#toggle-leaderboar').text( "View leaderboard" );
        }
    }

}

// popup-form-overlay
function popup(trigger, popupName, overlayName, bodylocked = false) {
    $('.' + trigger).click(function(e) {
        e.preventDefault();
        $('.' + overlayName).css({
            display: 'block',
        });
        // body locked/ not scrolling when popup is active
        if (bodylocked == true) {
            $('body').addClass('locked');
        }

        // stop propagation/ prevent close of popup,on form slick
        $('.' + popupName).click(function(e){
            e.stopPropagation();
        });

        // overlay click/ close popup
        $('.' + overlayName).click(function() {
            $('.' + overlayName).css({
                display: 'none'
            });
            if (bodylocked == true) {
                $('body').removeClass('locked');
            }
        });

        // when forgot pass links clicked, log in popup hide
        $('.js-forgot-password').click(function() {
            $('.overlay-log-in').hide();
        });

    });
}


// leaderboard toggle
function leaderboardToggle() {
    $('#toggle-leaderboar').click(function(e) {
        e.preventDefault();
        var text = $('#toggle-leaderboar').text();
        $('#toggle-leaderboar').text(
        text == "View leaderboard" ? "Hide leaderboard" : "View leaderboard");

        if ($('body').hasClass('mobile') || $('body').hasClass('phablet') || $('body').hasClass('tablet')) {
            if ($('.profiles-table-mobile').hasClass('active')) {
                $('.profiles-table-mobile').removeClass('active').slideUp();
            } else {
                $('.profiles-table-mobile').removeClass('active').slideUp();
                $('.profiles-table-mobile').addClass('active').slideDown();
            }
        };
    });
}

window.ensureMusicStarted = function() {
    if (window._audioStartRequired) {
		window._audioStartRequired = false;
		playingList("audioplayer-two");
	}
};


// audio controls
function playerControls( playerNumber, muteButton, volumeBarNumber )  {
	try {
		let prefix = muteButton == 'audio-icon' ? "rp.music" : "rp.speech"
	    var $aud = $('.'+playerNumber + ' .audio'),
	        $pp  = $('.'+playerNumber + ' .'+muteButton),
	        $vol = $('.' +volumeBarNumber),
	        // $bar = $('.'+playerNumber+'#progressbar'),
	        AUDIO= $aud[0];
	
	    AUDIO.volume = 0.5;
	    if (window.localStorage && localStorage.getItem(prefix + ".volume")) {
	    	AUDIO.volume = localStorage.getItem(prefix + ".volume");
        }
	    // AUDIO.addEventListener("timeupdate", progress, false);
	
	    // function progress() {
	    //   $bar.slider('value', ~~(100/AUDIO.duration*AUDIO.currentTime));
	    // }
	
	    $vol.slider( {
	      value : AUDIO.volume*100,
	      slide : function(ev, ui) {
	        AUDIO.volume = ui.value/100;
	        if (window.localStorage) {
	        	localStorage.setItem(prefix + ".volume", AUDIO.volume);
	        }
	      }
	    });
	
	    $('.'+muteButton).click(function (e) {
	        $('.'+muteButton).toggleClass('active');
	        //AUDIO.muted = !AUDIO.muted;
	        AUDIO.muted = $('.'+muteButton).hasClass('active');
	        if (window.localStorage) {
	        	if (AUDIO.muted) {
	        		localStorage.removeItem(prefix + ".enabled");
	        		localStorage.setItem(prefix + ".muted", true);
	        	}
	        	else {
	        		localStorage.removeItem(prefix + ".muted");
	        		localStorage.setItem(prefix + ".enabled", true);
	        	}
	        }
	        
	        if (!AUDIO.muted) {
	        	if (window._audioStartRequired && playerNumber.indexOf("-two") != -1) {
		    		window._audioStartRequired = false;
		    		playingList("audio" + playerNumber);
		    	}
	        }
	        
	        return false;
	    });
	
	    //volume bar event
	    var volumeDrag = false;
	    $('.' +volumeBarNumber).on('mousedown', function (e) {
	        volumeDrag = true;
	        AUDIO.muted = false;
	        if (window.localStorage) {
	        	localStorage.removeItem(prefix + ".muted");
	        	localStorage.setItem(prefix + ".enabled", true);
	        }
	        updateVolume(e.pageX);
	        $('.'+muteButton).removeClass('active');
	    });
	    $(document).on('mouseup', function (e) {
	        if (volumeDrag) {
	            volumeDrag = false;
	            updateVolume(e.pageX);
	        }
	    });
	    $(document).on('mousemove', function (e) {
	        if (volumeDrag) {
	            updateVolume(e.pageX);
	        }
	    });
	    var updateVolume = function (x, vol) {
	    	if (window._audioStartRequired && playerNumber.indexOf("-two") != -1) {
	    		window._audioStartRequired = false;
	    		playingList("audio" + playerNumber);
	    	}
	    	
	    	var volume = $('.' +volumeBarNumber);
	        var percentage;
	        //if only volume have specificed
	        //then direct update volume
	        if (vol) {
	            percentage = vol * 100;
	        } else {
	            var position = x - volume.offset().left;
	            percentage = 100 * position / volume.width();
	        }
	
	        if (percentage > 100) {
	            percentage = 100;
	        }
	        if (percentage < 0) {
	            percentage = 0;
	        }
	
	        //update volume bar and video volume
	        AUDIO.volume = percentage / 100;
	        if (window.localStorage) {
	        	localStorage.setItem(prefix + ".volume", AUDIO.volume);
	        }
	
	        //change sound icon based on volume
	        if (AUDIO.volume == 0) {
	            $('.'+muteButton).addClass('active');
	            if (window.localStorage) {
		        	localStorage.removeItem(prefix + ".enabled");
		        	localStorage.setItem(prefix + ".muted", true);
		        }
	        } else {
	            $('.'+muteButton).removeClass('active');
	            if (window.localStorage) {
		        	localStorage.removeItem(prefix + ".muted");
		        	localStorage.setItem(prefix + ".enabled", true);
		        }
	        }
	    };
	}
	catch (ignored) {} 
}

// random playing list
function playingList(audioId) {
	try {
	    var lastSong = null;
	    var selection = null;
	    var playlist = []; // List of Songs
	
	    for (var i = 1; i <= $('#' +audioId+ ' source').length; i++) {
	        var songCatch = $('#' +audioId+ ' source:nth-child('+i+')').attr("src");
	        playlist.push(songCatch);
	    }
	
	    var player = document.getElementById(audioId); // Get Audio Element
	    player.autoplay=true;
	    player.addEventListener("ended", selectRandom); // Run function when song ends
	
	    function selectRandom(){
	        while(selection == lastSong){ // Repeat until different song is selected
	            selection = Math.floor(Math.random() * playlist.length);
	        }
	        lastSong = selection; // Remember last song
	        player.src = playlist[selection]; // Tell HTML the location of the new Song
	
	    }
	
	    selectRandom(); // Select initial song
	    player.play(); // Start Song
	}
	catch (ignored) {}
}

// popup-form-overlay
function popupButtonClose(trigger, popupName, overlayName, closeButton, bodylocked = false) {
    $('.' + trigger).click(function(e) {
        e.preventDefault();
        $('.' + overlayName).css({
            display: 'block',
        });
        // body locked/ not scrolling when popup is active
        if (bodylocked == true) {
            $('body').addClass('locked');
        }

        // stop propagation/ prevent close of popup,on form slick
        $('.' + popupName).click(function(e){
            e.stopPropagation();
        });

        // overlay click/ close popup
        $('.' + closeButton).click(function() {
            $('.' + overlayName).css({
                display: 'none'
            });

            if (bodylocked == true) {
                $('body').removeClass('locked');
            }
        });

    });
}

// level selec drop down
function levelSelect() {

    $('.game-level-info-helper').click(function() {

        if ($('body').hasClass('mobile') || $('body').hasClass('phablet')) {

            if ($(this).hasClass('active')) {
                $(this).removeClass('active').find('.js-drop-down').slideUp();
            } else {
                $('.game-level-info-helper').removeClass('active').find('.js-drop-down').slideUp();
                $(this).addClass('active').find('.js-drop-down').slideDown();
            }

            $('.js-drop-down').click(function(e){
                e.stopPropagation();
            });
        }
    });
}

$(document).ready(function() {

    detectSize();

    // retina images
    if (window.devicePixelRatio > 1) {

        var images = $('img.retina');

        for(var i = 0; i < images.length; i++) {

            var imageType = images[i].src.substr(-4);
            var imageName = images[i].src.substr(0, images[i].src.length - 4);
            imageName += "-2x" + imageType;
            images[i].src = imageName;

        }

    }

    // tabs
    $('.js-tabs-tab').click(function() {
        $(this).addClass('nav-tab-active').siblings().removeClass('nav-tab-active');
        var tabId = $(this).data('tab-active');
        $('.tabs-tab').hide();
        $('#tab-'+tabId).fadeIn('slow');
    });

    // mobile-menu
    $('.toggle-nav').click(function() {
        $('.mobile-menu').addClass('active');
        $('body').addClass('locked');
    });

    $('.mobile-menu-content-header .close-menu').click(function() {
        $('.mobile-menu').removeClass('active');
        $('body').removeClass('locked');
    });

    // auto tabs changer
    window.autoTabs = setInterval(
        function(){
            var tabsCount = $('.auto-switch').length;
            i++;
            $('.auto-switch[data-tab-active=' + i + ']').trigger('click');
            if ( i > tabsCount) {
                i = 1;
                $('.auto-switch[data-tab-active=' + i + ']').trigger('click');
            }
            $('.auto-switch').click(function() {
                if ($(this).data('tab-active') != i) {
                    i = $(this).data('tab-active')
                }
            });
        },
        5000, i = 1  /* 5000 ms = 5 sec */
    );

    // check if it have on page .custom-select
    if ($('.custom-select').length > 0) {
        $('.custom-select').selectOrDie();
    }

    // deal button fade-out/fade-in
    //$('.js-deal-trigger').click(function(e) {
    //    e.preventDefault();
    //    $('.js-timer').toggleClass('fadeIn-Out');
    //    $('.js-deal').toggleClass('button-fade');
    //
    //});
    
//    // slick slider on landing game 2 page
//    if ($('.js-game-level').length > 0) {
//        $('.js-game-level').slick({
//            infinite: true,
//            slidesToShow: 4,
//            slidesToScroll: 1,
//            // dots: true,
//            responsive: [
//                {
//                  breakpoint: 991,
//                  settings: {
//                      slidesToShow: 2,
//                      slidesToScroll: 1,
//                  }
//                },
//                {
//                  breakpoint: 768,
//                  settings: "unslick",
//                }
//
//            ]
//        });
//        $(window).resize(function() {
//            $('.js-game-level').slick('resize');
//        });
//    }

    playerControls('player-two', 'audio-icon', 'player-two-volume');
    playerControls('player-one', 'volume-icon', 'player-one-volume');
    levelSelect();
    leaderboardToggle();
    
    popup('js-log-in-form', 'popup-form-log-in', 'overlay-log-in', false);
    popupButtonClose('js-forgot-password', 'popup-forgot-password', 'overlay-forgot-password', 'popup-forgot-password .close-button',false);
    popupButtonClose('js-submit-bid', 'popup-bet', 'overlay-bet', 'popup-bet .close-button', true );

    //messages
    if (window.location.href.indexOf("purchaseCanceled") != -1) {
    	$(".overlay-purchase-canceled").show();
    }
    else if (window.location.href.indexOf("purchaseCompleted") != -1) {
    	$(".overlay-purchase-completed").show();
    }
    else if (window.location.href.indexOf("profileUpdated") != -1) {
    	$(".overlay-profile-updated").show();
    }
});

$(window).resize(function() {


    detectSize();

});