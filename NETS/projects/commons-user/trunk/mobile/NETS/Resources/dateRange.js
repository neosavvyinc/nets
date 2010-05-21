/**
@file dateRange.js
view for the date range picker
*/

var dateRange = Titanium.UI.createView({
    top: 0,
    opacity: 1,
	title: 'Date Range'
});

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

/*
var datePickerImageView = Ti.UI.createImageView({
	url:'assets/images/camera.png',
	left:10,
	width:'auto',
	height:'auto'
});
*/

var startingLabel = Ti.UI.createLabel({
	text:'Starting:',
	font:{fontSize:15, fontWeight:'bold'},
	color:NETS_COLOR.DARK_GRAY,
	highlightedColor:NETS_COLOR.DARK_GRAY,
	top:35,
	height:30,
	left:5
});
dateRange.add(startingLabel);
var endingLabel = Ti.UI.createLabel({
	text:'Ending:',
	font:{fontSize:15, fontWeight:'bold'},
	color:NETS_COLOR.DARK_GRAY,
	highlightedColor:NETS_COLOR.DARK_GRAY,
	top:65,
	height:30,
	left:5
});
dateRange.add(endingLabel);

//@todo there's a problem on android mobilesdk 1.3.0 current where setting the backgroundcolor doesn't cause an invalidate
//      the workaround right now is to tickle the text to get the label to redraw. remove that nonsense when appcelerator fixes it
function setActive(index) {
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
		startingLabel.visible = false;
		endingLabel.visible = false;
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
		startingLabel.visible = true;
		endingLabel.visible = true;	
	}
	
	setProperty(PROPERTY.DATERANGE, index);
	Ti.API.debug('date range index now ' + PROPERTY.DATERANGE.value);
	
	Ti.App.fireEvent(evtUpdateDateRange);
}
setActive(PROPERTY.DATERANGE.value); //so we set it up the first time.

dateLabel1.addEventListener('click', function(e) {
	if (e.source.index == 0 && dateLabel1.backgroundColor == colorUnselected) {
		setActive(e.source.index);
	}
});
dateLabel2.addEventListener('click', function(e) {
	if (e.source.index == 1 && dateLabel2.backgroundColor == colorUnselected) {
		setActive(e.source.index);
	}
});

/* just for test purposes, just trying to see what, if anything, instantiates on android. nothing does
Ti.API.info(Ti.UI.createPicker({type:Ti.UI.PICKER_TYPE_PLAIN}));
Ti.API.info(Ti.UI.createPicker({type:Ti.UI.PICKER_TYPE_DATE_AND_TIME}));
Ti.API.info(Ti.UI.createPicker({type:Ti.UI.PICKER_TYPE_DATE}));
Ti.API.info(Ti.UI.createPicker({type:Ti.UI.PICKER_TYPE_TIME}));
Ti.API.info(Ti.UI.createPicker({type:Ti.UI.PICKER_TYPE_COUNT_DOWN_TIMER}));
*/
	
function saveStartDate(startDate) {
	setProperty(PROPERTY.START_D, startDate.getDate());
	setProperty(PROPERTY.START_M, startDate.getMonth());
	setProperty(PROPERTY.START_Y, startDate.getFullYear());
	setProperty(PROPERTY.START_S, startDate.toLocaleDateString()); //toDateString()
}
function saveEndDate(endDate) {
	setProperty(PROPERTY.END_D, endDate.getDate());
	setProperty(PROPERTY.END_M, endDate.getMonth());
	setProperty(PROPERTY.END_Y, endDate.getFullYear());
	setProperty(PROPERTY.END_S, endDate.toLocaleDateString()); //toDateString()
}
var startDate = new Date();
var endDate = new Date();
//sanity check to make sure we have these properties set to something
if (PROPERTY.START_D.value==null || PROPERTY.START_M.value==null || PROPERTY.START_Y.value==null || PROPERTY.START_S.value==null) {
	saveStartDate(startDate);
}
if (PROPERTY.END_D.value==null || PROPERTY.END_M.value==null || PROPERTY.END_Y.value==null || PROPERTY.END_S.value==null) {
	saveEndDate(endDate);
}

if (Ti.Platform.name == 'iPhone OS') {

var minDate = new Date();
minDate.setFullYear(2010);
minDate.setMonth(0);
minDate.setDate(1);

var maxDate = new Date(); //maximum is right now

var dateStartPicker = Ti.UI.createPicker({
	bottom:0,
	type:Ti.UI.PICKER_TYPE_DATE,
	minDate:minDate,
	maxDate:maxDate,
	value:startDate
});
dateStartPicker.selectionIndicator = true;

var dateEndPicker = Ti.UI.createPicker({
	bottom:0,
	type:Ti.UI.PICKER_TYPE_DATE,
	minDate:minDate,
	maxDate:maxDate,
	value:endDate
});
dateEndPicker.selectionIndicator = true;

dateRange.add(dateStartPicker);

dateStartPicker.addEventListener('change', function(e) {
	startDate = e.value;
	saveStartDate(startDate);
	Ti.App.fireEvent(evtUpdateDateRange);
});

dateEndPicker.addEventListener('change', function(e) {
	endDate = e.value;
	saveEndDate(endDate);
	Ti.App.fireEvent(evtUpdateDateRange);
});

} //iPhone OS