(function() {

	//Load instructions
	var instructions = loadTXTfile(params.mainInstructions.instructions);
	var screenHeight = screen.height;
	var windowHeight = $(window).height();
	var windowWidth = $(window).width();
	var divHeight = $("#content").height();

	var backgroundcolor = params.mainInstructions.backgroundcolor;
	var textcolor = params.mainInstructions.textColor;
	var instructWidth = params.mainInstructions.width;
	var instructHeight = params.mainInstructions.height;
	var fontSize = params.mainInstructions.fontsize;
	var buttonWidth = params.mainInstructions.buttonwidth;
	var buttonHeight = params.mainInstructions.buttonHeight;
	var buttonFontSize = params.mainInstructions.buttonfontSize;

	initialize();


	function initialize() {
		// Set background color
		$("#content").css({"background-color": "rgb" +backgroundcolor});
		// Create a div that will display a message and append to the HTML body
		$("#content").append("<div class = 'messagedisplay'>\
			<div id = 'messagedisplay'></div>\
			<button id ='messageButton'>Click Here To Continue</button>\
		</div>");

		$("#content").append("<div id='progress-container'>\
			<div id='progress-bar'></div>\
			</div>");
		// $(".messagedisplay").hide();

		// =========== DEFINE STYLE OF THE ELEMENTS ===========

		setStyle();
		showMessage();
	}

	// Defines the style of the elements
	function setStyle(){

		// Define style of div used to display a message during break
		$(".messagedisplay").css({
			'color':'rgb' + textcolor,
		    'width': ''+instructWidth+'px',
		    'height': ''+instructHeight+'px',
		    'position': 'relative',
		    'font-size':  '' + fontSize+'px',
		    'text-align':'center',
		    'margin': '0 auto', 
			'-moz-user-select': '-moz-none',
   			'-khtml-user-select': 'none',
   			'-webkit-user-select': 'none',
   			'-ms-user-select': 'none',
   			'user-select': 'none',
   			'white-space': 'pre-wrap'       
		});
		$("#messageButton").css({
			'width': ''+buttonWidth+'px',
			'height': ''+buttonHeight+'px',
		    'font-size':  '' + buttonFontSize +'px',
		});
	}
		
	// Displays a prompt to the user
	function showMessage(){
		setMessage(instructions);
		$(".messagedisplay").show();
	}
	// Sets message that will be displayed to the user as the text on
	// the messagedisplay element
	function setMessage(message){
		$("#messagedisplay").text("" + message); 	
	}
	
	// =========== EVENT FUNCTIONS ===========

	$("#messageButton").click(function() {
		$(".messagedisplay").remove();
		nextProtocol();
	});





}());



// =========== INITIALIZE PAGE/DIVS ===========









//loadStimuli(RGBarray);
//makeThumbVisible();

// Create a div named color### for each of the 360 colors loaded
function loadStimuli(RGBarray){
	for (degree=0; degree<RGBarray.length; degree++) {
		//console.log('<div id = "color' + degree + '" style = "background-color:rgb(' + RGBarray[degree][0] + ',' + RGBarray[degree][1] + ',' + RGBarray[degree][2] + ');"></div>');
		$('<div class = "deg' + degree + ' color" id = "color' + degree + '" style = "background-color:rgb(' + RGBarray[degree][0] + ',' + RGBarray[degree][1] + ',' + RGBarray[degree][2] + ');"></div>').appendTo(".color-circle");
	}
}

//Makes all thumbnails visible
function makeThumbVisible(){
	//$(".color-circle").show();
	$(".deg0").show();
	$(".deg45").show();
	$(".deg90").show();
	$(".deg135").show();
	$(".deg180").show();
	$(".deg225").show();
	$(".deg270").show();
	$(".deg315").show();
}





//window.alert("Screen loaded");
//console.log(wheelRotation);
// document.body.innerHTML="<p>BEGINNING OF THE TRIAL</p>";


//$('body').prepend('<div class = "color-circle"></div>');
//$('body').prepend('<div id="created_div"></div>');


//$('.expDiv').append("<div class="color-circle">I'm new box by prepend</div>");
//var $expDiv = $("<div class="color-circle">I'm new box by prepend</div>").appendTo('body');


//setCircleSize(0.3);
//setCenterImageSize(.01);
//setThumbNailSize(.07);
//







