/**
@file dateRange.js

dateRange screen
*/
var dateRangeScreen = null;


//instead of tabbed bar, try using two labels
var colorSelected = NETS_COLOR.BUTTON_ACTIVE_GRADIENT_LIGHT;
var colorUnselected = NETS_COLOR.BUTTON_INACTIVE_GRADIENT_LIGHT;
//gradients don't work with android :(
var gradientSelected = {
	type:'linear',
	colors:[NETS_COLOR.BUTTON_ACTIVE_GRADIENT_LIGHT, NETS_COLOR.BUTTON_ACTIVE_GRADIENT_DARK],
	startPoint:{x:0,y:0},
	endPoint:{x:0,y:30}
};
var gradientUnselected = {
	type:'linear',
	colors:[NETS_COLOR.BUTTON_INACTIVE_GRADIENT_LIGHT, NETS_COLOR.BUTTON_INACTIVE_GRADIENT_DARK],
	startPoint:{x:0,y:0},
	endPoint:{x:0,y:30}
};

function saveStartDateProperties(startDate) {
	setProperty(PROPERTY.START_D, startDate.getDate());
	setProperty(PROPERTY.START_M, startDate.getMonth());
	setProperty(PROPERTY.START_Y, startDate.getFullYear());
	setProperty(PROPERTY.START_S, startDate.toLocaleDateString()); //toDateString()
}
function saveEndDateProperties(endDate) {
	setProperty(PROPERTY.END_D, endDate.getDate());
	setProperty(PROPERTY.END_M, endDate.getMonth());
	setProperty(PROPERTY.END_Y, endDate.getFullYear());
	setProperty(PROPERTY.END_S, endDate.toLocaleDateString()); //toDateString()
}
var startDate = new Date();
var endDate = new Date();
//sanity check to make sure we have these properties set to something, if any are null, we'll just set the current date since
//the date was just instantiated above
if (PROPERTY.START_D.value==null || PROPERTY.START_D.value < 1 || PROPERTY.START_D.value > 31 ||
	PROPERTY.START_M.value==null || PROPERTY.START_M.value < 0 || PROPERTY.START_M.value > 11 ||
	PROPERTY.START_Y.value==null || PROPERTY.START_Y.value < 0 || PROPERTY.START_Y.value > 9999 ||
	PROPERTY.START_S.value==null) {
	saveStartDateProperties(startDate);
} else {
	startDate.setDate(PROPERTY.START_D.value);
	startDate.setMonth(PROPERTY.START_M.value);
	startDate.setFullYear(PROPERTY.START_Y.value);
}
if (PROPERTY.END_D.value==null || PROPERTY.END_D.value < 1 || PROPERTY.END_D.value > 31 ||
	PROPERTY.END_M.value==null || PROPERTY.END_M.value < 0 || PROPERTY.END_M.value > 11 ||
	PROPERTY.END_Y.value==null || PROPERTY.END_Y.value < 0 || PROPERTY.END_Y.value > 9999 ||
	PROPERTY.END_S.value==null) {
	saveEndDateProperties(endDate);
} else {
	endDate.setDate(PROPERTY.END_D.value);
	endDate.setMonth(PROPERTY.END_M.value);
	endDate.setFullYear(PROPERTY.END_Y.value);
}

/**
 * Row Constructor
 * DateRangeRow properties:
 * row : Ti.UI.TableViewRow
 * nameLabel : Ti.UI.Label
 * dateLabel : Ti.UI.Label
 *
 * @param name a String telling you what the date is for
 * @param date a String for the date
 */
function DateRangeRow(name, date) {
    this.nameLabel = Ti.UI.createLabel({
        text: name,
        font:{fontSize:15, fontWeight:'bold'},
        color:NETS_COLOR.BUTTON_ACTIVE_FONT,
        highlightedColor:NETS_COLOR.BUTTON_ACTIVE_FONT,
        width:'auto',
        left:5
    });
    this.dateLabel = Ti.UI.createLabel({
        text:date,
        font:{fontSize:15, fontWeight:'normal'},
        color:NETS_COLOR.BUTTON_ACTIVE_FONT,
        highlightedColor:NETS_COLOR.BUTTON_ACTIVE_FONT,
        width:'auto',
        right:5
    });
    this.row = Ti.UI.createTableViewRow({
        backgroundColor:colorSelected
    });
    this.row.add(this.nameLabel);
    this.row.add(this.dateLabel);
}
/**
 * active()
 * Sets the DateRangeRow to active colors
 */
