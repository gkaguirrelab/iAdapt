function createCORSRequest(method, url) {
  
  var xhr = new XMLHttpRequest();
  
  if ("withCredentials" in xhr) {
	console.log("Option 1!")
    // Check if the XMLHttpRequest object has a "withCredentials" property.
    // "withCredentials" only exists on XMLHTTPRequest2 objects.
    xhr.open(method, url, true);
		
   // xhr.onload=function () {
    //	var responseText = xhr.responseText;
    //	console.log(responseText)
    	//console.log(jQuery.parseJSON(xhr.responseText).status);	
    	//xhr.onload = function()
   // }
//    var obj = jQuery.parseJSON(xhr.responseText);
  //  console.log(obj)
	//xhr.send();
	
  } else if (typeof XDomainRequest != "undefined") {
		 
    // Otherwise, check if XDomainRequest.
    // XDomainRequest only exists in IE, and is IE's way of making CORS requests.
    xhr = new XDomainRequest();
    xhr.open(method, url);

  } else {
		 console.log("Option 3!")
    // Otherwise, CORS is not supported by the browser.
    xhr = null;

  }
  return xhr;
}

function makeCorsRequest(url) {
  // All HTML5 Rocks properties support CORS.
  
  var xhr = createCORSRequest('GET', url);
  if (!xhr) {
    alert('CORS not supported');
    return;
  }

  // Response handlers.
  xhr.onload = function() {
    console.log("Onload!");
    var params = jQuery.parseJSON(xhr.responseText);	
  };

  xhr.onerror = function() {
    alert('Woops, there was an error making the request.');
  };

  xhr.send();
}