//Size in pixels. Sets height and width both to a percentage of the screen height
function setCenterImageSize(percentScreenHeight){
	var size = screen.height * percentScreenHeight;
	var margin = size/2;
	margin += "px";
	var windowWidth = $(window).width();
	var halfCircleSize = $(".color-circle").height() / 2;
	var iconSize = $(".color-circle div").height();
		
	$("#faceCenter").css({"width":""+size+"px","height":""+size+"px", "margin":"-"+margin});
	$("#colorCenter").css({"width":""+size+"px","height":""+size+"px", "margin":"-"+margin});
	$("#blank").css({"width":""+size+"px","height":""+size+"px", "margin":"-"+margin, "line-height":""+size+"px"});
	$("#theMask").css({"width":""+size+"px","height":""+size+"px", "margin":"-"+margin});
	$(".faceTargetPrime img").css({"width":""+size+"px","height":""+size+"px", "margin":"-"+margin});
	$(".colorTargetPrime div").css({"width":""+size+"px","height":""+size+"px", "margin":"-"+margin});

	$(".directions").css({"width":""+(halfCircleSize*4)+"px","height":""+(halfCircleSize*2)+"px","margin":"-"+(halfCircleSize*2)});

	// If the window size is less than a certain size, make calibrators closer to the center
	if(windowWidth < (halfCircleSize * 4) + size)
	{
		$("#faceCalibratorLeft").css({"width":""+size+"px","height":""+size+"px", "margin":"-"+margin, "top":"50%","left": "-" +(halfCircleSize - iconSize + 20)+"px" });
		$("#colorCalibratorLeft").css({"width":""+size+"px","height":""+size+"px", "margin":"-"+margin, "top":"50%","left": "-" +(halfCircleSize - iconSize + 20)+"px"});
		$("#faceCalibratorRight").css({"width":""+size+"px","height":""+size+"px", "margin":"-"+margin, "top":"50%","left":""+(halfCircleSize * 3 - iconSize + 20)+"px"  });
		$("#colorCalibratorRight").css({"width":""+size+"px","height":""+size+"px", "margin":"-"+margin, "top":"50%","left":"" +(halfCircleSize * 3 - iconSize + 20)+"px" });
	}
	else
	{
		$("#faceCalibratorLeft").css({"width":""+size+"px","height":""+size+"px", "margin":"-"+margin, "top":"50%","left": "-50%" });
		$("#colorCalibratorLeft").css({"width":""+size+"px","height":""+size+"px", "margin":"-"+margin, "top":"50%","left":"-50%"});
		$("#faceCalibratorRight").css({"width":""+size+"px","height":""+size+"px", "margin":"-"+margin, "top":"50%","left": "150%"});
		$("#colorCalibratorRight").css({"width":""+size+"px","height":""+size+"px", "margin":"-"+margin, "top":"50%","left": "150%"});
	}
}



//Size in pixels. Sets height and width both to a percentage of the screen height
function setThumbNailSize(percentScreenHeight){
	var size  = screen.height * percentScreenHeight;
	var margin = size/2;
	margin += "px";
	$(".face-circle img").css({"width":""+size+"px","height":""+size+"px","margin":"-"+margin});
	$(".color-circle div").css({"width":""+size+"px","height":""+size+"px","margin":"-"+margin});
}






















//window.alert("Loading js file again...");

