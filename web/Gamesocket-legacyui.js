//UI functions
function show_image(card, hand_number, odds, hand_card_count1, usefull3, state) {
    var card_id = "im" + (((hand_number - 1) * 5) + hand_card_count1);
    if (card == "/images/ad.gif") {
        card = "/images/da.gif";
    }
    if (options.isSinglePlayer) {
    	setTimeout(function() {
            document.getElementById(card_id).src = card;
        }, 10);
    }
    else if (state.stats.running_deal_number > 1) {
        setTimeout(function() {
            document.getElementById(card_id).src = card;
        }, 400);
    }
    else {
    	document.getElementById(card_id).src = card;
    }
    
    var width = screen.width;
    if (usefull3 === true) {
        var im_id = document.getElementById(card_id);
        $(im_id).fadeOut(400);
        $(im_id).fadeIn();
    }
}
function move_horse(odds, hand_number, state) {
    var width_window = $(document).width();
    if (width_window > 1024) {
        width_window = 1024;
    }
    if (odds < 0) {
        var divhodd = "hodd" + hand_number;
        var imageId = document.getElementById(divhodd);
        imageId.style.position = 'relative';
        if (state.stats.running_deal_number > 0 && odds < 0)
            var cal_odds = 16 / 2;
        else
        if (odds != 0)
            var cal_odds = 4.0;
        else
            var cal_odds = 16.0;
        var x = parseInt(width_window) / 47;
        x = parseInt(x) + 1;
        var cal_margin = (x * cal_odds);
        imageId.src = "/images/" + "0" + hand_number + "lose.gif";
        if (hand_number == 1) {
            imageId.style.left = "0px";
            cal_margin = "" + (cal_margin - 0) + "px";;
        }
        if (hand_number == 2) {
            imageId.style.left = "-57px";
            cal_margin = "" + (cal_margin - 57) + "px";
        }
        if (hand_number == 3) {
            imageId.style.left = "-114px";
            cal_margin = "" + (cal_margin - 114) + "px";
        }
        if (hand_number == 4) {
            imageId.style.left = "-171px";
            cal_margin = "" + (cal_margin - 171) + "px";
        }
        if (hand_number == 5) {
            imageId.style.left = "-228px";
            cal_margin = "" + (cal_margin - 228) + "px";
        }
        if (hand_number == 6) {
            imageId.style.left = "-285px";
            cal_margin = "" + (cal_margin - 285) + "px";
        }
        setTimeout(function() {
            imageId.style.left = cal_margin;
        }, 400);
    }
    else {
        if (odds >= 0) {
            var divhodd = "hodd" + hand_number;
            var cal_odds = 16 - odds;
            var x = parseInt(width_window) / 35.5;
            x = parseInt(x) + 1;
            var cal_margin = (x * cal_odds);
            //  alert(cal_margin);
            var imageId = document.getElementById(divhodd);
            //  alert(imageId);
            imageId.style.position = 'relative';
            // imageId.style.left = "" +Math.floor(Math.random() * 100) +"px";

            if (hand_number == 1) {
                if (odds == 0) {
                    imageId.style.top = "-155px";
                    document.getElementById("hodd1").src = "/images/01win.gif";
                    document.getElementById("hodd2").src = "/images/02lose.gif";
                    document.getElementById("hodd3").src = "/images/03lose.gif";
                    document.getElementById("hodd4").src = "/images/04lose.gif";
                    document.getElementById("hodd5").src = "/images/05lose.gif";
                    document.getElementById("hodd6").src = "/images/06lose.gif";
                    //document.getElementById("hodd1").style.zIndex = "-1";
                }
                imageId.style.left = "0px";
                cal_margin = "" + (cal_margin - 0) + "px";;

            }
            if (hand_number == 2) {
                if (odds == 0) {
                    imageId.style.top = "-155px";
                    document.getElementById("hodd2").src = "/images/02win.gif";
                    document.getElementById("hodd1").src = "/images/01lose.gif";
                    document.getElementById("hodd3").src = "/images/03lose.gif";
                    document.getElementById("hodd4").src = "/images/04lose.gif";
                    document.getElementById("hodd5").src = "/images/05lose.gif";
                    document.getElementById("hodd6").src = "/images/06lose.gif";

                }
                imageId.style.left = "-60px";
                cal_margin = "" + (cal_margin - 60) + "px";
            }
            if (hand_number == 3) {
                if (odds == 0) {
                    imageId.style.top = "-145px";
                    document.getElementById("hodd3").src = "/images/03win.gif";
                    document.getElementById("hodd2").src = "/images/02lose.gif";
                    document.getElementById("hodd1").src = "/images/01lose.gif";
                    document.getElementById("hodd4").src = "/images/04lose.gif";
                    document.getElementById("hodd5").src = "/images/05lose.gif";
                    document.getElementById("hodd6").src = "/images/06lose.gif";

                }
                imageId.style.left = "-118px";
                cal_margin = "" + (cal_margin - 118) + "px";
            }
            if (hand_number == 4) {
                if (odds == 0) {
                    imageId.style.top = "-125px";
                    document.getElementById("hodd4").src = "/images/04win.gif";
                    document.getElementById("hodd2").src = "/images/02lose.gif";
                    document.getElementById("hodd3").src = "/images/03lose.gif";
                    document.getElementById("hodd1").src = "/images/01lose.gif";
                    document.getElementById("hodd5").src = "/images/05lose.gif";
                    document.getElementById("hodd6").src = "/images/06lose.gif";
                }
                imageId.style.left = "-176px";
                cal_margin = "" + (cal_margin - 176) + "px";
            }
            if (hand_number == 5) {
                if (odds == 0) {
                    imageId.style.top = "-105px";
                    document.getElementById("hodd5").src = "/images/05win.gif";
                    document.getElementById("hodd2").src = "/images/02lose.gif";
                    document.getElementById("hodd3").src = "/images/03lose.gif";
                    document.getElementById("hodd4").src = "/images/04lose.gif";
                    document.getElementById("hodd1").src = "/images/01lose.gif";
                    document.getElementById("hodd6").src = "/images/06lose.gif";

                }
                imageId.style.left = "-236px";
                cal_margin = "" + (cal_margin - 236) + "px";
            }
            if (hand_number == 6) {
                if (odds == 0) {
                    imageId.style.top = "-85px";
                    document.getElementById("hodd6").src = "/images/06win.gif";
                    document.getElementById("hodd2").src = "/images/02lose.gif";
                    document.getElementById("hodd3").src = "/images/03lose.gif";
                    document.getElementById("hodd4").src = "/images/04lose.gif";
                    document.getElementById("hodd5").src = "/images/05lose.gif";
                    document.getElementById("hodd1").src = "/images/01lose.gif";

                }
                imageId.style.left = "-296px";
                cal_margin = "" + (cal_margin - 296) + "px";
            }

            setTimeout(function() {
                imageId.style.left = cal_margin;
            }, 400);
        }
    }
    if (! state.options.isSinglePlayer) {
    	move_horse1(odds, hand_number, state);
    }
}
function move_horse1(odds, hand_number, state) {
    var width_window = $(document).width();
    console.log(odds);
    if (width_window > 1024) {
        width_window = 1024;
    }
    if (odds < 0) {
        if (state.stats.running_deal_number > 0) {
            var divhodd = "hodd" + hand_number + hand_number;
            var imageId = document.getElementById(divhodd);
            imageId.style.position = 'relative';
            if (state.stats.running_deal_number > 0 && odds < 0)
                var cal_odds = 16 / 2;
            else
            if (odds != 0)
                var cal_odds = 4.0;
            else
                var cal_odds = 16.0;
            var x = parseInt(width_window) / 49;
            x = parseInt(x) + 1;
            var cal_margin = (x * cal_odds);
            if (imigeId) {
            	imageId.src = "/images/" + "0" + hand_number + "lose.gif";
            }
            if (hand_number == 1) {
                imageId.style.left = "0px";
                // cal_margin =  "" +(cal_margin - 0) + "px";;
            }
            if (hand_number == 2) {
                imageId.style.left = "0px";
                ///cal_margin = "" +(cal_margin - 57) + "px";
            }
            if (hand_number == 3) {
                imageId.style.left = "0px";
                // cal_margin = "" +(cal_margin - 114) + "px";
            }
            if (hand_number == 4) {
                imageId.style.left = "0px";
                // cal_margin = "" +(cal_margin - 171) + "px";
            }
            if (hand_number == 5) {
                imageId.style.left = "0px";
                // cal_margin = "" +(cal_margin - 228) + "px";
            }
            if (hand_number == 6) {
                imageId.style.left = "0px";
                // cal_margin = "" +(cal_margin - 285) + "px";
            }
            setTimeout(function() { //imageId.style.left = cal_margin;

            }, 400);
        }
    }
    else {
        if (odds >= 0) {
            var divhodd = "hodd" + hand_number + hand_number;
            var cal_odds = 16 - odds;
            var x = parseInt(width_window) / 48;
            x = parseInt(x) + 1;
            var cal_margin = (x * cal_odds);
            //  alert(cal_margin);
            var imageId = document.getElementById(divhodd);
            //  alert(imageId);
            imageId.style.position = 'relative';
            // imageId.style.left = "" +Math.floor(Math.random() * 100) +"px";

            if (hand_number == 1) {
                if (odds == 0) {
                    //imageId.style.top = "-155px";
                    document.getElementById("hodd11").src = "/images/01win_ios.gif";
                    document.getElementById("hodd22").src = "/images/02lose_ios.gif";
                    document.getElementById("hodd33").src = "/images/03lose_ios.gif";
                    document.getElementById("hodd44").src = "/images/04lose_ios.gif";
                    document.getElementById("hodd55").src = "/images/05lose_ios.gif";
                    document.getElementById("hodd66").src = "/images/06lose_ios.gif";
                    //document.getElementById("hodd1").style.zIndex = "-1";
                }
                imageId.style.left = "0px";
                cal_margin = "" + (cal_margin - 0) + "px";;

            }
            if (hand_number == 2) {
                if (odds == 0) {
                    // imageId.style.top= "-155px";
                    document.getElementById("hodd22").src = "/images/02win_ios.gif";
                    document.getElementById("hodd11").src = "/images/01lose_ios.gif";
                    document.getElementById("hodd33").src = "/images/03lose_ios.gif";
                    document.getElementById("hodd44").src = "/images/04lose_ios.gif";
                    document.getElementById("hodd55").src = "/images/05lose_ios.gif";
                    document.getElementById("hodd66").src = "/images/06lose_ios.gif";

                }
                //imageId.style.left = "-60px";
                cal_margin = "" + (cal_margin) + "px";
            }
            if (hand_number == 3) {
                if (odds == 0) {
                    // imageId.style.top = "-145px";
                    document.getElementById("hodd33").src = "/images/03win_ios.gif";
                    document.getElementById("hodd22").src = "/images/02lose_ios.gif";
                    document.getElementById("hodd11").src = "/images/01lose_ios.gif";
                    document.getElementById("hodd44").src = "/images/04lose_ios.gif";
                    document.getElementById("hodd55").src = "/images/05lose_ios.gif";
                    document.getElementById("hodd66").src = "/images/06lose_ios.gif";

                }
                // imageId.style.left = "-118px";
                cal_margin = "" + (cal_margin) + "px";
            }
            if (hand_number == 4) {
                if (odds == 0) {
                    //imageId.style.top = "-125px";
                    document.getElementById("hodd44").src = "/images/04win_ios.gif";
                    document.getElementById("hodd22").src = "/images/02lose_ios.gif";
                    document.getElementById("hodd33").src = "/images/03lose_ios.gif";
                    document.getElementById("hodd11").src = "/images/01lose_ios.gif";
                    document.getElementById("hodd55").src = "/images/05lose_ios.gif";
                    document.getElementById("hodd66").src = "/images/06lose_ios.gif";
                }
                // imageId.style.left = "-176px";
                cal_margin = "" + (cal_margin) + "px";
            }
            if (hand_number == 5) {
                if (odds == 0) {
                    // imageId.style.top= "-105px";
                    document.getElementById("hodd55").src = "/images/05win_ios.gif";
                    document.getElementById("hodd22").src = "/images/02lose_ios.gif";
                    document.getElementById("hodd33").src = "/images/03lose_ios.gif";
                    document.getElementById("hodd44").src = "/images/04lose_ios.gif";
                    document.getElementById("hodd11").src = "/images/01lose_ios.gif";
                    document.getElementById("hodd66").src = "/images/06lose_ios.gif";

                }
                //imageId.style.left = "-236px";
                cal_margin = "" + (cal_margin) + "px";
            }
            if (hand_number == 6) {
                if (odds == 0) {
                    //imageId.style.top= "-85px";
                    document.getElementById("hodd66").src = "/images/06win_ios.gif";
                    document.getElementById("hodd22").src = "/images/02lose_ios.gif";
                    document.getElementById("hodd33").src = "/images/03lose_ios.gif";
                    document.getElementById("hodd44").src = "/images/04lose_ios.gif";
                    document.getElementById("hodd55").src = "/images/05lose_ios.gif";
                    document.getElementById("hodd11").src = "/images/01lose_ios.gif";

                }
                //imageId.style.left = "-296px";
                cal_margin = "" + (cal_margin) + "px";
            }

            setTimeout(function() {
                imageId.style.left = cal_margin;
            }, 400);
        }
    }
}
function blink(house_div1, i) {
    house_div1.style.color = "white";
    $(house_div1).fadeOut('slow').fadeIn('slow');
}
function padSeconds(secs) {
	secs = secs + "";
	if (secs.length < 2) {
		secs = "0" + secs;
	}
	return "00:" + secs;
}
function clear_function(state) {
    $("#nobet_popup").modal('hide');
    if (! state.options.isSinglePlayer) {
    	for (var j = 1; j < 7; j++) {
    		var card_id = "hodd" + j + j;
    		var card_value = "/images/0" + j + "_ios" + ".gif";
    		document.getElementById(card_id).src = card_value;
    	}
    }

    for (var o = 1; o < 7; o++) {
        var card_id = "hodd" + o;
        var card_value = "/images/0" + o + o + o + ".gif";
        document.getElementById(card_id).src = card_value;
        if (o == 1)
            document.getElementById(card_id).style.top = "-135px";
        if (o == 2)
            document.getElementById(card_id).style.top = "-115px";
        if (o == 3)
            document.getElementById(card_id).style.top = "-95px";
        if (o == 4)
            document.getElementById(card_id).style.top = "-75px";
        if (o == 5)
            document.getElementById(card_id).style.top = "-55px";
        if (o == 6)
            document.getElementById(card_id).style.top = "-35px";
    }
    for (var j = 1; j < 31; j++) {
        // alert("clear");
        var card_id = "im" + j;
        document.getElementById(card_id).src = "/images/pt-card.png";
    }
    for (var m = 1; m < 13; m++) {
        if (m < 7)
            var house_div = "house" + m + m;
        else {
            var k = m - 6;
            var house_div = "house" + k + k + k;
        }
        var house_div1 = document.getElementById(house_div);
        house_div1.style.color = "";
        house_div1.innerHTML = "Bet: 0.0" + " " + " Return:0.0";

    }
    for (var k = 1; k < 7; k++) {
        var div1 = "hand" + k + "_" + "bet";
        var hand_num = document.getElementById(div1);
        var div2 = "hand" + k + "_" + "type" + "_" + "bet";
        var hand_type = document.getElementById(div2);
        hand_num.innerHTML = "";
        hand_type.innerHTML = "";
    }
    for (var i = 1; i < 7; i++) {
        var im = "hodd" + i;
        var horseId = document.getElementById(im);
        horseId.style.position = 'relative';
        //horseId.style.left = '0px';
        move_horse(16, i, state);
    }
    if (! state.options.isSinglePlayer) {
        for (var i = 1; i < 7; i++) {
            var im = "hodd" + i + i;
            var horseId = document.getElementById(im);
            horseId.style.position = 'relative';
            //horseId.style.left = '0px';
            move_horse1(16, i, state);
        }
    }

    var hand = document.getElementById("current_hand");
    hand.innerHTML = "Hand";
    var amount = document.getElementById("current_amount");
    amount.innerHTML = "Amount";
    var ret_amount = document.getElementById("current_return");
    ret_amount.innerHTML = "Return";
}
function clicked(id) {
    window.location.href = "/results.html?tournament_id=" + id;
}
function clicked_link(id) {
    $.getJSON("/FrontControl", {
        "clicked": id,
        "command": "clicked"
    }, function(data) {
        // alert(data.result);
        window.location.href = "/u/home";
    });
}
function play() {
	//FIXME:  see if anything actually calls this
	//XXX:  no-op
}
function close() {
	//FIXME:  see if anything actually calls this
	//XXX:  no-op
}
function confirm_bet() {
    var state = RP.externalState();
	if (state.flags.bets_confirm) {
		var bet_value = document.getElementById("bet_amount").value;
        var hand_value = parseInt(document.getElementById("hand").value, 10) - 1;
        var odds = state.hands[hand_value].odds;
        
        if ((parseInt(bet_value) > 0) && (hand_value >= 0)) {
            var return_amount = (bet_value * odds);
            return_amount = return_amount.toFixed(2);
            return_amount = Math.round(return_amount);
            $("#bets_buttons1").hide();
            $("#bets_buttons2").hide();
            $("#place_bet").hide();
            $("#erase").hide();
            // $("#hand").hide();
            //$("#bet_amount").hide();
            $("#hand_bet_amount").hide();
            $("#loading_bet").show();
            var loading_bet = document.getElementById("loading_bet");
            loading_bet.innerHTML = "<img src=\"/images/loading_bet.gif\" class=\"img-responsive\"  />";
            
            var betSuccess = RP.placeBet(hand_value + 1, bet_value, return_amount);
            if (! betSuccess) {
            	$("#bets_popup").modal('hide');
            }

            document.getElementById("Error").style.visibility = "hidden";

            loading_bet.innerHTML = "<img src=\"/images/correct.jpg\" class=\"\" height=\"25\" />" + "Your bet is successful";
            setTimeout(function() {
                $("#bets_popup").modal('hide');
            }, 1000);
            var current_hand_div = document.getElementById("current_hand");
            current_hand_div.innerHTML += "<br/>" + (hand_value + 1);
            var current_amount_div = document.getElementById("current_amount");
            current_amount_div.innerHTML += "<br/>" + bet_value;

            var current_return_div = document.getElementById("current_return");
            current_return_div.innerHTML += "<br/>" + return_amount;
            
            var house_div = "house" + (hand_value + 1) + (hand_value + 1);
            var house_div1 = document.getElementById(house_div);

            //XXX:  need to refresh the state here, as calling 'placeBet' may have changed things
            state = RP.externalState();
            
            house_div1.style.color = "white";
            house_div1.innerHTML = "Bet:" + parseFloat(state.bets[hand_value].bet) + "  " + "Return:" + parseFloat(state.bets[hand_value].payout);
            house_div = "house" + (hand_value + 1) + (hand_value + 1) + (hand_value + 1);
            house_div1 = document.getElementById(house_div);

            house_div1.style.color = "white";
            house_div1.innerHTML = "Bet:" + parseFloat(state.bets[hand_value].bet) + "  " + "Return:" + parseFloat(state.bets[hand_value].payout);
            if (state.options.isSinglePlayer) {
            	var last_win_div = document.getElementById('current_last_win');
            	last_win_div.innerHTML = "Total bets:" + "&nbsp;" + state.stats.total_bets;
            }
            document.getElementById("hand").value = 0.0;
            document.getElementById("bet_amount").value = 0.0;
            document.getElementById("return_amount").value = 0.0;
        }
    }
    else {
        document.getElementById("Error").style.visibility = "visible";
    }
}
function calculate(amount) {
    var amountOkay = RP.validateBetAmount(amount);
    
    //XXX:  need to get this after validating the bet, as validation modifies game state
    var state = RP.externalState();
    
    var bet_div = document.getElementById("bet_amount");
    bet_div.value = state.stats.bet_amount;
    if (! amountOkay) {
        document.getElementById("Error").style.display = "inline";
        document.getElementById("Error").style.visibility = "visible";
        
    }
    else {
        document.getElementById("Error").style.display = "none";
        document.getElementById("Error").style.visibility = "hidden";
        
        var hand_value = parseInt(document.getElementById("hand").value, 10) - 1;
        var odds = state.hands[hand_value].odds;

        var return_amount = (state.stats.bet_amount * odds);
        return_amount = return_amount.toFixed(1);
        document.getElementById("return_amount").value = return_amount;
    }
}
function erase() {
    var bet_div = document.getElementById("bet_amount");
    var ret_div = document.getElementById("return_amount");
    bet_div.value = 0.0;
    ret_div.value = 0.0;
    
    document.getElementById("Error").style.display = "none";
    document.getElementById("Error").style.visibility = "hidden";
    
    RP.eraseLastBet();
}
function click_hand(hand_num) {
	var state = RP.externalState();
    
	var hand_div = document.getElementById("hand");
    hand_div.value = hand_num;
    if (!state.stats.hands_status[hand_num]) {
        //$("#bets_popup").modal('hide');
        $("#place_bet").hide();
        $("#erase").hide();
        $("#bets_buttons1").hide();
        $("#bets_buttons2").hide();
        var error = document.getElementById("Error");
        error.innerHTML = "No bets are accepted.Please click on another hand";
    }
    else {
        $("#loading_bet").hide();
        $("#bets_buttons1").show();
        $("#bets_buttons2").show();
        $("#place_bet").show();
        $("#erase").show();
        $("#hand").show();
        $("#bet_amount").show();
        $("#hand_bet_amount").show();
    }
}
function open_modal() {
	var state = RP.externalState(); 
	
	if (state.flags.timer_flag) {
        $("#bets_popup").modal('toggle');
    }
    $("#loading_bet").hide();
}
function send_exit(state) {
    $.getJSON("/Exit_tournament", {
        "tournament_id": state.options.tournamentId,
        "user_credits": state.user.current_player_points,
        "username": state.user.username
    }, function(data) {
    });
}
function audio_mode() {
	var state = RP.externalState(); 
	
    if (state.interfaceState.help.enabled) {
    	RP.setAudioEnabled(false);
        document.getElementById("audio_mode").value = "Help mode on";
    }
    else {
    	RP.setAudioEnabled(true);
        document.getElementById("audio_mode").value = "Help mode off";
    }
}
function exit() {
	var state = RP.externalState(); 
	
    if (state.flags.tournament_end || confirm("Hey, hold on a second you will lose your bets and bonuses if you exit the tournament room.") === true) {
    	if (state.options.isSinglePlayer) {
    		RP.exitGame();
    	}
    	else {
    		send_exit(state);
    	}
        
        window.location.href = options.isGuestMode ? "/r/indexPage" : "/u/home";
    }
    else if ($('input[name="exit_checkbox"]').length > 0) {
        $('input[name="exit_checkbox"]').bootstrapSwitch('state', false, false);
    }
}
function deal() {
	var state = RP.externalState(); 
	
	if (! state.options.isSinglePlayer) {
		return;
	}
	
	RP.forceDeal();
	
    $("#deal_button").hide();
    document.getElementById("ready").disabled = true;
}
function send_chat1() {
	var state = RP.externalState(); 
	
    var chat_body = document.getElementById("chat_body2");
    var chat_player_name = document.createElement("DIV");
    // chat_player_name.innerHTML = player_name ;

    var chat_msg = document.createElement("DIV");

    // $(chat_msg).addClass("pull-right");
    var msg = document.getElementById('chat_message1').value;

    chat_msg.innerHTML = "<span style=\"color:#FFA500; font-size:14px\">" + state.user.current_player + "</span>" + "<span>" + "&nbsp;&nbsp;" + "</span>" + "<span class=\"text-cross\">" + msg + "</span>";

    chat_body.appendChild(chat_msg);
    // chat_body.innerHTML += "<hr style=\"color:#ffffff\">";
    // msg =msg.split(' ').join(',');
    //alert(msg);
    $.getJSON("/Chat_servlet", {
        "User": state.user.current_player,
        "Message": msg,
        "Tournament_id": state.options.tournamentId
    }, function(data) {

    });
    var chats = document.getElementById("chat_body2");
    chats.scrollTop = chats.scrollHeight;
    
    if (! state.options.isSinglePlayer) {
    	RP.chatMessage(msg);
    }
}

