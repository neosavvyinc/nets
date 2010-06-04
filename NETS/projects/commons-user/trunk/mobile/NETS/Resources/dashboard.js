/**
@file dashboard.js
Establishes the dashboard view
*/

var dashboardData = null;

var dashboard = Titanium.UI.createView({
    top: 0,
    width: 320,
    height: 420,
    opacity: 1
});



//report banner showing the date range for the reports shown
var dashboardBanner = new DateBanner();
dashboardBanner.update(); //initial update
dashboard.add(dashboardBanner.view);

//set up the dashboard table
var data = [];

var section = Ti.UI.createTableViewSection();
data.push(section);

//Open
var openDataLabel = Titanium.UI.createLabel({
    text: '-',
    height: 'auto',
    width: 'auto',
    color: NETS_COLOR.FONT_DARK,
    left: 10
});
var openLabel = Titanium.UI.createLabel({
    text: DASHBOARD_STATUS.OPEN.name,
    height: 'auto',
    width: 'auto',
    color: NETS_COLOR.FONT_DARK,
    left: 50
});
var openRow = Ti.UI.createTableViewRow({
    hasChild: true,
	backgroundColor:NETS_COLOR.TABLE_BG_DARK,
	dashStatus:DASHBOARD_STATUS.OPEN
});
openRow.add(openDataLabel);
openRow.add(openLabel);

//Submitted
var submittedDataLabel = Titanium.UI.createLabel({
    text: '-',
    height: 'auto',
    width: 'auto',
    color: NETS_COLOR.FONT_DARK,
    left: 10
});
var submittedLabel = Titanium.UI.createLabel({
    text: DASHBOARD_STATUS.SUBMITTED.name,
    height: 'auto',
    width: 'auto',
    color: NETS_COLOR.FONT_DARK,
    left: 50
});
var submittedRow = Ti.UI.createTableViewRow({
    hasChild: true,
	backgroundColor:NETS_COLOR.TABLE_BG_DARK,
	dashStatus:DASHBOARD_STATUS.SUBMITTED
});
submittedRow.add(submittedDataLabel);
submittedRow.add(submittedLabel);

//Declined
var declinedDataLabel = Titanium.UI.createLabel({
    text: '-',
    height: 'auto',
    width: 'auto',
    color: NETS_COLOR.FONT_DARK,
    left: 10
});
var declinedLabel = Titanium.UI.createLabel({
    text: DASHBOARD_STATUS.DECLINED.name,
    height: 'auto',
    width: 'auto',
    color: NETS_COLOR.FONT_DARK,
    left: 50
});
var declinedRow = Ti.UI.createTableViewRow({
    hasChild: true,
	backgroundColor:NETS_COLOR.TABLE_BG_DARK,
	dashStatus:DASHBOARD_STATUS.DECLINED
});
declinedRow.add(declinedDataLabel);
declinedRow.add(declinedLabel);


//Approving
var approvingDataLabel = Titanium.UI.createLabel({
    text: '-',
    height: 'auto',
    width: 'auto',
    color: NETS_COLOR.FONT_DARK,
    left: 10
});
var approvingLabel = Titanium.UI.createLabel({
    text: DASHBOARD_STATUS.APPROVING.name,
    height: 'auto',
    width: 'auto',
    color: NETS_COLOR.FONT_DARK,
    left: 50
});
var approvingRow = Ti.UI.createTableViewRow({
    hasChild: true,
	backgroundColor:NETS_COLOR.TABLE_BG_DARK,
	dashStatus:DASHBOARD_STATUS.APPROVING
});
approvingRow.add(approvingDataLabel);
approvingRow.add(approvingLabel);

//Approved
var approvedDataLabel = Titanium.UI.createLabel({
    text: '-',
    height: 'auto',
    width: 'auto',
    color: NETS_COLOR.FONT_DARK,
    left: 10
});
var approvedLabel = Titanium.UI.createLabel({
    text: DASHBOARD_STATUS.APPROVED.name,
    height: 'auto',
    width: 'auto',
    color: NETS_COLOR.FONT_DARK,
    left: 50
});
var approvedRow = Ti.UI.createTableViewRow({
    hasChild: true,
	backgroundColor:NETS_COLOR.TABLE_BG_DARK,
	dashStatus:DASHBOARD_STATUS.APPROVED
});
approvedRow.add(approvedDataLabel);
approvedRow.add(approvedLabel);

//Reimbursement Sent
var sentDataLabel = Titanium.UI.createLabel({
    text: '-',
    height: 'auto',
    width: 'auto',
    color: NETS_COLOR.FONT_DARK,
    left: 10
});
var sentLabel = Titanium.UI.createLabel({
    text: DASHBOARD_STATUS.REIMBURSEMENT_SENT.name,
    height: 'auto',
    width: 'auto',
    color: NETS_COLOR.FONT_DARK,
    left: 50
});
var sentRow = Ti.UI.createTableViewRow({
    hasChild: true,
	backgroundColor:NETS_COLOR.TABLE_BG_DARK,
	dashStatus:DASHBOARD_STATUS.REIMBURSEMENT_SENT
});
sentRow.add(sentDataLabel);
sentRow.add(sentLabel);

