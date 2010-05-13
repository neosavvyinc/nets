function parseServiceResponse(responseText) {
    if (responseText == null || responseText == '') {
		return null;
    }

    try {
		Ti.API.debug('Response=' + JSON.stringify(responseText));
	    return JSON.parse(responseText);
	}
	catch (err) {
		return null;
	}
}

/**
Do the Login
Sample REST Login Response="{\"authorities\":\"ROLE_ADMIN\",\"name\":\"foo\",\"sessionId\":\"CA798276-7C3D-4216-BCCD-43B11C6BCD11\",\"user\":{\"emailAddress\":\"chris@underculture.net\",\"firstName\":\"Foo\",\"lastName\":\"Foo\",\"middleName\":\"Foo\",\"active\":\"true\",\"confirmedRegistration\":\"true\",\"id\":\"1\",\"username\":\"foo\"}}"
*/
function serviceLogin(username, password, successCallback, failureCallback) {
    httpClient.onerror = failureCallback;
    httpClient.onload = function() { successCallback(parseServiceResponse(this.responseText)); };
	httpClient.open('POST', MOBILE_SERVICE_BASE_URL + '/dashboardlogin/');
    httpClient.send({
        username:username,
        password:password
    });    

}

/**
Get the Dashboard Summary
Sample REST Dashboard Response"{\"numberExpenseReportsApproved\":\"0\",\"numberExpenseReportsAwaitingApproval\":\"1\",\"numberExpenseReportsAwaitingReconciliation\":\"0\",\"numberExpenseReportsDeclined\":\"0\",\"numberExpenseReportsOpened\":\"0\",\"numberExpenseReportsReconciled\":\"0\"}"
*/
function serviceGetDashboardData(successCallback, failureCallback) {
    httpClient.onerror = failureCallback;
    httpClient.onload = function() { successCallback(parseServiceResponse(this.responseText)); };
	httpClient.open('GET', MOBILE_SERVICE_BASE_URL + '/dashboard/');
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
	httpClient.open('POST', MOBILE_SERVICE_BASE_URL + '/savereceipt/');
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
	httpClient.open('POST', STORAGE_SERVICE_BASE_URL + '/file/receipts/');
    httpClient.send({
        fileNameOverride:fileName,
        file:image
    });    
}

/**
Dashboard status drill-down
requests $MOBILE_SERVICE_BASE_URL/statusDashboard/status/<category>
where <category> is one of:
	OPEN
	SUBMITTED
	DECLINED
	APPROVING
	APPROVED
	dont' use--> REIMBURSEMENT
	REIMBURSEMENT_SENT
	REIMBURSEMENT_RECEIVED

REST call returns:
	private String expenseReportName;
    private String expenseReportLocation;
    private Double expenseReportTotal;
    private String projectName;
    private String projectApprover;
    private Date expenseReportStartDate;
    private Date expenseReportEndDate;
    private Date expenseReportLastActivityDate;

@param category string, <category> mentioned above
*/
function serviceGetStatusDashboard(category, successCallback, failureCallback) {
    httpClient.onerror = failureCallback;
    httpClient.onload = function() { successCallback(parseServiceResponse(this.responseText)); };
	httpClient.open('GET', MOBILE_SERVICE_BASE_URL + '/statusDashboard/status/' + category);
    httpClient.send(null);    
}

