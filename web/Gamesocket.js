(function() {
	if (window.RP) {
		console.log("ERROR:  RacingPoker gameplay module already appears to have been loaded; bailing out!");
		return;
	}
	
	window.RP = {};
	
	//event types; public
	RP.eventTypes = {
		init: "rp.init",					//The game has loaded and will begin execution
		start: "rp.start",					//The game is ready to start loading
		loaded: "rp.loaded",				//The game has loaded and is about to start
		end: "rp.game.end",					//The game has reached its end
		finished: "rp.game.finish",			//The game has finished (this occurs after 'end')
		userInfo: "rp.user.info",			//Information is available about the current player	
		currentPlayer: "rp.player.info",	//Information about the current player's score
		gameNumber: "rp.game.number",		//The current game number is being updated (probably because a new round has begun?)
		dealNumber: "rp.deal.number",		//The deal number for the current round is being updated
		playerBonus: "rp.player.bonus",		//A player has received a bonus
		redeal: "rp.redeal",				//A winning hand occurred on the initial deal, the round will be restarted
		socketClosed: "rp.socket.closed",	//The websocket has been closed
		chatMessage: "rp.chat.msg",			//A chat message has been received from another player
		checkHands: "rp.hands.check",		//The current hands should be checked (for what???)
		discardHand: "rp.hand.discard",		//A hand should be discarded/reset
		updateCard: "rp.card.refresh",		//The value of a card has changed
		updateOdds: "rp.odds.refresh",		//The odds of a hand have changed	
		zeroOdds: "rp.odds.zero",			//The odds of a hand have become zero
		resetOdds: "rp.odds.reset",			//The odds of a hand should be reset (same as zero odds, but updates horse position and adds some text???)
		startTimer: "rp.timer.start",		//The deal timer is starting
		stopTimer: "rp.timer.stop",			//The deal timer has stopped
		timerTick: "rp.timer.tick",			//The deal timer should be updated
		checkHand: "rp.hand.check",			//A single hand should be checked (for what???)
		handType: "rp.hand.type",			//Info about the type of a hand in the game is available
		playerRank: "rp.player.rank",		//A game has finished and the player's rank is available	
		winningHand: "rp.hand.win",			//A hand has won the current round
		winType: "rp.win.type",				//Info about the type of hand that won the game is available
		clear: "rp.game.clear",				//A game has completed and the UI should reset for the next round
		playerBalance: "rp.player.balance",	//The player's balance is available (single-player mode only)
		playerBalanceExt: "rp.player.bal2",	//The player's balance is available (multi-player modes only)
		connectedPlayers: "rp.players",		//Details about the connected players are available (not fired in single-player mode)
		prevGame1: "rp.game.prev1",			//Details about the previous game should be reported (part 1 of 2)
		prevGame2: "rp.game.prev2",			//Details about the previous game should be reported (part 2 of 2)
		connectFailed: "rp.net.fail"		//We could not connect to the game
	};
	
	//FIXME:  update all references to public things to go through 'RP' namespace
	//public setting for integrated help
	RP.setHelpState = function(enabled) {
		interfaceState.help.enabled = enabled;
	};

	//creates a detached copy of the game state, public
	RP.externalState = function(extra) {
		var source = Object.assign({}, gameData);
		source.webSocket = undefined;
		
		var result = JSON.parse(JSON.stringify(source));
		result.interfaceState = JSON.parse(JSON.stringify(interfaceState));
		
		if (extra) {
			result = Object.assign(result, extra);
		}
		
		return result;
	};
	
	//public
	RP.setCurrentPlayerInfo = function(email, nick) {
		var oldNick = gameData.options.current_player;
		
		gameData.user.email = email;
		gameData.user.username = nick;
		gameData.user.screenname = nick;
		gameData.user.current_player = nick;
		
		for (var index = 0; index < gameData.players.sorted_connected_players.length; index++) {
			if (gameData.players.sorted_connected_players[index] == oldNick) {
				gameData.players.sorted_connected_players[index] = nick;
			}
			if (gameData.players.connected_players[index] == oldNick) {
				gameData.players.connected_players[index] = nick;
			}
		}
	}
	    
	//public
	RP.start_game = function(refreshOptions) {
		if (window.options && refreshOptions) {
			gameData.options = options;
		}
		
		//set default audio settings based upon options
		interfaceState.audio.enabled = gameData.options.audioOn;		//music?
		interfaceState.help.enabled = gameData.options.helpOn;			//speech?
		
	    if (! options.isGuestMode) {
	    	gameData.options.tournamentId = gameData.options.tournamentId.replace(/"/gi, "");
	        gameData.user.username = gameData.options.username;
	        gameData.user.current_player = gameData.options.playerName;
	        
	        console.log(gameData.user.username);
	        console.log(gameData.options.tournamentId);
	    	
	    	$.getJSON("/FrontControl", {
		        "username": gameData.user.username,
		        "command": "user_details"
		    }, function(data) {
		        var split_data = data.user_detail;
		        var user_split = split_data.split(",");
		        var user_credit = user_split[1];
		        var user_fname = user_split[2];
		        var user_lname = user_split[3];
		        var user_nname = user_split[0];
		        var user_level = parseInt(user_split[7]);
		        
		        gameData.user.current_level = parseInt(user_level);
		        gameData.user.current_bitlets = parseInt(user_split[6]);
		        gameData.user.current_player = user_nname;
		        
		        gameEvent("userInfo");
		    });
		    $.getJSON("/Achievements", {
		        "username": gameData.user.username,			
		        "command": "get"
		    }, function(data) {
		        console.log(data);
		        if (! data) {
	        	    data = {};
	            }
	            if (! data.achievement) {
	        	    data.achievement = "0,0,0,0,0,0,0";
	            }
		        
		        achievements_length = data.achievement.split(",").length;
		        gameData.stats.highest_profit = parseInt(data.highest_profit);
		        gameData.stats.highest_odds = parseInt(data.highest_odds);
		        gameData.stats.royal_flush = parseInt(data.royal_flush);
		        gameData.stats.straight_flush = parseInt(data.straight_flush);
		        gameData.stats.reach_level = parseInt(data.reach_level);
		    });
	    }
	    else {
	    	gameData.user.username = gameData.user.screenname;
	    	gameData.user.current_player = gameData.user.screenname;
	    	if (! gameData.options.tournamentId || gameData.options.tournamentId == "") {
	    		gameData.options.tournamentId = "guest_mode";
	    		gameData.options.tournamentId = "guest_mode";
	    	}
	    }
	    
	    //post 'start' event
	    gameEvent("start");
	    
	    setTimeout(function() {
	        socket_connection();
	    }, 1000);

	};
	
	//public API
	RP.placeBet = function(handNum, betAmount, returnAmount) {
		var message = "bet:true" + "," + "hand_number" + ":" + handNum + "," + "username" + ":" + gameData.user.username + "," + "game_number" + ":" + gameData.stats.running_game_number + "," + "deal_number" + ":" + gameData.stats.running_deal_number + "," 
					  + "bet_amount" + ":" + betAmount + "," + "return_amount" + ":" + returnAmount;
	    
		var result = false;
		if (gameData.stats.tournament_bets > 0 || gameData.stats.running_game_number <= gameData.stats.total_games || gameData.flags.check_games || gameData.options.isSinglePlayer) {
			gameData.webSocket.send(message);
	        result = true;
		}
	    
	    //FIXME:  probably this should only happen if the server accepts the bet?
	    gameData.user.current_bet_amount += betAmount;
	    gameData.stats.total_bets += parseFloat(betAmount);

	    //XXX:  handNum is 1-based!!!
	    gameData.bets[handNum - 1].bet += parseFloat(betAmount);
	    gameData.bets[handNum - 1].payout += returnAmount;

	    if (gameData.options.isSinglePlayer) {
	    	gameData.stats.tournament_bets += gameData.stats.total_bets;
	    }
	    gameData.stats.bet_amount = 0.0;
	    
	    return result;
	}

	//public API
	RP.validateBetAmount = function(amount) {
		gameData.stats.bet_amount += amount;
		if (gameData.stats.bet_amount > gameData.user.current_player_points) {
			gameData.flags.bets_confirm = false;
		}
		else {
			gameData.flags.bets_confirm = true;
		}
		
		return gameData.flags.bets_confirm;
	}

	//public API
	RP.eraseLastBet = function() {
		gameData.stats.bet_amount = 0.0;
	}

	//public API
	RP.setAudioEnabled = function(enabled) {
		interfaceState.audio.enabled = enabled;
		if (! enabled && interfaceState.audio.responsiveVoice) {
			interfaceState.audio.responsiveVoice.cancel();
		}
	}

	//public API
	RP.exitGame = function() {
		gameData.webSocket.send("exit:true");
	}

	//public API
	RP.forceDeal = function() {
		if (! gameData.options.isSinglePlayer) {
			return;
		}
	    gameData.flags.timer_flag = false;
	    var message = "deal:true";
	    gameData.webSocket.send(message);
	}
	
	//public API
	RP.fastForward = function() {
		if (! gameData.options.isSinglePlayer && ! gameData.options.isGuestMode) {
			return;
		}
	    gameData.flags.timer_flag = false;
	    
	    //FIXME:  unclear why, but only posts successfully if the message looks like a bet message; some sort of prefiltering happening on the server?
	    //FIXME:  can still get stuck unable to send sometimes???
	    //var message = "fastforward:true\n";
	    var message = "bet:true" + "," + "hand_number" + ":" + -1 + "," + "username" + ":" + gameData.user.username + "," 
	    			  + "game_number" + ":" + gameData.stats.running_game_number + "," + "deal_number" + ":" + gameData.stats.running_deal_number + "," 
					  + "bet_amount" + ":" + 0 + "," + "return_amount" + ":" + 0 + ",fastforward:true";
	    
	    var res = gameData.webSocket.send(message);
	}
	

	//public API
	RP.chatMessage = function(msg) {
		if (! gameData.options.isSinglePlayer) {
	    	var message = "Chat:true" + "," + msg + "|" + "User" + "-" + gameData.user.current_player;
	    	gameData.webSocket.send(message);
	    }
	}
	
	//public API
	RP.setSpeechVolume = function(vol) {
		if (vol >= 0 && vol <= 1) {
			interfaceState.audio.speechOptions.volume = vol;
		}
	}
	
	
	
	//game data; private
	var gameData = {
		bets: [
		    {odds: 0.0, bet: 0.0, payout: 0.0},
		    {odds: 0.0, bet: 0.0, payout: 0.0},
		    {odds: 0.0, bet: 0.0, payout: 0.0},
		    {odds: 0.0, bet: 0.0, payout: 0.0},
		    {odds: 0.0, bet: 0.0, payout: 0.0},
		    {odds: 0.0, bet: 0.0, payout: 0.0}
		],
		bonus: {
			double_credits: "no",
			triple_credits: "no",
			bonus_type: "DoubleShot",
			bonus_amount: "1200.0",
			bonus_amounts: [],
			bonus_types: [],
			bonus_pre_number: 0
		},
		flags: {
			discard: false,
			check_load: true,					//XXX:  unused?
			bets_confirm: true,
			check_hand: [false, false, false, false, false, false, false],
			card_check: false,
			timer_flag: false,
			winners_popup: false,
			check_games: false,
			tournament_end: false
		},
		hands: [
		    {odds: 0.0, type: "", cards: []},
		    {odds: 0.0, type: "", cards: []},
		    {odds: 0.0, type: "", cards: []},
		    {odds: 0.0, type: "", cards: []},
		    {odds: 0.0, type: "", cards: []},
		    {odds: 0.0, type: "", cards: []}
		],
		options: (window.options ? window.options : {}),
		players: {
			connected_players_count: 0,									
			connected_players: [],
			connected_players_points: [],
			sorted_connected_players: [],
			sorted_connected_players_points: []
		},
		stats: {
			highest_profit: 0,
			highest_odds: 0,
			reach_level: 0,
			straight_flush: 0,
			royal_flush: 0,
			bet_amount: 0,
			total_games: 0,
			hand_card_count: 0,
			running_game_number: 0,
			running_deal_number: 0,
			running_hand_number: 0,
			hands_status: [],
			winning_type: "",
			winning_type_split: "",
			winning_hand: "",
			horse_won: 0,
			total_bets: 0.0,
			last_win: 0.0,
			deal_start_points: 0.0,
			count_send: 0,
			tournament_bets: 0.0,
			hand_number: 0
		},
		user: {
			email: "",
			screenname: "",
			username: "",
			current_player: "",
			current_balance: 0,
			current_player_points: 0,
			current_player_last_win: 0,
			current_bet_amount: 0,
			current_bitlets: 0,
			total_bitlets: 0,
			total_level: 0,
			finished_rank: 0,
			total_tournament_credits: 0,
			current_level: 1.0
		},
		webSocket: undefined
	};

	//interface options; private
	var interfaceState = {
		audio: {
			enabled: true,
			responsiveVoice: undefined,
			voiceType: "UK English Female",
			speechOptions: {volume: 1}
		},
		help: {
			enabled: false
		},
		messages: {
			error_message: ""
		},
		timer: {
			betsChecked: false,
			timer_canvas: undefined,		//XXX:  unused?
			timer_count: 0,
			timerID: undefined
		},
		timestamps: {
			now: new Date(),				//XXX:  unused?
			before: new Date()
		}
	};

	//FIXME:  test current version on stage																			[X]
		//FIXME:  timer countdown text is not animating																[X]
		//FIXME:  have to click the 'amount' button twice before the bet starts incrementing						[X]
		//FIXME:  current player displays email instead of screen-name in leaderboard; no player is highlighted		[X]
		//FIXME:  round count is not displayed																		[X]
		
	//FIXME:  encapsulate the gameplay logic in a module and expose a well-defined API for interacting with it		[X]
	//FIXME:  update guest, single, and multi mode to use refactored code and API									[X]
	//FIXME:  test on stage																							[]
		//FIXME:  chat messages from bots do not display?															[X]
		//FIXME:  bets are not deducted from displayed balance in leaderboard or page header (transiently?; 
		//		  bet displays as okay but is not actually accepted by server)										[did not reproduce]
		//FIXME:  exit button doesnt work in single player															[]

	//FIXME:  check/fix audio mode enablement outside of guest mode
	//FIXME:  fix issue where first bit of spoken text does not play

	//dispatches a new gameplay event to our listeners; private
	function gameEvent(name, extraFields) {
		if (! RP.eventTypes[name]) {
			console.log("WARN:  Unsupported event - " + name);
			return;
		}
		
		var evt = new CustomEvent(RP.eventTypes[name], {detail: RP.externalState(extraFields)});
		document.dispatchEvent(evt);
	};

	//gets the cards at the given index; private
	function getHandCards(index) {
		if (gameData.hands[index]) {
			return gameData.hands[index].cards;
		}
		
		//invalid call
		console.log("Illegal hand index:  " + index, new Error());
		return[];
	};

	//private
	var say = function(words) {
		//if (gameData.options.isSinglePlayer) {
		//	return;
		//}
		if (! interfaceState.audio.responsiveVoice) {
			if (window.ResponsiveVoice) {
				interfaceState.audio.responsiveVoice = new ResponsiveVoice();
			}
			else {
				return;
			}
		}
		if (! interfaceState.audio.enabled) {
			return;
		}
		
		var result = interfaceState.audio.responsiveVoice.speak(words, interfaceState.audio.voiceType, interfaceState.audio.speechOptions);
		if (! result && window.ResponsiveVoice) {
			interfaceState.audio.responsiveVoice = new ResponsiveVoice();
		}
	};

	//private
	var talk = function(words) {
		say(words);
	};

	//private
	var loadResponsiveVoice = function() {
		$.getScript("/Jquery/responsivevoice.js", function() {
	        console.log("Responsive Voice Script added");
	        interfaceState.audio.responsiveVoice = new ResponsiveVoice();
	    });
	};

	//private
	var loadFbGuestMode = function() {
		$.getScript("/fb_guestmode.js", function() {
			console.log(gameData.user.screenname);
		});
	};

	//private
	$(document).ready(function() {
		if (gameData.options.loadResponsiveVoice) {
			loadResponsiveVoice();
		}
		
		gameEvent("init");
	    
	    if (gameData.options.loadFbGuestMode) {
	    	loadFbGuestMode();
	    }
	    
	    if (! gameData.options.isGuestMode /*&& typeof(Storage) !== "undefined"*/) {
	        gameData.user.username = gameData.options.userName;
	    }
	    
	    //FIXME:  move this call to external page
	    if (! gameData.options.isGuestMode) {
	    	RP.start_game();
	    }
	});

	//private
	function socket_connection() {
	    var count = 0;
	    var hand_count = 0;
	    var tournaments_length = 0;
	    var tournaments_LISTS = "";
	    var open_id = 0;
	    var winner = false;
	    var game_ctx;
	    var deal_ctx;
	    var timerID;
	    var send_check = false;

	    gameData.webSocket = new WebSocket('wss://' + gameData.options.socketHost + '/' + gameData.options.socketPath );

	    gameData.webSocket.onopen = function(event) {
	        send_check = true;
	        writeResponse("opened");
	    };
	    gameData.webSocket.onerror = function(evt) {
	        console.log("The following error occurred: " + evt.data);
	    };
	    gameData.webSocket.onmessage = function(event) {
	        writeResponse(event.data);
	    };
	    gameData.webSocket.onclose = function(event) {
	        writeResponse("Connection closed");
	    };

	    //private
	    function send() {
	        //var text = document.getElementById("messageinput").value;
	        if (gameData.stats.count_send == 0) {
	            console.log(gameData.user.username);
	            console.log(gameData.options.tournamentId);
	            var message = "connect" + "," + gameData.user.username + "," + gameData.options.tournamentId + "," + gameData.stats.count_send;
	            //send_check = false;
	            // alert(message);
	            open_id++;
	            console.log(open_id);

	            gameData.webSocket.send(message);
	            gameData.stats.count_send++;
	        }
	    }

	    //private/unused
	    function closeSocket() {
	        console.log("closesoclet");
	        gameData.webSocket.close();
	    }

	    //private
	    function writeResponse(text) {
	        console.log(text);
	        
	        if (text && text.indexOf("connected_players:") == 0) {
	        	//HACK - whitespace in player names breaks the event parsing!!!
	        	text = text.trim().replace(/\s/gi, "%%");
	        }

	        if (text === "opened") {
	            send();
	            count++;
	        }
	        else {
	            var card_count = 0;
	            var odds = "0.0";
	            var first_split = text.split(" ");
	            var split_length = first_split.length;
	            var timerID;
	            for (var j = 0; j < split_length; j++) {
	                var card = "/images/";
	                var second_split = first_split[j].split(":");
	                // console.log(second_split);
	                if (second_split[0] === "game_number") {
	                	gameData.stats.running_game_number = parseInt(second_split[1]);
	                	//if (gameData.stats.running_game_number < parseInt(second_split[1])) {
	                		gameEvent("gameNumber");
	                    //}
	                }
	                if (second_split[0] === "Bonus_player") {
	                    var thrid_split = second_split[1].split(",");
	                    var fourth_split = thrid_split[1].split("-");
	                    var fifth_split = fourth_split[1].split("*");
	                    var sixth_split = fifth_split[1].split("||");
	                    var seventh_split = sixth_split[1].split("()");
	                    var eight_split = seventh_split[1].split("@");
	                    var ninth_split = eight_split[1].split("!");
	                    var tenth_split = ninth_split[1].split("&");
	                    console.log(thrid_split[0])
	                    console.log(fourth_split[0]);
	                    console.log(fifth_split[0]);
	                    console.log(sixth_split[1]);
	                    console.log(seventh_split[0]);
	                    console.log(eight_split[1]);
	                    console.log(tenth_split[0]);
	                    console.log(tenth_split[1]);
	                    if (gameData.user.current_player === thrid_split[0]) {
	                        //synchronous code
	                    	gameData.bonus.bonus_type = fifth_split[0];
	                        gameData.bonus.bonus_amount = parseInt(seventh_split[0]);
	                        
	                        //timeout code
	                        gameData.user.current_level = parseInt(gameData.user.current_level);
	                        gameData.user.current_bitlets = parseInt(gameData.user.current_bitlets);
	                        if (parseInt(tenth_split[1]) > 0) {
	                        	gameData.user.total_level = parseInt(tenth_split[1]) + parseInt(gameData.user.total_level);
	                        }
	                        if (parseInt(ninth_split[0]) > 0) {
	                        	gameData.user.total_bitlets = parseInt(ninth_split[0]) + parseInt(gameData.user.total_bitlets);
	                        }
	                        if (gameData.bonus.bonus_pre_number > 0) {
	                            gameData.bonus.bonus_pre_number++;
	                            gameData.bonus.bonus_types[gameData.bonus.bonus_pre_number] = gameData.bonus.bonus_type;
	                            gameData.bonus.bonus_amounts[gameData.bonus.bonus_pre_number] = gameData.bonus.bonus_amount;
	                        }
	                        else {
	                            gameData.bonus.bonus_types[gameData.bonus.bonus_pre_number] = gameData.bonus.bonus_type;
	                            gameData.bonus.bonus_amounts[gameData.bonus.bonus_pre_number] = gameData.bonus.bonus_amount;
	                        }
	                        
	                        //UI event
	                        gameEvent("playerBonus", {split9: ninth_split[0], split10: tenth_split[1]});
	                    }
	                }
	                if (second_split[0] === "redeal") {
	                    var text = "Winner on first deal. Redealing.";
	                    say(text);
	                    
	                    gameEvent("redeal");
	                }
	                if (second_split[0] === "Socket") {
	                    if (second_split[1] === "closed") {
	                    	gameEvent("socketClosed");
	                    }
	                }
	                if (second_split[0] === "Chat") {
	                    //second_split.replace(" ", ",");
	                    var split_name = second_split[1].split("|");
	                    var player_message = split_name[0].replace(/,/gi, " ");
	                    var player_name = split_name[1].split("-");
	                    var user_name = player_name[1];

	                    if (user_name != gameData.user.current_player) {
	                    	gameEvent("chatMessage", {user_name: user_name, msg: player_message});
	                    }
	                }
	                if (second_split[0] === "deal_number") {
	                    gameData.stats.deal_start_points = gameData.user.current_player_points;
	                    gameData.stats.running_deal_number = second_split[1];
	                    
	                    gameEvent("dealNumber");
	                }
	                if (second_split[0] === "check" && gameData.stats.running_deal_number > 1) {
	                	check_hands();		
	                	setTimeout(function() {		
	                		gameEvent("checkHands");
	                	}, 1000);
	                }
	                if (second_split[0] === "hand_status") {
	                    if (second_split[1] === "true") {
	                        gameData.stats.hands_status[gameData.stats.running_hand_number] = false;
	                    }
	                    else {
	                        gameData.stats.hands_status[gameData.stats.running_hand_number] = true;
	                    }
	                }
	                if (second_split[0] === "hand_number") {
	                    gameData.stats.hand_number = second_split[1];						//XXX:  note that this is 1-based!!!
	                    gameData.stats.running_hand_number = parseInt(second_split[1]);		//XXX:  and this too!!!
	                    if (gameData.flags.discard || gameData.stats.running_deal_number === 1) {
	                    	gameEvent("discardHand");
	                    }
	                    var discard_hand = gameData.stats.hand_number - 1;		//FIXME:  correct to subtract 1 here (and then again, below)?
	                    if (discard_hand <= 6 && gameData.flags.discard && gameData.stats.running_deal_number > 1) {
	                    	if (gameData.stats.hand_card_count < 5) {
	                    		//FIXME:  does not appear to discard?
	                    		//console.log("!!!!!!!!!!  Discarding last " + (gameData.stats.hand_card_count, 5 - gameData.stats.hand_card_count) 
	                    		//		+ " cards from hand at index=" + discard_hand);
	                            getHandCards(discard_hand/* - 1*/).splice(gameData.stats.hand_card_count, 5 - gameData.stats.hand_card_count);
	                        }
	                    }
	                    
	                    gameData.stats.hand_card_count = 0;
	                }

	                if (second_split[0] === "card") {
	                    var useful = false;
	                    if (gameData.stats.hand_number == 1 && gameData.stats.hand_card_count == 0) {
	                    	//clear all hands before proceeding
	                    	for (var handIdx = 0; handIdx < 6; handIdx++) {
	                    		getHandCards(handIdx).splice(0, getHandCards(handIdx).length);
	                    	}
	                    }
	                    if (gameData.flags.discard) {
	                        if (gameData.stats.hand_number <= 6 && gameData.stats.hand_number > 0) {
	                        	getHandCards(gameData.stats.hand_number - 1)[gameData.stats.hand_card_count] = second_split[1];
	                        }
	                        gameData.stats.hand_card_count++;
	                        card_count++;
	                        
	                        gameEvent("updateCard", {cardType: second_split[1], odds: odds, useful: false});
	                    }
	                    else {
	                    	if (gameData.stats.hand_number <= 6 && gameData.stats.hand_number > 0) {
	                    		if (gameData.stats.running_deal_number > 1) {
	                                var num = gameData.stats.hand_number - 1;
	                    			gameData.flags.card_check = check_card(gameData.stats.hand_card_count, getHandCards(num), second_split[1]);
	                                if (!gameData.flags.card_check) {
	                                    useful = usefull_card(gameData.stats.hand_number, gameData.stats.running_deal_number, getHandCards(num), second_split[1]);
	                                    getHandCards(num)[gameData.stats.hand_card_count] = second_split[1];
	                                }

	                            }
	                    	}
	                        gameData.stats.hand_card_count++;
	                        card_count++;
	                        //console.log(card);
	                        if (!gameData.flags.card_check) {
	                        	gameEvent("updateCard", {cardType: second_split[1], odds: odds, useful: useful});
	                        }
	                        useful = false;
	                    }
	                }
	                if (second_split[0] === "odds" && gameData.flags.discard) {
	                    // total_bets = 0.0 ;
	                    odds = second_split[1];
	                    // alert(odds);
	                    if (card_count < 5 && gameData.stats.hands_status[gameData.stats.running_hand_number]) {
	                        if (second_split[1] > 0) {
	                            if (gameData.hands[gameData.stats.hand_number - 1].odds == second_split[1]) {
	                                gameData.flags.check_hand[gameData.stats.hand_number - 1] = false;
	                            }
	                            else {
	                                gameData.flags.check_hand[gameData.stats.hand_number - 1] = true;
	                            }
	                            gameData.hands[gameData.stats.hand_number - 1].odds = second_split[1];
	                            
	                            gameEvent("updateOdds", {split2: second_split[1]});
	                        }
	                        else {
	                        	gameEvent("zeroOdds");
	                        }
	                    }
	                    else {
	                    	gameEvent("resetOdds");
	                    }
	                }
	                if (second_split[0] === "timer_flag") {
	                    if (second_split[1] === "true") {
	                        // alert("st_flag");
	                        gameData.webSocket.send("idle");
	                        
	                        if (! gameData.options.isGuestMode && ! gameData.options.isSinglePlayer) {
	                        	connection_check();
	                        }
	                        
	                        //internal timer tick
	                        interfaceState.timer.timer_count = 0;
	                        interfaceState.timestamps.before = new Date().getTime();
	                        interfaceState.timer.betsChecked = false;
	                        
	                        //clear previous timer
	                        clearInterval(interfaceState.timer.timerID);
	                        
	                        var seconds = 30;
	                        
	                        //FIXME:  should use 30 seconds in all scenarios, however will require server-side update as well!!!
	                        //if (gameData.stats.running_deal_number == 2) {
	                        //    seconds = 20;
	                        //}
	                        //else if (gameData.stats.running_deal_number > 2) {
	                        //    seconds = 15;
	                        //}
	                        //seconds = gameData.options.isSinglePlayer ?  : seconds;
	                        
	                        //start new internal timer
	                        interfaceState.timer.timerID = setInterval("timerBox(" + seconds + ")", 100);
	                        
	                        //notify listeners that timer has started
	                        gameEvent("startTimer", {seconds: seconds});
	                        
	                        if (gameData.stats.running_deal_number != 1) {
	                            check_hands();
	                        }
	                        
	                        gameData.flags.timer_flag = true;
	                        gameData.flags.discard = gameData.options.isGuestMode;
	                    }
	                    hands_equality();
	                }
	                if (second_split[0] === "discard") {
	                    if (second_split[1] === "true")
	                        gameData.flags.discard = true;
	                    if (second_split[1] === "false")
	                        gameData.flags.discard = false;
	                }
	                if (second_split[0] === "firstwinner") {
	                    if (gameData.user.current_player === second_split[1]) {
	                    	gameEvent("playerRank", {position: 1});
	                        gameData.flags.winners_popup = true;
	                    }
	                }
	                if (second_split[0] === "secondwinner") {
	                    if (gameData.user.current_player === second_split[1]) {
	                    	gameEvent("playerRank", {position: 2});
	                        gameData.flags.winners_popup = true;
	                    }
	                }
	                if (second_split[0] === "thirdwinner") {
	                    if (gameData.user.current_player === second_split[1]) {
	                    	gameEvent("playerRank", {position: 3});
	                        gameData.flags.winners_popup = true;
	                    }
	                }
	                if (second_split[0] === "winners") {
	                    if (!gameData.flags.winners_popup) {
	                    	gameEvent("playerRank", {position: gameData.players.connected_players_count + 1});
	                    }
	                }
	                if (second_split[0] === "deal") {
	                    var text = "Dealing the cards" + 
	                    	(gameData.options.isGuestMode ? 
	                    			" Please click on the hands, to place your bets."
	                    			: "");
	                    say(text);
	                }
	                if (second_split[0] === "total_games") {
	                    gameData.stats.total_games = second_split[1];
	                    if (! gameData.options.isGuestMode && ! gameData.options.isSinglePlayer) {
	                    	if (parseInt(gameData.stats.total_games) === 1)
	                    		gameData.flags.check_games = true;
	                    }
	                }
	                if (second_split[0] === "started") {	//this occurs well *before* the 'start' event
	                	//FIXME:  the welcome message is not speaking completely
	                    var text = "welcome to racing poker " + (gameData.options.playerName ? gameData.options.playerName : gameData.user.screenname) + "." + " Please wait while we load your game.";
	                    say(text);
	                    setTimeout(function() {
	                    	gameEvent("loaded");
	                        var text = "Six hands of poker will be displayed." + 
	                        	(gameData.options.isGuestMode ? 
	                        			" Remember for a hand to win, it should reach it's full potential. After this " + gameData.stats.total_games + " game tournament, the highest credits holder will be declared the winner. Good Luck, " + gameData.user.screenname
	                        			: " Please click on the hands , to place your bets.");
	                        say(text);
	                    }, 4000);
	                }
	                if (second_split[0] === "start") {	//this actually comes well *after* 'started'
	                	gameData.options.tournamentId = second_split[1];
	                    //gameEvent("loaded");
	                }
	                if (second_split[0] === "winning_hand_number") {
	                    if (second_split[1] > 0) {
	                        gameData.stats.hand_number = second_split[1];
	                        gameData.stats.horse_won = parseInt(second_split[1]);
	                        gameData.stats.winning_hand = gameData.stats.hand_number;
	                        
	                        gameEvent("winningHand");
	                        
	                        setTimeout(function() {
	                        	gameData.stats.deal_start_points = gameData.user.current_player_points;
	                            gameData.user.current_bet_amount = 0.0;
	                            for (var handIndex = 0; handIndex < gameData.hands.length; handIndex++) {
	                            	gameData.hands[handIndex].cards = [];
	                            	gameData.bets[handIndex].bet = 0.0;
	                            	gameData.bets[handIndex].payout = 0.0;
	                            }
	                            gameData.flags.discard = false;
	                            
	                            gameEvent("clear", {split: second_split[1]});
	                        }, 9000);

	                    }
	                }
	                if (second_split[0] === "winning_hand_type") {
	                    gameData.stats.winning_type_split = second_split[1];
	                    var thrid_split = gameData.stats.winning_type_split.replace(/,/gi, " ");
	                    gameData.stats.winning_type = thrid_split;
	                    
	                    gameEvent("winType");
	                    
	                    if (gameData.stats.running_deal_number > 1) {
	                        winning_talk();
	                        setTimeout(function() {
	                        	var type_split = gameData.stats.winning_type.split(" ");
	                            if (type_split[0] === "Four" && type_split[1] === "of" && type_split[2] === "a" && type_split[3] === "Kind") {
	                                gameData.stats.winning_type = "Four - Kind";
	                            }
	                            
	                            gameData.stats.last_win = gameData.user.current_player_points - gameData.stats.deal_start_points;
	                            if (gameData.stats.last_win < 0) {
	                                gameData.stats.last_win = 0.0;
	                            }
	                        	
	                            //fire event 1
	                            gameEvent("prevGame1");
	                            
	                            gameData.stats.last_win -= gameData.stats.total_bets;
	                            if (gameData.stats.last_win > 0 && ! gameData.options.isSinglePlayer) {
	                                if (gameData.stats.highest_profit < gameData.stats.last_win) {
	                                    gameData.stats.highest_profit = gameData.stats.last_win;
	                                    if (gameData.stats.winning_hand <= 6 && gameData.stats.winning_hand != "") {
	                                    	var odds = gameData.bets[gameData.stats.winning_hand - 1].odds
	                                    	if (gameData.stats.highest_odds < odds) {
	                                    		gameData.stats.highest_odds = odds;
	                                    	}
	                                    }
	                                    if (gameData.stats.winning_type_split == "Straight,Flush") {
	                                        gameData.stats.straight_flush++;
	                                    }
	                                    if (gameData.stats.winning_type_split == "Royal,Flush") {
	                                        gameData.stats.royal_flush++;
	                                    }
	                                }
	                            }
	                            gameData.stats.total_bets = 0.0;
	                            
	                            //fire event 2
	                            gameEvent("prevGame2");
	                            
	                            if (gameData.stats.last_win <= 0) {
	                                gameData.stats.last_win *= -1;
	                            }
	                        }, 2000);

	                    }
	                }
	                if (second_split[0] === "hand_type") {
	                    if (card_count <= 5) {
	                        var thrid_split = second_split[1].replace(/,/gi, " ");
	                        gameEvent("handType", {type:  thrid_split});
	                    }
	                    if (gameData.flags.discard /*&& ! gameData.options.isSinglePlayer*/) {
	                        var type = second_split[1].replace(/,/gi, " ");
	                        if ((type.indexOf("Pos")) > -1) {
	                            type = type.replace(/Pos./i, "Possible");
	                        }
	                        if ((type.indexOf("Dbl")) > -1) {
	                            type = type.replace(/Dbl/i, "double");
	                        }
	                        if ((type.indexOf("End")) > -1) {
	                            type = type.replace(/End/i, "Ended");
	                        }
	                        gameData.hands[gameData.stats.hand_number - 1].type = type;
	                    }
	                }

	                if (second_split[0] === "current_player") {
	                    var thrid_split = second_split[1].split(",");
	                    gameData.user.current_player = thrid_split[0];
	                    gameData.user.current_player_points = thrid_split[1];
	                    gameData.user.current_player_last_win = 0;
	                    
	                    gameEvent("currentPlayer", {lastWin: thrid_split[2]})
	                }
	                if (second_split[0] === "end") {
	                	if (! gameData.options.isSinglePlayer) {
	                		gameData.flags.tournament_end = true;
	                		
	                		var diff = gameData.user.current_player_points - gameData.user.total_tournament_credits;
		                    if (diff > gameData.user.current_player_points) {
		                        if (diff >= (2 * gameData.user.current_player_points)) {
		                            gameData.bonus.triple_credits = "yes";
		                        }
		                        else {
		                            gameData.bonus.double_credits = "yes";
		                        }
		                    }
		                    if (gameData.stats.reach_level < gameData.user.total_level) {
		                        gameData.stats.reach_level = gameData.user.total_level;
		                    }
		                    
		                    $.getJSON("/Achievements", {
		                        "username": gameData.user.username,
		                        "command": "save",
		                        "Highest_profit": gameData.stats.highest_profit,
		                        "Highest_odds": gameData.stats.highest_odds,
		                        "Double_credits": gameData.bonus.double_credits,
		                        "Triple_credits": gameData.bonus.triple_credits,
		                        "Straight_flush": gameData.stats.straight_flush,
		                        "Royal_flush": gameData.stats.royal_flush,
		                        "Reach_level": parseInt(gameData.user.total_level)
		                    }, function(data) {
		                    	if (! data) {
		        	        	    data = {};
		        	            }
		        	            if (! data.achievement) {
		        	        	    data.achievement = "0,0,0,0,0,0,0";
		        	            }
		                    });
		                    
		                    winning_end_tournament();
		                	
		                    $.getJSON("/FrontControl", {
		                        "clicked": gameData.options.tournamentId,
		                        "command": "clicked"
		                    }, function(data) {
		                        //  alert(data.result);
		                        //  
		                        //s window.location.href = "Tournament_details.html";   
		                        sessionStorage.clicked = gameData.options.tournamentId;
		                        gameEvent("finished");
		                    });
	                	}
	                	
	                	gameEvent("end");
	                }
	                if (second_split[0] === "remove_player") {
	                    var fourth_split = second_split[1].split(",");
	                    for (var i = 0; i < gameData.players.connected_players.length; i++) {
	                        if (gameData.players.connected_players[i] === fourth_split[0]) {
	                            gameData.players.connected_players.splice(i, 1);
	                            gameData.players.connected_players_points.splice(i, 1);
	                            break;
	                        }
	                    }
	                }
	                if (second_split[0] === "result") {
	                    var fourth_split = second_split[1].split(",");
	                    if (gameData.user.current_player === fourth_split[0]) {
	                        gameData.user.total_level = parseFloat(fourth_split[3]) - gameData.user.current_level;
	                        gameData.user.total_bitlets = parseInt(fourth_split[2]);
	                    }
	                }
	                if (second_split[0] === "connected_players") {
	                    var fourth_split = second_split[1].split(",");
	                    fourth_split[0] = fourth_split[0].replace(/%%/gi, " ");	//HACK:  put spaces back into the username
	                    fourth_split[1] = fourth_split[1].replace(/%%/gi, " ");	//HACK:  put spaces back into the username
	                    if (gameData.options.isSinglePlayer) {
	                    	current_palyer = fourth_split[0];
	                        gameData.user.current_player_points = fourth_split[1];
	                        
	                        gameEvent("playerBalance");
	                    }
		                else {
		                	var check = true;
		                	if (gameData.players.connected_players_count == 0) {
		                        gameData.user.total_tournament_credits = parseFloat(fourth_split[1]) - 1;
		                        gameData.players.connected_players_count++;
		                    }
		                	
		                	if (gameData.players.connected_players.length > 0) {
		                        for (var i = 0; i < gameData.players.connected_players.length; i++) {
		                            if (gameData.players.connected_players[i] === fourth_split[0]) {
		                                check = false;
		                                gameData.players.connected_players_points[i] = fourth_split[1];
		                                gameData.user.current_balance = fourth_split[1];
		                            }
		                        }
		                        if (check) {
		                            gameData.players.connected_players[gameData.players.connected_players.length] = fourth_split[0];
		                            gameData.players.connected_players_points[gameData.players.connected_players.length - 1] = fourth_split[1];
		                        }
		                    }
		                    else {
		                        gameData.players.connected_players[0] = fourth_split[0];
		                        gameData.players.connected_players_points[0] = fourth_split[1];
		                    }
		                	
		                	//gameData.players.sorted_connected_players = gameData.players.connected_players;
		                    //gameData.players.sorted_connected_players_points = gameData.players.connected_players_points;
		                	var players = [];
		                	gameData.players.sorted_connected_players = [];
		                	gameData.players.sorted_connected_players_points = [];
		                	for (var i = 0; i < gameData.players.connected_players.length; i++) {
		                		var player = {name: gameData.players.connected_players[i], score: gameData.players.connected_players_points[i]};
		                		players.push(player);
		                	}
		                	players = players.sort(function(left, right) {
		                		return right.score - left.score;
		                	});
		                	for (var i = 0; i < players.length; i++) {
		                		var player = players[i];
		                		gameData.players.sorted_connected_players.push(player.name);
		                		gameData.players.sorted_connected_players_points.push(player.score);
		                	}
		                	
		                	
		                    /*var check1 = [];
		                    var count1 = 1;
		                    for (var i = 0; i < gameData.players.sorted_connected_players.length; i++) {
		                        check1[i] = true;
		                    }
		                    if (gameData.stats.running_game_number > 0) {
		                        var temp = gameData.players.sorted_connected_players_points.slice();
		                        var temp1 = gameData.players.sorted_connected_players.slice();
		                        gameData.players.sorted_connected_players_points.sort(function(a, b) {
		                            return b - a;
		                        });
		                        for (var k = 0; k < gameData.players.sorted_connected_players_points.length; k++) {
		                            for (var j = 0; j < gameData.players.sorted_connected_players_points.length; j++) {
		                                if (((temp[j] === gameData.players.sorted_connected_players_points[k]) && check1[j]) && (count1 === 1)) {
		                                    gameData.players.sorted_connected_players[k] = temp1[j];
		                                    check1[j] = false;
		                                    count1++;
		                                    break;
		                                }
		                            }
		                            count1 = 1;
		                        }
		                    }*/
		                    
		                    gameEvent("connectedPlayers");
		                    
		                    for (var k = 0; k < gameData.players.sorted_connected_players.length; k++) {
		                        if (gameData.players.sorted_connected_players[k] === gameData.user.current_player) {
		                            var last_win = gameData.user.current_player_points;
		                            gameData.user.current_player_points = gameData.players.sorted_connected_players_points[k];
		                            gameData.user.current_player_last_win = gameData.user.current_player_points - last_win;
		                            gameData.user.finished_rank = k + 1;
		                            
		                            gameEvent("playerBalanceExt", {count: k});
		                        }
		                    }
		                }
	                }
	            }
	        }

	        //internal use only; private
	        function check_hands() {
	            for (var i = 0; i < 6; i++) {
	                if (gameData.flags.check_hand[i]) {
	                    gameEvent("checkHand", {index: i});
	                    gameData.flags.check_hand[i] = false;
	                }
	            }

	        }

	        //internal use only; private
	        function winning_end_tournament() {
	        	var rank = parseInt(gameData.user.finished_rank, 10);
	        	var places = ["", "first", "second", "third"];
	            if (places[rank]) {
	            	var text = "Congratulations, you came " + places[rank] + " in a tournament.";
	            }
	            else {
	                var text = "Oops !!, you came " + parseInt(gameData.user.finished_rank) + "th" + " in a tournament";
	            }
	            say(text);
	            
	            if (gameData.options.isGuestMode) {
	            	text = "Please grab our offer and sign up to recieve 5000 credits immediately, You can then play in full blown tournaments where you can achieve higher levels and accolades.";
	            	say(text);
	            }
	        }

	        //internal use only; private
	        function winning_talk() {
	            var text = "hand" + gameData.stats.winning_hand + "won the race with a " + gameData.stats.winning_type;
	            say(text);
	        }

	        //internal use only; private
	        function hands_equality() {
	            var count = 0;
	            var hands = gameData.hands;
	            var shortest = hands[0].odds;
	            var hand_num = 0;
	            var hand_type = "";
	            for (var i = 1; i < 6; i++) {
	                if (parseFloat(shortest) >= parseFloat(hands[i].odds)) {
	                    if (parseFloat(shortest) === parseFloat(hands[i].odds)) {
	                        count++;
	                        hand_num += "," + i;
	                    }
	                    else {
	                        shortest = hands[i].odds;
	                        hand_num = i;
	                        count = 0;
	                    }
	                }
	            }
	            var shortest1 = parseFloat(shortest).toFixed(2);
	            var cents = shortest1 - parseInt(shortest);
	            cents *= 100;
	            cents = parseInt(cents);
	            if (cents % 10 != 0) {
	                var rem = cents % 10;
	                cents += (10 - rem);
	            }
	            if (cents % 10 != 0) {
	                var rem = cents % 10;
	                cents += (10 - rem);
	            }
	            var amount = "";
	            if (parseInt(shortest) > 1) {
	                if (cents > 0)
	                    amount = parseInt(shortest) + "dollars and " + cents + "cents.";
	                else
	                    amount = parseInt(shortest) + "dollars.";
	            }
	            else {
	                if (cents > 0)
	                    amount = parseInt(shortest) + "dollar and " + cents + "cents.";
	                else
	                    amount = parseInt(shortest) + "dollar.";
	            }
	            if (count === 0) {
	                if (gameData.hands[hand_num].type.indexOf("Pos") > -1)
	                    var text = "hand" + (hand_num + 1) + " is in the lead " + "with a " + gameData.hands[hand_num].type + " and paying ";
	                else
	                    var text = "hand" + (hand_num + 1) + " is in the lead " + "with " + gameData.hands[hand_num].type + " and paying ";
	                var shortest1 = parseFloat(shortest).toFixed(2);
	                var cents = shortest1 - parseInt(shortest);
	                cents *= 100;
	                cents = parseInt(cents);
	                if (cents % 10 != 0) {
	                    var rem = cents % 10;
	                    cents += (10 - rem);
	                }
	                if (parseInt(shortest) > 1) {
	                    if (cents > 0)
	                        text += parseInt(shortest) + "dollars and " + cents + "cents.";
	                    else
	                        text += parseInt(shortest) + "dollars.";
	                }
	                else {
	                    if (cents > 0)
	                        text += parseInt(shortest) + "dollar and " + cents + "cents.";
	                    else
	                        text += parseInt(shortest) + "dollar.";
	                }
	                if ((gameData.hands[hand_num].type.split(' ').join(',')) === "3,of,a,Kind") {
	                    if (interfaceState.help.enabled && interfaceState.audio.enabled)
	                        text += "hand" + (hand_num + 1) + "either needs a pair for a full house or a same face value card for a four of a kind.";
	                    console.log(text);
	                }

	                if ((gameData.hands[hand_num].type.split(' ').join(',')) === "Possible,Flush") {
	                    if (interfaceState.help.enabled && interfaceState.audio.enabled)
	                        text += "If" + " hand" + (hand_num + 1) + " pulls another same suit card, it could win.";
	                    console.log(text);
	                }

	                if ((gameData.hands[hand_num].type.split(' ').join(',')) === "2,Pairs") {
	                    if (interfaceState.help.enabled && interfaceState.audio.enabled)
	                        text += "hand" + (hand_num + 1) + " needs a same face value card of either of these pairs for full house.";
	                    console.log(text);
	                }
	                if ((gameData.hands[hand_num].type.split(' ').join(',')) === "Possible,Straight") {
	                    if (interfaceState.help.enabled && interfaceState.audio.enabled)
	                        text += "hand" + (hand_num + 1) + " needs a missing card to make a straight.";
	                    console.log(text);
	                    if (interfaceState.help.enabled && interfaceState.audio.enabled)
	                        text += "It can turn into a pair if it pulls a same face value card from the deck.";
	                }
	                say(text);
	            }
	            else {
	                var hand_num_split = hand_num.split(",");
	                var hand_num_split_length = hand_num_split.length;
	                var text = "";

	                if (count == 1) {
	                    for (var j = 0; j < hand_num_split_length; j++) {

	                        if (j == hand_num_split_length - 1) {
	                            text += "and " + (parseInt(hand_num_split[j], 10) + 1) + " are leading and paying " + amount;
	                        }
	                        else {
	                            text += "hands " + (parseInt(hand_num_split[j], 10) + 1) + ", ";
	                        }
	                    }
	                }
	                else {
	                    if (count == 2) {
	                        for (var j = 0; j < hand_num_split_length; j++) {

	                            if (j == hand_num_split_length - 1) {
	                                text += "and " + (parseInt(hand_num_split[j], 10) + 1) + " are sharing the lead and paying " + amount;
	                            }
	                            else {
	                                if (j == 0)
	                                    text += "hands " + (parseInt(hand_num_split[j], 10) + 1) + ", ";
	                                else
	                                    text += (parseInt(hand_num_split[j], 10) + 1) + ",";
	                            }
	                        }
	                    }
	                    else {
	                        text = "It's any ones race at the moment";
	                    }
	                }

	                //console.log(text);
	                say(text);

	                var handType = gameData.hands[hand_num_split[0]].type.split(' ').join(',');
	                if (handType === "3,of,a,Kind") {
	                    if (interfaceState.help.enabled && interfaceState.audio.enabled) {
	                        var text = "hand " + (hand_num_split[0] + 1) + " either needs a pair for a full house or a same face value card for a four of a kind .";
	                        //console.log(text);
	                        say(text);
	                    }
	                }

	                if (handType === "Possible,Flush") {
	                    if (interfaceState.help.enabled && interfaceState.audio.enabled) {
	                        var text = "If" + " hand" + (hand_num_split[0] + 1) + " pulls another same suit card, it could win.";
	                        //console.log(text);
	                        say(text);
	                    }
	                }

	                if (handType === "2,Pairs") {
	                    if (interfaceState.help.enabled && interfaceState.audio.enabled) {
	                        var text = "hand" + (hand_num_split[0] + 1) + " needs a same face value card of either of these pairs for full house . ";
	                        //console.log(text);
	                        say(text);
	                    }
	                }

	                if (handType === "1,Pair") {
	                    if (interfaceState.help.enabled && interfaceState.audio.enabled) {
	                        var text = "hand" + (hand_num_split[0] + 1) + " could become a fullhouse, flush, or a straight at this stage.";
	                        //console.log(text);
	                        say(text);
	                    }
	                }
	            }
	        }

	        //internal use only; private
	        function connection_check() {
	            $.getJSON("/connect_check", {
	                "command": check
	            }, function(data) {
	                if (data.result === "success") {
	                    console.log("true");
	                }
	                else {
	                	gameEvent("connectFailed");
	                }
	            });
	        }

	        //internal use only; private
	        function check_card(count_cards, house, card_num) {
	            try {
	                var house_split = house[gameData.stats.hand_card_count].split("");
	                //console.log(house_split);
	                var card_split = card_num.split("");

	                if ((house_split[0] === card_split[0]) && (house_split[1] === card_split[1])) {
	                    if (house_split.length === 2 && card_split.length === 2) {
	                        return true;
	                    }
	                    else {
	                        if ((house_split[2] === card_split[2])) {
	                            return true;
	                        }
	                    }
	                }
	                else {
	                    return false;
	                }
	            }
	            catch (err) {
	                return false;
	            }
	        }
	    }

	    //internal use only; private
	    function check_tournament_bets() {
	        if (gameData.stats.tournament_bets <= 0 && gameData.stats.running_game_number < gameData.stats.total_games) {
	            //alert("Try to place bets in every game. Otherwise you  can't place bets in last game. ");
	            // $("#nobet_popup").modal('show');
	        }
	    }

	    //internal use only; private
	    function usefull_card(han_number, dela_number, house, card_number) {
	        if (dela_number > 1) {
	            var card1_split = card_number.split("");
	            var count_card = 0;
	            var usefull1 = false;
	            var straight_count = 1;
	            var pair_count = 0;
	            var straight_house = false;
	            var count_flush = 0;
	            var flush_house = false;
	            if (gameData.options.isSinglePlayer) {
	            	for (var i = 0; i < house.length - 1; i++) {
	                    var card3_split = house[i].split("");
	                    var card4_split = house[i + 1].split("");
	                    if (card3_split[0] === card4_split[0]) {
	                        pair_count++;
	                    }
	                }
	            }

	            for (var i = 0; i < house.length - 1; i++) {
	                var card3_split = house[i].split("");
	                var card4_split = house[i + 1].split("");
	                var value = 0.0;
	                var value1 = 0.0;

	                if (card3_split[0] === "j" || card3_split[0] === "q" || card3_split[0] === "k" || card3_split[0] === "a") {
	                    if (card3_split[0] === "j")
	                        value = 11;
	                    if (card3_split[0] === "q")
	                        value = 12;
	                    if (card3_split[0] === "k")
	                        value = 13;
	                    if (card3_split[0] === "a")
	                        value = 14;
	                }
	                else
	                    value = parseInt(card3_split[0]);
	                if (card4_split[0] === "j" || card4_split[0] === "q" || card4_split[0] === "k" || card4_split[0] === "a") {
	                    if (card4_split[0] === "j")
	                        value1 = 11;
	                    if (card4_split[0] === "q")
	                        value1 = 12;
	                    if (card4_split[0] === "k")
	                        value1 = 13;
	                    if (card4_split[0] === "a")
	                        value1 = 14;
	                }
	                else
	                    value1 = parseInt(card4_split[0]);

	                if (value1 - value == 1)
	                    straight_house = true;
	            }
	            for (var i = 0; i < house.length - 1; i++) {
	                var card2_split = house[i].split("");
	                var card3_split = house[i + 1].split("");
	                if (card2_split[1] === card3_split[1]) {
	                    count_flush++;
	                }
	            }
	            if (count_flush == 3)
	                flush_house = true;

	            if (house.length == 4) {
	                if (!usefull1) {
	                    for (var i = 0; i < house.length; i++) {
	                        var card2_split = house[i].split("");
	                        if (card1_split[1] === card2_split[1]) {
	                            count_card++;
	                        }
	                    }
	                    if (count_card === house.length) {
	                        return true;
	                    }

	                }
	            }
	            for (var i = 0; i < house.length; i++) {
	                if (house.length >= 1) {

	                    var card2_split = house[i].split("");

	                    if (card1_split[0] === card2_split[0]) {
	                        usefull1 = true;
	                        if (house.length == 4) {
	                            if (straight_house)
	                                return false;
	                            else
	                            if (flush_house)
	                                return false;
	                            else
	                            if (pair_count >= 1)
	                                return true;

	                        }
	                        else {
	                            if (house.length == 1)
	                                return true;
	                            if (house.length == 2)
	                                return true;
	                            if (house.length == 3)
	                                return true;
	                        }

	                    }
	                }

	            }
	        }
	    }
	    
	    //internal timer tick, private; does not update UI directly
	    window.timerBox = function(seconds) {
	        var now = new Date().getTime();
	        var elapsedMillis = now - interfaceState.timestamps.before;
	        var elapsedSeconds = Math.floor(elapsedMillis / 1000.0);
	    	
	        interfaceState.timer.timer_count++;
	        
	        var rem = seconds - elapsedSeconds;
	        var remMillis = (seconds * 1000) - elapsedMillis;
	        if (! gameData.options.isSinglePlayer && rem === 5 && ! interfaceState.timer.betsChecked) {
	        	interfaceState.timer.betsChecked = true;
	        	check_tournament_bets();
	        	
	        	var text = "Last bets";
	            say(text);
	        }
	        
	        if (! gameData.flags.timer_flag) {
	        	rem = 0;
	        	remMillis = 0;
	        }
	        
	        if (/*rem < 0*/ rem === 0 &&  gameData.flags.timer_flag === false) {
	        	gameEvent("stopTimer");
	        	stopTimer(0);
	        }
	        else {
	        	gameEvent("timerTick", {seconds: rem, milliseconds: remMillis});
	        }
	        
	        if (rem < 1) {
	            gameData.flags.timer_flag = false;
	        }
	    }

	    //internal timer stop, private; does not update UI
	    function stopTimer(seconds) {
	        gameData.flags.timer_flag = false;
	        clearInterval(interfaceState.timer.timerID);
	        interfaceState.timer.timer_count = seconds;
	        gameData.flags.discard = false;
	    }
	}
}());