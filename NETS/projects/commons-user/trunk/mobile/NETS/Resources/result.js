
var result = Titanium.UI.createView({
  width:320,
  height:420,
  visible:false
});

var warp = Titanium.Media.createSound({url:'assets/sounds/warp.caf'});
var yay = Titanium.Media.createSound({url:'assets/sounds/yay.caf'});

var resultLabel = Ti.UI.createLabel({
  text: 'Magically beaming image...',
  textAlign:'center',
  font:{
    fontSize:18,
    fontFamily:'Trebuchet MS',
    fontWeight:'bold',
    fontStyle:'italic'
  },
  height:'auto',
  width:'auto',
  color:'#fff',
  top:120
});
result.add(resultLabel);

var ind = Titanium.UI.createProgressBar({
	width:200,
	height:50,
	min:0,
	max:1,
	value:0,
	style:Titanium.UI.iPhone.ProgressBarStyle.BAR,
	top:150,
	message:'Upload Progress:',
	font:{fontSize:12, fontWeight:'bold'},
	color:'#fff'
});

result.add(ind);
ind.show();

//Listen for post event
Titanium.App.addEventListener("postClicked", function(e) {
    Ti.API.info('Handling a post clicked event');
	ind.show();
	var xhr = Titanium.Network.createHTTPClient();
	xhr.onerror = function(e) {
	  ind.hide();
	  var a = Titanium.UI.createAlertDialog({ 
	    title:'Well, this is awkward...',
	    message: 'We had a problem posting your image - please try again'
	  });
		a.show();
		showChooser();
	};
	xhr.onload = function() {
	  ind.hide();
	  var doc = this.responseText;
      Ti.API.info(doc);
	  
	  if (doc) {
	    var a = Titanium.UI.createAlertDialog({
            title:'Upload Complete!',
            message: 'Receipt Uploaded...'
        });
        a.show();
  	    yay.play();
        Ti.API.info('Changing to receipt confirmation...');
//        switchToScreen(SCREEN.RECEIPT_DRILLDOWN_META);
	  }
	  
	  ind.value = 0;
    setTimeout(function() {
      resultLabel.text = 'Magically beaming image...';
    },2000);
	};
	xhr.onsendstream = function(e) {
		ind.value = e.progress;
	};
    Ti.API.info('About to post it up ... ');
	xhr.open('POST',STORAGE_SERVICE_BASE_URL + securityWrapper.sessionId);
  xhr.send({
    media:theImage
  });
  warp.play();
});