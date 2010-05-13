var progressWin = Ti.UI.createWindow({
	height:250,
	width:250
});
var progressView = Ti.UI.createView({
	height:250,
	width:250,
	backgroundColor:'#000',
	opacity:0.75,
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

Ti.App.addEventListener(evtDisplayActivityIndicator, function(e) {
	if (e.message!=null) {
		progressLabel.text = e.message;
	} else {
		progressLabel.text = '';
	}

	progressWin.open();
	progressActivity.show();
});

Ti.App.addEventListener(evtHideActivityIndicator, function(e) {
	progressActivity.hide();
	progressWin.close({opacity:0, duration:500});
});

