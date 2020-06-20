/**
 * This file gets tournaments details.
 */

var tournaments;

$(function() {
	console.log(window.location);
	var tournamentType = window.location.href.split("=")[1].replace("#", "");
	console.log(tournamentType);
	$.post("TournamentInfoController",{"tournamentType": tournamentType},function(data) {
		if (data.result === "success") {
			setTimeout(function(){
				render(data);
			}, 2500);
		} else {
			// redirect to index page 
		}
	}, "json");
});

function render(data) {
	
	var entryLevelTournaments = [];
	var midLevelTournaments = [];
	var highLevelTournaments = [];
	var highestLevelTournaments = [];
	
	var tournamentsJson = JSON.parse(data.tournaments);
	
	for (var i =0; i < tournamentsJson.length ; i++) {
		var tournamentLevel = tournamentsJson[i].tournamentLevel;
		
		if (tournamentLevel === "ENTRY_LEVEL") {
			entryLevelTournaments.push(tournamentsJson[i]);
		}		
		if (tournamentLevel === "MID_LEVEL") {
			midLevelTournaments.push(tournamentsJson[i]);
		}
		if (tournamentLevel === "HIGH_LEVEL") {
			highLevelTournaments.push(tournamentsJson[i]);
		}
		if (tournamentLevel === "HIGHEST_LEVEL") {
			highestLevelTournaments.push(tournamentsJson[i]);
		}
	}
	
	sortTournamentsByCreditsByAscendingOrder(entryLevelTournaments);
	sortTournamentsByCreditsByAscendingOrder(midLevelTournaments);
	sortTournamentsByCreditsByAscendingOrder(highLevelTournaments);
	sortTournamentsByCreditsByAscendingOrder(highestLevelTournaments);
	
	addDataToHtml(entryLevelTournaments);
	addDataToHtml(midLevelTournaments);
	addDataToHtml(highLevelTournaments);
	addDataToHtml(highestLevelTournaments);
	slider();
}

function sortTournamentsByCreditsByAscendingOrder(dataArray) {
	dataArray.sort(function(a,b) {
		if (a.buyInCredits.credits > b.buyInCredits.credits) {
			return 1;
		} else {
			return -1;
		}
	});
}

function addDataToHtml(dataArray) {
	console.log(dataArray);
	var tournamentsDiv = document.getElementById("tournaments");
//	tournamentsDiv.innerHTML = "";
		
	var eliCheck;

	for (var i=0; i < dataArray.length; i++) {
		var credits = dataArray[i].buyInCredits.credits;

		if (credits <= userCredits) {
			eliCheck = "eli-check";
		} else {
			eliCheck = "eli-uncheck";
		}
		
		addToTournamentsDiv(dataArray[i], eliCheck, tournamentsDiv);
	}
}

function addToTournamentsDiv(data, eliCheck, tournamentsDiv) {
	var playBtnClass;
	var addChipsClass;
	var prizeDisributionClass;
	var prizesCredits;
	var prizesGoldCoins;
	var addChipsText;
	
	if (eliCheck === "eli-uncheck") {
		playBtnClass = "disabled";
		addChipsClass="";
		addChipsText = "Get Chips and Gold";
	} else {
		playBtnClass= "";
		addChipsClass="add-chips-hidden";
		addChipsText = "";
	}
	
	if (data.prizes.length > 0) {
		prizeDisributionClass = "";
		prizesCredits = [data.prizes[0].credits, data.prizes[1].credits, data.prizes[2].credits];
		prizesGoldCoins = [data.prizes[0].goldCoins, data.prizes[1].goldCoins, data.prizes[2].goldCoins];
	} else {
		prizeDisributionClass = "hidden";
		prizesCredits = [0, 0, 0];
		prizesGoldCoins = [0, 0, 0];
	}
	
	var tournamentDiv = "<div class=\"game-level-info clearfix col-3\" > " +
			               "<div class=\"img-holder\">" +
        						"<img src=\"/images/v2/chip1.png\" alt=\"\">" +
    						"</div>" +
    						"<form action=\"GameController\" method=\"get\">" +
							"<div class=\"game-level-info-helper\">" +
							    "<input name=\"tournamentId\" value=\"" + data.tournamentId + "\"  class=\"hidden\" \>" +
							    "<input name=\"tournamentType\" value=\"" + data.tournamentType + "\" class=\"hidden\" \>" +
								"<div class=\"game-level-info-triger\">" +
					            "<h5 name=\"tournamentName\" value=\""+ data.tournamentName + "\" >" + data.tournamentName + "</h5>" +
					            "<p class=\"game-level-info-title-info first clearfix\">" +
					            	"" +
					            	"<span class=\"pull-left\">Required Chips: $" + data.buyInCredits.credits + "</span></p>" +
					            	"<p class=\"game-level-info-title-info second\">Required Gold:" + data.buyInCredits.goldCoins+"</p>" +
					        "</div>" +
					        "<div class=\"game-level-info-description js-drop-down\">" +
					        	"<p>Max Players <span>"+ data.maxPlayers+"</span></p>" +
					        	"<p>Number of Games <span>" +data.numberOfGames+ "</span></p>" +
					        	"<p>Eligibility <span class=\""+ eliCheck + "\"></span></p>" +
					        	"<table class=\"prize-distribution "+prizeDisributionClass+ "\">" +
					        		"<caption>Prize Distribution</caption>" +
					        		"<tr class=\"prize-distribution-subtitle\">" +
					        			"<th>Rank</th>" +
					        			"<th>Chips</th>" +
					        			"<th>Gold</th>" +
				        			"</tr>" +
				        			"<tr>" +
				        				"<td>1st</td>" +
				        				"<td>$" + prizesCredits[0] + "</td>" +
				        				"<td>" + prizesGoldCoins[0] + "</td>" +
			        				"</tr>" +
			        				"<tr>" +
			        					"<td>2nd</td>" +
			        					"<td>$"+ prizesCredits[1] +"</td>" +
			        					"<td>"+ prizesGoldCoins[1] +"</td>" +
		        					"</tr>" +
		        					"<tr>" +
		        						"<td>3rd</td>" +
		        						"<td>$"+ prizesCredits[2] +"</td>" +
		        						"<td>"+ prizesGoldCoins[2] +"</td>" +
	        						"</tr>" +
        						"</table>" +
        						"<button class=\"btn\""+ playBtnClass +" type=\"submit\" >Play now</button>" +
        						"<button class=\"btn add-chips " + addChipsClass+ "\">"+ addChipsText +"</button>" +
    						"</div>" +
						"</div>" +
						"</form>" +
					"</div>" ;
	
	tournamentsDiv.innerHTML += tournamentDiv;
}

function slider() {
	// slick slider on tournament selection page
    if ($('.js-game-level').length > 0) {
        $('.js-game-level').slick({
            infinite: true,
            slidesToShow: 4,
            slidesToScroll: 1,
            // dots: true,
            responsive: [
                {
                  breakpoint: 991,
                  settings: {
                      slidesToShow: 2,
                      slidesToScroll: 1,
                  }
                },
                {
                  breakpoint: 768,
                  settings: "unslick",
                }

            ]
        });
        $(window).resize(function() {
            $('.js-game-level').slick('resize');
        });
    }
}