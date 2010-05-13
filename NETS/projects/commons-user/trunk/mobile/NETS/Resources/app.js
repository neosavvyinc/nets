/**
NeoSavvy Expense Tracker
@file app.js
*/

// this sets the background color of the master UIView (when there are no windows/tab groups on it)
Titanium.UI.setBackgroundColor('#000');

var httpClient = Titanium.Network.createHTTPClient();
var securityWrapper = null;

//Root Window & View
var rootWin = Titanium.UI.createWindow({  
    title:'NETS',
    //backgroundColor:'#000'
	backgroundImage:'assets/images/NETS_bg.png'
});

var viewContainer = Titanium.UI.createView({
  //top:60,
  width:320,
  height:420
});

//Includes
Titanium.include('events.js'); //include this one first. all the uesr-events (should) live in here
Titanium.include('constants.js'); //and this one second. important global app mojo in here
Titanium.include('service.js'); //some views depend on services, so include it before we build views
Titanium.include('dashboard.js');
Titanium.include('login.js');
Titanium.include('confirm_receipt_upload.js');
Titanium.include('login_handlers.js');
Titanium.include('dashboard_handlers.js');
Titanium.include('progress.js');

//add all our views into our view container
viewContainer.add(login);
viewContainer.add(dashboard);
viewContainer.add(confirmReceiptUpload);

/**
@param v enumerator for the view to switch to. see VIEW in constants.js
*/
function switchToView(v) {
	Ti.API.debug('switchToView value:' + v.value + ' name:' + v.name);
	
	login.visible = false;
	dashboard.visible = false;
	confirmReceiptUpload.visible = false;
	
	switch(v) {
	case VIEW.LOGIN:
		viewContainer.animate({view:login,transition:Ti.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT});
		login.visible = true;
		break;
	case VIEW.DASHBOARD:
		viewContainer.animate({view:dashboard,transition:Ti.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT});
		dashboard.visible = true;
		break;
	case VIEW.CONFIRM_RECEIPT_UPLOAD:
		viewContainer.animate({view:confirmReceiptUpload,transition:Ti.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT});
		confirmReceiptUpload.visible = true;
		break;
	default:
		Ti.API.error('switchToView error: invalid view arg');
	}
};

rootWin.add(viewContainer);
rootWin.open({
	transition:Titanium.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT
});

switchToView(VIEW.LOGIN);

if (!Titanium.Network.online) {
  var a = Titanium.UI.createAlertDialog({ 
    title:'Network Connection Required',
    message: 'NETS requires an internet connection .  Check your network connection and try again.'
  });
	a.show();
}