DateRangeRow.prototype.active = function() {
    this.nameLabel.color = NETS_COLOR.BUTTON_ACTIVE_FONT;
    this.nameLabel.highlightedColor = NETS_COLOR.BUTTON_ACTIVE_FONT;
    this.dateLabel.color = NETS_COLOR.BUTTON_ACTIVE_FONT;
    this.dateLabel.highlightedColor = NETS_COLOR.BUTTON_ACTIVE_FONT;
    this.row.backgroundColor = colorSelected;
};
/**
 * inactive()
 * Sets the DateRangeRow to inactive colors
 */
DateRangeRow.prototype.inactive = function() {
    this.nameLabel.color = NETS_COLOR.BUTTON_INACTIVE_FONT;
    this.nameLabel.highlightedColor = NETS_COLOR.BUTTON_INACTIVE_FONT;
    this.dateLabel.color = NETS_COLOR.BUTTON_INACTIVE_FONT;
    this.dateLabel.highlightedColor = NETS_COLOR.BUTTON_INACTIVE_FONT;
    this.row.backgroundColor = colorUnselected;
};

/**
 * constructor
 * this object has the properties
 * win : Titanium.UI.Window
 * view : Titanium.UI.View
 * subView : Titanium.UI.View
 * allLabel : Titanium.UI.Label
 * customLabel : Titanium.UI.Label
 * startRow : DateRangeRow
 * endRow : DateRangeRow
 * rowData : [] of Ti.UI.TableViewRow
 * table : Ti.UI.Table
 * activeRow : Number
 * minDate : Date
 * maxDate : Date
 *
 * iPhone Only
 * datePicker : Ti.UI.Picker
 */
