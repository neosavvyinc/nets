// this sets the background color of the master UIView (when there are no windows/tab groups on it)
Titanium.UI.setBackgroundColor('#000');

var httpClient = Titanium.Network.createHTTPClient();
var mobileServiceBaseUrl = 'http://localhost:8080/nets/expense/services/mobile';
var storageServiceBaseUrl = 'http://localhost:8080/nets/storage';
var securityWrapper = null;

var app = Titanium.UI.createWindow({  
    title:'NETS',
    //backgroundColor:'#000'
	backgroundImage:'assets/images/NETS_bg.png'
});

var viewContainer = Titanium.UI.createView({
  //top:60,
  width:320,
  height:420
});

Titanium.include('service.js');
Titanium.include('dashboard.js');
Titanium.include('login.js');
Titanium.include('confirm_receipt_upload.js');
Titanium.include('login_handlers.js');
Titanium.include('dashboard_handlers.js');
Titanium.include('progress.js');

viewContainer.add(login);
viewContainer.add(dashboard);
viewContainer.add(confirmReceiptUpload);

function showLogin() {
  viewContainer.animate({view:login,transition:Ti.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT});
  login.visible = true;
  dashboard.visible = false;
  confirmReceiptUpload.visible = false;
}

function showDashboard() {
  viewContainer.animate({view:dashboard,transition:Ti.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT});
  login.visible = false;
  dashboard.visible = true;
  confirmReceiptUpload.visible = false;
  Ti.App.fireEvent("userLoggedIn", {securityWrapper: securityWrapper});
  Ti.App.fireEvent("loadDashboard");
}

function showConfirmReceiptUpload() {
  viewContainer.animate({view:confirmReceiptUpload,transition:Ti.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT});
  login.visible = false;
  dashboard.visible = false;
  confirmReceiptUpload.visible = true;
}

app.add(viewContainer);
app.open({
	transition:Titanium.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT
});

showLogin();

if (!Titanium.Network.online) {
  var a = Titanium.UI.createAlertDialog({ 
    title:'Network Connection Required',
    message: 'NETS requires an internet connection .  Check your network connection and try again.'
  });
	a.show();
}


