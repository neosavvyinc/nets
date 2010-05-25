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
var dashboardRange = new DateBanner();
dashboardRange.update(); //initial update
dashboard.add(dashboardRange.view);

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

// create table view event listener
tableView.addEventListener('click', function(e) {
    // event data
    var index = e.index;
    var section = e.section;
    var row = e.row;
    var rowdata = e.rowData;
    //Titanium.UI.createAlertDialog({title: 'Table View', message:'row ' + row + '\nindex ' + index + '\nsection ' + section + '\nrow data ' + rowdata}).show();
	Ti.App.fireEvent(evtLoadStatusDashboard, {dstat:row.dashStatus});
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
    backgroundDisabledImage:'assets/images/orange_button_unsel.png'
});

addReceiptButton.addEventListener('click',
function(e) {
    Ti.App.fireEvent(evtDisplayCamera);
});

dashboard.add(addReceiptButton);

/**
@param data object "{\"numberApprovedExpenses\":\"0\",\"numberApprovingExpenses\":\"0\",\"numberDeclinedExpenses\":\"0\",\"numberOpenExpenses\":\"0\",\"numberReimbursedmentReceivedExpenses\":\"0\",\"numberReimbursmentSentExpenses\":\"0\",\"numberSubmittedExpenses\":\"0\"}"
*/
function updateDashboard(data) {
    dashboardData = data;

	openDataLabel.text = dashboardData.numberOpenExpenses;
	submittedDataLabel.text = dashboardData.numberSubmittedExpenses;
	declinedDataLabel.text = dashboardData.numberDeclinedExpenses;
	approvingDataLabel.text = dashboardData.numberApprovingExpenses;
    approvedDataLabel.text = dashboardData.numberApprovedExpenses;
    sentDataLabel.text = dashboardData.numberReimbursmentSentExpenses;
    receivedDataLabel.text = dashboardData.numberReimbursedmentReceivedExpenses;
}


Ti.App.addEventListener(evtUserLoggedIn, function(e) {
    //greetingLabel.text = 'Welcome ' + e.securityWrapper.name;
});

