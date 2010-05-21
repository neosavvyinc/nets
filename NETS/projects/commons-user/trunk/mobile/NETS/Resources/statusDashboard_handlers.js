function loadStatusDashboardData(e) {
	Ti.API.info('loadStatusDashboardData: ' + e.dstat.name + ' ' + e.dstat.status);
	
	//Ti.App.fireEvent(evtDisplayActivityIndicator, {message: 'Loading data...'});
	//serviceGetDashboardData(onDashboardLoadComplete, onDashboardLoadFailure);	
	setupStatusDashboard(e.dstat);
	switchToScreen(SCREEN.STATUS_DASHBOARD);
}

Ti.App.addEventListener(evtLoadStatusDashboard, loadStatusDashboardData);
