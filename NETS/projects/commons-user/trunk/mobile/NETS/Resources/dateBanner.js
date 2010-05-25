/**
 * @file dateBanner
 * This is the implementation of the DateBanner class
 * This is a banner that sits at the top of the dashboard and statusDashboard views and
 * allows access, when touched, to the dateRange selector screen.
 */

/**
 * DateBanner constructor
 * this object has the properties
 *	view : Ti.UI.View
 *	icon : Ti.UI.Button
 *	label : Ti.UI.Label
 */
function DateBanner() {
	this.view = Ti.UI.createView({
		top:0,
		height:35,
		backgroundColor:NETS_COLOR.BANNER
	});
	this.label = Ti.UI.createLabel({
		text:STRING.ALL_REPORTS,
        font:{fontSize:15, fontWeight:'bold'},
		textAlign:'center',
		color:NETS_COLOR.FONT_LIGHT,
		highlightedColor:NETS_COLOR.FONT_LIGHT
	});
    this.icon = Ti.UI.createButton({
		image:'assets/images/Icon_calendar.png',
		right:5
	});

	this.view.add(this.label);
	this.view.add(this.icon);

    /*
    this.icon.addEventListener('click', function(e) {
		Ti.App.fireEvent(evtSwitchToScreen, {screen:SCREEN.DATE_RANGE});
	});
	*/
    //touch the banner anywhere, we transition to the date range selector screen
    this.view.addEventListener('click', function(e) {
        Ti.App.fireEvent(evtSwitchToScreen, {screen:SCREEN.DATE_RANGE});
    });
}

/**
 * update()
 * updates the DateBanner
 */
DateBanner.prototype.update = function() {
	if (PROPERTY.DATERANGE.value == null || PROPERTY.DATERANGE.value == 0) {
		this.label.text = STRING.ALL_REPORTS;
	} else {
		this.label.text = PROPERTY.START_S.value + ' ' + STRING.TO + ' ' + PROPERTY.END_S.value;
	}
};