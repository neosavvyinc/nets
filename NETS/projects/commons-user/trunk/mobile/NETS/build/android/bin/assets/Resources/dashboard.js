var dashboardData = null;

var dashboard = Titanium.UI.createView({
  top:0,
  width:320,
  height:420,
  opacity:1
});

var greetingLabel = Titanium.UI.createLabel({
  text: 'Welcome',
  textAlign:'Left',
  height:'auto',
  width:'auto',
  color:'#fff',
  top:0,
  left:30
});

dashboard.add(greetingLabel);


var approvingDataLabel = Titanium.UI.createLabel({
  text: '0',
  textAlign:'Left',
  height:'auto',
  width:'auto',
  color:'#fff',
  top:30,
  left:10
});

dashboard.add(approvingDataLabel);

var approvingLabel = Titanium.UI.createLabel({
  text: 'Approving',
  textAlign:'Left',
  height:'auto',
  width:'auto',
  color:'#fff',
  top:30,
  left:50
});

dashboard.add(approvingLabel);


var approvedDataLabel = Titanium.UI.createLabel({
  text: '0',
  textAlign:'Left',
  height:'auto',
  width:'auto',
  color:'#fff',
  top:55,
  left:10
});

dashboard.add(approvedDataLabel);

var approvedLabel = Titanium.UI.createLabel({
  text: 'Approved',
  textAlign:'Left',
  height:'auto',
  width:'auto',
  color:'#fff',
  top:55,
  left:50
});

dashboard.add(approvedLabel);

var declinedDataLabel = Titanium.UI.createLabel({
  text: '0',
  textAlign:'Left',
  height:'auto',
  width:'auto',
  color:'#fff',
  top:80,
  left:10
});

dashboard.add(declinedDataLabel);

var declinedLabel = Titanium.UI.createLabel({
  text: 'Declined',
  textAlign:'Left',
  height:'auto',
  width:'auto',
  color:'#fff',
  top:80,
  left:50
});

dashboard.add(declinedLabel);

var openDataLabel = Titanium.UI.createLabel({
  text: '0',
  textAlign:'Left',
  height:'auto',
  width:'auto',
  color:'#fff',
  top:105,
  left:10
});

dashboard.add(openDataLabel);

var openLabel = Titanium.UI.createLabel({
  text: 'Open',
  textAlign:'Left',
  height:'auto',
  width:'auto',
  color:'#fff',
  top:105,
  left:50
});

dashboard.add(openLabel);


var awaitingDataLabel = Titanium.UI.createLabel({
  text: '0',
  textAlign:'Left',
  height:'auto',
  width:'auto',
  color:'#fff',
  top:130,
  left:10
});

dashboard.add(awaitingDataLabel);

var awaitingLabel = Titanium.UI.createLabel({
  text: 'Awaiting Reconciliation',
  textAlign:'Left',
  height:'auto',
  width:'auto',
  color:'#fff',
  top:130,
  left:50
});

dashboard.add(awaitingLabel);

var reconciledDataLabel = Titanium.UI.createLabel({
  text: '0',
  textAlign:'Left',
  height:'auto',
  width:'auto',
  color:'#fff',
  top:155,
  left:10
});

dashboard.add(reconciledDataLabel);

var reconciledLabel = Titanium.UI.createLabel({
  text: 'Reconciled',
  textAlign:'Left',
  height:'auto',
  width:'auto',
  color:'#fff',
  top:155,
  left:50
});

dashboard.add(reconciledLabel);

var addReceiptButton = Titanium.UI.createButton({
	title:'Add Receipt',
	top:190,
	left:30,
	height:30,
	width:250
});

addReceiptButton.addEventListener("click", function(e) {
	Ti.App.fireEvent("displayCamera");
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

Ti.App.addEventListener("userLoggedIn", function(e) {
	greetingLabel.text = 'Welcome ' + e.securityWrapper.name;
});