function calibrationColor(){
	// Remove all click functions present at the moment
	$("html").unbind("click");
	var clickCount = 0;//Keeps track of the number of clicks that user has made in order to only show the circle on the first click, and record input on the second click
	var color;

	$("html").mousemove(function(event){
		if($(".color-circle").is(":visible")){
			//Find x, y coordinates in relation to center of the circle, which is offset in relation to the top left corner of the browser window
			var x = event.pageX - $(".color-circle").offset().left - ($(".color-circle").width()/2);
			var y = event.pageY - $(".color-circle").offset().top -  ($(".color-circle").height()/2);
			var coordinates = x + ", " + y;

			//Gives angle (in radians) from negative pi to pi
			angle = Math.atan2(y, x);
			//Converts to degrees
			if(angle < 0){
				angle += 2 * Math.PI;
				angle *= (180/Math.PI);
			}
			else{
				angle *= (180/Math.PI);
			}
			angle = Math.floor(angle);

			//Used for debugging. Sets log to show current angle of the mouse in relation the center of the circle
			//$("#log").html(""+angle);
			//console.log(angle);
			centerChange(angle, "color");
		}
	});

	$("html").click(function(){
		if($(".color-circle").is(":visible")){
			$(".color-circle").show();
			if(clickCount == 0){
				$("#colorDir").hide();
				$(".colorCenter").show();
				$("#colorCenter").css({"background-color":"rgb(255,0,0)"});
				centerChange(angle, "color");
				clickCount ++;
				//window.alert("clickCount = " + clickCount);
			}
			/*
			else{
				//Take user's target choice and time of click, store all data from trial, then reset data variable and clickCount variable
				dataSet += "#";
				color = $("#colorCenter").css("background-color");
				dataSet += color.replace("rgb","");
				dataSet += "#";
				dataSet += $.now();
				dataSet += "#";
				dataSet += taskTrialNum; 
								
				dataSet += "#" + sTarget;
				dataSet += "#" + sPrimeOffset;

				store(dataSet);
				taskTrialNum++;
				clickCount = 0;
				
				//During prime task, check if user is clicking on prime instead of target
				if(task == "primeColorLong" || task == "primeColorShort"){
					//Account for wheel rotation
					if(task == "primeColorLong"){
						var target = params["primeTargetColorLong"][taskTrialNum - 2] + rotation;
						if (target > 360) target -= 360;
						if (target < 0) target += 360;
						currPrime = calcPrimeOffset(target, params["primePrimeColorLong"][taskTrialNum - 2]);
					}
					else{
						var target = params["primePrimeColorShort"][taskTrialNum - 2] + rotation;
						if (target > 360) target -= 360;
						if (target < 0) target += 360;
						currPrime = calcPrimeOffset(target, params["primePrimeColorShort"][taskTrialNum - 2]);
					}
					//Find distance of user choice from prime	
					var distPrime = Math.abs(angle - currPrime);
					if(distPrime > 180 && angle > currPrime){
						distPrime = Math.abs(360 - angle + currPrime);
					}
					else if(distPrime > 180 && angle < currPrime){
						distPrime = Math.abs(angle + 360 - currPrime);
					}
					if(Math.abs(angle - currPrime) <= 10){
						window.alert("Remember that you must match the second color, and not the first one, on the selection wheel");
					}
				}
				$(".color-circle").hide()
				//Rotate wheel back to original position
				rotateWheel((rotation * -1),"color",params["initialize"][0]);
				trial();
			}
			*/
		}
	});





	if(taskTrialNum <= thisSeq.length){
		if(blockNum == -1){
			numTrials = thisSeq.length;
			setDirections(params.calibrationColor.instructionsPre);
			$(".directions").show();
			blockNum ++;
			//window.alert("blockNum = " + blockNum);
		}else if(blockNum==0){
			//$(".directions").hide();
			blockNum ++;
			//window.alert("blockNum = " + blockNum);
			window[protocolList[0].name]();
		}else if(taskTrialNum <= params.calibrationColor.trialsPerBlock * blockNum){
			//window.alert("taskTrialNum = "+ taskTrialNum);
			setTimeout(function(){dataSet = id + "";}, 0);
			setTimeout(function(){dataSet += "#CalibrationColor#Calibration";},0);
			setTimeout(function(){dataSet += "#"; dataSet += 0;},0);
			setTimeout(function(){$(".directions").hide();}, 0);
			setTimeout(function(){$("#body").css({"background-color": "rgb(128, 128, 128)"});}, 0);
			setTimeout(function(){rotateWheel(wheelRotation[taskTrialNum-1][1],"color",params.calibrationColor.wheelSize);},0);
			setTimeout(function(){rotation = wheelRotation[taskTrialNum-1][1];},0);
			setTimeout(function(){setCalibrator(thisSeq[taskTrialNum-1]);setCalibrator(thisSeq[taskTrialNum-1],"color");}, 0);
			setTimeout(function(){sTarget = thisSeq[taskTrialNum-1];}, 0);
			setTimeout(function(){dataSet += "#";},0);
			setTimeout(function(){dataSet += $.now();},0);
			setTimeout(function(){$(".colorCalibrator").show();}, 0);
			setTimeout(function(){dataSet += "#";},0);
			setTimeout(function(){dataSet += $.now();},0);
			setTimeout(function(){$(".color-circle").show();}, 0);
			setTimeout(function(){$(".colorCenter").hide(); $(".faceCenter").hide();}, 0);
		}else{
			setTimeout(function(){$("#body").css({"background-color": "rgb(0, 0, 0)"});}, 0);
			setTimeout(function(){$(".colorCalibrator").hide();}, 0);
			setTimeout(function(){$(".color-circle").hide();}, 0);
			setTimeout(function(){$(".colorCenter").hide(); $(".faceCenter").hide();}, 0);
			setTimeout(function(){setDirections(params.calibrationColor.instructionsBreak);}, 0);
			setTimeout(function(){$(".directions").show();}, 0);
			blockNum ++;
		}			
	}else{
		setTimeout(function(){$("#body").css({"background-color": "rgb(0, 0, 0)"});}, 0);
		setTimeout(function(){$(".colorCalibrator").hide();}, 0);
		setTimeout(function(){$(".color-circle").hide();}, 0);
		setTimeout(function(){$(".colorCenter").hide(); $(".faceCenter").hide();}, 0);
		setTimeout(function(){analyze("CalibrationColor#Calibration#color#" + id);}, 0);
		setTimeout(function(){setDirections(params.calibrationColor.instructionsPost);}, 0);
		setTimeout(function(){$(".directions").show();}, 0);
		blockNum = -1;
		taskTrialNum = 1;
		//Next task
		taskNum ++;
	}

}





//console.log(thisSeq);
//console.log(RGBarray);

