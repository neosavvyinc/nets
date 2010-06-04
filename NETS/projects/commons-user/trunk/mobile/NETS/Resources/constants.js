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

//Enumerator for the different windows we use. It's conceivable that more than
//one screen (view) could live in a window
var WINDOW = {
	ROOT		: {id:0, name:'rootWin'},
	DASHBOARD 	: {id:1, name:'dashboardWin'},
	STATUSDASH 	: {id:2, name:'statusDashboardWin'},
	DATERANGE  	: {id:3, name:'dateRangeWin'},
    REPORT      : {id:4, name:'reportWin'},
	HELP 		: {id:5, name:'helpWin'}
};
var TABGROUP = {
	ROOT		: {id:100, name:'tabGroup'}
};

//Enumerator for the different screens we have in the app
//A screen is more of a logical notion about what the user sees
//For the most part, a screen will probably map to a View, but SCREEN
//is used with our switchToScreen fn which might create a window or tab group
var SCREEN = {
	LOGIN 					: {id:0, name:'login', parent:WINDOW.ROOT},
	TABGROUP 				: {id:1, name:'dashboard', parent:TABGROUP.ROOT},
	CONFIRM_RECEIPT_UPLOAD 	: {id:2, name:'confirmReceiptUpload', parent:WINDOW.ROOT},
	STATUS_DASHBOARD		: {id:3, name:'statusDashboard', parent:WINDOW.STATUSDASH},
	DATE_RANGE				: {id:4, name:'dateRange', parent:WINDOW.DATERANGE},
    REPORT                  : {id:5, name:'report', parent:WINDOW.REPORT}
};

//App Properties
var PROPERTY = {
	USERNAME  : {id:0, name:'un', type:'string', value:Ti.App.Properties.getString('un')},
	PASSWORD  : {id:1, name:'pw', type:'string', value:Ti.App.Properties.getString('pw')},
	DATERANGE : {id:2, name:'dr', type:'string', value:Ti.App.Properties.getString('dr')},
	START_D   : {id:3, name:'sd', type:'string', value:Ti.App.Properties.getString('sd')},
	START_M   : {id:4, name:'sm', type:'string', value:Ti.App.Properties.getString('sm')},
	START_Y   : {id:5, name:'sy', type:'string', value:Ti.App.Properties.getString('sy')},
	START_S   : {id:6, name:'ss', type:'string', value:Ti.App.Properties.getString('ss')},
	END_D     : {id:7, name:'ed', type:'string', value:Ti.App.Properties.getString('ed')},
	END_M     : {id:8, name:'em', type:'string', value:Ti.App.Properties.getString('em')},
	END_Y     : {id:9, name:'ey', type:'string', value:Ti.App.Properties.getString('ey')},
	END_S     : {id:10,name:'es', type:'string', value:Ti.App.Properties.getString('es')}
};
/**
Helper function to set Properties in Titanium to persist between applet instances
@param p 	a PROPERTY as defined above
@param val	a value to assign to the property
*/
function setProperty(p, val) {
	p.value = val;
	if (p.type == 'string') {
		Ti.API.debug('Saving ' + p.value + ' to ' + p.name);
		Titanium.App.Properties.setString(p.name, p.value);
	} else {
		Ti.API.error('Tried to set a ' + p.type + ' property.');
	}
}

//Colors
var NETS_COLOR = {
	BG_GRADIENT_DARK : '#9acab9',
	BG_GRADIENT_LIGHT : '#e5f2ee',
	BUTTON_ACTIVE_GRADIENT_DARK : '#0d6447', //'#f18106',
	BUTTON_ACTIVE_GRADIENT_LIGHT : '#479e81', //'#feac37',
    BUTTON_ACTIVE_FONT : '#fff',
    BUTTON_INACTIVE_GRADIENT_DARK : '#c1c1c1',
    BUTTON_INACTIVE_GRADIENT_LIGHT : '#ececec',
    BUTTON_INACTIVE_FONT : '#000',
	DIALOG_BG_LIGHT : '#fcf7e7',
	DIALOG_BG_DARK : '#fdedb9',
    FONT_DARK : '#000',
    FONT_LIGHT : '#fff',
    FONT_HIGHLIGHTED : '#2e7cb3',
    BANNER : '#479e81',
    TABLE_BG_LIGHT : '#fff',
    TABLE_BG_DARK : '#f7f7f7'
};

//String localization
var STRING = {
	ALL_REPORTS: 'All Reports',
	CUSTOM: 'Custom',
	STARTING: 'Starting',
	ENDING: 'Ending',
	LOADING: 'Loading',
	DASHBOARD: 'Dashboard',
	REPORTS: 'Reports',
    TO: 'to',
    LOGIN_WELCOME: 'Welcome to NETS',
    LOGIN_DESCRIPTION: 'Login with your username and password here',
    ENTER_USERNAME: 'Enter Username',
    ENTER_PASSWORD: 'Enter Password',
    REMEMBER_LOGIN: 'Remember Login',
    LOGIN: 'Login',
    LOGGING_IN: 'Logging In',
    DATE_RANGE: 'Date Range'
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
*/
//Dashboard categories
var DASHBOARD_STATUS = {
	OPEN 					: {id:100, name:'Open', status:'OPEN'},
	SUBMITTED				: {id:101, name:'Submitted', status:'SUBMITTED'},
	DECLINED 				: {id:102, name:'Declined', status:'DECLINED'},
	APPROVING 				: {id:103, name:'Approving', status:'APPROVING'},
	APPROVED 		   		: {id:104, name:'Approved', status:'APPROVED'},	
	REIMBURSEMENT_SENT 	   	: {id:105, name:'Reimbursement Sent', status:'REIMBURSEMENT_SENT'},
	REIMBURSEMENT_RECEIVED 	: {id:106, name:'Reimbursement Received', status:'REIMBURSEMENT_RECEIVED'}
};

/*
The fields in an expense report
*/
var REPORT = {
    NAME            : {id:0, name:'Report Name'},
    LOCATION        : {id:1, name:'Location'},
    PROJECT         : {id:2, name:'Project'},
    APPROVER        : {id:3, name:'Approver'},
    START           : {id:4, name:'Start Date'},
    END             : {id:5, name:'End Date'},
    LAST_ACTIVITY   : {id:6, name:'Last Activity'},
    TOTAL           : {id:7, name:'Total'},    
    MAX             : {id:8, name:''}
};
