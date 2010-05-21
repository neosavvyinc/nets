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
Titanium.include('progress.js');
Titanium.include('statusDashboard.js');
Titanium.include('dashboard.js');
Titanium.include('login.js');
Titanium.include('confirm_receipt_upload.js');
Titanium.include('dateRange.js');
//handlers
Titanium.include('login_handlers.js');
Titanium.include('dashboard_handlers.js');
Titanium.include('statusDashboard_handlers.js');


//Tab Group
//Windows in the tab group
var dashboardWindow = Ti.UI.createWindow({
	//url:'dashboard.js',
	title:'Summary',
	backgroundImage:'assets/images/NETS_bg.png'
});
var dashboardScrollView = Titanium.UI.createScrollView({
	contentWidth:'auto',
	contentHeight:'auto',
	top:0,
	showVerticalScrollIndicator:true,
	showHorizontalScrollIndicator:true
});
dashboardScrollView.add(dashboard);
dashboardWindow.add(dashboardScrollView);

var helpWindow = Ti.UI.createWindow({
	title:'Help',
	backgroundImage:'assets/images/NETS_bg.png'
});

var tabGroup = Titanium.UI.createTabGroup();

var dashboardTab = Ti.UI.createTab({
	icon:'',
	title:'Dashboard',
	window:dashboardWindow
});
var helpTab = Ti.UI.createTab({
	icon:'',
	title:'Help',
	window:helpWindow
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
		var loginWin = Titanium.UI.createWindow({  
		    title:'NETS',
		    backgroundImage:'assets/images/NETS_bg.png'
		});
		var viewContainer = Titanium.UI.createView({
		  width:320,
		  height:420
		});
		viewContainer.add(login);
		//viewContainer.animate({view:login,transition:Ti.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT});
		loginWin.add(viewContainer);
		loginWin.open({
			transition:Titanium.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT
		});
		break;
	case SCREEN.DASHBOARD:
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
		var statusWin = Titanium.UI.createWindow({
			title:statusDashboard.title,
			backgroundImage:'assets/images/NETS_bg.png'
		});
		statusWin.add(statusDashboard);
		//tabGroup.activeTab.open(statusWin,{animated:true});
		dashboardTab.open(statusWin,{animated:true});
		break;
	case SCREEN.DATE_RANGE:
		var dateWin = Titanium.UI.createWindow( {
			title:dateRange.title,
			backgroundImage:'assets/images/NETS_bg.png'
		});
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


