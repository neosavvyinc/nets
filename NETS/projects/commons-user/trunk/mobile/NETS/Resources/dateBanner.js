/**
 * DateBanner constructor , this object has the properties
 *	view : Ti.UI.View
 *	icon : Ti.UI.Button
 *	label : Ti.UI.Label
 */
function DateBanner() {
	this.view = Ti.UI.createView({
		top:0,
		height:35,
		backgroundColor:NETS_COLOR.BUTTON_GRADIENT_LIGHT
	});
	this.label = Ti.UI.createLabel({
		text:STRING.ALL_REPORTS,
		textAlign:'center',
		color:NETS_COLOR.DARK_GRAY,
		highlightedColor:NETS_COLOR.DARK_GRAY
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
    this.view.addEventListener('click', function(e) {
        Ti.App.fireEvent(evtSwitchToScreen, {screen:SCREEN.DATE_RANGE});
    });
}

DateBanner.prototype.update = function() {
	if (PROPERTY.DATERANGE.value == null || PROPERTY.DATERANGE.value == 0) {
		this.label.text = STRING.ALL_REPORTS;
	} else {
		this.label.text = PROPERTY.START_S.value + ' to ' + PROPERTY.END_S.value;
	}
};