//event handlers for when the gameplay state changes
document.addEventListener(RP.eventTypes.connectFailed, function(evt) {
	window.location.href = "/r/indexPage";
});

document.addEventListener(RP.eventTypes.prevGame2, function(evt) {
	var state = evt.detail;
	
	if (state.stats.last_win > 0 && ! state.options.isSinglePlayer) {
        if (state.stats.highest_profit < state.stats.last_win) {
            $("#achievements").modal('show');
            var achievements_body = document.getElementById("achievements_body");
            achievements_body.innerHTML = "<p> Congratulations!!! You just made highest profit from all bets  you placed in all tournaments.</p>"
            achievements_body.innerHTML += "Now, your highest profit is " + state.stats.highest_profit;
        }
    }
    
    var last_win_div = document.getElementById('current_last_win');
    if (state.stats.last_win > 0) {
        last_win_div.innerHTML = "Your last win: " + parseInt(state.stats.last_win) + "<img src=\"/images/arrow-up.png\" />";
    }
    else {
        last_win_div.innerHTML = "Your last win: " + parseInt(state.stats.last_win * -1) + "<img src=\"/images/arrow-down.png\" />";
    }
    
    var current_bonus = document.getElementById('current_bonus');
    if (! state.options.isSinglePlayer && current_bonus) {
    	current_bonus.innerHTML = "";
    }
});

