/**
 * @file progress.js
 * For throwing up a progress indicator.
 */
var progressWin = Ti.UI.createWindow({
	height:250,
	width:250
});
var progressView = Ti.UI.createView({
	height:250,
	width:250,
	backgroundColor:'#000',
	opacity:0.75,
    borderRadius:7,
	touchEnabled:false
});
progressWin.add(progressView);

var progressLabel = Ti.UI.createLabel({
	text:'',
	color:'#fff',
	width:250,
	top:180,
	height:'auto',
	textAlign:'center'
});
progressView.add(progressLabel);
var progressActivity = Ti.UI.createActivityIndicator({
	style:Ti.UI.iPhone.ActivityIndicatorStyle.BIG,
	height:30,
	width:30
});
progressView.add(progressActivity);

function progress_show(message) {
	if (message!=null) {
		progressLabel.text = message;
	} else {
		progressLabel.text = '';
	}

	progressWin.open();
	progressActivity.show();
}

function progress_hide() {
	progressActivity.hide();
	progressWin.close({opacity:0, duration:500});
}

Ti.App.addEventListener(evtDisplayActivityIndicator, function(e) {
	progress_show(e.message);
});

Ti.App.addEventListener(evtHideActivityIndicator, function(e) {
	progress_hide();
});