function DateRangeScreen() {
    this.win = NETSCreateWindow(WINDOW.DATERANGE, STRING.DATE_RANGE);
    this.view = Titanium.UI.createView({
        top: 0,
        opacity: 1,
        title: STRING.DATE_RANGE
    });
    this.subView = Titanium.UI.createView({top:35,height:375});

    this.allLabel = Ti.UI.createLabel({
        text:STRING.ALL_REPORTS,
        font:{fontSize:15, fontWeight:'bold'},
        textAlign:'center',
        color:NETS_COLOR.BUTTON_ACTIVE_FONT,
        highlightedColor:NETS_COLOR.BUTTON_ACTIVE_FONT,
        top:5,
        width:155,
        height:30,
        left:5,
        borderRadius:0,
        borderWidth:1,
        borderColor:NETS_COLOR.BUTTON_INACTIVE_GRADIENT_DARK,
        backgroundColor:colorSelected,
        backgroundGradient:gradientSelected,
        index:0
    });
    this.customLabel = Ti.UI.createLabel({
        text:STRING.CUSTOM,
        font:{fontSize:15, fontWeight:'bold'},
        textAlign:'center',
        color:NETS_COLOR.BUTTON_INACTIVE_FONT,
        highlightedColor:NETS_COLOR.BUTTON_INACTIVE_FONT,
        top:5,
        width:155,
        height:30,
        right:5,
        borderRadius:0,
        borderWidth:1,
        borderColor:NETS_COLOR.BUTTON_INACTIVE_GRADIENT_DARK,
        backgroundColor:colorUnselected,
        backgroundGradient:gradientUnselected,
        index:1
    });

    this.startRow = new DateRangeRow(STRING.STARTING + ':', PROPERTY.START_S.value);
    this.startRow.active();
    this.endRow = new DateRangeRow(STRING.ENDING + ':', PROPERTY.END_S.value);
    this.endRow.inactive();
    this.activeRow = 0;

    this.rowData = [];
    this.rowData.push(this.startRow.row);
    this.rowData.push(this.endRow.row);

    this.table = Ti.UI.createTableView({
        data:this.rowData,
        style:Ti.UI.iPhone.TableViewStyle.GROUPED,
        backgroundColor:'transparent'
    });

    this.win.add(this.view);
    this.view.add(this.allLabel);
    this.view.add(this.customLabel);
    this.view.add(this.subView);
    this.subView.add(this.table);

    this.minDate = new Date();
    this.minDate.setFullYear(2010);
    this.minDate.setMonth(0);
    this.minDate.setDate(1);
    this.maxDate = new Date(); //maximum is right now

    if (Ti.Platform.name == 'iPhone OS') {

        this.datePicker = Ti.UI.createPicker({
            bottom:0,
            type:Ti.UI.PICKER_TYPE_DATE,
            minDate:this.minDate,
            maxDate:this.maxDate,
            value:startDate
        });
        this.datePicker.selectionIndicator = true;

        this.subView.add(this.datePicker);

        this.datePicker.addEventListener('change', function(e) {
            Ti.API.debug('date now ' + e.source.value.toDateString() + ' row:' + dateRangeScreen.activeRow);

            if (dateRangeScreen.activeRow == 0) {
                startDate = e.source.value;
                saveStartDateProperties(startDate);
                dateRangeScreen.startRow.dateLabel.text = PROPERTY.START_S.value;
            } else {
                endDate = e.source.value;
                saveEndDateProperties(endDate);
                dateRangeScreen.endRow.dateLabel.text = PROPERTY.END_S.value;
            }

            Ti.App.fireEvent(evtUpdateDateRange);
        });

        this.table.addEventListener('click', function(e) {
            Ti.API.debug('selected row ' + e.index);
            dateRangeScreen.activeRow = e.index;
            if (e.index == 0) {
                dateRangeScreen.startRow.active();
                dateRangeScreen.endRow.inactive();
                dateRangeScreen.datePicker.value = startDate;
            } else {
                dateRangeScreen.startRow.inactive();
                dateRangeScreen.endRow.active();
                dateRangeScreen.datePicker.value = endDate;
            }
        });

    }//iPhone OS
    else
    {

        this.table.addEventListener('click', function(e) {
            dateRangeScreen.activeRow = e.index;
            if (e.index == 0) {
                dateRangeScreen.startRow.active();
                dateRangeScreen.endRow.inactive();
            } else {
                dateRangeScreen.startRow.inactive();
                dateRangeScreen.endRow.active();
            }
        });
    }
}
/**
 * init()
 */
DateRangeScreen.prototype.init = function() {
    this.table.setData(this.rowData); //@todo this is a workaround for iphone b/c when a window is closed it seems that any tables in that window lose their data.
							 //      so we count on whoever's stuffing the dateRange view into a window to call this init to get things set up properly
	if (PROPERTY.DATERANGE.value == null || PROPERTY.DATERANGE.value == 0) {
		this.subView.opacity = 0;
		this.subView.visible = false;

        this.customLabel.backgroundColor = colorUnselected;
		this.customLabel.backgroundGradient = gradientUnselected;
		this.customLabel.text = '';
		this.customLabel.text = STRING.CUSTOM;
        this.customLabel.color = NETS_COLOR.BUTTON_INACTIVE_FONT;
	    this.customLabel.highlightedColor = NETS_COLOR.BUTTON_INACTIVE_FONT;
		this.allLabel.backgroundColor = colorSelected;
		this.allLabel.backgroundGradient = gradientSelected;
		this.allLabel.text = '';
		this.allLabel.text = STRING.ALL_REPORTS;
        this.allLabel.color = NETS_COLOR.BUTTON_ACTIVE_FONT;
	    this.allLabel.highlightedColor = NETS_COLOR.BUTTON_ACTIVE_FONT;
	} else {
		this.subView.opacity = 1;
		this.subView.visible = true;

		this.allLabel.backgroundColor = colorUnselected;
		this.allLabel.backgroundGradient = gradientUnselected;
		this.allLabel.text = '';
		this.allLabel.text = STRING.ALL_REPORTS;
        this.allLabel.color = NETS_COLOR.BUTTON_INACTIVE_FONT;
	    this.allLabel.highlightedColor = NETS_COLOR.BUTTON_INACTIVE_FONT;
		this.customLabel.backgroundColor = colorSelected;
		this.customLabel.backgroundGradient = gradientSelected;
		this.customLabel.text = '';
		this.customLabel.text = STRING.CUSTOM;
        this.customLabel.color = NETS_COLOR.BUTTON_ACTIVE_FONT;
	    this.customLabel.highlightedColor = NETS_COLOR.BUTTON_ACTIVE_FONT;
	}

    this.allLabel.addEventListener('click', function(e) {
	    if (e.source.index == 0 && e.source.backgroundColor == colorUnselected) {
		    dateRangeScreen.setActive(e.source.index);
	    }
    });
    this.customLabel.addEventListener('click', function(e) {
	    if (e.source.index == 1 && e.source.backgroundColor == colorUnselected) {
		    dateRangeScreen.setActive(e.source.index);
	    }
    });
};