//Reimbursement Received
var receivedDataLabel = Titanium.UI.createLabel({
    text: '-',
    height: 'auto',
    width: 'auto',
    color: NETS_COLOR.FONT_DARK,
    left: 10
});
var receivedLabel = Titanium.UI.createLabel({
    text: DASHBOARD_STATUS.REIMBURSEMENT_RECEIVED.name,
    height: 'auto',
    width: 'auto',
    color: NETS_COLOR.FONT_DARK,
    left: 50
});
var receivedRow = Ti.UI.createTableViewRow({
    hasChild: true,
	backgroundColor:NETS_COLOR.TABLE_BG_DARK,
	dashStatus:DASHBOARD_STATUS.REIMBURSEMENT_RECEIVED
});
receivedRow.add(receivedDataLabel);
receivedRow.add(receivedLabel);

section.add(openRow);
section.add(submittedRow);
section.add(declinedRow);
section.add(approvingRow);
section.add(approvedRow);
section.add(sentRow);
section.add(receivedRow);

var tableView = Ti.UI.createTableView({
    data:data,
	style:Ti.UI.iPhone.TableViewStyle.GROUPED,
	backgroundColor:'transparent',
	top:30
});

/**
The tableView listener expects a row clicked, and that the row has been assigned a dashStatus property so that
we know which row status data to fetch.
*/
tableView.addEventListener('click', function(e) {
    //Titanium.UI.createAlertDialog({title: 'Table View', message:'row ' + row + '\nindex ' + index + '\nsection ' + section + '\nrow data ' + rowdata}).show();
	Ti.API.info(e);
    if (e.row != null && e.row.dashStatus != null && e.row.hasChild == true) {
        // example event data expected:
        //detail = 0;
        //index = 1;
        //row = [object TiUITableViewRow];
        //rowData = [object TiUITableViewRow];
        //searchMode = 0;
        //section = [object TiUITableViewSection];
        //source = [object TiUILabel]; <-- this could be a Label or Row or somthing else, depending on where the user touched.
        //type = click;
        Ti.App.fireEvent(evtLoadStatusDashboard, {dstat:e.row.dashStatus});
    } else {
        Ti.API.debug('dashboard tableView not interested');
    }
});

dashboard.add(tableView);

//ADD
var addReceiptButton = Titanium.UI.createButton({
    title: 'Add Receipt',
    top: dashboard.height * 0.9,
    //left: 30,
    height: 30,
    width: 250,
	backgroundImage:'assets/images/orange_button_unsel.png',
    backgroundSelectedImage:'assets/images/orange_button_sel.png',
    backgroundDisabledImage:'assets/images/orange_button_unsel.png',
    who: 'addReceiptButton'
});

addReceiptButton.addEventListener('click', function(e) {
    if (e.source.who != null &&  e.source.who == 'addReceiptButton') {
        Ti.App.fireEvent(evtDisplayCamera);
    }
});

dashboard.add(addReceiptButton);

/**
@param data object "{\"numberApprovedExpenses\":\"0\",\"numberApprovingExpenses\":\"0\",\"numberDeclinedExpenses\":\"0\",\"numberOpenExpenses\":\"0\",\"numberReimbursedmentReceivedExpenses\":\"0\",\"numberReimbursmentSentExpenses\":\"0\",\"numberSubmittedExpenses\":\"0\"}"
*/
function updateDashboard(data) {
    dashboardData = data;

    if (dashboardData.numberOpenExpenses > 0) {
	    openDataLabel.text = dashboardData.numberOpenExpenses;
        openRow.hasChild = true;
    } else {
        openDataLabel.text = 0;
        openRow.hasChild = false;
    }

    if (dashboardData.numberSubmittedExpenses > 0) {
        submittedDataLabel.text = dashboardData.numberSubmittedExpenses;
        submittedRow.hasChild = true;
    } else {
        submittedDataLabel.text = 0;
        submittedRow.hasChild = false;
    }

    if (dashboardData.numberDeclinedExpenses > 0) {
        declinedDataLabel.text = dashboardData.numberDeclinedExpenses;
        declinedRow.hasChild = true;
    } else {
        declinedDataLabel.text = 0;
        declinedRow.hasChild = false;
    }

	if (dashboardData.numberApprovingExpenses > 0) {
        approvingDataLabel.text = dashboardData.numberApprovingExpenses;
        approvingRow.hasChild = true;
    } else {
        approvingDataLabel.text = 0;
        approvingRow.hasChild = false;
    }

    if (dashboardData.numberApprovedExpenses > 0) {
        approvedDataLabel.text = dashboardData.numberApprovedExpenses;
        approvedRow.hasChild = true;
    } else {
        approvedDataLabel.text = 0;
        approvedRow.hasChild = false;
    }

    if (dashboardData.numberReimbursmentSentExpenses > 0) {
        sentDataLabel.text = dashboardData.numberReimbursmentSentExpenses;
        sentRow.hasChild = true;
    } else {
        sentDataLabel.text = 0;
        sentRow.hasChild = false;
    }

    if (dashboardData.numberReimbursedmentReceivedExpenses > 0) {
        receivedDataLabel.text = dashboardData.numberReimbursedmentReceivedExpenses;
        receivedRow.hasChild = true;
    } else {
        receivedDataLabel.text = 0;
        receivedRow.hasChild = false;
    }
}


Ti.App.addEventListener(evtUserLoggedIn, function(e) {
    //greetingLabel.text = 'Welcome ' + e.securityWrapper.name;
});

