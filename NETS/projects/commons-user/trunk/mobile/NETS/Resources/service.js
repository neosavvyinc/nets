/**
Parse NETS server response into JSON
@return JSON encapsulation for the responseText, or null if failed
*/
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
expected REST Login Response="{\"authorities\":\"ROLE_ADMIN\",\"name\":\"foo\",\"sessionId\":\"CA798276-7C3D-4216-BCCD-43B11C6BCD11\",\"user\":{\"emailAddress\":\"chris@underculture.net\",\"firstName\":\"Foo\",\"lastName\":\"Foo\",\"middleName\":\"Foo\",\"active\":\"true\",\"confirmedRegistration\":\"true\",\"id\":\"1\",\"username\":\"foo\"}}"
*/
function serviceLogin(aUsername, aPassword, successCallback, failureCallback) {
	Ti.API.debug('serviceLogin> aUsername:' + aUsername + ' aPassword:' + aPassword);
	
    httpClient.onerror = failureCallback;
    httpClient.onload = function() { successCallback(parseServiceResponse(this.responseText)); };
	httpClient.open('POST', MOBILE_SERVICE_BASE_URL + '/dashboardlogin');
    httpClient.send({
        username:aUsername,
        password:aPassword
    });
}

/**
Get the Dashboard Summary
expected REST Dashboard Response="{\"numberApprovedExpenses\":\"0\",\"numberApprovingExpenses\":\"0\",\"numberDeclinedExpenses\":\"0\",\"numberOpenExpenses\":\"0\",\"numberReimbursedmentReceivedExpenses\":\"0\",\"numberReimbursmentSentExpenses\":\"0\",\"numberSubmittedExpenses\":\"0\"}"
*/
function serviceGetDashboardData(successCallback, failureCallback) {
	Ti.API.debug('serviceGetDashboardData>');
	
    httpClient.onerror = failureCallback;
    httpClient.onload = function() { successCallback(parseServiceResponse(this.responseText)); };
	httpClient.open('GET', MOBILE_SERVICE_BASE_URL + '/dashboard');
    httpClient.send(null);    
}

function serviceAddReceiptToUser(fileRef, successCallback, failureCallback) {
    Ti.API.debug('serviceAddReceiptToUser>');

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
	httpClient.open('POST', MOBILE_SERVICE_BASE_URL + '/savereceipt');
	httpClient.setRequestHeader('Content-Type', 'application/json');
	try {
    	httpClient.send(JSON.stringify(fileRef));    
    }
    catch (err) {
    	alert(err);
    }
}

function serviceUploadReceipt(fileName, image, successCallback, failureCallback, progressCallback) {
    Ti.API.debug('serviceUploadReceipt>');

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
requests $MOBILE_SERVICE_BASE_URL/statusDashboard/<category>
where <category> is one of:
	OPEN
	SUBMITTED
	DECLINED
	APPROVING
	APPROVED
	REIMBURSEMENT_SENT
	REIMBURSEMENT_RECEIVED

REST call returns an array named statusDashboardData which is a list of:
	private String expenseReportName;
    private String expenseReportLocation;
    private Double expenseReportTotal;
    private String projectName;
    private String projectApprover;
    private Date expenseReportStartDate;
    private Date expenseReportEndDate;
    private Date expenseReportLastActivityDate;

expected REST Dashboard Response="{\"statusDashboardData\":[{\"expenseReportEndDate\":\"2010-05-24T14:54:26.786-04:00\",\"expenseReportLastActivityDate\":\"2010-05-24T14:54:26.786-04:00\",\"expenseReportLocation\":\"Raleigh Fool!\",\"expenseReportName\":\"Drinkin' hard\",\"expenseReportStartDate\":\"2010-05-24T14:54:26.786-04:00\",\"expenseReportTotal\":\"500.0\"},{\"expenseReportEndDate\":\"2010-05-24T14:54:26.786-04:00\",\"expenseReportLastActivityDate\":\"2010-05-24T14:54:26.786-04:00\",\"expenseReportLocation\":\"Raleigh Fool!\",\"expenseReportName\":\"Makin' deals\",\"expenseReportStartDate\":\"2010-05-24T14:54:26.786-04:00\",\"expenseReportTotal\":\"500.0\"},{\"expenseReportEndDate\":\"2010-05-24T14:54:26.786-04:00\",\"expenseReportLastActivityDate\":\"2010-05-24T14:54:26.786-04:00\",\"expenseReportLocation\":\"Raleigh Fool!\",\"expenseReportName\":\"Hirin' Strippers\",\"expenseReportStartDate\":\"2010-05-24T14:54:26.786-04:00\",\"expenseReportTotal\":\"500.0\"}]}"

@param aCategory string, <category> mentioned above
*/
function serviceGetStatusDashboard(aCategory, successCallback, failureCallback) {
    Ti.API.debug('serviceGetStatusDashboard> aCategory:' + aCategory);

	httpClient.onerror = failureCallback;
    httpClient.onload = function() { successCallback(parseServiceResponse(this.responseText)); };
	httpClient.open('GET', MOBILE_SERVICE_BASE_URL + '/statusDashboard/' + aCategory);
    httpClient.send(null);    
}

