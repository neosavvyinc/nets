function expenseItemDrilldownError() {
	var a = Titanium.UI.createAlertDialog({
		title:'Oops!',
		message:"We weren't able to load your reports breakdown at this time.  Please try again later."
	});

	a.show();
}
function onExpenseItemDrilldownFailure(e) {
	Ti.API.info('onExpenseItemDrilldownFailure');
	Ti.API.info('HTTP ERROR:' + e.error);
	Ti.API.info('HTTP status:' + httpClient.status);
	Ti.API.info('HTTP responseText:' + httpClient.responseText);
	Ti.API.info('HTTP connected:' + httpClient.connected);

	Ti.App.fireEvent(evtHideActivityIndicator);
	expenseItemDrilldownError();
}

function onExpenseItemDrilldownComplete(data) {
	Ti.API.debug('onExpenseItemDrilldownComplete data:' + data);

	Ti.App.fireEvent(evtHideActivityIndicator);

	if (data == null) {
		expenseItemDrilldownError();
		return;
	}

	reportDrilldown_update(data);
	Ti.App.fireEvent(evtSwitchToScreen, {screen:SCREEN.REPORT_DRILLDOWN});
}

/**
expects the following properties on the event e:
    id - an expense report id
 */
function loadExpenseItemDrilldown(e) {
	Ti.API.info('loadExpenseItemDrilldown: ' + e.id);

	//setupStatusDashboard(e.dstat);
	Ti.App.fireEvent(evtDisplayActivityIndicator, {message:STRING.LOADING + ' ' + STRING.REPORT_BREAKDOWN + '...'});
    serviceGetExpenseItemDrilldown(e.id, onExpenseItemDrilldownComplete, onExpenseItemDrilldownFailure);
}

Ti.App.addEventListener(evtLoadExpenseItemDrilldown, loadExpenseItemDrilldown);
