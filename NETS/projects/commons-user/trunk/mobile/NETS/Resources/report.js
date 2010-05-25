/**
@file report.js
*/

/*
all these live in statusDashboard.js:
statusDashboardData
statusTableData
statusDashboardRows
*/

var report = Titanium.UI.createView({
    top: 0,
    width: 320,
    height: 420,
    opacity: 1,
    title: ''
});

var reportTableView = Ti.UI.createTableView({
	backgroundColor:'transparent'
});

report.add(reportTableView);

/**
 * properties:
 * row : Ti.UI.TableViewRow
 * nameLabel : Ti.UI.Label
 * valueLabel : Ti.UI.Label
 *
 * @param name a String for the name field
 * @param value a String for the value field
 */
function ReportRow(name, value) {
    this.row = Ti.UI.createTableViewRow({
        backgroundColor:NETS_COLOR.TABLE_BG_DARK,
        hasChild:false
    });
    this.nameLabel = Ti.UI.createLabel({
        text:name,
        font:{fontSize:15, fontWeight:'bold'},
        textAlign:'left',
        color:NETS_COLOR.FONT_DARK,
        highlightedColor:NETS_COLOR.FONT_DARK,
        left:5
    });
    this.valueLabel = Ti.UI.createLabel({
        text:value,
        font:{fontSize:15, fontWeight:'normal'},
        textAlign:'right',
        color:NETS_COLOR.FONT_DARK,
        highlightedColor:NETS_COLOR.FONT_DARK,
        right:5
    });

    this.row.add(this.nameLabel);
    this.row.add(this.valueLabel);
}

var reportRows = [];

function report_update(index) {
    var r = statusDashboardData.statusDashboardData[index];
    report.title = r.expenseReportName;

    var data = [];

    var i=0;
    for (i=0; i<REPORT.MAX.id; i++) {
        var rrow;
        switch(i) {
        case REPORT.NAME.id:
            rrow = new ReportRow(REPORT.NAME.name, r.expenseReportName);
            break;
        case REPORT.LOCATION.id:
            rrow = new ReportRow(REPORT.LOCATION.name, r.expenseReportLocation);
            break;
        case REPORT.TOTAL.id:
            rrow = new ReportRow(REPORT.TOTAL.name, r.expenseReportTotal);
            break;
        case REPORT.PROJECT.id:
            rrow = new ReportRow(REPORT.PROJECT.name, r.projectName);
            break;
        case REPORT.APPROVER.id:
            rrow = new ReportRow(REPORT.APPROVER.name, r.projectApprover);
            break;
        case REPORT.START.id:
            rrow = new ReportRow(REPORT.START.name, r.expenseReportStartDate);
            break;
        case REPORT.END.id:
            rrow = new ReportRow(REPORT.END.name, r.expenseReportEndDate);
            break;
        case REPORT.LAST_ACTIVITY.id:
            rrow = new ReportRow(REPORT.LAST_ACTIVITY.name, r.expenseReportLastActivityDate);
            break;
        default:
            continue;
        }
        reportRows.push(rrow);
        data.push(rrow.row);
    }
    reportTableView.data = data;
}
