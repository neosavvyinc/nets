/**
 * @file reportDrilldown.js
 */

var reportDrilldown = Titanium.UI.createView({
    top: 0,
    width: 320,
    height: 420,
    opacity: 1,
    title: ''
});

var reportDrilldownTableView = Ti.UI.createTableView({
	backgroundColor:'transparent'
});

reportDrilldown.add(reportDrilldownTableView);

/**
 * properties:
 */
function ReportDrilldownSection() {

}

var reportDrilldownData;

/**
 * @param data server expenseItemDrilldown response
 * Single Response="{\"expenseItem\":{\"amount\":\"23.00\",\"expenseDate\":\"2010-06-01T00:00:00-04:00\",\"id\":\"5\"}}"
 */
function reportDrilldown_update(data) {
    reportDrilldownData = null;

    if (data==null || data.expenseItem==null) {
		Ti.API.error('reportDrilldown_update data is busted: data' + data);
        return;
	}

    Ti.API.debug('reportDrilldown_update');

    var tabledata = [];
    //setup the global statusDashboardData, if we only have a single element, we construct an array of len 1
    if (!(data.expenseItem instanceof Array)) { //(data.expenseItem.length == null || data.expenseItem.length == 0) {
        // construct an array
        reportDrilldownData = { expenseItem : [data.expenseItem] };
    } else {
        reportDrilldownData = data;
    }
    Ti.API.info(reportDrilldownData);

    Ti.API.debug('drilldown len:'+reportDrilldownData.expenseItem.length);
    if (reportDrilldownData.expenseItem.length > 0) {
        var item = 0;
        for (item in reportDrilldownData.expenseItem) {
            Ti.API.info('amount:' + reportDrilldownData.expenseItem[item].amount);
            Ti.API.info('expenseDate:' + reportDrilldownData.expenseItem[item].expenseDate);
            Ti.API.info('id:' + reportDrilldownData.expenseItem[item].id);
            Ti.API.info('---');

            tabledata[item] = Ti.UI.createTableViewSection( {headerTitle:'Item '+ reportDrilldownData.expenseItem[item].id} );
            var row = new ReportRow('Date', reportDrilldownData.expenseItem[item].expenseDate, null);
            tabledata[item].add(row.row);
            row = new ReportRow('Amount', reportDrilldownData.expenseItem[item].amount, null);
            tabledata[item].add(row.row);

            //sdr = new StatusDashboardRow(reportx);
            //statusDashboardRows.push(sdr);
            //tabledata.push(sdr.row);
        }
        reportDrilldownTableView.data = tabledata;
    } else {
        Ti.API.error('no expense data');
    }
}