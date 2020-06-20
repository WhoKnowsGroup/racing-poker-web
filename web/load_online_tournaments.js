$(document).ready(function() {
   //XXX:  this just makes up some random numbers to display; doesn't load anything from the server
	var load = Math.floor((Math.random() * 200) + 1); 
	load += 2500;
	var tournaments_load = parseInt(load/7);
	var load_div = document.getElementById("online");
	if (load_div) {
		load_div.innerHTML = "<em><span> &nbsp;"+ load+"</span></em>"+" &nbsp;Players&nbsp;"+"<em><span> &nbsp;"+ tournaments_load+"</span></em>"+" &nbsp;Tournaments&nbsp;";
	}
});