document.addEventListener(RP.eventTypes.prevGame1, function(evt) {
	var state = evt.detail;
	
	$("previous_game").show();
    
    var newRow = document.all("result_table").insertRow();
    var oCell = newRow.insertCell();
    oCell.innerHTML = "" + state.stats.running_game_number + "&nbsp;";
    var oCell1 = newRow.insertCell();
    oCell1.innerHTML = state.stats.winning_hand + "&nbsp;" + state.stats.winning_type + "&nbsp;&nbsp;";
    var oCell2 = newRow.insertCell();
    oCell2.innerHTML = "" + state.stats.total_bets + "&nbsp;&nbsp; ";
    var oCell3 = newRow.insertCell();
    if (state.stats.last_win > state.stats.total_bets)
        oCell3.style.color = "#FFA500";
    oCell3.innerHTML = state.stats.last_win;
});

document.addEventListener(RP.eventTypes.connectedPlayers, function(evt) {
	var state = evt.detail;
	
	var div32 = document.getElementById("player_name");
    var div33 = document.getElementById("Balance");
    for (var j = 0; j < state.players.sorted_connected_players.length; j++) {
        var ply_div = document.createElement("DIV");
        var point_div = document.createElement("DIV");
        if (state.players.sorted_connected_players[j] === state.user.current_player) {
            ply_div.style.color = "#FFA500";
            point_div.style.color = "#FFA500";
        }

        if (j === 0) {
            div32.innerHTML = "Player Name" + "<br/>";
            ply_div.innerHTML = state.players.sorted_connected_players[j];
            div33.innerHTML = "Balance" + "<br/>";
            point_div.innerHTML = parseInt(state.players.sorted_connected_players_points[j]);
        }
        else {
            ply_div.innerHTML = state.players.sorted_connected_players[j];
            point_div.innerHTML = parseInt(state.players.sorted_connected_players_points[j]);
        }
        
        div32.appendChild(ply_div);
        div33.appendChild(point_div);
    }
});

