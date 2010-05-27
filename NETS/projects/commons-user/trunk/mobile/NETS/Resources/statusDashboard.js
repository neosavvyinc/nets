/**
@file statusDashboard.js
Establishes the status dashboard view. This is the screen that shows the reports for a selected dashboard category.
*/

var statusDashboardData = null;
var statusTableData = [];
var statusDashboardRows = [];

var statusDashboard = Titanium.UI.createView({
    top: 0,
    width: 320,
    height: 420,
    opacity: 1
});

/**
 * properties:
 * row : Ti.UI.TableViewRow
 * label : Ti.UI.Label
 * index : Number
 *
 * @param index a Number that is an index into the statusDashboardData global
 */
function StatusDashboardRow(index) {
    var report = statusDashboardData.statusDashboardData[index];

    this.index = index;
	this.row = Ti.UI.createTableViewRow({
        backgroundColor:NETS_COLOR.TABLE_BG_DARK,
        hasChild:true
    });
    this.label = Ti.UI.createLabel({
        text:report.expenseReportName,
        textAlign:'center',
        color:NETS_COLOR.FONT_DARK,
        highlightedColor:NETS_COLOR.FONT_DARK
    });

    this.row.add(this.label);
}


//report date range info
var statusDashboardBanner = new DateBanner();
statusDashboardBanner.update(); //initial update
statusDashboard.add(statusDashboardBanner.view);

var statusTableView = Ti.UI.createTableView({
	data:statusTableData,
	style:Ti.UI.iPhone.TableViewStyle.GROUPED,
	backgroundColor:'transparent',
	top:statusDashboardBanner.view.height + 5
});
// create table view event listener
statusTableView.addEventListener('click', function(e) {
    // event data
    var index = e.index;
    var section = e.section;
    var row = e.row;
    var rowdata = e.rowData;
    //Titanium.UI.createAlertDialog({title: 'Table View', message:'row ' + row + '\nindex ' + index + '\nsection ' + section + '\nrow data ' + rowdata}).show();

    //open report
    report_update(e.index);
    Ti.App.fireEvent(evtSwitchToScreen, {screen:SCREEN.REPORT});
});

statusDashboard.add(statusTableView);

/**
@param dstat one of the DASHBOARD_STATUS objs
*/
function setupStatusDashboard(dstat) {
	Ti.API.info('setupStatusDashboard: ' + dstat.name + ' ' + dstat.status);
	
	statusDashboard.title = dstat.name;
	
	switch(dstat.id) {
	case DASHBOARD_STATUS.OPEN.id:
		break;
	case DASHBOARD_STATUS.SUBMITTED.id:
		break;
	case DASHBOARD_STATUS.DECLINED.id:
		break;
	case DASHBOARD_STATUS.APPROVING.id:
		break;
	case DASHBOARD_STATUS.APPROVED.id:
		break;
	case DASHBOARD_STATUS.REIMBURSEMENT_SENT.id:
		break;
	case DASHBOARD_STATUS.REIMBURSEMENT_RECEIVED.id:
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
	if (data==null) {
		Ti.API.error('updateStatusDashboard data is busted: data' + data);
	} else {
		Ti.API.debug('updateStatusDashboard');
	}
	
	statusDashboardData = data;
	
	if(data.statusDashboardData.length > 0) {
		var tabledata = [];
        var reportx = 0;
		for (reportx in data.statusDashboardData) {
			Ti.API.info('expenseReportName:' + data.statusDashboardData[reportx].expenseReportName);
			Ti.API.info('expenseReportLocation:' + data.statusDashboardData[reportx].expenseReportLocation);
			Ti.API.info('expenseReportTotal:' + data.statusDashboardData[reportx].expenseReportTotal);
			Ti.API.info('projectName:' + data.statusDashboardData[reportx].projectName);
			Ti.API.info('projectApprover:' + data.statusDashboardData[reportx].projectApprover);
			Ti.API.info('expenseReportStartDate:' + data.statusDashboardData[reportx].expenseReportStartDate);
			Ti.API.info('expenseReportEndDate:' + data.statusDashboardData[reportx].expenseReportEndDate);
			Ti.API.info('expenseReportLastActivityDate:' + data.statusDashboardData[reportx].expenseReportLastActivityDate);
			Ti.API.info('---');

            var sdr = new StatusDashboardRow(reportx);
            statusDashboardRows.push(sdr);
            tabledata.push(sdr.row);
		}
        //@todo cleanup old table data here?
        statusTableView.data = tabledata;
	} else {
        Ti.API.error('no status data');
	}
}