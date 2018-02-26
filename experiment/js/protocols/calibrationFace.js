(function() {
		
	// =========== LOAD PARAMETERS and DEFINE VARIABLES ===========
	// Load the values for each face from external file
	var faceArray = loadCSVfile(params.calibrationFace.stimulusList);
	// Load the trial sequence from external file
	var temp = loadCSVfile(params.calibrationFace.stimulusSeq);
	var seqLen = temp.length;
	var seq = [];
	for (var i = 0; i < seqLen; i++) {
		seq.push(parseInt(temp[i]));
	}

	// Create one div for each face of the wheel, with the right face
	var temp = loadCSVfile(params.calibrationFace.wheelRotation);
	var thumbDisplacement = [];
	var wheelRotation = [];
	for (var i = 0; i < seqLen; i++) {
		thumbDisplacement.push(parseInt(temp[i][0]));
		wheelRotation.push(parseInt(temp[i][1]));
	}

	var preExperInstruction = loadTXTfile(params.calibrationFace.instructionsPre);
	var breakInstruction = loadTXTfile(params.calibrationFace.instructionsBreak);
	var postExperInstruction = loadTXTfile(params.calibrationFace.instructionsPost);

	var trialsPerBlock = params.calibrationFace.trialsPerBlock;
	var totalTrials = params.calibrationFace.totalTrials;
	var screenHeight = screen.height;
	var windowHeight = $(window).height();
	var windowWidth = $(window).width();
	var divHeight = $("#content").height();
	var circleSize = divHeight * params.calibrationFace.wheelSize;
	var centerSize = circleSize * params.calibrationFace.centerSize;
	var calibratorSize = circleSize * params.calibrationFace.centerSize;
	var thumbSize = circleSize * params.calibrationFace.thumbSize;

	var textColor = params.calibrationFace.textColor;
	var instructWidth = params.calibrationFace.instructWidth;
	var instructHeight = params.calibrationFace.instructHeight;
	var fontSize = params.calibrationFace.instructFontsize;
	var buttonWidth = params.calibrationFace.instructButtonwidth;
	var buttonHeight = params.calibrationFace.instructButtonHeight;
	var buttonFontSize = params.calibrationFace.instructButtonfontSize;
	var instructShiftFromTop = params.calibrationFace.instructShiftFromTop;

	var minimumClickTime = params.calibrationFace.minimumClickTime;
	var maxClickTime = params.calibrationFace.maxClickTime;

	// Accumulates the subject's accuracy score, to be used 
	// in order to calculate average accuracy score
	var accuracySum = 0;

	// breakstatus and clickstatus are used to manage event functions
	var breakstatus = 0;
	var clickstatus = 0;
	var loopstatus = 0;

	var trial = 0;
	var dbTableName = params.calibrationFace.dbTableName;

	var expData = new Object();
	expData.responseGiven = new Array(seqLen);
	expData.correctResp = new Array(seqLen);
	expData.trialNum = new Array(seqLen);
	expData.reactionTime = new Array(seqLen);


	initializeExperiment();
	
		

	// =========== EXPERIMENT FUNCTIONS ===========

	function initializeExperiment() {
		// Set background color
		$("#content").css({"background-color": "rgb" +params.calibrationFace.backgroundcolor});
		$("#header").css({"background-color": "rgb" +params.calibrationFace.backgroundcolor});
		// Reset header text
		$("#header").html("");
		$("#header").hide();

		// Create face circle and append to the HTML body
		//document.getElementById('content').innerHTML = 'Extra stuff';
		//$('<p>Text</p>').appendTo('#content');
		//$("#content").append('<p>Text</p>');
	
		$("#content").append("<div class = 'face-circle'>\
			<div class = 'thumbfaces' id = 'directions'>Click Here to Make Center Appear</div>\
			<p id = 'directions2'>Select the closest face on the wheel and then move your cursor to adjust. Click when you have it matched</p>\
			<img class = 'thumbfaces' id = 'faceCenter' draggable = 'false'></img>\
		    <img class = 'thumbfaces' id = 'faceCalibratorLeft' draggable = 'false'></img>\
		    <img class = 'thumbfaces' id = 'faceCalibratorRight' draggable = 'false'></img>\
		    <img class = 'thumbfaces' id = 'thumb0' draggable = 'false'></img>\
		    <img class = 'thumbfaces' id = 'thumb45' draggable = 'false'></img>\
		    <img class = 'thumbfaces' id = 'thumb90' draggable = 'false'></img>\
		    <img class = 'thumbfaces' id = 'thumb135' draggable = 'false'></img>\
		    <img class = 'thumbfaces' id = 'thumb180' draggable = 'false'></img>\
		    <img class = 'thumbfaces' id = 'thumb225' draggable = 'false'></img>\
		    <img class = 'thumbfaces' id = 'thumb270' draggable = 'false'></img>\
		    <img class = 'thumbfaces' id = 'thumb315' draggable = 'false'></img>\
		</div>");
		// Create a div that will display a message and append to the HTML body
		$("#content").append("<div class = 'messagedisplay'>\
			<div id = 'messagedisplay'></div>\
			<button id ='messageButton'>Click Here To Continue</button>\
		</div>");

		$("#content").append("<div id='progress-container'>\
			<div id='progress-bar'></div>\
			</div>");
		setMessage("Loading...Please wait");

		// =========== DEFINE STYLE OF THE ELEMENTS ===========

		setStyle();
		$("#messageButton").hide();
		preloadInit(faceArray);
		
	}

	// Defines the style of the elements
	function setStyle(){
		// Reajust sizes if window width or window height has changed
		if($(window).width() != windowWidth || $(window).height() != windowHeight){
			screenHeight = screen.height;
			windowHeight = $(window).height();
			windowWidth = $(window).width();
			divHeight = $("#content").height();
			circleSize = divHeight * params.calibrationFace.wheelSize;
			centerSize = circleSize * params.calibrationFace.centerSize;
			calibratorSize = circleSize * params.calibrationFace.centerSize;
			thumbSize = circleSize * params.calibrationFace.thumbSize;
		}
		// Define the style of the face circle
		$("#progress-container").css({
		    'width': ''+(windowWidth*params.calibrationFace.progressWidth)+'px',
		    'position': 'fixed',
		    'left':''+((windowWidth/2) - (windowWidth*params.calibrationFace.progressWidth)/2)+'px',
		    'top':params.calibrationFace.progressPercentFromTop +'%',
		    'height': windowHeight*params.calibrationFace.progressHeight+'px',
		    'background-color':'rgb'+params.calibrationFace.progressBackgroundColor
		});
		$("#progress-bar").css({
		  	'background-color':'rgb'+params.calibrationFace.progressForegroundColor,
		  	'width': '0%',
		  	'height': windowHeight*params.calibrationFace.progressHeight+'px',
		});
		$("#progress-container").hide();
		// Define the style of the face circle
		$(".face-circle").css({
		    'width': ''+circleSize+'px',
		    'height': ''+circleSize+'px',
		    'top': ''+((windowHeight/2) - (circleSize/2))+'px',
		    //'display': 'none',
		    'position': 'relative',
		    'border-radius': '50%', // make the borders of the div round
		    'border': 'dashed 1px green', // make the borders of the div dashed and green
		    'opacity': '1', // make the div and borders opaque
		    'margin': '0 auto' // move the div horizontaly towards the center of the parent div
		});

		// Define properties for all divs within the face-circle
		$(".thumbfaces").css({
		    'width': ''+thumbSize+'px',
		    'height': ''+thumbSize+'px',
		    'position':'absolute',
		    'top': ''+ (circleSize/2 - thumbSize/2)+'px',
		    'left': ''+(circleSize/2 - thumbSize/2)+'px',
		    'margin': '0 auto', // move the div horizontaly towards the center of the parent div
		    '-moz-user-select': '-moz-none',
   			'-khtml-user-select': 'none',
   			'-webkit-user-select': 'none',
   			'-ms-user-select': 'none',
   			'user-select': 'none'
		});

		// Define the style of the face center
		$("#faceCenter, #directions").css({
		    'width': ''+centerSize+'px',
		    'height': ''+centerSize+'px',
		    'top': ''+(circleSize/2 - centerSize/2)+'px',
		    'left': ''+(circleSize/2 - centerSize/2)+'px'
		});

		// Define the style of left calibrator
		$("#faceCalibratorLeft").css({
		    'width': ''+calibratorSize+'px',
		    'height': ''+calibratorSize+'px',
		    'top': ''+(circleSize/2 - calibratorSize/2)+'px',
		    'left': ''+(-(calibratorSize/2 + circleSize/2))+'px',
		    'float': 'left'
		});

		// Define the style of right calibrator
		$("#faceCalibratorRight").css({
		    'width': ''+calibratorSize+'px',
		    'height': ''+calibratorSize+'px',
		    'top': ''+ (circleSize/2 - calibratorSize/2)+'px',
		    'left': ''+(circleSize - calibratorSize/2 + circleSize/2)+'px',
		    'float': 'right'
		});
		// Define style of div used to display a message during break
		$(".messagedisplay").css({
		    'color':'rgb' + textColor,
		    'top': ''+(windowHeight/instructShiftFromTop)+'px',
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
		    'display':'block',
		    'margin': '0 auto'
		});
		// Define style of the directions shown on screen every trial
		$("#directions").css({
			'word-wrap': 'break-word',
		    'text-align':'center',
		    'top': ''+ (circleSize/2 - thumbSize/4)+'px',
		    'white-space': '-o-pre-wrap',
		    'white-space': '-pre-wrap'  
		});
		$("#directions2").css({
			'top':'115%',
			'position': 'relative',
			'word-wrap': 'break-word',
			'text-align':'center',
			 '-moz-user-select': '-moz-none',
   			'-khtml-user-select': 'none',
   			'-webkit-user-select': 'none',
   			'-ms-user-select': 'none',
   			'user-select': 'none'
		});

	}
	
	function getPercentProgress(barID){
		var width = $('#' + barID).width();
		var parentWidth = $('#' + barID).offsetParent().width();
		var percent = 100*width/parentWidth;
		return percent
	}
	// Adds additional (percentage) progress to the progress bar
	// specified by ID
	function addProgress(barID, progress) {
		var percent = getPercentProgress(barID);
		$("#" + barID).css({
		  	'width':(percent + progress) + "%"
		});
	};
	// Resets value of bar to 0
	function resetProgress(barID){
		$("#" + barID).css({
		  	'width':"0%"
		});
	}
	function loadProgressBar(barID, loadTime, increment){
		interval = setInterval(function(){
			var percent = getPercentProgress(barID);
			if(percent >= 100){
				clearInterval(interval);
			}else{
				addProgress(barID, (100/((loadTime/increment)-1))); 
			}
		},increment);
	}
	
	// Preloads images into cache, then either initializes
	// the experiment or the instructions loop
	function preloadInit(sources){
		$(".face-circle").hide();
		var count = 0;
		for(var i = 0; i < sources.length; i ++){
			var img = new Image();
			// Insures that all images are preloaded before trial is initialized
			img.onload = function(){
				if(count < sources.length - 1){
					count++;
				}else{
					$("#messageButton").show();
					$(".messagedisplay").hide();
					initializeTrial();
				}
			}
			img.src = sources[i];
		}
	}

	function initializeTrial() {
		if (trial < totalTrials){
			if(trial % trialsPerBlock == 0 && breakstatus == 0){
				takeBreak();
			}else{
				if(loopstatus == 1){
					loopstatus = 0;
				}
				$("#header").show();
				executeTrial();
			}
		}else if(breakstatus == 0){
			takeBreak();
		}else{
			$("#header").hide();
			finalizeExperiment();
		}
	}

	function executeTrial(){
		// Reajust sizes if window width or window height has changed
		if ($(window).width() != windowWidth || $(window).height() != windowHeight) {
		    setStyle();
		}
		$(".face-circle").show();
		$("#faceCenter").hide();
		$("#directions").show();
		// Define the style of left calibrator
		$("#faceCalibratorLeft").attr('src',faceArray[seq[trial]]);
		// Define the style of right calibrator
		$("#faceCalibratorRight").attr('src',faceArray[seq[trial]]);
		setDisplacement(thumbDisplacement[trial]);
		setRotation(wheelRotation[trial], 0);
		initialTime = $.now();
		if(maxClickTime != 0){
			$("#progress-container").show();
			loadProgressBar('progress-bar', maxClickTime, params.calibrationFace.progressInterval);	
			setMaxTimer(trial);
		}
		
	}
		
	function finalizeTrial(responseDegrees) {

		clearInterval(interval);
		resetProgress('progress-bar');
		$("#progress-container").hide();

		var unshiftResponse = scaleDegree(responseDegrees - thumbDisplacement[trial] - wheelRotation[trial]);
		expData.responseGiven[trial] = unshiftResponse;
		expData.reactionTime[trial] = $.now() - initialTime;
		expData.correctResp[trial] = seq[trial];
		expData.trialNum[trial] = trial;

		var rawScore = calcOffset(seq[trial], unshiftResponse);
		var accuracyScore = 100 - rawScore/1.8;
		// Round to the nearest tenth
		accuracyScore = Math.floor(accuracyScore * 10)/10;
		accuracySum += accuracyScore;
		// Rotate back to original position (setDisplacement() resets displacement to 0 before setting, so
		// that does not need to be reset)
		setRotation((wheelRotation[trial]) * -1, wheelRotation[trial]);
		// Write trial data to database
		writeTrialData(expData,trial,dbTableName, params.calibrationFace.database);
		trial++;

		$("#header").html("Trial Accuracy: " + accuracyScore + "%<br>Trial: #" + trial + " of " + totalTrials);

		initializeTrial();	
	}

	function finalizeExperiment() {
		$("#header").html("Experiment completed!");
		// Remove all eleemnts that were added to the DOM
		$( ".face-circle" ).remove();
		$( ".messagedisplay" ).remove();
		//Unbind event functions assosciated with body	
		$( "body" ).unbind("click");
		$( "body" ).unbind("mousemove");
		protocolComplete();
		// Have to delete every element I added to the page before leaving
	}

	// Pauses experiment and displays a prompt to the user
	function takeBreak(){
		$( ".face-circle" ).hide();
		if(trial == 0){
			if(params.calibrationFace.displayExperNum == 1){setMessage("This is task " + currentExperNum + "/" + protocolList.length + "\n\n"+ preExperInstruction);}else{setMessage(preExperInstruction);}
		}else if(trial < totalTrials){
			setMessage(breakInstruction);
		}else{
			// Subtract out the null trials from total number of trials
			// when calculating total average accuracy score 
			var nullTrials = 0;
			for(var i = 0; i < totalTrials; i ++){
				if(expData.responseGiven[i] == 'NULL'){
					nullTrials ++;
				}
			}
			setMessage(postExperInstruction + "\nYour average accuracy score is: " + Math.floor((accuracySum/(totalTrials - nullTrials))*10)/10);
		}
		$(".messagedisplay").show();
		breakstatus = 1;
	}
	// Sets message that will be displayed to the user as the text on
	// the messagedisplay element
	function setMessage(message){
		$("#messagedisplay").text("" + message); 	
	}
	// Sets the maximum time the user to complete a trial
	function setMaxTimer(startTrialNum){
		setTimeout(function(){
			if(trial == startTrialNum){
				window.alert("No response given. Please click OK to proceed to the next trial");
				expData.responseGiven[trial] = 'NULL';
				expData.reactionTime[trial] = 'NULL';
				expData.correctResp[trial] = seq[trial];
				expData.trialNum[trial] = trial;
				// Rotate back to original position (setDisplacement() resets displacement to 0 before setting, so
				// that does not need to be reset)
				setRotation((wheelRotation[trial]) * -1, wheelRotation[trial]);
				// Write trial data to database
				writeTrialData(expData,trial,dbTableName, params.calibrationFace.database);
				trial++;
				clickstatus = 0;
				
				$("#header").html("Trial Accuracy: No response given <br>Trial: #" + trial + " of " + totalTrials);
				clearInterval(interval);
				resetProgress('progress-bar');
				$("#progress-container").hide();
				showThumbNails();

				initializeTrial();
			}
		},maxClickTime);
	}
	// Given a degree value, returns the equivalent degree value from 0-259
	function scaleDegree(degree) {
		degree = parseInt(degree);
		while(degree >= 360 || degree < 0){
			if (degree >= 360) {
	            degree -= 360;
	        } else if (degree < 0) {
	            degree += 360;
	        }
	    }
	    return degree;
	}
	// Calculates the smallest of the two distances between
	// deg1 and deg2 in degrees
	function calcOffset(deg1, deg2){
		return Math.min(scaleDegree(deg1 - deg2), scaleDegree(deg2 - deg1));
	}
	function hideThumbNails(){
		for (var i = 0; i < 360; i+=45){
			$("#thumb" + i).hide();
		}
				  
	}
	function showThumbNails(){
		for (var i = 0; i < 360; i+=45){
			$("#thumb" + i).show();
		}
				  
	}
	// Sets displacement. Resets displacement from 0 position every time
	// this function is called
	function setDisplacement(displacement){
		for (var i = 0; i < 360; i += 45) {
			var displaceDeg = scaleDegree(i + displacement);
			$("#thumb"+i).css({
				'-webkit-transform': 'rotate(-'+displaceDeg+'deg) translate('+(circleSize/2)+'px) rotate('+displaceDeg+'deg)',
				'-moz-transform': 'rotate(-'+displaceDeg+'deg) translate('+(circleSize/2)+'px) rotate('+displaceDeg+'deg)',
				'-ms-transform': 'rotate(-'+displaceDeg+'deg) translate('+(circleSize/2)+'px) rotate('+displaceDeg+'deg)',
				'-o-transform': 'rotate(-'+displaceDeg+'deg) translate('+(circleSize/2)+'px) rotate('+displaceDeg+'deg)',
				'transform': 'rotate(-'+displaceDeg+'deg) translate('+(circleSize/2)+'px) rotate('+displaceDeg+'deg)'
				});
		}
	}
	// Rotate wheel, accounting for any offset currently in place
	function setRotation(rotation, offset){
		for (var i = 0; i < 360; i += 45) {
			var rotateface = scaleDegree( i - rotation - offset);
			$("#thumb"+i).attr('src',faceArray[rotateface]);
		}
	}


	// =========== EVENT FUNCTIONS ===========

	$("body").mousemove(function(e) {
		var mouseDegs = xy2degrees(e);
		// Account for any shifts
		var unshiftedDegrees = scaleDegree(mouseDegs - thumbDisplacement[trial] - wheelRotation[trial]);
		// Change the face of the center square
		$("#faceCenter").attr('src',faceArray[unshiftedDegrees]);
		//console.log(mouseDegs);
	});

	$("body").click(function(e) {
		if(!($(".messagedisplay").is(":visible")) && breakstatus == 1 && loopstatus == 0){
				breakstatus = 0;
		}else if($(".face-circle").is(":visible")&& loopstatus == 0){
			if(clickstatus == 0){
				clickstatus = 1;
				$("#directions").hide();
				hideThumbNails();
				$("#faceCenter").show();

				var mouseDegs = xy2degrees(e);
				// Account for any shifts
				var unshiftedDegrees = scaleDegree(mouseDegs - thumbDisplacement[trial] - wheelRotation[trial]);
				// Change the face of the center square
				$("#faceCenter").attr('src',faceArray[unshiftedDegrees]);
				//console.log(mouseDegs);

			}else if($.now() - initialTime > minimumClickTime){
					showThumbNails();
					clickstatus = 0;
					var mouseDegs = xy2degrees(e);
					finalizeTrial(mouseDegs);
					//console.log(mouseDegs);
			}
		}
	});
	$("#messageButton").click(function() {
		$(".messagedisplay").hide();
		if(trial == 0 && params.calibrationFace.instructLoop != undefined){
			instructLoop(params.calibrationFace.instructLoop.questions,
			params.calibrationFace.instructLoop.choices,
			params.calibrationFace.instructLoop.answers,initializeTrial);
			loopstatus = 1;
		}else{
			initializeTrial();
		}
	});





	// =========== AUXILIAR FUNCTIONS ===========

	/**
	 * xy2degrees(e)
	 * Converts from cartesian coordinates to degrees
	 * @param {Number} event object
	 * @return {Number} corresponding value in degrees
	 */
	function xy2degrees(e){
		var mouseCoords = "( " + e.pageX + ", " + e.pageY + " )";
		var clientCoords = "( " + e.clientX + ", " + e.clientY + " )";
		var horzCenter = windowWidth/2;
		var vertCenter = $("#faceCenter").offset().top + (centerSize/2);
		// Convert from cartesian to degrees
		var mouseDegs = (180/Math.PI) * Math.atan( (-(e.pageY-vertCenter)) / (e.pageX-horzCenter) );
		// Adjust degrees to be in the 0-360 range
		if (e.pageX < horzCenter){
			mouseDegs+=180;
		}
		if ((e.pageY >= vertCenter) && (e.pageX >= horzCenter)){
			mouseDegs += 360;
		}
		// Make sure there's 360 degrees is represented as 0
		mouseDegs = Math.round(mouseDegs);
		if (mouseDegs == 360){
			mouseDegs = 0;
		}

		// Finally, return degree value
		return mouseDegs;
	}
	

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

