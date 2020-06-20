/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var ctx;
var radius;
var hour = 3.10;
var minute = 0;
var count = 0;
var timer;
var fill_angle = 0.5;
var startTime;

function startTimerClock(seconds) {
    var canvas = document.getElementById("canvas");
    if (!canvas) {
        return;
    }
    ctx = canvas.getContext("2d");
    ctx.clearRect(0, 0, 50, 50);
    radius = canvas.height / 2;
    ctx.translate(radius, radius);
    radius = radius * 0.90;
    ctx.beginPath();
    ctx.arc(0, 0, radius, 0, 2 * Math.PI);
    ctx.fillStyle = "green";
    ctx.fill();

    ctx.lineWidth = 5;
    ctx.strokeStyle = "#003300";
    ctx.stroke();

    if (seconds == 30) {
        drawHand(ctx, 3.10, radius, radius * 0.07);
        drawHand(ctx, 0, radius, radius * 0.07);
        hour = 3.10;
        fill_angle = 0.5;
    }
    else if (seconds == 20) {
        drawHand(ctx, 2.10, radius, radius * 0.07);
        drawHand(ctx, 0, radius, radius * 0.07);
        hour = 2.10;
        fill_angle = 0.166;
    }
    else if (seconds == 15) {
        drawHand(ctx, 1.55, radius, radius * 0.07);
        drawHand(ctx, 0, radius, radius * 0.07);
        hour = 1.55;
        fill_angle = 0;
    }

    /* fill_angle = fill_angle - 0.033 ;
     ctx.arc(0, 0, radius, - 0.5*Math.PI , fill_angle*Math.PI);
     ctx.fillStyle = "#E03C31";
     ctx.fill(); */
    
    clearInterval(timer);

    startTime = new Date().getTime();
    timer = setInterval("drawClock(" + seconds + ")", 100);
}

function stopTimer() {
    clearInterval(timer);
    hour = 0;
    minute = 0;
    count = 0;
    //  fill_angle =-0.5;
}

function drawClock(seconds) {
	var now = new Date().getTime();
	var elapsedSeconds = Math.floor((now - startTime) / 1000.0);
	
    if (elapsedSeconds >= seconds) {
        stopTimer();
    }
    else if (elapsedSeconds > count) {
        ctx.beginPath();
        ctx.arc(0, 0, radius, 0, 2 * Math.PI);
        ctx.fillStyle = "green";
        ctx.fill();

        ctx.lineWidth = 5;
        ctx.strokeStyle = "#003300";
        ctx.stroke();
        hour = hour - 0.103;
        drawHand(ctx, hour, radius, radius * 0.07);
        drawHand(ctx, 0, radius, radius * 0.07);

        fill_angle = fill_angle - 0.033;
        ctx.arc(0, 0, radius, -0.5 * Math.PI, fill_angle * Math.PI);
        ctx.fillStyle = "#E03C31";
        ctx.fill();
        
        count++;
    }
}

function drawHand(ctx, pos, length, width) {
    ctx.beginPath();
    ctx.lineWidth = width;
    ctx.lineCap = "round";
    ctx.moveTo(0, 0);
    ctx.rotate(pos);
    ctx.lineTo(0, -length);
    ctx.strokeStyle = "black";
    ctx.stroke();
    ctx.rotate(-pos);
    // ctx.closePath();
}
