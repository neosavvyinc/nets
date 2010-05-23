/**
@file dateRange.js
view for the date range picker
*/

var dateRange = Titanium.UI.createView({
    top: 0,
    opacity: 1,
	title: 'Date Range'
});

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

/** hmm, tabbed bar only exists for iPhone
var dateRangeBar = Titanium.UI.createTabbedBar({
	labels:['STRING.ALL_REPORTS', STRING.CUSTOM],
	top:0,
	style:Titanium.UI.iPhone.SystemButtonStyle.BAR,
	height:30,
	width:'93%',
	index:0
});
dateRange.add(dateRangeBar);
*/

//instead of tabbed bar, try using two labels
var colorSelected = NETS_COLOR.BUTTON_GRADIENT_LIGHT;
var colorUnselected = NETS_COLOR.DIALOG_BG_GRADIENT_DARK;
//gradients don't work with android :(
var gradientSelected = {
	type:'linear',
	colors:[NETS_COLOR.DIALOG_BG_GRADIENT_DARK,NETS_COLOR.BUTTON_GRADIENT_DARK],
	startPoint:{x:0,y:0},
	endPoint:{x:0,y:30}
};
var gradientUnselected = {
	type:'linear',
	colors:[NETS_COLOR.DIALOG_BG,NETS_COLOR.DIALOG_BG_GRADIENT_DARK],
	startPoint:{x:0,y:0},
	endPoint:{x:0,y:30}
};
var label1Text = STRING.ALL_REPORTS;
var label2Text = STRING.CUSTOM;

var dateLabel1 = Ti.UI.createLabel({
	text:label1Text,
	font:{fontSize:15, fontWeight:'bold'},
	textAlign:'center',
	color:NETS_COLOR.DARK_GRAY,
	highlightedColor:NETS_COLOR.DARK_GRAY,
	top:5,
	width:155,
	height:30,
	left:5,
	borderRadius:0,
	borderWidth:1,
	borderColor:NETS_COLOR.BUTTON_GRADIENT_DARK,
	backgroundColor:colorSelected,
	backgroundGradient:gradientSelected,
	index:0
});
var dateLabel2 = Ti.UI.createLabel({
	text:label2Text,
	font:{fontSize:15, fontWeight:'bold'},
	textAlign:'center',
	color:NETS_COLOR.DARK_GRAY,
	highlightedColor:NETS_COLOR.DARK_GRAY,
	top:5,
	width:155,
	height:30,
	right:5,
	borderRadius:0,
	borderWidth:1,
	borderColor:NETS_COLOR.BUTTON_GRADIENT_DARK,
	backgroundColor:colorUnselected,
	backgroundGradient:gradientUnselected,
	index:1
});

dateRange.add(dateLabel1);
dateRange.add(dateLabel2);

var drView = Titanium.UI.createView({top:35,height:375});
dateRange.add(drView);

drData = [];
var startingLabel = Ti.UI.createLabel({
	text:'Starting:',
	font:{fontSize:15, fontWeight:'bold'},
	color:NETS_COLOR.DARK_GRAY,
	highlightedColor:NETS_COLOR.DARK_GRAY,
	width:'auto',
	left:5
});
var startDateLabel = Ti.UI.createLabel({
	text:PROPERTY.START_S.value,
	font:{fontSize:15, fontWeight:'normal'},
	color:NETS_COLOR.BG_GRADIENT_DARK,
	highlightedColor:NETS_COLOR.BG_GRADIENT_DARK,
	width:'auto',
	right:5
});
var startRow = Ti.UI.createTableViewRow({
	backgroundColor:colorSelected
});
startRow.add(startingLabel);
startRow.add(startDateLabel);
drData.push(startRow);

var endingLabel = Ti.UI.createLabel({
	text:'Ending:',
	font:{fontSize:15, fontWeight:'bold'},
	color:NETS_COLOR.DARK_GRAY,
	highlightedColor:NETS_COLOR.DARK_GRAY,
	width:'auto',
	left:5
});
var endDateLabel = Ti.UI.createLabel({
	text:PROPERTY.END_S.value,
	font:{fontSize:15, fontWeight:'normal'},
	color:NETS_COLOR.BG_GRADIENT_DARK,
	highlightedColor:NETS_COLOR.BG_GRADIENT_DARK,
	width:'auto',
	right:5
});
var endRow = Ti.UI.createTableViewRow({
	backgroundColor:colorUnselected
});
endRow.add(endingLabel);
endRow.add(endDateLabel);
drData.push(endRow);

var drTable = Ti.UI.createTableView({
	data:drData,
	style:Ti.UI.iPhone.TableViewStyle.GROUPED,
	backgroundColor:'transparent',
	top:35
});

drView.add(drTable);

var drRowSelected = 0;

/* just for test purposes, just trying to see what, if anything, instantiates on android. nothing does
Ti.API.info(Ti.UI.createPicker({type:Ti.UI.PICKER_TYPE_PLAIN}));
Ti.API.info(Ti.UI.createPicker({type:Ti.UI.PICKER_TYPE_DATE_AND_TIME}));
Ti.API.info(Ti.UI.createPicker({type:Ti.UI.PICKER_TYPE_DATE}));
Ti.API.info(Ti.UI.createPicker({type:Ti.UI.PICKER_TYPE_TIME}));
Ti.API.info(Ti.UI.createPicker({type:Ti.UI.PICKER_TYPE_COUNT_DOWN_TIMER}));
*/

