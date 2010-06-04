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
 * child : String of the child source file
 *
 * @param name a String for the name field
 * @param value a String for the value field
 */
function ReportRow(name, value, child) {
    this.row = Ti.UI.createTableViewRow({
        backgroundColor:NETS_COLOR.TABLE_BG_DARK
    });
    this.child = child;
    if (child == null) {
        this.row.hasChild = false;
        this.touchEnabled = false;
    } else {
        this.row.hasChild = true;
        this.touchEnabled = true;
    }
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
var reportId= null;

function report_update(index) {
    var r = statusDashboardData.statusDashboardData[index];
    report.title = r.expenseReportName;

    var data = [];

    var section1 = Ti.UI.createTableViewSection();
    data.push(section1);
    var section2 = Ti.UI.createTableViewSection({headerTitle:' ',headerView:Ti.UI.createView({backgroundColor:'transparent',height:10})});
    data.push(section2);

    var i=0;
    for (i=0; i<REPORT.MAX.id; i++) {
        var rrow;
        switch(i) {
        case REPORT.NAME.id:
            rrow = new ReportRow(REPORT.NAME.name, r.expenseReportName);
            section1.add(rrow.row);
            break;
        case REPORT.LOCATION.id:
            rrow = new ReportRow(REPORT.LOCATION.name, r.expenseReportLocation);
            section1.add(rrow.row);
            break;
        case REPORT.PROJECT.id:
            rrow = new ReportRow(REPORT.PROJECT.name, r.projectName);
            section1.add(rrow.row);
            break;
        case REPORT.APPROVER.id:
            rrow = new ReportRow(REPORT.APPROVER.name, r.projectApprover);
            section1.add(rrow.row);
            break;
        case REPORT.START.id:
            rrow = new ReportRow(REPORT.START.name, r.expenseReportStartDate);
            section1.add(rrow.row);
            break;
        case REPORT.END.id:
            rrow = new ReportRow(REPORT.END.name, r.expenseReportEndDate);
            section1.add(rrow.row);
            break;
        case REPORT.LAST_ACTIVITY.id:
            rrow = new ReportRow(REPORT.LAST_ACTIVITY.name, r.expenseReportLastActivityDate);
            section1.add(rrow.row);
            break;
        case REPORT.TOTAL.id:
            rrow = new ReportRow(REPORT.TOTAL.name, r.expenseReportTotal, 'reportItems.js');
            section2.add(rrow.row);

            if (r.expenseReportId != null) {
                reportId = r.expenseReportId;
            }
            rrow.row.addEventListener('click', function() {
                serviceGetExpenseItemDrilldown(reportId, function(d){Ti.API.info(d);}, function(d){Ti.API.info(d);});
            });
            break;
        default:
            continue;
        }
        reportRows.push(rrow);
    }
    reportTableView.data = data;
}
