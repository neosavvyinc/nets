function displayDashboardLoadError() {
	var a = Titanium.UI.createAlertDialog({ 
		title:'Oops!',
		message: "We weren't able to load your dashboard data at this time.  Please try again later."		
	});
	
	a.show();    
}

function onDashboardLoadFailure(e) {
	Ti.App.fireEvent('hideActivityIndicator');
}

function onDashboardLoadComplete(data) {
	Ti.App.fireEvent('hideActivityIndicator');
	  
	if (data == null) {
		displayDashboardLoadError();
		return;
	}

	updateDashboard(data);    
}

function loadDashboardData() {
	Ti.App.fireEvent('displayActivityIndicator', {message: 'Loading dashboard...'});
	serviceGetDashboardData(onDashboardLoadComplete, onDashboardLoadFailure);
}

function handleReceiptImageEvent(e) {
	currentReceiptImage = e.media;
    Ti.App.fireEvent("confirmReceiptUpload");     
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

Ti.App.addEventListener("loadDashboard", loadDashboardData);
Ti.App.addEventListener("displayCamera", showCamera);
Ti.App.addEventListener("uploadReceipt", uploadReceipt);