//document.getElementsByName("body").innerHTML="test";
//document.body.innerHTML="<p>NEW EXPERIMENT</p>";

//placeThumbnailsOnWheel(wheelRadius);

/*
// Makes all thumbnails visible
makeThumbVisible(); // In setGetters.js
// Sets height and width both to a percentage of the screen height
setThumbNailSize(params["initialize"][1]); // In setGetters.js
// Sets height and width both to a percentage of the screen height
setCircleSize(params["initialize"][0]); // In setGetters.js
// Sets height and width both to a percentage of the screen height
setCenterImageSize(params["initialize"][2]); // In setGetters.js
*/
// Append HTML element
//$("#foo").append("<div>hello world</div>")
// Change .css
//$("#myParagraph").css({"backgroundColor": "black", "color": "white"});
/*











*/

function calcXY(){

	//Change attribute of center
	centerchange();
}

function recorduInput(){

	//Record center attribute
}

function centerChange(imageDegree){
	//Replace center image source with source of image given (based on image degree)
	var imageDegree = "#color" + imageDegree;
	var newColor = $(imageDegree).css("background-color");
	$("#colorCenter").css({"background-color":""+newColor});
}

function calibColorSave(){
	if($(".color-circle").is(":visible")){
		if(clickCount == 0){
			$(".colorCenter").show();
			clickCount ++;
		}
		else{
			//Take user's target choice and time of click, store all data from trial, then reset data variable and clickCount variable
			dataSet += "#";
			color = $("#colorCenter").css("background-color");
			dataSet += color.replace("rgb","");
			dataSet += "#";
			dataSet += $.now();
			dataSet += "#";
			dataSet += taskTrialNum; 
							
			dataSet += "#" + sTarget;
			dataSet += "#" + sPrimeOffset;
				store(dataSet);
			taskTrialNum++;
			clickCount = 0;
			
			$(".color-circle").hide()
			//Rotate wheel back to original position
			rotateWheel((rotation * -1),"color",params["initialize"][0]);
			trial();
		}
	}
}








function setDirections(directions){
	$("#directions").text("" + directions); 
}





function rotateWheel(rotAngle, stimulus, circleSizePercentage){
	var angle;
	for (var i = 0; i < 360; i ++) {
		angle = getAngle(i, stimulus);
		angle = parseInt(angle);//Convert the string to an integer
		angle += rotAngle;
		
		if(angle >= 360)
		{
			angle -= 360;
		}
		else if(angle < 0)
		{
			angle += 360;
		}
		angleSetter(i, angle, stimulus);
	}
	//Readjust circle size each rotation so that it can be repositioned if user readjusts browser window size 
	setCircleSize(circleSizePercentage);
}


//Gets degree of an image given by parsing the image's class, set as the image's current angle
//Classes labeled using the convention: "deg" + angle + " " + stimulus (either face or color) 
function getAngle(imageNumber, stimulus)
{
	var image = "#" + stimulus + imageNumber;
	
	//Take first class of image (deg x)
	var degreeString = $(image).attr("class").split(" ")[0];
	
	//Split the integer from degreeString, which corresponds to the image angle
	var angle = degreeString.match(/\d+/g );
	return angle;
}

//Places an image on the circle based on angle
function angleSetter(imageNumber, angle, stimulus){
	
	//Remove old class and replace it with new angle class so that the new angle css now applies to this image
	var image = "#" + stimulus + imageNumber;
	var oldClass = $(image).attr("class");
	$(image).removeClass(""+oldClass);
	$(image).addClass("deg"+angle + "  " + stimulus);
   
	//If the new angle pertain's to a thumbnail, show it. Otherwise, hide it
	if(isThumbNail(imageNumber, stimulus))
	{
		$(image).show();
	}
	else
	{
		$(image).hide();
	}
}

//Changes the calibrator base on source of the nth image
function setCalibrator(imageNumber, stimulus){
	var target = "#"+stimulus + imageNumber;
	
	if(stimulus == "face")
	{
		var newSource = $(target).attr("src");
		$("#faceCalibratorLeft").attr("src", newSource);
		$("#faceCalibratorRight").attr("src", newSource);
	}
	else if (stimulus == "color")
	{
		var newColor = $(target).css("background-color");
		$("#colorCalibratorLeft").css({"background-color":""+newColor});
		$("#colorCalibratorRight").css({"background-color":""+newColor});
	}
}

//Checks if the image given has a class pertaining to the angle of a thumbnail
function isThumbNail(imageNumber, stimulus){
	var angle = getAngle(imageNumber, stimulus);
	if(angle == 0 || angle == 45 || angle == 90 || angle == 135 || angle == 180 || angle == 225 || angle == 270 || angle == 315)
	{
		return true;
	}
	else
	{
		return false;
	}
}

//console.log("calibColor.js successfully executed");

