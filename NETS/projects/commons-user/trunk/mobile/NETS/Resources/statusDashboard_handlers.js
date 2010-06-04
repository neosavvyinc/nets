function displayStatusDashboardLoadError() {
	var a = Titanium.UI.createAlertDialog({ 
		title:'Oops!',
		message:"We weren't able to load your dashboard data at this time.  Please try again later."
	});
	
	a.show();    
}
function onStatusDashboardLoadFailure(e) {
	Ti.API.info('onStatusDashboardLoadFailure');
	Ti.API.info('HTTP ERROR:' + e.error);
	Ti.API.info('HTTP status:' + httpClient.status);
	Ti.API.info('HTTP responseText:' + httpClient.responseText);
	Ti.API.info('HTTP connected:' + httpClient.connected);
	
	Ti.App.fireEvent(evtHideActivityIndicator);
	displayStatusDashboardLoadError();
}

function onStatusDashboardLoadComplete(data) {
	Ti.API.debug('onStatusDashboardLoadComplete data:' + data);
	
	Ti.App.fireEvent(evtHideActivityIndicator);
	  
	if (data == null) {
		displayStatusDashboardLoadError();
		return;
	}

	updateStatusDashboard(data);
	Ti.App.fireEvent(evtSwitchToScreen, {screen:SCREEN.STATUS_DASHBOARD}); //switchToScreen(SCREEN.STATUS_DASHBOARD);
}

/**
expects the following properties on the event e:
    dstat - a DASHBOARD_STATUS property (see constants.js)
 */
function loadStatusDashboardData(e) {
	Ti.API.info('loadStatusDashboardData: ' + e.dstat.name + ' ' + e.dstat.status);
	
	setupStatusDashboard(e.dstat);
	Ti.App.fireEvent(evtDisplayActivityIndicator, {message:STRING.LOADING + ' ' + e.dstat.name + ' ' + STRING.REPORTS + '...'});
	serviceGetStatusDashboard(e.dstat.status, onStatusDashboardLoadComplete, onStatusDashboardLoadFailure);	
}

Ti.App.addEventListener(evtLoadStatusDashboard, loadStatusDashboardData);
Ti.App.addEventListener(evtUpdateDateRange, function() {
    statusDashboardBanner.update();
});
