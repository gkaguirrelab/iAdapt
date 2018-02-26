// =========== READ FROM SERVER ===========

// Read a JSON file and output an object with contents
function readJSONsync(jsonFile){
	var jsonContents = {};
	$.ajax({
		dataType: "json",
		url: jsonFile,
		async: false,
		success: function(data){
			//window.alert("Success!");
			jsonContents = data;
		},
		error: function(){window.alert("Failed to load: " + jsonFile);}
	});
	return jsonContents;
}

// Load all parameter files specified in the protocolList file
function loadParams(protocolList){
	var params = {};
	for(var i=0; i<protocolList.length; i++){
		params[protocolList[i].name] = readJSONsync(protocolList[i].paramsFile);
	}
	return params;
}

// Load a CSV file and output to a two-dimensional array
function loadCSVfile(csvFile){
	var formattedData = [];
	$.ajax({
		type: "GET",
		url: csvFile,
		dataType: "text",
		async: false,
		success: function(data) {
			allTextLines = data.split(/\r\n|\n/);
			headers = allTextLines[0].split(',');
			numRows = allTextLines.length;
			numCols = headers.length;
			var allData = new Array (numRows);
			for (var i=0; i<numRows; i++) {
				allData[i] = allTextLines[i].split(',');
			}
			formattedData = allData;
		},
		error: function(){window.alert("Failed to load: " + csvFile);}
	});
	// Remove blank lines at the end
	i=1;
	while(formattedData[formattedData.length-1] == ""){
		formattedData = formattedData.slice(0, -1);
	}
	//console.log(formattedData);
	return formattedData;
}

// Load all parameter files specified in the protocolList file
function loadTXTfile(txtFile){
	var loadedText = [];
	$.ajax({
		type: "GET",
		url: txtFile,
		dataType: "text",
		async: false,
		success: function(data) {
			loadedText = data;
		},
		error: function(){window.alert("Failed to load: " + csvFile);}
	});
	// Remove blank lines at the end
	i=1;
	while(loadedText[loadedText.length-1] == ""){
		loadedText = loadedText.slice(0, -1);
	}
	return loadedText;
}

// Load and execute a JavaScript script
function runJSscript(jsFile){
	$.ajax({
		url: jsFile,
		dataType: "script",
		error: function() {window.alert("Could not run script: " + jsFile);}
	});
}