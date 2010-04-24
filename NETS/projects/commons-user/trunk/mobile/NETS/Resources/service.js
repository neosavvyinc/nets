function parseServiceResponse(responseText) {
    if (responseText == null || responseText == '') {
		return null;
    }

    try {
	    return JSON.parse(responseText);
	}
	catch (err) {
		return null;
	}
}

function serviceLogin(username, password, successCallback, failureCallback) {
    httpClient.onerror = failureCallback;
    httpClient.onload = function() { successCallback(parseServiceResponse(this.responseText)); };
	httpClient.open('POST', mobileServiceBaseUrl + '/dashboardlogin/');
    httpClient.send({
        username:username,
        password:password
    });    

}

function serviceGetDashboardData(successCallback, failureCallback) {
    httpClient.onerror = failureCallback;
    httpClient.onload = function() { successCallback(parseServiceResponse(this.responseText)); };
	httpClient.open('GET', mobileServiceBaseUrl + '/dashboard/');
    httpClient.send(null);    
}

function serviceAddReceiptToUser(fileRef, successCallback, failureCallback) {
    httpClient.onerror = failureCallback;
    httpClient.onload = function() { 
        if (this.responseText == 'true') {
        	successCallback(fileRef);
        }
        else {
        	failureCallback(this.responseText);
        }
    };
    httpClient.onsendstream = function(e) { progressCallback(e.progress); };
	httpClient.open('POST', mobileServiceBaseUrl + '/savereceipt/');
	httpClient.setRequestHeader('Content-Type', 'application/json');
	try {
    	httpClient.send(JSON.stringify(fileRef));    
    }
    catch (err) {
    	alert(err);
    }
}

function serviceUploadReceipt(fileName, image, successCallback, failureCallback, progressCallback) {
    httpClient.onerror = failureCallback;
    httpClient.onload = function() { 
    	var fileRef = parseServiceResponse(this.responseText);
    	
    	if (fileRef == null) {
    	    Ti.API.debug('Failed to parse response: ' + this.responseText);
    		failureCallback(null);
    		return;
    	}
    	serviceAddReceiptToUser(fileRef, successCallback, failureCallback);
    };
    httpClient.onsendstream = function(e) { progressCallback(e.progress); };
	httpClient.open('POST', storageServiceBaseUrl + '/file/receipts/');
    httpClient.send({
        fileNameOverride:fileName,
        file:image
    });    
}