document.addEventListener(RP.eventTypes.playerBalanceExt, function(evt) {
	var state = evt.detail;
	var k = state.count;
	
	var div31 = document.getElementById("current_balance");
    div31.innerHTML = "Balance: " + parseInt(state.user.current_player_points);
    
    var div32 = document.getElementById("current_bitlets");
    if (state.user.total_bitlets > 0) {
        div32.innerHTML = "Bitlets: " + parseInt(state.user.current_bitlets) + "&nbsp;" + "<span style=\"color:#FFFFFF\" >" + "+" + "&nbsp;" + state.user.total_bitlets + "</span>";
    }
    else
        div32.innerHTML = " Bitlets: " + parseInt(state.user.current_bitlets);
    var div33 = document.getElementById("current_level");
    if (state.user.total_level > 0) {
        div33.innerHTML = "Level: " + state.user.current_level + "&nbsp;" + "<span style=\"color:#FFFFFF\" >" + "+" + "&nbsp;" + state.user.total_level + "</span>";
    }
    else {
        div33.innerHTML = "Level: " + state.user.current_level;
    }
        
    var div34 = document.getElementById("current_pos");
    div34.innerHTML = "Pos:" + (parseInt(k) + 1) + "/" + (state.players.connected_players.length);
});

document.addEventListener(RP.eventTypes.playerBalance, function(evt) {
	var state = evt.detail;
	if (! state.options.isSinglePlayer) {
		return;
	}
	
	var balance = document.getElementById("current_balance");
    balance.innerHTML = "Balance: " + parseInt(state.user.current_player_points);
}); 

