// Parameters questions, choices and answers are arrays. Choices is a 2d array and the rest are 1d.
// This function assumes that(number of answers) = (number of questions). initfunc is a function
// that is called to initialize an experiment after the instruction loop
function instructLoop(questions, choices, answers, initfunc) {

	var instructs = readJSONsync(instructionListFile);
	instructs = loadParams(instructs);
	
	//Load instructions
	var prompt =  loadTXTfile(instructs.instructLoop.prompt);
	var backgroundcolor = instructs.instructLoop.backgroundcolor;
	var textcolor = instructs.instructLoop.textColor;
	var instructWidth = instructs.instructLoop.width;
	var instructHeight = instructs.instructLoop.height;
	var titleFontSize = instructs.instructLoop.titleFontSize;
	var textFontSize = instructs.instructLoop.textFontSize;
	var buttonWidth = instructs.instructLoop.buttonwidth;
	var buttonHeight = instructs.instructLoop.buttonHeight;
	var buttonFontSize = instructs.instructLoop.buttonfontSize;

	var numQuestions = questions.length;
	initialize();


	function initialize() {
		// Set background color
		$("#content").css({"background-color": "rgb" +backgroundcolor});

		// Create a div that will display a message and append to the HTML body
		$("#content").append("<div class = 'loopDir'>\
			<div id = 'loopDirPromp'></div>\
			<div id = 'loopDir'></div>\
			<button id ='submitButton'>Submit</button>\
		</div>");

		// =========== DEFINE STYLE OF THE ELEMENTS ===========

		setStyle();
	}

	// Defines the style of the elements
	function setStyle(){

		// Define style of div used to display a message during break
		$(".loopDir").css({
			'color':'rgb' + textcolor,
		    'width': ''+instructWidth+'px',
		    'height': ''+instructHeight+'px',
		    'position': 'relative',
		    'font-size':  '' +titleFontSize+'px',
		    'text-align':'center',
		    'margin': '0 auto', 
			'-moz-user-select': '-moz-none',
   			'-khtml-user-select': 'none',
   			'-webkit-user-select': 'none',
   			'-ms-user-select': 'none',
   			'user-select': 'none',
   			'white-space': 'pre-wrap'       
		});
		$("#loopDir").css({
		    'text-align':'left',
		    'font-size':  '' +textFontSize+'px'
		});
		$("#submitButton").css({
			'width': ''+buttonWidth+'px',
			'height': ''+buttonHeight+'px',
		    'font-size':  '' + buttonFontSize +'px',
		    'display':'block',
		    'margin': '0 auto'
		});
		$("#content").css({
			'overflow':'scroll'
		});
		// Set prompt
		$("#loopDirPromp").text("" + prompt);
		for(var i = 0; i < numQuestions; i ++){
			$("#loopDir").append("" + questions[i] + "\n\n");
			for(var j = 0; j < choices[i].length; j ++){
				$("#loopDir").append("<input type='radio' name = question"+i+" value = '"+choices[i][j]+"'>");
				$("#loopDir").append("" + choices[i][j] + "\n");
			}
			$("#loopDir").append("\n");
		}
		
	}
		
	
	// =========== EVENT FUNCTIONS ===========

	$("#submitButton").click(function() {
		// Checked if all of the answered questions are correct
		var allCorrect = true;
		for(var i = 0; i < numQuestions && allCorrect == true; i ++){
			if (!($("input:radio[name=question"+i+"]:checked ").val() == answers[i])){
				allCorrect = false;
			}
		}
		if(allCorrect == false){
			window.alert("At least one of your answers is incorrect");
		}else{
			$(".loopDir").remove();
			initfunc();
		}
	});

}
