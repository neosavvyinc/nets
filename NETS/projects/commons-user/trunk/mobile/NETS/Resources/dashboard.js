var dashboardData = null;

var dashboard = Titanium.UI.createView({
    top: 0,
    width: 320,
    height: 420,
    opacity: 1
});

var greetingLabel = Titanium.UI.createLabel({
    text: 'Welcome',
    textAlign: 'Left',
    height: 'auto',
    width: 'auto',
    color: '#fff',
    top: 0,
    left: 30
});

dashboard.add(greetingLabel);

//set up the dashboard table
var tblBgClr = '#fcf7e8';
var tblTxtClr = '#222';
var data = [];
var section = Ti.UI.createTableViewSection();
data.push(section);

//approving
var approvingDataLabel = Titanium.UI.createLabel({
    text: '-',
    textAlign: 'Left',
    height: 'auto',
    width: 'auto',
    color: tblTxtClr,
    left: 10
});
var approvingLabel = Titanium.UI.createLabel({
    text: 'Approving',
    textAlign: 'Left',
    height: 'auto',
    width: 'auto',
    color: tblTxtClr,
    left: 50
});
var approvingRow = Ti.UI.createTableViewRow({
    hasChild: true,
	backgroundColor:tblBgClr
});
approvingRow.add(approvingDataLabel);
approvingRow.add(approvingLabel);

//approved
var approvedDataLabel = Titanium.UI.createLabel({
    text: '-',
    textAlign: 'Left',
    height: 'auto',
    width: 'auto',
    color: tblTxtClr,
    left: 10
});
var approvedLabel = Titanium.UI.createLabel({
    text: 'Approved',
    textAlign: 'Left',
    height: 'auto',
    width: 'auto',
    color: tblTxtClr,
    left: 50
});
var approvedRow = Ti.UI.createTableViewRow({
    hasChild: true,
	backgroundColor:tblBgClr
});
approvedRow.add(approvedDataLabel);
approvedRow.add(approvedLabel);

//declined
var declinedDataLabel = Titanium.UI.createLabel({
    text: '-',
    textAlign: 'Left',
    height: 'auto',
    width: 'auto',
    color: tblTxtClr,
    left: 10
});
var declinedLabel = Titanium.UI.createLabel({
    text: 'Declined',
    textAlign: 'Left',
    height: 'auto',
    width: 'auto',
    color: tblTxtClr,
    left: 50
});
var declinedRow = Ti.UI.createTableViewRow({
    hasChild: true,
	backgroundColor:tblBgClr
});
declinedRow.add(declinedDataLabel);
declinedRow.add(declinedLabel);

//open
var openDataLabel = Titanium.UI.createLabel({
    text: '-',
    textAlign: 'Left',
    height: 'auto',
    width: 'auto',
    color: tblTxtClr,
    left: 10
});
var openLabel = Titanium.UI.createLabel({
    text: 'Open',
    textAlign: 'Left',
    height: 'auto',
    width: 'auto',
    color: tblTxtClr,
    left: 50
});
var openRow = Ti.UI.createTableViewRow({
    hasChild: true,
	backgroundColor:tblBgClr
});
openRow.add(openDataLabel);
openRow.add(openLabel);

//awaiting
var awaitingDataLabel = Titanium.UI.createLabel({
    text: '-',
    textAlign: 'Left',
    height: 'auto',
    width: 'auto',
    color: tblTxtClr,
    left: 10
});
var awaitingLabel = Titanium.UI.createLabel({
    text: 'Awaiting Reconciliation',
    textAlign: 'Left',
    height: 'auto',
    width: 'auto',
    color: tblTxtClr,
    left: 50
});
var awaitingRow = Ti.UI.createTableViewRow({
    hasChild: true,
	backgroundColor:tblBgClr
});
awaitingRow.add(awaitingDataLabel);
awaitingRow.add(awaitingLabel);

//reconciled
var reconciledDataLabel = Titanium.UI.createLabel({
    text: '-',
    textAlign: 'Left',
    height: 'auto',
    width: 'auto',
    color: tblTxtClr,
    left: 10
});
var reconciledLabel = Titanium.UI.createLabel({
    text: 'Reconciled',
    textAlign: 'Left',
    height: 'auto',
    width: 'auto',
    color: tblTxtClr,
    left: 50
});
var reconciledRow = Ti.UI.createTableViewRow({
    hasChild: true,
	backgroundColor:tblBgClr
});
reconciledRow.add(reconciledDataLabel);
reconciledRow.add(reconciledLabel);

section.add(approvingRow);
section.add(approvedRow);
section.add(declinedRow);
section.add(openRow);
section.add(awaitingRow);
section.add(reconciledRow);

var tableView = Ti.UI.createTableView({
	data:data,
	style:Ti.UI.iPhone.TableViewStyle.GROUPED,
	backgroundColor:'transparent',
	top:30
});

dashboard.add(tableView);

//ADD
var addReceiptButton = Titanium.UI.createButton({
    title: 'Add Receipt',
    top: '80%',
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

function updateDashboard(data) {
    dashboardData = data;
    approvingDataLabel.text = dashboardData.numberExpenseReportsAwaitingApproval;
    approvedDataLabel.text = dashboardData.numberExpenseReportsApproved;
    declinedDataLabel.text = dashboardData.numberExpenseReportsDeclined;
    openDataLabel.text = dashboardData.numberExpenseReportsOpened;
    awaitingDataLabel.text = dashboardData.numberExpenseReportsAwaitingReconciliation;
    reconciledDataLabel.text = dashboardData.numberExpenseReportsReconciled;
}

Ti.App.addEventListener(evtUserLoggedIn,
function(e) {
    greetingLabel.text = 'Welcome ' + e.securityWrapper.name;
});