document.addEventListener(RP.eventTypes.finished, function(evt) {
	var state = evt.detail;
	if ( state.options.isSinglePlayer) {
		return;
	}
	
	var div31 = document.getElementById("current_balance");
	var append1 = state.options.isGuestMode ? "" : "<button  data-role=\"button\" id=" + state.options.tournamentId + " onclick=\"clicked(this.id)\" style=\"color:black\" data-mini=\"true\" data-inline=\"true\"> Show results </button>";
    div31.innerHTML += append1;
    var gamestatus = document.getElementById("game_status");
    gamestatus.innerHTML = "Tournament Finished";
});

document.addEventListener(RP.eventTypes.end, function(evt) {
	var state = evt.detail;
	
	if (state.options.isSinglePlayer) {
		var gamestatus = document.getElementById("game_status");
		if (gameStatus) {
			gamestatus.innerHTML = "Tournament Finished";
		}
	}
    else {
        var div31 = document.getElementById("current_balance");
        
        $("#finish_popup").modal('show');
        $("#animation_image").show();
        $("#data_info").hide();
        setTimeout(function() {
            $("#animation_image").hide();
            $("#data_info").show();
            var finish_rank = document.getElementById("finish_rank");
            finish_rank.innerHTML = "Your rank :" + state.user.finished_rank;
            var current_credits = document.getElementById("current_credits");
            current_credits.innerHTML = "Current credits :" + parseInt(state.user.current_player_points);
            var level = document.getElementById("finish_level");
            level.innerHTML = " Player level: " + state.user.current_level + "&nbsp;" + "<span style=\"color:#FFA500\" >" + "+" + "&nbsp;" + parseInt(state.user.total_level) + "</span>";
            var bitlets = document.getElementById("finish_bitlets");
            if (parseInt(state.user.total_bitlets) < 0)
                bitlets.innerHTML = "Bitlets Lost:" + (parseInt(state.user.total_bitlets) * (-1));
            if (parseInt(state.user.total_bitlets) > 0)
                bitlets.innerHTML = "Bitlets gained:" + "&nbsp" + state.user.current_bitlets + "+" + (parseInt(state.user.total_bitlets));
            var append1 = state.options.isGuestMode ? "" : "<button  data-role=\"button\" id=" + state.options.tournamentId + " onclick=\"clicked(this.id)\"  > Show results </button>";
            var full_results = document.getElementById("full_results");
            full_results.innerHTML = append1;
            if (! state.options.isGuestMode) {
            	setTimeout(function() {
            		clicked(state.options.tournamentId);
            	}, 10000);
            }
        }, 4000);
    }
});

document.addEventListener(RP.eventTypes.currentPlayer, function(evt) {
	var state = evt.detail;
	
	var div31 = document.getElementById("current_balance");
    div31.innerHTML += "<br/>" + "Balance: " + state.user.current_player_points;
    div31.innerHTML += "<br/>" + "Your Last Win: " + state.lastWin;
});

document.addEventListener(RP.eventTypes.handType, function(evt) {
	var state = evt.detail;
	
	var div_id = "hand" + state.stats.hand_number + "_" + "type" + "_" + "bet";
    var hands_div = document.getElementById(div_id);
    hands_div.innerHTML = state.type;
    hands_div.style.textShadow = "none";
    hands_div.style.color = "Black";
});

document.addEventListener(RP.eventTypes.winType, function(evt) {
	var state = evt.detail;
	
	var div_id = "hand" + state.stats.hand_number + "_" + "type" + "_" + "bet";
    var hands_div = document.getElementById(div_id);

    hands_div.innerHTML = state.stats.winning_type;
    hands_div.style.textShadow = "none";
    hands_div.style.color = "Black";
});

document.addEventListener(RP.eventTypes.winningHand, function(evt) {
	var state = evt.detail;
	
	var div_id = "hand" + state.stats.hand_number + "_" + "bet";
    var winning_div = document.getElementById(div_id);
    winning_div.innerHTML = "WINNER";
    var odds = 0;
    move_horse(odds, state.stats.hand_number, state);
    var game_status = document.getElementById("game_status");
    game_status.innerHTML = " Winning Hand Number :" + state.stats.hand_number;
    var div_id1 = "house" + state.stats.hand_number;
    var div_id2 = document.getElementById(div_id1);
    div_id2.style.backgroundColor = "white";
    div_id2.style.backgroundImage = "url('/images/stars-1.GIF')";
    $(div_id2).fadeOut(1000);
    $(div_id2).fadeIn();
});

