/**
NeoSavvy Expense Tracker
@file app.js
*/

// this sets the background color of the master UIView (when there are no windows/tab groups on it)
Titanium.UI.setBackgroundColor('#000');

var httpClient = Titanium.Network.createHTTPClient();
var securityWrapper = null;


//Includes
Titanium.include('events.js'); //include this one first. all the uesr-events (should) live in here
Titanium.include('constants.js'); //and this one second. important global app mojo in here
Titanium.include('service.js'); //some views depend on services, so include it before we build views
//views
// 
Titanium.include('dateRange.js');
Titanium.include('progress.js');
Titanium.include('statusDashboard.js');
Titanium.include('dashboard.js');
Titanium.include('login.js');
Titanium.include('confirm_receipt_upload.js');
//handlers
Titanium.include('login_handlers.js');
Titanium.include('dashboard_handlers.js');
Titanium.include('statusDashboard_handlers.js');

/**
Handler for our window events
*/
function NETSEventHandler(e) {
	Ti.API.debug('<<NETSEventHandler>> evt:' + e.type + ' name:' + e.source.type.name);
	Ti.API.debug(e.source.type);
	switch(e.source.type.id) {
	case WINDOW.ROOT.id:
		break;
	case WINDOW.DASHBOARD.id:
		break;
	case WINDOW.STATUSDASH.id:
		break;
	case WINDOW.DATERANGE.id:
		break;
	case TABGROUP.ROOT.id:
		break;
	default:
		Ti.API.debug('handle invalid window type');
	}
}

/**
A utility for creating windows
@type   use a WINDOW member from constants.js (not a Titanium property)
@title  Option. Window title.
@return a Titanium.UI.Window object
*/
function NETSCreateWindow(type, title) {
	//@todo validate type?
	if (title==null) {
		title = '';
	}
	var win = Titanium.UI.createWindow({  
	    title:title,
	    backgroundImage:'assets/images/NETS_bg.png',
		type:type
	});
	win.addEventListener('blur', NETSEventHandler);
	win.addEventListener('close', NETSEventHandler);
	win.addEventListener('focus', NETSEventHandler);
	win.addEventListener('open', NETSEventHandler);
	return win;
}

//Tab Group
//Windows in the tab group
var dashboardWin = NETSCreateWindow(WINDOW.DASHBOARD, 'Summary');
var dashboardScrollView = Titanium.UI.createScrollView({
	contentWidth:'auto',
	contentHeight:'auto',
	top:0,
	showVerticalScrollIndicator:true,
	showHorizontalScrollIndicator:true
});
dashboardScrollView.add(dashboard);
dashboardWin.add(dashboardScrollView);

var helpWin = NETSCreateWindow(WINDOW.HELP, 'Help');

var tabGroup = Titanium.UI.createTabGroup({type:TABGROUP.ROOT});
tabGroup.addEventListener('blur', NETSEventHandler);
tabGroup.addEventListener('close', NETSEventHandler);
tabGroup.addEventListener('focus', NETSEventHandler);
tabGroup.addEventListener('open', NETSEventHandler);

var dashboardTab = Ti.UI.createTab({
	icon:'',
	title:'Dashboard',
	window:dashboardWin
});
var helpTab = Ti.UI.createTab({
	icon:'',
	title:'Help',
	window:helpWin
});
tabGroup.addTab(dashboardTab);
tabGroup.addTab(helpTab);

/**
@param v enumerator for the view to switch to. see SCREEN in constants.js
*/
function switchToScreen(v) {
	Ti.API.debug('switchToScreen id:' + v.id + ' name:' + v.name);
	
	switch(v) {
	case SCREEN.LOGIN:
		//Root Window & View
		var loginWin = NETSCreateWindow(WINDOW.ROOT, 'NETS');
		var viewContainer = Titanium.UI.createView({
		  width:320,
		  height:420
		});
		viewContainer.add(login);
		loginWin.add(viewContainer);
		loginWin.open({
			transition:Titanium.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT
		});
		break;
	case SCREEN.TABGROUP:
		Ti.API.debug('opening the tab group');
		tabGroup.open({
			transition:Titanium.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT
		});
		break;
	case SCREEN.CONFIRM_RECEIPT_UPLOAD:
		viewContainer.animate({view:confirmReceiptUpload,transition:Ti.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT});
		confirmReceiptUpload.visible = true;
		break;
	case SCREEN.STATUS_DASHBOARD:
		var statusWin = NETSCreateWindow(WINDOW.STATUSDASH, statusDashboard.title);
		statusWin.add(statusDashboard);
		//tabGroup.activeTab.open(statusWin,{animated:true});
		dashboardTab.open(statusWin,{animated:true});
		break;
	case SCREEN.DATE_RANGE:
		var dateWin = NETSCreateWindow(WINDOW.DATERANGE, dateRange.title);
		dateWin.add(dateRange);
		//tabGroup.activeTab.open(dateWin,{animated:true}); //apparently android doesn't do well with this
		dashboardTab.open(dateWin,{animated:true});
		break;
	default:
		Ti.API.error('switchToScreen error: invalid view arg');
	}
};


//start out by showing the login screen
switchToScreen(SCREEN.LOGIN);


if (!Titanium.Network.online) {
 	var a = Titanium.UI.createAlertDialog({ 
    	title:'Network Connection Required',
    	message: 'NETS requires an internet connection .  Check your network connection and try again.'
  	});
	a.show();
}


