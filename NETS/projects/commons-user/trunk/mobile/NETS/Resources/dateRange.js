/**
@file dateRange.js
view for the date range picker
*/

var dateRange = Titanium.UI.createView({
    top: 0,
    width: 320,
    height: 420,
    opacity: 1,
	title: 'Date Range'
});

/** hmm, tabbed bar only exists for iPhone
var dateRangeBar = Titanium.UI.createTabbedBar({
	labels:['All Reports', 'Custom'],
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
var label1Text = 'All Reports';
var label2Text = 'Custom';
var drIndex = Titanium.App.Properties.getString(PROPERTY.DATERANGE.name);
if (drIndex == null || drIndex == '') {
	drIndex = 0;
}
Ti.API.debug('daterange index is ' + drIndex);

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
	borderColor:NETS_COLOR.BUTTON_GRADIENT_DARK,
	backgroundColor:colorSelected,
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
	borderColor:NETS_COLOR.BUTTON_GRADIENT_DARK,
	backgroundColor:colorUnselected,
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
	drIndex = index;
	Titanium.App.Properties.setString(PROPERTY.DATERANGE.name, drIndex);
	Ti.API.debug('drIndex now ' + drIndex);
	if (drIndex == 0) {
		//all
		Ti.API.debug('Activating All Reports');
		dateLabel2.backgroundColor = colorUnselected;
		dateLabel2.text = '';
		dateLabel2.text = label2Text;
		dateLabel1.backgroundColor = colorSelected;
		dateLabel1.text = '';
		dateLabel1.text = label1Text;
		startingLabel.visible = false;
		endingLabel.visible = false;
	} else {
		//custom
		Ti.API.debug('Activating Custom');
		dateLabel1.backgroundColor = colorUnselected;
		dateLabel1.text = '';
		dateLabel1.text = label1Text;
		dateLabel2.backgroundColor = colorSelected;
		dateLabel2.text = '';
		dateLabel2.text = label2Text;
		startingLabel.visible = true;
		endingLabel.visible = true;
		
	}
}
setActive(drIndex); //so we set it up the first time.

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