document.addEventListener(RP.eventTypes.clear, function(evt) {
	var state = evt.detail;
	var split = state.split;
	
	var div_id1 = "house" + state.stats.hand_number;//split;//state.stats.hand_number;
    var div_id2 = document.getElementById(div_id1);
	
    if (div_id2) {
		div_id2.style.backgroundImage = "none";
	    //div_id2.style.backgroundColor = "#F8C300"; },2000 ) ;
	    // console.log(second_split[1]);
	    if (split == 1) {
	        div_id2.style.backgroundColor = "#F8C300";
	    }
	    if (split == 2) {
	        div_id2.style.backgroundColor = "#DA251D";
	    }
	    if (split == 3) {
	        div_id2.style.backgroundColor = "#00923F";
	    }
	    if (split == 4) {
	        div_id2.style.backgroundColor = "#0093DD";
	    }
	    if (split == 5) {
	        div_id2.style.backgroundColor = "#6F448A";
	    }
	    if (split == 6) {
	        div_id2.style.backgroundColor = "#E77817";
	    }
    }
    else {
    	console.log("ERROR:  No div found for id=" + div_id1 + ", split=" + split + ", hand_number=" + state.stats.hand_number);
    }
    
    for (var hand = 1; hand <= 6; hand++) {
    	div_id1 = "house" + hand;//state.stats.hand_number;
        div_id2 = document.getElementById(div_id1);
    	
        if (div_id2) {
	    	div_id2.style.backgroundImage = "none";
	        //div_id2.style.backgroundColor = "#F8C300"; },2000 ) ;
	        // console.log(second_split[1]);
	        if (hand == 1) {
	            div_id2.style.backgroundColor = "#F8C300";
	        }
	        if (hand == 2) {
	            div_id2.style.backgroundColor = "#DA251D";
	        }
	        if (hand == 3) {
	            div_id2.style.backgroundColor = "#00923F";
	        }
	        if (hand == 4) {
	            div_id2.style.backgroundColor = "#0093DD";
	        }
	        if (hand == 5) {
	            div_id2.style.backgroundColor = "#6F448A";
	        }
	        if (hand == 6) {
	            div_id2.style.backgroundColor = "#E77817";
	        }
        }
    }
    
    clear_function(state);
});

document.addEventListener(RP.eventTypes.loaded, function(evt) {
	var state = evt.detail;
	
	$("#loading_popup").modal('hide');

    $('html,body').animate({
        scrollTop: $("#game_number").offset().top
    }, 1000);
    
    var tour_id = document.getElementById("tournament_id");
    tour_id.innerHTML = state.options.tournamentId;
    var div22 = document.getElementById("div22");
    div22.innerHTML = "<div style=\"text-shadow:none;\" class=\"row\" id=\"deal\"> " +
        "<div id=\"deal_number\" class=\"col-sm-2 col-md-2 col-lg-3 col-xs-3\" style=\"color:green;\">Deal:1</div> " +
        "<div id=\"game_status\" class=\"col-sm-6 col-md-6 col-lg-6 col-xs-7\" style=\"color:green;text-shadow:none;\"> Game in Progress <img id=\"improgress\" src=\"/images/loading2.gif\"  /> </div> " +
        "<div id=\"in\"  class=\"col-sm-4 col-md-4 col-lg-3 col-xs-2\"> &nbsp; &nbsp;" +
        " </div></div>";
});

document.addEventListener(RP.eventTypes.playerRank, function(evt) {
	var state = evt.detail;
	var rank = state.position;
	
	if (rank == 1) {
		$("#winners_popup").modal('show');
        var winners_popup_body = document.getElementById("winners_popup_body");
        winners_popup_body.innerHTML = "Congrats, You finished first in the tournament";
	}
	else if (rank == 2) {
		$("#winners_popup").modal('show');
        var winners_popup_body = document.getElementById("winners_popup_body");
        winners_popup_body.innerHTML = "Congrats, You finished second in the tournament";
	}
	else if (rank == 3) {
		$("#winners_popup").modal('show');
        var winners_popup_body = document.getElementById("winners_popup_body");
        winners_popup_body.innerHTML = "Congrats, You finished third in the tournament";
	}
	else {
		$("#winners_popup").modal('show');
        var winners_popup_body = document.getElementById("winners_popup_body");
        winners_popup_body.innerHTML = "Prizes are only paid to 1st, 2nd and 3rd winners of the tournament. Hope you do better next time.";
	}
});

document.addEventListener(RP.eventTypes.startTimer, function(evt) {
	var state = evt.detail;
	var seconds = state.seconds;
	
	if (state.options.isSinglePlayer) {
    	$("#deal_button").show();
    	if (document.getElementById("ready")) {
    		document.getElementById("ready").disabled = false;
    	}
    }
    
    var canvas = document.getElementById("canvas");
    if (canvas) {
    	var ctx = canvas.getContext("2d");
    	canvas.height = 50;
    }
    
    if (state.options.isGuestMode) {
    	if (parseInt(state.stats.running_game_number) % 2 == 0 && parseInt(state.stats.running_deal_number) == 1) {
    		$("#register_popup").modal('show');
    	}
    	else {
    		$("#register_popup").modal('hide');
    	}
    }
    
    //XXX:  only do this when 'canvas' is present???
    if (canvas) {
    	//draws a clock-style graphic
    	startTimerClock(seconds);						//XXX:  this calls to an external function
    }

    //textual countdown timer
    var displayTime = padSeconds(seconds);
    var timer_canvas = document.getElementById('timer');
    if (timer_canvas) { 
    	timer_canvas.innerHTML = displayTime;
    }							

    // send();
    var gamestatus = document.getElementById("game_status");
    gamestatus.innerHTML = "Click hands to place bets  " + "&nbsp;";
    if (state.stats.running_deal_number != 1) {
        setTimeout(function() {
            for (var i = 1; i < 7; i++) {
                var house_div = "hand" + i + "_bet";

                var house_div1 = document.getElementById(house_div);
                house_div1.style.color = "black";
            }
        }, 1000);
    }
});

document.addEventListener(RP.eventTypes.stopTimer, function(evt) {
	var state = evt.detail;
	var canvas = document.getElementById("canvas");
	
	if (state.options.isSinglePlayer) {
		if (canvas) {
			var time = "00" + ":00";		
			canvas.innerHTML = time;
		}
		$("#deal_button").hide();		
	}
	
    $("#bets_popup").modal('hide');
    $("#bets_popup").removeAttr("data-toggle");
    $("#nobet_popup").modal('hide');
});

document.addEventListener(RP.eventTypes.timerTick, function(evt) {
	var state = evt.detail;
	//var canvas = document.getElementById("canvas");
	
	//if (canvas) {
	//	canvas.innerHTML = padSeconds(state.seconds);
	//}
	
	var timer_canvas = document.getElementById('timer');
    if (timer_canvas) { 
    	timer_canvas.innerHTML = padSeconds(state.seconds);//displayTime;
    }	
});

document.addEventListener(RP.eventTypes.checkHand, function(evt) {
	var state = evt.detail;
	
	var i = state.index;
	var house_div = "hand" + (i + 1) + "_" + "bet";
    var house_div1 = document.getElementById(house_div);

    //for (var j = 0; j < 1; j++) {
        blink(house_div1, (i + 1));
    //}
}); 

document.addEventListener(RP.eventTypes.resetOdds, function(evt) {
	var state = evt.detail;
	
	var div_id = "hand" + state.stats.hand_number + "_" + "bet";
    var odds_div = document.getElementById(div_id);
    odds_div.innerHTML = "No Bets";
    odds_div.style.textShadow = "none";
    odds_div.style.color = "Black";
    
    move_horse(-1, state.stats.hand_number, state);
});

document.addEventListener(RP.eventTypes.zeroOdds, function(evt) {
	var state = evt.detail;
	
	var div_id = "hand" + state.stats.hand_number + "_" + "bet";
    var odds_div = document.getElementById(div_id);
    // alert("1");
    // odds_div.innerHTML = "No Bets";
    odds_div.style.textShadow = "none";
    odds_div.style.color = "Black";
});

