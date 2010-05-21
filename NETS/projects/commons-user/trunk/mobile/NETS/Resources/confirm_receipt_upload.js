var currentReceiptImage = null;
var receiptNameVal;

var confirmReceiptUpload = Titanium.UI.createView({
  top:0,
  width:320,
  height:420,
  opacity:1
});

var uploadProgress=Titanium.UI.createProgressBar({
	width:200,
	height:50,
	min:0,
	max:1,
	value:0,
	style:Titanium.UI.iPhone.ProgressBarStyle.PLAIN,
	top:10,
	message:'Waiting...',
	font:{fontSize:12, fontWeight:'bold'},
	color:'#888'
});

confirmReceiptUpload.add(uploadProgress);
uploadProgress.show();

var nameField = Titanium.UI.createTextField({
	hintText:'Enter Receipt Name',
	height:35,
	top:70,
	left:30,
	width:250,
	keyboardType:Titanium.UI.KEYBOARD_DEFAULT,
	returnKeyType:Titanium.UI.RETURNKEY_DEFAULT,
	borderStyle:Titanium.UI.INPUT_BORDERSTYLE_ROUNDED,
	autocorrect:true
});

confirmReceiptUpload.add(nameField);

var uploadButton = Titanium.UI.createButton({
	title:'Upload',
	top:140,
	left:30,
	height:30,
	width:250
});
confirmReceiptUpload.add(uploadButton);

var cancelButton = Titanium.UI.createButton({
	title:'Cancel',
	top:190,
	left:30,
	height:30,
	width:250
});
confirmReceiptUpload.add(cancelButton);

cancelButton.addEventListener('click', function(e) {
	switchToScreen(SCREEN.DASHBOARD);
});

nameField.addEventListener('return', function() {
	nameField.blur();
});

nameField.addEventListener('change', function(e) {
	receiptNameVal = e.value;	
});

function onReceiptUploadFailure(e) {
	var a = Titanium.UI.createAlertDialog({ 
		title:'Oops!',
		message: "An error occurred while uploading the receipt to our servers.  Please try again later."		
	});
	
	a.show();    
	a.addEventListener('click', function() {
	    switchToScreen(SCREEN.DASHBOARD);
	});
}

function onReceiptUploaded(storageServiceFileRef) {
    Ti.API.info(storageServiceFileRef);    
    
    if (storageServiceFileRef == null) {
    	onReceiptUploadFailure(null);
    	return;
    }
    
	var a = Titanium.UI.createAlertDialog({ 
		title:'Uploaded!',
		message: "Your receipt has been added to your account.  You can log in to your account and add the receipt to an expense report later."		
	});
	
	a.show();    
	a.addEventListener('click', function() {
	    switchToScreen(SCREEN.DASHBOARD);
	});
}

function onReceiptProgress(progress) {
	uploadProgress.value = progress;
}

uploadButton.addEventListener('click', function(e) {
    if (receiptNameVal == null || receiptNameVal.length == 0) {
    	alert('You must enter a receipt name.');
	    return;
    }
    
	uploadProgress.message = 'Uploading Receipt...';
	uploadButton.visible = false;
	cancelButton.visible = false;
	serviceUploadReceipt(receiptNameVal, currentReceiptImage, onReceiptUploaded, onReceiptUploadFailure, onReceiptProgress);
});


Ti.App.addEventListener(evtConfirmReceiptUpload, function(e) {
    uploadProgress.value = 0;
    nameField.value = '';
    receiptNameVal = null;
	cancelButton.visible = true;
	uploadButton.visible = true;
    uploadProgress.message = 'Waiting...';
	switchToScreen(SCREEN.CONFIRM_RECEIPT_UPLOAD);
});
