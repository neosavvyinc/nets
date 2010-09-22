/**
NeoSavvy Expense Tracker
@file app.js

 This is the file where it all starts...
*/

// this sets the background color of the master UIView (when there are no windows/tab groups on it)
Titanium.UI.setBackgroundColor('#000');

var httpClient = Titanium.Network.createHTTPClient();
var securityWrapper = null;

var theImage = null;
var theThumbnail = null;

//Includes
Titanium.include('events.js'); //include this one first. all the user-events (should) live in here
Titanium.include('constants.js'); //and this one second. important global app mojo in here
Titanium.include('service.js'); //some views depend on services, so include it before we build views
//building blocks
Titanium.include('dateBanner.js');
//views
Titanium.include('dateRange.js');
Titanium.include('progress.js');
Titanium.include('dashboard.js');
Titanium.include('login.js');
Titanium.include('confirm_receipt_upload.js');
Titanium.include('statusDashboard.js');
Titanium.include('report.js');
Titanium.include('reportDrilldown.js');
Titanium.include('reportDrillDownReceipt.js');
Titanium.include('reportDrillDownReceiptMetadata.js');
//handlers
Titanium.include('result.js');
Titanium.include('login_handlers.js');
Titanium.include('dashboard_handlers.js');
Titanium.include('statusDashboard_handlers.js');
Titanium.include('report_handlers.js');

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
    case WINDOW.REPORT.id:
        break;
    case WINDOW.REPORT_DRILLDOWN.id:
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
function NETSCreateWindow(type, title, url) {
    Ti.API.info('NETSCreateWindow ' + type.name + ' ' + title + ' ' + url);

	//@todo validate type?
	if (title == null) {
		title = '';
	}

    var win = Titanium.UI.createWindow({
        //url:url,
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
	
	switch(v.id) {
	case SCREEN.LOGIN.id:
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
	case SCREEN.TABGROUP.id:
		Ti.API.debug('opening the tab group');
		tabGroup.open({
			transition:Titanium.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT
		});
		break;
	case SCREEN.CONFIRM_RECEIPT_UPLOAD.id:
		viewContainer.animate({view:confirmReceiptUpload,transition:Ti.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT});
		confirmReceiptUpload.visible = true;
		break;
	case SCREEN.STATUS_DASHBOARD.id:
		var statusWin = NETSCreateWindow(WINDOW.STATUSDASH, statusDashboard.title);
		statusWin.add(statusDashboard);
		//tabGroup.activeTab.open(statusWin,{animated:true});
		dashboardTab.open(statusWin,{animated:true});
		break;
	case SCREEN.DATE_RANGE.id:
        dateRangeScreen = new DateRangeScreen();
        dateRangeScreen.init();
		//tabGroup.activeTab.open(dateWin,{animated:true}); //apparently android doesn't do well with this
		dashboardTab.open(dateRangeScreen.win,{animated:true});
		break;
    case SCREEN.REPORT.id:
        var reportWin = NETSCreateWindow(WINDOW.REPORT, report.title);
        reportWin.add(report);
        dashboardTab.open(reportWin,{animated:true});
        break;
    case SCREEN.REPORT_DRILLDOWN.id:
        var reportDrilldownWin = NETSCreateWindow(WINDOW.REPORT_DRILLDOWN, reportDrilldown.title);
        reportDrilldownWin.add(reportDrilldown);
        dashboardTab.open(reportDrilldownWin,{animated:true});
        break;
    case SCREEN.RECEIPT_CAPTURE.id:
        var receiptCaptureWin = NETSCreateWindow(WINDOW.RECEIPT_CAPTURE, receiptDrillDown.title);
        receiptCaptureWin.add(receiptDrillDown);
        dashboardTab.open(receiptCaptureWin,{animated:true});
        break;
    case SCREEN.RECEIPT_DRILLDOWN_META.id:
        var receiptMetaDataWin = NETSCreateWindow(WINDOW.RECEIPT_METADATA, reportDrillReceiptMetadata.title);
        receiptMetaDataWin.add(reportDrillReceiptMetadata);
        dashboardTab.open(receiptMetaDataWin,{animated:true});
        break;
	default:
		Ti.API.error('switchToScreen error: invalid view arg');
	}
};
Titanium.App.addEventListener(evtSwitchToScreen, function(e) {
	switchToScreen(e.screen);
});

//start out by showing the login screen
switchToScreen(SCREEN.LOGIN);


if (!Titanium.Network.online) {
 	var a = Titanium.UI.createAlertDialog({ 
    	title:'Network Connection Required',
    	message: 'NETS requires an internet connection .  Check your network connection and try again.'
  	});
	a.show();
}


/* just keeping this here b/c I copy/paste it now and again for quick debugging -csr
try{
} catch(e) { Titanium.UI.createAlertDialog({title:'FAIL',message:e}).show(); }
*/