document.addEventListener(RP.eventTypes.updateOdds, function(evt) {
	var state = evt.detail;
	
	move_horse(state.split2, state.stats.hand_number, state);
	
    var mul = state.split2 * 10;
    var divd = mul % 10;
    if (divd === 0) {
        var div_id = "hand" + state.stats.hand_number + "_" + "bet";
        var div_id1 = "house" + state.stats.hand_number;
        var odds_div = document.getElementById(div_id);
        var div_id11 = document.getElementById(div_id1);
        // alert("1");

        odds_div.innerHTML = "$" + state.split2 + "0";
        odds_div.style.textShadow = "none";
        odds_div.style.color = "Black";

        // $(div_id11).fadeOut(2000);
        // $(div_id11).fadeIn();
    }
    else {
        var div_id = "hand" + state.stats.hand_number + "_" + "bet";
        var div_id1 = "house" + state.stats.hand_number;
        var odds_div = document.getElementById(div_id);
        // alert("1");
        var div_id11 = document.getElementById(div_id1);
        odds_div.innerHTML = "$" + state.split2 + "0";
        odds_div.style.textShadow = "none";
        odds_div.style.color = "Black";
        // $(div_id11).fadeOut(2000);
        // $(div_id11).fadeIn();
    }
});

document.addEventListener(RP.eventTypes.updateCard, function(evt) {
	var state = evt.detail;
    var card = "/images/" + state.cardType + ".gif";
    show_image(card, state.stats.hand_number, state.odds, state.stats.hand_card_count, state.useful, state);
});

document.addEventListener(RP.eventTypes.discardHand, function(evt) {
	var state = evt.detail;
	for (var i = ((state.stats.hand_number - 1) * 5 + 1); i < ((state.stats.hand_number - 1) * 5 + 6); i++) {
        var card_id = "im" + i;
        document.getElementById(card_id).src = "/images/pt-card.png";
    }
});

document.addEventListener(RP.eventTypes.checkHands, function(evt) {
	for (var i = 1; i < 7; i++) {		
		var house_div = "hand" + i + "_bet";		
		var house_div1 = document.getElementById(house_div);
		if (house_div1) {
			house_div1.style.color = "black";	
		}
	}
});

document.addEventListener(RP.eventTypes.chatMessage, function(evt){
	var state = evt.detail;
	var chat_body = document.getElementById("chat_body2");

	//var chat_player_name = document.createElement("DIV");
    var chat_msg = document.createElement("DIV");

    chat_msg.innerHTML = "<span style=\"color:green; font-size:14px\">" + state.user_name + "</span>" + "<span>" + "&nbsp;&nbsp;" + "</span>" + "<span class=\"text-cross\">" + state.msg + "</span>";
    chat_body.appendChild(chat_msg);

    var chats = document.getElementById("chat_body2");
    chats.scrollTop = chats.scrollHeight;
});

document.addEventListener(RP.eventTypes.socketClosed, function(evt){
	window.location.href = "/Error.html";
});

document.addEventListener(RP.eventTypes.redeal, function() {
	var game_status = document.getElementById("game_status");
    game_status.innerHTML = "Winner on First deal. So,Redeal";
});

document.addEventListener(RP.eventTypes.playerBonus, function(evt) {
	var state = evt.detail;
	
	$("#bonus_popup").modal('show');
    var bonus_body = document.getElementById("bonus_body");
    var bonus_main = document.getElementById("bonus_main");
    // bonus_body.innerHTML = "";
    bonus_main.innerHTML = "<img src=\"/images/countdown-321.gif\" class=\"img-responsive\"/>";
    setTimeout(function() {
        var bonus_body1 = document.getElementById("bonus_body");
        var bonus_main1 = document.getElementById("bonus_main");
        bonus_main1.innerHTML = "<img src=\"/images/bonus-im.jpg\" class=\"img-responsive\"/>";
        
        bonus_main1.innerHTML += "Congratulations!!" + "<br/> " + "Bonus Type:" + "&nbsp;" + state.bonus.bonus_type + "<br/>" + "Bonus amount" + "&nbsp;" + parseInt(state.bonus.bonus_amount) + "<br/>" + "Bitlets Won" + ":" + parseInt(state.split9) + "<br/>" + "Player level won" + ":" + parseInt(state.split10);
        if (state.stats.running_game_number != state.stats.total_games) {
        	bonus_main1.innerHTML += "<br/>" + "  Profit Again for a higher level bonus !";
        }

        var current_bonus = document.getElementById('current_bonus');
        if (state.options.isSinglePlayer && current_bonus) {
        	current_bonus.innerHTML = "Bonus type:" + state.bonus.bonus_type + "<br/>" + "Bonus amount:" + state.bonus.bonus_amount;
        }
        var bitlets = document.getElementById('current_bitlets');
        
        bitlets.innerHTML = "Bitlets: " + parseInt(state.user.current_bitlets);
        var level = document.getElementById('current_level');
        level.innerHTML = "Level: " + state.user.current_level;
        if (parseInt(state.split10) > 0) {
            var level_won = document.getElementById("level_won");
            level.innerHTML = "Level: " + state.user.current_level + "&nbsp;" + "<span style=\"color:#FFFFFF\" >" + "+" + "&nbsp;" + state.user.total_level + "</span>";
        }
        if (parseInt(state.split9) > 0) {
            var bitlets_won = document.getElementById("bitlets_won");
            bitlets.innerHTML = "Bitlets: " + parseInt(state.user.current_bitlets) + "&nbsp;" + "<span style=\"color:#FFFFFF\" >" + "+" + "&nbsp;" + state.user.total_bitlets + "</span>";
        }
        $("#bonus_head").show();
        var bonus_add = document.getElementById('bonus_add');
        var bonus_pre = document.getElementById("bonus_previous");

        if (state.bonus.bonus_type == "2shot" && ! state.options.isSinglePlayer) {
            bonus_pre.innerHTML = "&nbsp;" + "<span class=\"glyphicon glyphicon-asterisk\"></span>" + "&nbsp;" + state.bonus.bonus_types[state.bonus.bonus_pre_number] + "&nbsp;" + state.bonus.bonus_amounts[state.bonus.bonus_pre_number] + "<br/>";
        }

        if (state.bonus.bonus_type == "3shot")
            bonus_add.innerHTML = "&nbsp;" + "<span class=\"glyphicon glyphicon-asterisk\"></span>" + "&nbsp;" + state.bonus.bonus_type + "&nbsp;" + state.bonus.bonus_amount + "<br/>";

        if (state.bonus.bonus_type == "4shot") {
            bonus_pre.innerHTML += "&nbsp;" + "<span class=\"glyphicon glyphicon-asterisk\"></span>" + "&nbsp;" + state.bonus.bonus_types[state.bonus.bonus_pre_number] + "&nbsp;" + state.bonus.bonus_amounts[state.bonus.bonus_pre_number] + "<br/>";
        }

        if (state.bonus.bonus_type == "6shot") {
            bonus_pre.innerHTML += "&nbsp;" + "<span class=\"glyphicon glyphicon-asterisk\"></span>" + "&nbsp;" + state.bonus.bonus_types[state.bonus.bonus_pre_number] + "&nbsp;" + state.bonus.bonus_amounts[state.bonus.bonus_pre_number] + "<br/>";
        }

        if (state.bonus.bonus_type == "8shot") {
            bonus_pre.innerHTML += "&nbsp;" + "<span class=\"glyphicon glyphicon-asterisk\"></span>" + "&nbsp;" + state.bonus.bonus_types[state.bonus.bonus_pre_number] + "&nbsp;" + state.bonus.bonus_amounts[state.bonus.bonus_pre_number] + "<br/>";
        }

        if (state.bonus.bonus_type == "10shot") {
            bonus_pre.innerHTML += "&nbsp;" + "<span class=\"glyphicon glyphicon-asterisk\"></span>" + "&nbsp;" + state.bonus.bonus_types[state.bonus.bonus_pre_number] + "&nbsp;" + state.bonus.bonus_amounts[state.bonus.bonus_pre_number] + "<br/>";
        }

        if (state.bonus.bonus_type == "5shot")
            bonus_add.innerHTML += "&nbsp;" + "<span class=\"glyphicon glyphicon-asterisk\"></span>" + "&nbsp;" + state.bonus.bonus_type + "&nbsp;" + state.bonus.bonus_amount + "<br/>";

        if (state.bonus.bonus_type == "7shot")
            bonus_add.innerHTML += "&nbsp;" + "<span class=\"glyphicon glyphicon-asterisk\"></span>" + "&nbsp;" + state.bonus.bonus_type + "&nbsp;" + state.bonus.bonus_amount + "<br/>";

        if (state.bonus.bonus_type == "9shot")
            bonus_add.innerHTML += "&nbsp;" + "<span class=\"glyphicon glyphicon-asterisk\"></span>" + "&nbsp;" + state.bonus.bonus_type + "&nbsp;" + state.bonus.bonus_amount + "<br/>";
    }, 3000);
});

