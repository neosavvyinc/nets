/**
@file statusDashboard.js
Establishes the status dashboard view. This is the screen that shows the reports for a selected dashboard category.
*/

var statusDashboardData = null;
var statusTableData = [];

var statusDashboard = Titanium.UI.createView({
    top: 0,
    width: 320,
    height: 420,
    opacity: 1
});

var statusTableView = Ti.UI.createTableView({
	data:statusTableData,
	style:Ti.UI.iPhone.TableViewStyle.GROUPED,
	backgroundColor:'transparent',
	top:20
});

statusDashboard.add(statusTableView);

/**
@param dstat one of the DASHBOARD_STATUS objs
*/
function setupStatusDashboard(dstat) {
	Ti.API.info('setupStatusDashboard: ' + dstat.name + ' ' + dstat.status);
	
	statusDashboard.title = dstat.name;
	
	switch(dstat) {
	case DASHBOARD_STATUS.OPEN:
		break;
	case DASHBOARD_STATUS.SUBMITTED:
		break;
	case DASHBOARD_STATUS.DECLINED:
		break;
	case DASHBOARD_STATUS.APPROVING:
		break;
	case DASHBOARD_STATUS.APPROVED:
		break;
	case DASHBOARD_STATUS.REIMBURSEMENT_SENT:
		break;
	case DASHBOARD_STATUS.REIMBURSEMENT_RECEIVED:
		break;
	default:
	}
}

/**
@param data is an and array of  report objects that look like:
private String expenseReportName;
private String expenseReportLocation;
private Double expenseReportTotal;
private String projectName;
private String projectApprover;
private Date expenseReportStartDate;
private Date expenseReportEndDate;
private Date expenseReportLastActivityDate;
*/
function updateStatusDashboard(data) {
	if (data==null || data.length()==0) {
		Ti.API.error('updateStatusDashboard data is busted: data' + data);
	}
	
	statusDashboardData = data;
	
	var report = null;
	for (report in statusDashboardData) {
		Ti.API.info('---');
		Ti.API.info('expenseReportName:' + report.expenseReportName);
		Ti.API.info('expenseReportLocation:' + report.expenseReportLocation);
		Ti.API.info('expenseReportTotal:' + report.expenseReportTotal);
		Ti.API.info('projectName:' + report.projectName);
		Ti.API.info('projectApprover:' + report.projectApprover);
		Ti.API.info('expenseReportStartDate:' + report.expenseReportStartDate);
		Ti.API.info('expenseReportEndDate:' + report.expenseReportEndDate);
		Ti.API.info('expenseReportLastActivityDate:' + report.expenseReportLastActivityDate);
		Ti.API.info('---');
	}
}