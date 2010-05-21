/**
@file constants.js

Application constants cataloged here.
*/

var MOBILE_SERVICE_BASE_URL = 'http://nets.neosavvy.com:8080/nets/expense/services/mobile';
var STORAGE_SERVICE_BASE_URL = 'http://nets.neosavvy.com:8080/nets/storage';
if (1) {
	MOBILE_SERVICE_BASE_URL = 'http://localhost:8080/nets/expense/services/mobile';
	STORAGE_SERVICE_BASE_URL = 'http://localhost:8080/nets/storage';
	if (Titanium.Platform.name == 'android') {
		//localhost and 127.0.0.1 don't work for the local host on android, instead 10.0.2.2
		//see http://developer.android.com/guide/developing/tools/emulator.html#networkaddresses
		MOBILE_SERVICE_BASE_URL = 'http://10.0.2.2:8080/nets/expense/services/mobile';
		STORAGE_SERVICE_BASE_URL = 'http://10.0.2.2:8080/nets/storage';
		//MOBILE_SERVICE_BASE_URL = 'http://174.143.211.104:8080/nets/expense/services/mobile';
		//STORAGE_SERVICE_BASE_URL = 'http://174.143.211.104:8080/nets/storage';
	}
}


//Enumerator for the different screens we have in the app
var SCREEN = {
	LOGIN 					: {id:0, name:'login'},
	DASHBOARD 				: {id:1, name:'dashboard'},
	CONFIRM_RECEIPT_UPLOAD 	: {id:2, name:'confirmReceiptUpload'},
	STATUS_DASHBOARD		: {id:3, name:'statusDashboard'},
	DATE_RANGE				: {id:4, name:'dateRange'}
};

//App Properties
var PROPERTY = {
	USERNAME  : {id:0, name:'un'},
	PASSWORD  : {id:1, name:'pw'},
	DATERANGE : {id:2, name:'dr'}
};

//Colors
var NETS_COLOR = {
	BG_GRADIENT_DARK : '#9acab9',
	BG_GRADIENT_LIGHT : '#e5f2ee',
	BUTTON_GRADIENT_DARK : '#f18106',
	BUTTON_GRADIENT_LIGHT : '#feac37',
	DIALOG_BG : '#fcf7e7',
	DIALOG_BG_GRADIENT_DARK : '#fdedb9',
	DARK_GRAY : '#222'
};

/*
public enum ExpenseReportStatus {
    OPEN                        //Open - when an expense report is created it is in an open state
    ,SUBMITTED                  //Submitted - once a user submits it to the workflow it is submitted
    ,DECLINED                   //Declined - once any approver has found a problem it will be set to this state
    ,APPROVING                  //Approving - once the first approver has touched the expense report it is in this state
    ,APPROVED                   //Approved - once the last approver has agreed that the expense report is valid it is in this state
    ,REIMBURSEMENT_SENT         //Reimbursement Sent - once the accounting personal has sent a check it is in this state
    ,REIMBURSEMENT_RECEIVED     //Reimbursement Received - once the expense report user who created the expense has received reimbursement
}

Sample REST Dashboard Response = {
	numberApprovedExpenses : 0 ,
	numberApprovingExpenses : 0 ,
	numberDeclinedExpenses : 0 ,
	numberOpenExpenses : 0 ,
	numberReimbursedmentReceivedExpenses : 0 ,
	numberReimbursmentSentExpenses : 0 ,
	numberSubmittedExpenses : 0
	}
*/
//Dashboard categories
var DASHBOARD_STATUS = {
	OPEN 					: {name:'Open', status:'OPEN'},
	SUBMITTED				: {name:'Submitted', status:'SUBMITTED'},
	DECLINED 				: {name:'Declined', status:'DECLINED'},
	APPROVING 				: {name:'Approving', status:'APPROVING'},
	APPROVED 		   		: {name:'Approved', status:'APPROVED'},	
	REIMBURSEMENT_SENT 	   	: {name:'Reimbursement Sent', status:'REIMBURSEMENT_SENT'},
	REIMBURSEMENT_RECEIVED 	: {name:'Reimbursement Received', status:'REIMBURSEMENT_RECEIVED'}
};