var isDrViewAnimating = false;
var anim = Ti.UI.createAnimation(); //for fading our drView in/out
anim.duration = 400;
anim.status = 'inactive';  //defined by us, can be 'inactive', 'hiding', or 'showing'
anim.addEventListener('start', function(e) {
	isDrViewAnimating = true;
});
anim.addEventListener('complete', function(e) {
	isDrViewAnimating = false;
	if (e.source.status == 'hiding') {
		Ti.API.debug('hide complete');
		dateRangeScreen.subView.visible = false;
	} else if (e.source.status == 'showing') {
		Ti.API.debug('show complete');
	}
});
//@todo there's a problem on android mobilesdk 1.3.0 current where setting the backgroundcolor doesn't cause an invalidate
//      the workaround right now is to tickle the text to get the label to redraw. remove that nonsense when appcelerator fixes it
DateRangeScreen.prototype.setActive = function(index) {
	if (isDrViewAnimating==true) {
		return;
	}

	if (index==null) {
		index = 0;
	}

	if (index == 0) {
		//all
		Ti.API.debug('Activating All Reports');
		this.customLabel.backgroundColor = colorUnselected;
		this.customLabel.backgroundGradient = gradientUnselected;
		this.customLabel.text = '';
		this.customLabel.text = STRING.CUSTOM;
        this.customLabel.color = NETS_COLOR.BUTTON_INACTIVE_FONT;
	    this.customLabel.highlightedColor = NETS_COLOR.BUTTON_INACTIVE_FONT;
		this.allLabel.backgroundColor = colorSelected;
		this.allLabel.backgroundGradient = gradientSelected;
		this.allLabel.text = '';
		this.allLabel.text = STRING.ALL_REPORTS;
        this.allLabel.color = NETS_COLOR.BUTTON_ACTIVE_FONT;
	    this.allLabel.highlightedColor = NETS_COLOR.BUTTON_ACTIVE_FONT;

		anim.opacity = 0;
		anim.status = 'hiding';
		this.subView.animate(anim);
	} else {
		//custom
		Ti.API.debug('Activating Custom');
		this.allLabel.backgroundColor = colorUnselected;
		this.allLabel.backgroundGradient = gradientUnselected;
		this.allLabel.text = '';
		this.allLabel.text = STRING.ALL_REPORTS;
        this.allLabel.color = NETS_COLOR.BUTTON_INACTIVE_FONT;
	    this.allLabel.highlightedColor = NETS_COLOR.BUTTON_INACTIVE_FONT;
		this.customLabel.backgroundColor = colorSelected;
		this.customLabel.backgroundGradient = gradientSelected;
		this.customLabel.text = '';
		this.customLabel.text = STRING.CUSTOM;
        this.customLabel.color = NETS_COLOR.BUTTON_ACTIVE_FONT;
	    this.customLabel.highlightedColor = NETS_COLOR.BUTTON_ACTIVE_FONT;

		anim.opacity = 1;
		anim.status = 'showing';
		this.subView.visible = true;
		this.subView.opacity = 0;
		this.subView.animate(anim);
	}

	setProperty(PROPERTY.DATERANGE, index);
	Ti.API.debug('date range index now ' + PROPERTY.DATERANGE.value);

	Ti.App.fireEvent(evtUpdateDateRange);
};