document.addEventListener(RP.eventTypes.dealNumber, function(evt) {
	var state = evt.detail;
	
	var divdeal = document.getElementById("deal_number");
    divdeal.innerHTML = "Deal :" + state.stats.running_deal_number;

    var game_status = document.getElementById("game_status");
    game_status.innerHTML = "Game in Progress" + "&nbsp; &nbsp;" + "<img id=\"improgress\" src=\"/images/green_loading.gif\" width=\"90\" height=\"10\" />";
});

document.addEventListener(RP.eventTypes.gameNumber, function(evt) {
	var state = evt.detail;
	
	$("#bonus_popup").modal('hide');
    $("#achievements").modal('hide');
    
    game_canvas = document.getElementById('game_number');
    game_canvas.innerHTML = state.stats.running_game_number + "/" + state.stats.total_games;
    var game_status = document.getElementById("game_status");
    game_status.innerHTML = "Game in Progress " + "&nbsp;" + "<img id=\"improgress\" src=\"/images/green_loading.gif\"  width=\"90\" height=\"10\" />";
    //  alert("3");
});

document.addEventListener(RP.eventTypes.userInfo, function(evt) {
	var state = evt.detail;
	var div31 = document.getElementById("current_name");
    if (div31) {
    	div31.innerHTML += "Player:" + "&nbsp;" + state.user.current_player;
    }
    
    var level = document.getElementById("current_level");
    if (level) {
    	level.innerHTML = "Level: " + state.user.current_level;
    }
    
    var bitlets = document.getElementById("current_bitlets");
    if (bitlets) {
    	bitlets.innerHTML = "Bitlets: " + state.user.current_bitlets;
    }
});
document.addEventListener(RP.eventTypes.start, function(evt) {
	var state = evt.detail;
	if (! state.options.isGuestMode) {
		name = state.options.tournamentId.replace(/-/gi, " ");
		
		tour_canvas = document.getElementById('tournament_name');
        tour_canvas.innerHTML += name;
	}
	else {
		var div31 = document.getElementById("current_name");
    	div31.innerHTML += "Player:" + "&nbsp;" + state.user.screenname;
    	
    	var div32 = document.getElementById("current_balance");
    	div32.innerHTML = "Balance:" + "&nbsp;" + "3000";
	}
	
	var div22 = document.getElementById("div22");
    if (div22) {
	    $("#div22").show();
	    div22.style.textShadow = "none";
	    div22.style.color = "orangered";
	    div22.innerHTML = (state.options.isSinglePlayer ? "Loading...... " : "Please wait for other players to connect ")
	    	+ "<img id=\"im00\" src=\"/images/green_loading.gif\"  style=\"border: 0px black solid\" width=\"100\" height=\"10\" />" + "";
    }
    setTimeout(function() {
        $("#div21").show();
    }, 2000);
    setTimeout(function() {
        $("#div23").show();
    }, 5000);
    
    if ($("[name='exit_checkbox']").length > 0) {
	    $("[name='exit_checkbox']").bootstrapSwitch();
	    $('input[name="exit_checkbox"]').on('switchChange.bootstrapSwitch', function(event, conf) {
	    	if (conf && ! RP.externalState().flags.tournament_end) {
	            exit();
	        }
	        if (RP.externalState().flags.tournament_end) {
	            clicked(state.options.tournamentId);
	        }
	
	    });
    }
    
    if ($("[name='chat_checkbox']").length > 0) {
	    $("[name='chat_checkbox']").bootstrapSwitch();
	    $('input[name="chat_checkbox"]').on('switchChange.bootstrapSwitch', function(event, conf) {
	        if (conf)
	            $('#div34').show();
	        else
	            $('#div34').hide();
	    });
    }
    
    //FIXME:  appears that audio is only ever enabled in guest mode
    if ($("[name='audio_mode']").length > 0) {
	    $("[name='audio_mode']").bootstrapSwitch();
	    $('input[name="audio_mode"]').on('switchChange.bootstrapSwitch', function(event, conf) {
	        RP.setAudioEnabled(conf ? true : false)
	    	if (! conf) {
	            $('input[name="help_mode"]').bootstrapSwitch('state', false, false);
	    	}
	    });
    }
    
    if ($("[name='help_mode']").length > 0) {
	    $("[name='help_mode']").bootstrapSwitch();
	    $('input[name="help_mode"]').on('switchChange.bootstrapSwitch', function(event, conf) {
	        RP.setHelpState(conf ? true : false);
	    });
    }
});

document.addEventListener(RP.eventTypes.init, function(evt) {
	if ($("#bets_popup").length > 0) {
		$("#bets_popup").modal('hide');
	}

    $("#div21").hide();
    $("#div23").hide();
    $("#div22").hide();
    $("#previous").hide();
    $("#bonus_head").hide();
    
    $("#loading_popup").modal('show');
});