if (Ti.Platform.name == 'iPhone OS') {

var minDate = new Date();
minDate.setFullYear(2010);
minDate.setMonth(0);
minDate.setDate(1);

var maxDate = new Date(); //maximum is right now

var datePicker = Ti.UI.createPicker({
	bottom:0,
	type:Ti.UI.PICKER_TYPE_DATE,
	minDate:minDate,
	maxDate:maxDate,
	value:startDate
});
datePicker.selectionIndicator = true;

drView.add(datePicker);

datePicker.addEventListener('change', function(e) {
	if (drRowSelected == 0) {
		startDate = e.value;
		saveStartDateProperties(startDate);
		startDateLabel.text = PROPERTY.START_S.value;
	} else {
		endDate = e.value;
		saveEndDateProperties(endDate);
		endDateLabel.text = PROPERTY.END_S.value;
	}
	Ti.App.fireEvent(evtUpdateDateRange);
});

drTable.addEventListener('click', function(e) {
	drRowSelected = e.index;
	if (drRowSelected == 0) {
		startRow.backgroundColor = colorSelected;
		endRow.backgroundColor = colorUnselected;
		datePicker.value = startDate;
	} else {
		startRow.backgroundColor = colorUnselected;
		endRow.backgroundColor = colorSelected;
		datePicker.value = endDate;
	}
});

}//iPhone OS
else
{
	
drTable.addEventListener('click', function(e) {
	drRowSelected = e.index;
	if (drRowSelected == 0) {
		startRow.backgroundColor = colorSelected;
		endRow.backgroundColor = colorUnselected;
		//datePicker.value = startDate;
	} else {
		startRow.backgroundColor = colorUnselected;
		endRow.backgroundColor = colorSelected;
		//datePicker.value = endDate;
	}
});
}

function dateRange_init() {
	drTable.setData(drData); //@todo this is a workaround for iphone b/c when a window is closed it seems that any tables in that window lose their data.
							 //      so we count on whoever's stuffing the dateRange view into a window to call this init to get things set up properly
	if (PROPERTY.DATERANGE.value == null || PROPERTY.DATERANGE.value == 0) {
		drView.opacity = 0;
		drView.visible = false;
		
		dateLabel2.backgroundColor = colorUnselected;
		dateLabel2.backgroundGradient = gradientUnselected;
		dateLabel2.text = '';
		dateLabel2.text = label2Text;
		dateLabel1.backgroundColor = colorSelected;
		dateLabel1.backgroundGradient = gradientSelected;
		dateLabel1.text = '';
		dateLabel1.text = label1Text;
	} else {
		drView.opacity = 1;
		drView.visible = true;
		
		dateLabel1.backgroundColor = colorUnselected;
		dateLabel1.backgroundGradient = gradientUnselected;
		dateLabel1.text = '';
		dateLabel1.text = label1Text;
		dateLabel2.backgroundColor = colorSelected;
		dateLabel2.backgroundGradient = gradientSelected;
		dateLabel2.text = '';
		dateLabel2.text = label2Text;
	}
}

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
		drView.visible = false;
	} else if (e.source.status == 'showing') {
		Ti.API.debug('show complete');
	}
});


//@todo there's a problem on android mobilesdk 1.3.0 current where setting the backgroundcolor doesn't cause an invalidate
//      the workaround right now is to tickle the text to get the label to redraw. remove that nonsense when appcelerator fixes it
function dateRange_setActive(index) {
	if (isDrViewAnimating==true) {
		return;
	}
	
	if (index==null) {
		index = 0;
	}
	
	if (index == 0) {
		//all
		Ti.API.debug('Activating All Reports');
		dateLabel2.backgroundColor = colorUnselected;
		dateLabel2.backgroundGradient = gradientUnselected;
		dateLabel2.text = '';
		dateLabel2.text = label2Text;
		dateLabel1.backgroundColor = colorSelected;
		dateLabel1.backgroundGradient = gradientSelected;
		dateLabel1.text = '';
		dateLabel1.text = label1Text;
		
		anim.opacity = 0;
		anim.status = 'hiding';
		drView.animate(anim);
	} else {
		//custom
		Ti.API.debug('Activating Custom');
		dateLabel1.backgroundColor = colorUnselected;
		dateLabel1.backgroundGradient = gradientUnselected;
		dateLabel1.text = '';
		dateLabel1.text = label1Text;
		dateLabel2.backgroundColor = colorSelected;
		dateLabel2.backgroundGradient = gradientSelected;
		dateLabel2.text = '';
		dateLabel2.text = label2Text;
		
		anim.opacity = 1;
		anim.status = 'showing';
		drView.visible = true;
		drView.opacity = 0;
		drView.animate(anim);
	}
	
	setProperty(PROPERTY.DATERANGE, index);
	Ti.API.debug('date range index now ' + PROPERTY.DATERANGE.value);
	
	Ti.App.fireEvent(evtUpdateDateRange);
}

dateLabel1.addEventListener('click', function(e) {
	if (e.source.index == 0 && dateLabel1.backgroundColor == colorUnselected) {
		dateRange_setActive(e.source.index);
	}
});
dateLabel2.addEventListener('click', function(e) {
	if (e.source.index == 1 && dateLabel2.backgroundColor == colorUnselected) {
		dateRange_setActive(e.source.index);
	}
});
