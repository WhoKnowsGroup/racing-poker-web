<%@ taglib tagdir="/WEB-INF/tags" prefix="rp" %>
<%@ taglib tagdir="/WEB-INF/tags/v2" prefix="v2" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	//NOTE:  can get a hand like:  $(".main-table-list-item").eq(<hand_index>)
	//NOTE:  can get a card like:  $(".main-table-list-item").eq(<hand_index>).find(".cards").find(".card").eq(<card_index>)
	var assignedLevels = {};
	var levels = [
	    "Plankton",
		"Sardine",
		"Small Fry",
		"Mullet",
		"Snapper",
		"Tuna",
		"Marlin",
		"Reef Shark",
		"Bull Shark",
		"Tiger Shark",
		"Hammerhead Shark",
		"Grey Nurse Shark",
		"Great White Shark",
		"Whale",
		"Whale Shark",
		"Killer Whale",
		"Sea Monster",
		"The Kraken"
	];
	
	var horses = [
		{win: "/images/01win.gif", lose: "/images/01lose.gif", run: "/images/0111.gif"},
		{win: "/images/02win.gif", lose: "/images/02lose.gif", run: "/images/0222.gif"},
		{win: "/images/03win.gif", lose: "/images/03lose.gif", run: "/images/0333.gif"},
		{win: "/images/04win.gif", lose: "/images/04lose.gif", run: "/images/0444.gif"},
		{win: "/images/05win.gif", lose: "/images/05lose.gif", run: "/images/0555.gif"},
		{win: "/images/06win.gif", lose: "/images/06lose.gif", run: "/images/0666.gif"},
	];
	
	var gameRunning = false;
	
	window.onbeforeunload = function() {
		if (gameRunning) {
	    	return 'Hey, hold on a second you will lose your bets and bonuses if you exit the tournament room.';
		}
	}
	
	window.onunload = function() {
		if (gameRunning) {
			var state = RP.externalState(); 
	    	if (state.options.isSinglePlayer) {
	    		RP.exitGame();
	    	}
		}		
	}
	
	var shotsEarned = 0;
	var clickCount = 0; 					//HACK:  fixes double-firing event on bet increment click
	var betsEnabled = false;
	var cardOperationQueue = [];
	var profitLastRound = false;
	var checkedGameNumber = -1;
	
	//onblur/onfocus handlers to ensure displayed state is consistent with current game state (only if/when game is running)
	window.onblur = function() {
		//FIXME:  should we just shut down the operation queue entirely, and restart it when we regain focus?
	};
	
	window.onfocus = function() {
		if (gameRunning && cardOperationQueue.length == 0) {
			//game is in progress, no ops are queued; ensure the UI is correct based upon the current game state
			var hands = RP.externalState().hands;
			for (var handIndex = 0; handIndex <= hands.length; handIndex++) {
				for (var cardIndex = 0; cardIndex < 5; cardIndex++) {
					if (! hands || ! hands[handIndex] || ! hands[handIndex].cards) {
						continue;
					}
					
					var disp = hands[handIndex].cards[cardIndex]
					if (disp == "ad") {
				        disp = "da";
				    }
					
					if (! disp) {
						disp = "/images/pt-card.png";
					}
					else {
						disp = "/images/" + disp +  ".gif"
					}
					
					var card = $(".main-table-list-item").eq(handIndex).find(".cards").find(".card").eq(cardIndex);
					var cardImg = card.find("img").attr("src");
					if (cardImg != disp) {
						card.html($("<img src='" + disp + "' />"));
					}
				}
			}
		}
		else {
			//game is over/not running; just clear out the cards
			cardOperationQueue = [];
			$(".main-table-list-item .card").html("");
		}
	};
	
	function randomLevel() {
		return levels[Math.floor(Math.random()*levels.length)];
	}
	
	$(document).ready(function() {
		$( ".player-one-volume" ).slider({
			slide: function( event, ui ) { 
				RP.setSpeechVolume(ui.value / 100.0);
			}
		});
		
		$(".cancelButton").click(function() {
			$(this).parents(".overlay").eq(0).hide();
		});
		$(".exitButton").click(function() {
			//disable the unload handler and hide the popup
			gameRunning = false;
			$(this).parents(".overlay").eq(0).hide();
		});
		$(".registerButton").click(function() {
			window.location.href = "/r/registrationPage";
		});
		$(".guestButton").click(function() {
			window.location.href = "/r/guestModeV2";
		});
		$(".tournamentButton").click(function() {
			window.location.href = "/u/gameSelect?mode=tournament";
		});
		$(".potPokerButton").click(function() {
			window.location.href = "/u/gameSelect?mode=pot";
		});
		$(".singlePlayerButton").click(function() {
			window.location.href = "/u/singleModeV2";
		});
		$(".creditsButton").click(function() {
			window.location.href = "/u/addChips";
		});
		$(".loginButton").click(function() {
			$('.overlay-log-in').show();
		});
		
		
		//disable betting controls until there's something to bet on
		$(".submit-bid").addClass("disabled");
		$(".submit-bid").attr("disabled", "disabled");
		
       	$("body").addClass("in-game");
	});
	
	setInterval(function() {
		cardOperationQueue = cardOperationQueue.sort(function(left, right) {
			if (left.handIndex != right.handIndex) {
				return left.handIndex - right.handIndex;
			};
			
			if (left.cardIndex != right.cardIndex) {
				return left.cardIndex - right.cardIndex;
			}
			
			return left.priority - right.priority;
		});
		if (cardOperationQueue.length > 0) {
			var op = cardOperationQueue.shift();
			var card = $(".main-table-list-item").eq(op.handIndex).find(".cards").find(".card").eq(op.cardIndex);
			var cardImg = card.find("img").attr("src");
			while (cardImg == op.img.attr("src") && cardOperationQueue.length > 0) {
				//fast-forward past cards that are unchanged
				op = cardOperationQueue.shift();
				card = $(".main-table-list-item").eq(op.handIndex).find(".cards").find(".card").eq(op.cardIndex);
				cardImg = card.find("img").attr("src");
			}
			
			if (cardImg != op.img.attr("src")) {
				var cardToChange = card;
			
				//also explicitly check that all preceding cards are correct
				//FIXME:  hands drawn with extra cards; need to ensure number displayed matches array status!!!
				var hands = RP.externalState().hands;
				for (var handIndex = 0; handIndex <= op.handIndex; handIndex++) {
					for (var cardIndex = 0; cardIndex < op.cardIndex; cardIndex++) {
						card = $(".main-table-list-item").eq(handIndex).find(".cards").find(".card").eq(cardIndex);
						cardImg = card.find("img").attr("src");
						
						if (! hands[handIndex].cards) {
							continue;
						}
						
						var disp = hands[handIndex].cards[cardIndex]
						if (disp == "ad") {
					        disp = "da";
					    }
						
						//if (! disp && ! cardImg) {
						//	//don't update this; no need
						//	continue;
						//}
						
						if (! disp) {
							//disp = "/images/pt-card.png";
							continue;
						}
						else {
							disp = "/images/" + disp +  ".gif"
						}
						
						
						if (cardImg != disp) {
							card.html($("<img src='" + disp + "' />"));
						}
					}
				}
				
				cardToChange.html(op.img);
			}
		}
	}, 100);
	
	function show_image(card, hand_number, odds, hand_card_count1, usefull3, state) {
		//display card image in the correct location
		if (card == "/images/ad.gif") {
	        card = "/images/da.gif";
	    }
		
		//NOTE:  params are 1-based
		var img = $("<img src='" + card + "' />");
		cardOperationQueue.push({img: img, handIndex: hand_number - 1, cardIndex: hand_card_count1 - 1, priority: new Date().getTime()});
		//TODO:  effects?
	}
	
	function disableBetAmounts() {
		var currentBalance = intValue(".currentBalance");
		$(".bet-amounts-chip").removeClass("disabledChip");
		$(".bet-amounts-chip").each(function(){
			var currentBet = parseInt($(this).parents("form").eq(0).find(".betTotal").text().replace(/[^0-9]/g, ""), 10);
			var myValue = parseInt($(this).find("input").attr("value"), 10);
			if (myValue + currentBet > currentBalance) {
				$(this).addClass("disabledChip");
			}
		});
	}
	
	$(".closeResults").click(function() {
		var state = RP.externalState();
		if (state.options.isGuestMode) {
			setTimeout("$('.overlay-bonus').show();", 1000);		//"join now for bonus credits"; no equivalent 'v2' popup
		}
	});
	
	$(".bet-amounts-chip").click(function() {
		clickCount++;
		if (clickCount % 2 == 0) {
			//HACK:  ignore duplicate events
			return;
		}
		
		var amount = parseInt($(this).text(), 10);
		//var odds = parseFloat($(this).parents(".overlay").find(".betOdds").text().replace(/[^0-9\.]/g, ""));
		var odds = parseInt($(this).parents(".overlay").find(".betOdds").text().replace(/[^0-9]/g, ""), 10);
		var currentBet = parseInt($(this).parents("form").eq(0).find(".betTotal").text().replace(/[^0-9]/g, ""), 10);
		var currentBalance = intValue(".currentBalance");
		var currentReturns = parseInt($(this).parents("form").eq(0).find(".betReturn").text().replace(/[^0-9]/g, ""), 10);
		
		var payout = (amount * odds) + "";
		payout = parseInt(payout.substring(0, payout.length - 2), 10);
		
		if (amount + currentBet <= currentBalance) {
			$(".betTotal").html("$" + (amount + currentBet).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
			$(".betReturn").html("$" + Math.floor(currentReturns + payout).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
			$(".placeBet").removeClass("disabled")
		}
		
		disableBetAmounts();
	});
	
	$(".clearBet").click(function() {
		$(".betTotal,.betReturn").html("$0");
		$(".placeBet").addClass("disabled");
		disableBetAmounts();
	});
	
	$(".placeBet").click(function() {
		confirm_bet(this);
	});
	
	$(".cards").click(function() {
		//display betting UI
		var btn = $(this).parent().find(".submit-bid");
		if (btn && ! btn.hasClass("disabled")) {
			btn.trigger("click");
			//$(this).parent().find(".submit-bid").trigger("click");
		}
	});
	
	$(".submit-bid").click(function() {
		var state = RP.externalState();
		
		//NOTE:  hand_num is 1-based
		var hand_num = $(this).parent().find(".cards").index(".cards") + 1;
		
		//show betting UI if okay to bet
		if (! betsEnabled || ! state.stats.hands_status[hand_num]) {
			//bets not allowed
			//FIXME:  error message
			
			//setTimeout(function() {
			//	$(".closeBets").trigger("click");
			//	//$(".overlay").hide();		//HACK:  ensure that the betting overlay is not displayed
			//}, 1);
		}
		else {
			//okay to bet
			//FIXME:  CSS cursor style for cards div(s)
			//configure betting UI
			$(".betCards").html($(this).parent().find(".cards").html());
			$(".betType").html($(this).parent().find(".handLabel").html() + " " + $(this).parent().find(".handType").html());
			$(".betOdds").html($(this).parent().find(".bidOdds").html());
			
			$(".betTotal").html("$0");
			$(".betReturn").html("$0");
			$(".placeBet").addClass("disabled");
			disableBetAmounts();
		}
	});
	
	$(".volume-icon").click(function() {
		var enabled = $(this).hasClass("active");
		
		//toggle audio setting
	    if (enabled) {
	    	RP.setAudioEnabled(true);
	    }
	    else {
	    	RP.setAudioEnabled(false);
	    }
	});
	
	$(".exitGame").click(function() {
		exit();
	});
	
	
	function move_horse(odds, hand_number, state) {
		$(".horse").show();
		var worstOdds = 16;
		var width = $(".track").width();
		var margin = Math.floor(width / 4);
		
		//update horse positions and/or graphics
		if (odds < 0) {
			//this indicates we've reached the end of the race and a winner has been declared
			var winningHand = hand_number;
			for (var handNum = 1; handNum <= 6; handNum++) {
				var horse = $(".horse" + handNum);
				var images = horses[handNum - 1];
				horse.attr("src", handNum == winningHand ? images.win : images.lose);
				
				if (handNum == winningHand) {
					horse.css("left", (width - (margin / 2)) + "px");
				}
			}
		}
		else {
			//position horse(s) based upon the odds
			var horse = $(".horse" + hand_number);
			var images = horses[hand_number - 1];
			horse.attr("src", images.run);
			
			if (odds == 0) {
				odds = 32;
			}
			
			var factor = Math.log(odds) + 1;
			var offset = (width / factor) - margin;  //(width - margin) / odds;
			offset = Math.max(offset, 10);
			offset = Math.min(offset, width - margin);
			
			horse.css("left", offset + "px");
		}
	}
	
	function clear_function(state) {
	    //reset UI to its starting configuration
	    $(".handType,.bidOdds").html("");
	    $(".bet").html("Bet: $0");
	    $(".return").html("Return: $0");
	    $(".main-table-list-item .card").html("");
	    $(".horse").hide();
	    $(".main-table-list-item").css("background-image", "none");
	    $(".overlay-winner").hide();
	}
	function clicked(id) {
	    window.location.href = "/results.html?tournament_id=" + id;
	}
	
	function intValue(selector) {
		return parseInt($(selector).eq(0).text().replace(/[^0-9]/g, ""), 10);
	}
	
	function confirm_bet(button) {
		//FIXME:  something is severely broken here!!!
		
	    var state = RP.externalState();
	    var currentBalance = intValue(".currentBalance");
	    //var odds = parseFloat($(button).parents(".overlay").find(".betOdds").text().replace(/[^0-9\.]/g, ""));
		var odds = parseInt($(button).parents(".overlay").find(".betOdds").text().replace(/[^0-9]/g, ""), 10);
	    var currentBet = parseInt($(button).parents("form").eq(0).find(".betTotal").text().replace(/[^0-9]/g, ""), 10);
	    var handNum = parseInt($(button).parents(".overlay").find(".betType").text().split(".")[0], 10);
	    
	    var payout = (currentBet * odds) + "";
		payout = parseInt(payout.substring(0, payout.length - 2), 10);
	    
	    //display bet if valid/confirmed
	    if (betsEnabled && state.flags.bets_confirm && currentBet <= currentBalance && odds > 0 && currentBet > 0 && handNum > 0) {
	    	var winnings = Math.floor(payout);
	    	var betSuccess = RP.placeBet(handNum, currentBet, winnings);
	    	if (betSuccess) {
	    		//draw to 'bets' table
	    		$(".currentGameBets").append("<tr><td>" + handNum + "</td><td>$" + currentBet.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "</td><td>$" + winnings.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "</td></tr>");
	    		
	    		//XXX:  need to refresh the state here, as calling 'placeBet' may have changed things
	            state = RP.externalState();
	    		
	    		//update amout bet on the current hand
	    		var index = handNum - 1;
	            var handBets = $(".main-table-list-item").eq(index).find(".bet");
	            handBets.html("Bet:  $" + parseInt(state.bets[index].bet, 10).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	            
	            //update return for the current hand
	            var handReturns = $(".main-table-list-item").eq(index).find(".return");
	            handReturns.html("Return:  $" + parseInt(state.bets[index].payout, 10).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	            
	            var outlay = intValue(".currentOutlay");
	            outlay += currentBet;
	            $(".currentOutlay").html("$" + outlay.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	    		
	    		//$(".overlay").hide();
	            $(".closeBets").trigger("click");
	    	}
	    	else {
				//FIXME:  error message	
	    	}
	    }
	    else {
	    	//FIXME:  error message
	    }
	}
	
	function send_exit(state) {
	    $.getJSON("/Exit_tournament", {
	        "tournament_id": state.options.tournamentId,
	        "user_credits": state.user.current_player_points,
	        "username": state.user.username
	    }, function(data) {
	    });
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
	}
	
	//XXX:  no chat in new game UI???
	function send_chat1() {
		var state = RP.externalState(); 
		
	    /*var chat_body = document.getElementById("chat_body2");
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
	    chats.scrollTop = chats.scrollHeight;*/
	    
	    //FIXME:  implement; dispatch chat message
	    
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
		
		//XXX:  only achievement reported currently (and in original game) is hisghest profit from a win
		if (state.stats.last_win > 0 /*&& ! state.options.isGuestMode*/) {
			if (! state.stats.highest_profit || state.stats.highest_profit < state.stats.last_win) {
				if (! window._lastWin || state.stats.last_win > winfow._lastWin) {
					window._lastWin = state.stats.last_win;
					$(".achievementProfit").html((state.stats.last_win + "").replace(/\B(?=(\d{3})+(?!\d))/g, ","));
					$(".overlay-achievements").show();		//no equivalent 'v2' popup
				}
			}
		}
		
	    /*
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
	    }*/
	    
	    //FIXME:  implement; show previous game stats
	});

	document.addEventListener(RP.eventTypes.prevGame1, function(evt) {
		var state = evt.detail;
		
		/*$("previous_game").show();
	    
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
	    oCell3.innerHTML = state.stats.last_win;*/
	    
	    //FIXME:  implement; show previous game info
	});

	document.addEventListener(RP.eventTypes.playerBalanceExt, function(evt) {
		var state = evt.detail;
		var k = state.count;
		var rank = parseInt(k, 10) + 1;
		
		//display balance, bitlets, and rank
		//FIXME:  also player level?
		$(".currentBalance").html("$" + parseInt(state.user.current_player_points).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$(".currentBitlets").html(parseInt(state.user.current_bitlets).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		
		//FIXME:  appears broken
		$(".mobile-position,.tabs .special").html("<b>Position:  </b>" + (parseInt(k) + 1) + " of " + (state.players.connected_players.length));
		$(".popup-position").html((parseInt(k) + 1) + " of " + (state.players.connected_players.length));
		$(".numPlayers").html(state.players.connected_players.length);
		
		if (window._end_popup_needed) {
			window._end_popup_ranks++;
			if (window._end_popup_ranks >= state.players.connected_players.length) {	//wait until the ranks for allplayers have been updated
				//multiplayer/pot-poker tournaments; display final winnings based on rank
				console.log("Ending rank (2): " + rank);
				window._end_popup_needed = false;
				window._end_popup_ranks = 0;
				if (rank > 3) {
					$('.great-job').hide();
					$('.credits-rank-other').parent().show();
					if ($('.gold-rank-1').text() != "0") {
						$('.gold-rank-other').parent().show();
					}
				}
				else {
					$('.great-job').show();
					$('.credits-rank-' + rank).parent().show();
					if ($('.gold-rank-1').text() != "0") {
						$('.gold-rank-' + rank).parent().show();
					}
				}
				
				//show the popup now that it's configured
				var finalBalance = intValue(".currentBalance");
				if (finalBalance > 0) {
					$('.overlay-play-again-user-v2').show();
				}
				else {
					$('.overlay-play-again-user-loss-v2').show();
				}
			}
		}
		
		/*
	    var div33 = document.getElementById("current_level");
	    if (state.user.total_level > 0) {
	        div33.innerHTML = "Level: " + state.user.current_level + "&nbsp;" + "<span style=\"color:#FFFFFF\" >" + "+" + "&nbsp;" + state.user.total_level + "</span>";
	    }
	    else {
	        div33.innerHTML = "Level: " + state.user.current_level;
	    }
	    */
	});

	document.addEventListener(RP.eventTypes.playerBalance, function(evt) {
		var state = evt.detail;
		if (! state.options.isSinglePlayer) {
			return;
		}
		
		//display balance
		$(".currentBalance").html("$" + parseInt(state.user.current_player_points).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	}); 

	document.addEventListener(RP.eventTypes.finished, function(evt) {
		var state = evt.detail;
		if ( state.options.isSinglePlayer) {
			return;
		}
		
		/*var div31 = document.getElementById("current_balance");
		var append1 = state.options.isGuestMode ? "" : "<button  data-role=\"button\" id=" + state.options.tournamentId + " onclick=\"clicked(this.id)\" style=\"color:black\" data-mini=\"true\" data-inline=\"true\"> Show results </button>";
	    div31.innerHTML += append1;
	    var gamestatus = document.getElementById("game_status");
	    gamestatus.innerHTML = "Tournament Finished";*/
	    
	    //FIXME:  implement; display tournament status
	});

	document.addEventListener(RP.eventTypes.end, function(evt) {
		var state = evt.detail;
		
		/*if (state.options.isSinglePlayer) {
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
	    }*/
	    
	    //FIXME:  implement; display tornament results
	});

	document.addEventListener(RP.eventTypes.currentPlayer, function(evt) {
		var state = evt.detail;
		
		/*var div31 = document.getElementById("current_balance");
	    div31.innerHTML += "<br/>" + "Balance: " + state.user.current_player_points;
	    div31.innerHTML += "<br/>" + "Your Last Win: " + state.lastWin;*/
	    
	    //FIXME:  implement; display player info
	});

	document.addEventListener(RP.eventTypes.handType, function(evt) {
		var state = evt.detail;
		var handType = state.type;
		var handNum = state.stats.hand_number;
		
		//display hand info
		$(".main-table-list-item").eq(handNum - 1).find(".handType").html(handType);
	});

	document.addEventListener(RP.eventTypes.winType, function(evt) {
		var state = evt.detail;
		var gameNumber = parseInt($(".gameNumber").text().split(" of ")[0], 10);
		var handNumber = state.stats.hand_number;
		
		var allBets = 0;
		var allReturns = 0;
		var betsOnWinningHand = 0;
		var betStats = [{bet: 0, ret: 0}, {bet: 0, ret: 0}, {bet: 0, ret: 0}, {bet: 0, ret: 0}, {bet: 0, ret: 0}, {bet: 0, ret: 0}];
		$(".currentGameBets").eq(0).find("tr").each(function() {
			var betHand = parseInt($(this).find("td").eq(0).text(), 10);
			var betAmount = parseInt($(this).find("td").eq(1).text().replace(/[^0-9]/g, ""), 10);
			var retAmount = betHand == handNumber ? parseInt($(this).find("td").eq(2).text().replace(/[^0-9]/g, ""), 10) : 0;
			
			betStats[betHand - 1].bet += betAmount;
			betStats[betHand - 1].ret += retAmount;
			
			allBets += betAmount;
			allReturns += retAmount;
			betsOnWinningHand += retAmount > 0 ? betAmount : 0;
		});
		
		//track/report "shots"
		if (allReturns > allBets) {
			shotsEarned++;
		}
		else {
			shotsEarned = 0;
		}
		
		var shots = "&nbsp;";
		if (shotsEarned >= 10) {
			shots = "10shot";
		}
		else if (shotsEarned >= 2) {
			shots = shotsEarned + "shot";
		}
		
		//output betStats to history table
		//FIXME:  unused?
		for (var index = 0; index < betStats.length; index++) {
			var stats = betStats[index];
			if (stats.bet > 0) {
				//track/report "shots"
				/*if (stats.ret > stats.bet) {
					shotsEarned++;
				}
				else {
					shotsEarned = 0;
				}
				
				var shots = "&nbsp;";
				if (shotsEarned >= 10) {
					shots = "10shot";
				}
				else if (shotsEarned >= 2) {
					shots = shotsEarned + "shot";
				}*/
						
				var row = "<td>" + gameNumber + "</td><td>" + (index + 1) + "</td><td>$" + stats.bet + "</td><td>$" + stats.ret + "</td><td>" + shots + "</td>"
				//$(".previousGameResults").append("<tr>" + row + "</tr>");
			}
		}
		
		//output summary stats
		var row = "<td>" + gameNumber + "</td><td>" + handNumber + " " + state.stats.winning_type + "</td><td>$" + parseInt(allBets, 10).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "</td><td>$" + parseInt(allReturns, 10).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "</td><td>" + shots + "</td>";
		$(".previousGameResults").append("<tr>" + row + "</tr>");
		
		//clear current bets
		$(".currentGameBets").find("tr").remove();
		
		//reset outlay
		$(".currentOutlay").html("$0");
		
		var rank = intValue(".rank");
		var profitMade = allReturns > allBets;
		var bonusPopupAvailable = !(state.options.isGuestMode || state.options.isSinglePlayer);
		var bonusPopupWillDisplay = bonusPopupAvailable && profitLastRound;
		
		if (! bonusPopupWillDisplay) {
			if (state.options.isGuestMode) {
				$(".noGuestMode").hide();
			}
			if (gameNumber < state.stats.total_games) {
				//XXX:  overlay-result - [displayed at the end of each normal round]
		        $(".winAmount").html(allReturns.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				$(".winningHandType").html(state.stats.winning_type);
				
				var odds = allReturns / betsOnWinningHand;
				$(".lastOdds").html("$" + odds.toFixed(2));
				$(".lastBet,.overlay-v2 .totalBets").html("$" + betsOnWinningHand.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				$(".lastReturn,.overlay-v2 .totalWinnings").html("$" + allReturns.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				$(".overlay-v2 .totalProfit").html("$" + (allReturns - allBets).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				$(".overlay-v2 .totalLosses").html("$" + (allBets - allReturns).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				
				$(".multiplayerRank").hide();
				if (! state.options.isSinglePlayer) {
					$(".multiplayerRank").show();
				}
				
				//XXX:  add a delay to ensure the hands are correct when we grab them
				setTimeout(function () {
					$(".winningCards").html($(".main-table-list.card-holder .cards").eq(handNumber - 1).html());
					
					//$('.overlay-winner').show();
					if (profitMade) {
						$('.overlay-result-win-v2').show();
					}
					else {
                		//need to override this line to show all bets rather than just the bets placed on the winning hand
                		$(".lastBet,.overlay-v2 .totalBets").html("$" + allBets.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
						$('.overlay-result-loss-v2').show();
					}
					
					//auto-dismiss after 5 seconds
					setTimeout(function() {
						$("div[class*='overlay-result']").hide();
					}, 5000)
				}, 700 * handNumber);
			}
			else if (gameNumber >= state.stats.total_games /*&& rank <= 3*/) {
				//XXX:  overlay-play-again - ["Game Over" screen for end of the tournament; two variants depending upon whether the user has chips remaining or not]
				if (! state.options.isSinglePlayer) {
					$(".resultsXp").hide();					
					//$('.overlay-results').show();
				}
			
				//FIXME:  ensure popups have all required info
				//FIXME:  should these trigger only after a final 'result'/'bonus' popup has been displayed and dismissed?
				var finalBalance = intValue(".currentBalance");
				if (! state.options.isGuestMode) {
					//logged-in user popup
					if (!state.options.isSinglePlayer) {
						//multiplayer/pot-poker tournaments; display final winnings based on rank (which isn;t refreshed until later)
						console.log("Ending rank (1): " + rank);
						window._end_popup_needed = true;
						window._end_popup_ranks = 0;
					}
					else if (finalBalance > 0) {
						$('.overlay-play-again-user-v2').show();
					}
					else {
						$('.overlay-play-again-user-loss-v2').show();
					}
				}
				else {
					//guest-mode popup
					if (finalBalance > 0) {
						$('.overlay-play-again-guest-v2').show();
					}
					else {
						$('.overlay-play-again-guest-loss-v2').show();
					}
				}
			
				gameRunning = false;
			}
		}
		
		//display winning hand type
		$(".main-table-list-item").eq(handNumber - 1).find(".handType").html(state.stats.winning_type);
		
		//celebrate the win
		$(".main-table-list-item").eq(handNumber - 1).css("background-image", "url(/images/stars-1.GIF)");
		
		//update status
		profitLastRound = profitMade;
	});

	document.addEventListener(RP.eventTypes.winningHand, function(evt) {
		var state = evt.detail;
		
		//show the winning hand
	    move_horse(-1, state.stats.hand_number, state);
	});

	document.addEventListener(RP.eventTypes.clear, function(evt) {
		var state = evt.detail;
		var split = state.split;
		
		/*var div_id1 = "house" + state.stats.hand_number;//split;//state.stats.hand_number;
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
	    }*/
	    
	  	//FIXME:  implement; reset UI
	    
	  	betsEnabled = false;
	    clear_function(state);
	});

	document.addEventListener(RP.eventTypes.loaded, function(evt) {
		var state = evt.detail;
		
		gameRunning = true;
		$(".overlay-loading-v2 .progress").css("width", "100%");
		setTimeout(function() {
			$(".overlay-loading-v2").hide();
		}, 300)
		
		/*$("#loading_popup").modal('hide');

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
	        " </div></div>";*/
	        
	        //FIXME:  implement; clear loading UI
	});

	document.addEventListener(RP.eventTypes.playerRank, function(evt) {
		var state = evt.detail;
		var rank = state.position;
		
		$(".rank").html(rank);
		//if (rank <= 3) {
			//FIXME:  does not trigger from here; use the winType and manually check for last game
			//$('.overlay-results').show();
		//}
		
		/*if (rank == 1) {
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
		}*/
		
		//FIXME:  implement; display end of tournament wrap-up
	});

	document.addEventListener(RP.eventTypes.startTimer, function(evt) {
		var state = evt.detail;
		var seconds = state.seconds;
		
		//reset timer styles
		$(".inGameTimer span").css("font-size", "17px");
		//$(".inGameTimer span").css("color", "rgba(255, 255, 255, 0.85)");
		//$(".inGameTimer span b").css("color", "black");
		
		//start timer
		$(".timerSecs").html(seconds);
		
		//enable betting
		betsEnabled = true;
		$(".submit-bid").removeClass("disabled");
		$(".submit-bid").removeAttr("disabled", "disabled");
		
		//enable fast-forward (single-player and guest mode only)
		if (parseInt(state.stats.running_deal_number, 10) >= 4) {
			if (state.options.isGuestMode || state.options.isSinglePlayer) {
				$(".currentPlayer .fastForwardButton").show();	//FIXME:  will not work because the button constantly repaints
			}
		}
		
		/*if (state.options.isSinglePlayer) {
	    	$("#deal_button").show();
	    	if (document.getElementById("ready")) {
	    		document.getElementById("ready").disabled = false;
	    	}
	    }
	    
	    if (state.options.isGuestMode) {
	    	if (parseInt(state.stats.running_game_number) % 2 == 0 && parseInt(state.stats.running_deal_number) == 1) {
	    		$("#register_popup").modal('show');
	    	}
	    	else {
	    		$("#register_popup").modal('hide');
	    	}
	    }*/
	});

	document.addEventListener(RP.eventTypes.stopTimer, function(evt) {
		//stop/clear timer
		var state = evt.detail;
		
		//zero timer
		$(".timerSecs").html("0");
		
		//stop pulsing
		$(".inGameTimer").removeClass("pulsate-fwd");
	
		//disable betting
		betsEnabled = false;
		$(".submit-bid").addClass("disabled");
		$(".submit-bid").attr("disabled", "disabled");
		
		//dismiss bets overlay (if present)
		$(".closeBets").trigger("click");
		
		//disable fast-forward
		$(".fastForwardButton").hide();
		
		//reset timer styles
		$(".inGameTimer span").css("font-size", "17px");
		//$(".inGameTimer span").css("color", "rgba(255, 255, 255, 0.85)");
		//$(".inGameTimer span b").css("color", "black");
		
		//FIXME:  hide the 'deal' button (single-player mode only)
	});

	document.addEventListener(RP.eventTypes.timerTick, function(evt) {
		var state = evt.detail;
		var seconds = state.seconds;
		var milliseconds = state.milliseconds;
		
		var red = 255;
		var green = 255;
		var blue = 255;
		
		var fontSize = 17;
		var maxExtraSize = 0;//9;
		var extraFontSize = 0;
		var animationTime = 10000.0;
		if (milliseconds < animationTime) {
			var progress = (animationTime - milliseconds) / animationTime;  //0 -> 1
			extraFontSize = progress * maxExtraSize; //Math.round(progress * maxExtraSize);
			
			green -= Math.ceil(green * progress);
			blue = green;
			
			if (! $(".inGameTimer").hasClass("pulsate-fwd")) {
				$(".inGameTimer").addClass("pulsate-fwd");
			}
		}
		else {
			$(".inGameTimer").removeClass("pulsate-fwd");
		}
		
		//update font size
		$(".inGameTimer span").css("font-size", (fontSize + extraFontSize) + "px");
		
		
		//update font color
		//$(".inGameTimer span").css("color", "rgb(" + red + ", " + green + ", " + blue + ")");
				
		//update timer text
		$(".timerSecs").html(seconds);
	});

	document.addEventListener(RP.eventTypes.checkHand, function(evt) {
		var state = evt.detail;
		
		//flash the bet/odds details for this hand
		var i = state.index;
		$(".main-table-list-item").eq(i).find(".bid").fadeOut('slow').fadeIn('slow');
	}); 

	document.addEventListener(RP.eventTypes.resetOdds, function(evt) {
		var state = evt.detail;
		var handIndex = state.stats.hand_number - 1;
		
		//disable bets for this hand
		$(".main-table-list-item").eq(handIndex).find(".bid .bidOdds").html("No Bets");
		
		setTimeout(function() {
			$(".submit-bid").eq(handIndex).addClass("disabled");
			$(".submit-bid").eq(handIndex).attr("disabled", "disabled");
		}, 100);
	    
	    move_horse(0, state.stats.hand_number, state);
	});

	document.addEventListener(RP.eventTypes.zeroOdds, function(evt) {
		var state = evt.detail;
		
		/*var div_id = "hand" + state.stats.hand_number + "_" + "bet";
	    var odds_div = document.getElementById(div_id);
	    odds_div.style.textShadow = "none";
	    odds_div.style.color = "Black";*/
	    
	    //FIXME:  implement; clear the odds?
	});
	
	var flashRows = [];
	document.addEventListener(RP.eventTypes.updateOdds, function(evt) {
		var state = evt.detail;
		var handIndex = state.stats.hand_number - 1;
		var container = $(".main-table-list-item").eq(handIndex);
		
		//reset the rows
		if (handIndex == 0) {
			flashRows = [];
		}
		
		var oddsAmount =  "$" + state.split2 + "0";
		var curOdds = parseFloat(state.split2);
		var prevOdds = container.find(".bid .bidOdds").html() ? parseFloat(container.find(".bid .bidOdds").html().substring(1)) : NaN;
		
		//display odds and update horses
		container.find(".bid .bidOdds").html(oddsAmount);
		
		//check to see if the odds have improved; highlight the row if they have
		if (! isNaN(curOdds) && ! isNaN(prevOdds) && curOdds < prevOdds) {
			flashRows.push(handIndex);
		}
		
		//do this at the end so that all rows flash in unison
		if (handIndex == 5 && flashRows.length > 0) {
			/*container.addClass("pulse-red");
			setTimeout(function() {
				$(".pulse-red").removeClass("pulse-red");
			}, 2000);*/
			var rows = flashRows;
			$.each(rows, function() { 
				$(".main-table-list.card-holder").find("li").eq(this).addClass("pulse-white");
			});
			setTimeout(function() {
				$.each(rows, function() { 
					$(".main-table-list.card-holder").find("li").eq(this).removeClass("pulse-white"); 
				});
			}, 1500);
		}
		
		move_horse(state.split2, state.stats.hand_number, state);
	});

	document.addEventListener(RP.eventTypes.updateCard, function(evt) {
		var state = evt.detail;
	    
		//show image for the updated card
		var card = "/images/" + state.cardType + ".gif";
	    show_image(card, state.stats.hand_number, state.odds, state.stats.hand_card_count, state.useful, state);
	});

	document.addEventListener(RP.eventTypes.discardHand, function(evt) {
		var state = evt.detail;
		
		//reset the card operation queue
		//cardOperationQueue = [];
		
		//queue operations (in case the immediate update is premature)
		for (var index = 0; index < 5; index++) {
			var op = {
				handIndex: state.stats.hand_number - 1,
				cardIndex: index,
				img: "/images/pt-card.png",
				priority: new Date().getTime()
			};
		}
		
		//immediately reset card images for the specified hand
		$(".main-table-list-item").eq(state.stats.hand_number - 1).find(".card img").attr("src", "/images/pt-card.png");
	});

	document.addEventListener(RP.eventTypes.checkHands, function(evt) {
		for (var i = 1; i < 7; i++) {		
			/*var house_div = "hand" + i + "_bet";		
			var house_div1 = document.getElementById(house_div);
			if (house_div1) {
				house_div1.style.color = "black";	
			}*/
			
			//FIXME:  implement; mark hands?
		}
	});

	document.addEventListener(RP.eventTypes.chatMessage, function(evt){
		var state = evt.detail;
		/*var chat_body = document.getElementById("chat_body2");

		//var chat_player_name = document.createElement("DIV");
	    var chat_msg = document.createElement("DIV");

	    chat_msg.innerHTML = "<span style=\"color:green; font-size:14px\">" + state.user_name + "</span>" + "<span>" + "&nbsp;&nbsp;" + "</span>" + "<span class=\"text-cross\">" + state.msg + "</span>";
	    chat_body.appendChild(chat_msg);

	    var chats = document.getElementById("chat_body2");
	    chats.scrollTop = chats.scrollHeight;*/
	    
	    //FIXME:  implement; display chat message
	});

	document.addEventListener(RP.eventTypes.socketClosed, function(evt){
		window.location.href = "/Error.html";
	});

	document.addEventListener(RP.eventTypes.redeal, function() {
		/*var game_status = document.getElementById("game_status");
	    game_status.innerHTML = "Winner on First deal. So,Redeal";*/
	    
	    //FIXME:  implement; display game status
	});

	//used only in multiplayer (tournament, pot-poker) modes
	document.addEventListener(RP.eventTypes.playerBonus, function(evt) {
		//show bonus popup
		var state = evt.detail;
		
		//overlay-bonus-img [for when shots/bonus are earned]
		$(".bonusType,.overlay-v2 .numShots").html(state.bonus.bonus_type);
		$(".bonusCredits,.overlay-v2 .bonusChips").html(parseInt(state.bonus.bonus_amount).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$(".bonusGold").html(parseInt(state.split9).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$(".bonusLevel").html(parseInt(state.split10));
		
		//also required:  .totalBets, .totalWinnings, .totalProfit, .winningCards, .winningHandType (these are populated elsewhere)
		
		$(".popup-bonus-img-bottom-text").show();
		if (state.stats.running_game_number >= state.stats.total_games) {
        	$(".popup-bonus-img-bottom-text").hide();
        }
		
		//$(".overlay-bonus-img").show();
		$(".overlay-bonus-v2").show();
		
		//FIXME:  also update displayed level, credits, and bitlets to include the bonus amount(s) ???
		
		/*$("#bonus_popup").modal('show');
	    setTimeout(function() {

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
	    }, 3000);*/
	});

	document.addEventListener(RP.eventTypes.dealNumber, function(evt) {
		var state = evt.detail;
		$(".overlay-loading-v2,.overlay-skip-v2").hide();
		//var gameNum = state.stats.running_game_number;
		
		
		//FIXME:  if the deal number is 4 or higher, enable the 'Skip' button
		
		/*var divdeal = document.getElementById("deal_number");
	    divdeal.innerHTML = "Deal :" + state.stats.running_deal_number;

	    var game_status = document.getElementById("game_status");
	    game_status.innerHTML = "Game in Progress" + "&nbsp; &nbsp;" + "<img id=\"improgress\" src=\"/images/green_loading.gif\" width=\"90\" height=\"10\" />";*/
	    
	    //FIXME:  implement; update deal status
	});

	document.addEventListener(RP.eventTypes.gameNumber, function(evt) {
		var state = evt.detail;
		var gameNum = state.stats.running_game_number;
		var lastGameNumber = parseInt($(".gameNumber").html().split(" of ")[0], 10);
		
		//display game status
		$(".gameNumber").html(gameNum + " of " + state.stats.total_games);
		
		var credits = intValue(".currentBalance");
		if (checkedGameNumber != gameNum && credits < 1) {
			//player has run out of credits, show 'no chips' popup
			if (state.options.isGuestMode) {
				$(".overlay-no-chips-guest-v2").show();
			}
			else if (state.options.isSinglePlayer) {
				$(".overlay-no-chips-user-v2").show();
			}
		}
		else if (gameNum == state.stats.total_games && lastGameNumber == state.stats.total_games - 1) {
			if (state.options.isGuestMode) {
				//show registration popup
				$('.overlay-bonus').show();		//"join now for bonus credits"; no equivalent 'v2' popup
			}
		}
		
		checkedGameNumber = gameNum;
	});

	document.addEventListener(RP.eventTypes.userInfo, function(evt) {
		var state = evt.detail;
		/*var div31 = document.getElementById("current_name");
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
	    }*/
	    
	    //FIXME:  implement; display user info
	});
	document.addEventListener(RP.eventTypes.start, function(evt) {
		var state = evt.detail;
		/*if (! state.options.isGuestMode) {
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
	    }*/
	    
	    //FIXME:  implement; start game
	    RP.setHelpState(true);
	    
	    //loading spinner
	    $(".overlay-loading-v2").show();
	    
	    //failsafe in case game is unable to load
	    setTimeout(function(){
	    	//check visibility and alert user of connection error
	    	if ($(".overlay-loading-v2:visible").length > 0) {
	    		$(".overlay-loading-v2").hide();
	    		alert("We're sorry, but we could not connect to your game.\n\nPlease refresh the page to try again.");
	    	}
	    }, 25000);
	    
	    
	});

	document.addEventListener(RP.eventTypes.init, function(evt) {
		/*if ($("#bets_popup").length > 0) {
			$("#bets_popup").modal('hide');
		}

	    $("#div21").hide();
	    $("#div23").hide();
	    $("#div22").hide();
	    $("#previous").hide();
	    $("#bonus_head").hide();
	    
	    $("#loading_popup").modal('show');*/
	    
	    //FIXME:  implement; show loading UI [no, don't do this here; appears too early in guest mode]
		//$(".overlay-loading-v2 .progress").css("width", "0%");
		//$(".overlay-loading-v2").show();
	});
	
	$(document).ready(function() {
		if (window.playingList) {
			<c:if test="${ ! empty user && user.musicEnabled }">
				playingList('audioplayer-two');
			</c:if>
			<c:if test="${ ! empty user && ! user.musicEnabled }">
				window._audioStartRequired = true;
			</c:if>
			<c:if test="${ empty user }">
				if (window.localStorage && localStorage.getItem("rp.music.enabled")) {
					playingList('audioplayer-two');
				}
				else {
					window._audioStartRequired = true;
				}
			</c:if>
		}
	});
</script>