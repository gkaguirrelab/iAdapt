(function() {
	window.onload = function() {

		// =========== MAIN STRUCTURE ===========
		currentExperNum = 0;
		maximizeWindow();
		prepareSession();

		// var userInfo = prepareSession();
		/*1*/ //userDemographics()
		/*2*/ //mainInstructions()
		// beginSession(userInfo);

	};
}).call(this);


// Sets the next incomplete protocol in the 
// protocolList to have complete status, then
// loads the next incomplete protocol.
function protocolComplete(){
	var foundCompleteProtocol = false;
	for(var i = 0; foundCompleteProtocol == false && i < protocolList.length; i++){
		if(protocolList[i].completeStatus == false){
			protocolList[i].completeStatus = true;
			foundCompleteProtocol = true;
		}
	}
	nextProtocol();
}

// Loads next incomplete protocol
function nextProtocol(){
	var foundNextProtocol = false;
	// Search for next protocol that has not been completed
	for(var i = 0; foundNextProtocol == false && i < protocolList.length; i++){
		if(protocolList[i].completeStatus == false){
			foundNextProtocol = true;
			currentExperNum = i + 1;
			//beginIntructions(protocolList[i].jsFile);
			runJSscript(protocolList[i].jsFile);
			//endIntructions(protocolList[i].jsFile);
		}
	}
	if(foundNextProtocol == false){
		completionInstructions();
	}
		
}



//Provides a warning if user attempts to leave the page
window.onbeforeunload = function(event){ 
	return "Warning! Your work will be lost if you leave this page!"; 
};

function prepareSession(){
	// var userInfo = {
	//     age: 20,
	//     gender: "F",
	//     nationality:"US",
	//     handedness: "L",
	//     computerType:"Laptop"
	// };
	// return userInfo;
	
	// Get background info from subject
	runJSscript("js/background.js");

}

function mainInstructions(){
	runJSscript("js/instructions/mainInstructions.js");
}
function completionInstructions(){
	runJSscript("js/instructions/completionInstructions.js");
}
function beginSession(userInfo){
	var instructs = readJSONsync(instructionListFile);
	instructs = loadParams(instructs);
	protocolList = readJSONsync(protocolListFile); // in readFromServer.js
	params = loadParams(protocolList); // in readFromServer.js
	userID = writeUserData(userInfo, instructs.completionInstructions.database);
	var randBucketIndex = [];
	var randBucket = [];
	//Set completion status of each experiment to be false
	//and check if the protocol is to be shuffled
	for(var i = 0; i < protocolList.length; i++){
		protocolList[i].completeStatus = false;
		if(protocolList[i].shuffle != undefined){
			if(protocolList[i].shuffle == 1){
				randBucket.push(protocolList[i]);
				randBucketIndex.push(i);
			}
		}
	}
	// Shuffle protocols
	randBucket = shuffleArray(randBucket);
	for(var i = 0; i < randBucket.length; i ++){
		protocolList[randBucketIndex[i]] = randBucket[i];
	}

	mainInstructions();

	

	// nextProtocol();
}

//Randomize array element order in-place.
//Using Fisher-Yates shuffle algorithm.
function shuffleArray(array) {
    for (var i = array.length - 1; i > 0; i--) {
        var j = Math.floor(Math.random() * (i + 1));
        var temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

//Maximizes the browser window. Only seems to work in Safari browsers
function maximizeWindow(){
	window.moveTo(0, 0);
	window.resizeTo(screen.availWidth, screen.availHeight);
}


