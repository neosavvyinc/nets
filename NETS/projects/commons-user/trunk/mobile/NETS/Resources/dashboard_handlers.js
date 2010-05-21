function displayDashboardLoadError() {
	var a = Titanium.UI.createAlertDialog({ 
		title:'Oops!',
		message:"We weren't able to load your dashboard data at this time.  Please try again later."
	});
	
	a.show();    
}

function onDashboardLoadFailure(e) {
	Ti.API.info('HTTP ERROR:' + e.error);
	Ti.API.info('HTTP status:' + httpClient.status);
	Ti.API.info('HTTP responseText:' + httpClient.responseText);
	Ti.API.info('HTTP connected:' + httpClient.connected);
	
	Ti.App.fireEvent(evtHideActivityIndicator);
	displayDashboardLoadError();
}

function onDashboardLoadComplete(data) {
	Ti.API.debug('onDashboardLoadComplete data:' + data);
	
	Ti.App.fireEvent(evtHideActivityIndicator);
	  
	if (data == null) {
		displayDashboardLoadError();
		return;
	}

	updateDashboard(data);
}

function loadDashboardData() {
	Ti.App.fireEvent(evtDisplayActivityIndicator, {message: 'Loading dashboard...'});
	serviceGetDashboardData(onDashboardLoadComplete, onDashboardLoadFailure);
}

function handleReceiptImageEvent(e) {
	currentReceiptImage = e.media;
    Ti.App.fireEvent(evtConfirmReceiptUpload);     
}

function showCamera() {
  Titanium.Media.showCamera({
  	success:function(event) {
  	  handleReceiptImageEvent(event);
  	},
  	cancel:function() {},
  	error:function(error) {
  		if (error.code == Titanium.Media.NO_CAMERA) {
            Titanium.Media.openPhotoGallery({
  	            success:function(event) {
            	  handleReceiptImageEvent(event);
  	            },
			cancel:function() {},
			error:function(error){
			  var a = Titanium.UI.createAlertDialog({ 
				title:'Oops!',
				message: 'We had a problem reading from your photo gallery - please try again'
			  });
				a.show();
			},
			allowImageEditing:true
		  });  		}
  		else {
    		var a = Titanium.UI.createAlertDialog({ title:'Oops...'});
  			a.setMessage('Unexpected error: ' + error.code);
     		a.show();
  		}
  	},
  	allowImageEditing:true
  });
}

function uploadReceipt(e) {
}

Ti.App.addEventListener(evtLoadDashboard, loadDashboardData);
Ti.App.addEventListener(evtDisplayCamera, showCamera);
Ti.App.addEventListener(evtUploadReceipt, uploadReceipt);

