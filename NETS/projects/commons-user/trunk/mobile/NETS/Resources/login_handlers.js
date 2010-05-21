function onLoginFailure(e) {
	Ti.API.info('HTTP ERROR:' + e.error);
	Ti.API.info('HTTP status:' + httpClient.status);
	Ti.API.info('HTTP responseText:' + httpClient.responseText);
	Ti.API.info('HTTP connected:' + httpClient.connected);
	Ti.App.fireEvent(evtHideActivityIndicator);
    var a = Titanium.UI.createAlertDialog({ 
	    title:'Error[' + e.error + ']',
	    message: "We weren't able to log you in at this time.  Please try again."
	  });
	a.show();    
}

function onLoginComplete(wrapper, username, password, rememberMe) {
	Ti.App.fireEvent(evtHideActivityIndicator);
	
	var a = Titanium.UI.createAlertDialog({ 
		title:'Oops...',
		message: "The login or password were not correct.  Please try again."
	});
	  
    if (wrapper == null) {
		a.show();
		return;
    }
    
    securityWrapper = wrapper;
    
    if (rememberMe) {
		setProperty(PROPERTY.USERNAME, username);
		setProperty(PROPERTY.PASSWORD, password);
    }
    else {
		setProperty(PROPERTY.USERNAME, null);
		setProperty(PROPERTY.PASSWORD, null);
    }
    
    switchToScreen(SCREEN.TABGROUP);
	Ti.App.fireEvent(evtLoadDashboard);
}

function executeLogin(e) {
	Ti.API.debug('doing executeLogin');
	Ti.App.fireEvent(evtDisplayActivityIndicator, {message: 'Logging in...'});
	serviceLogin(e.username, e.password, function(wrapper) { onLoginComplete(wrapper, e.username, e.password, e.rememberMe); }, onLoginFailure);
}

Titanium.App.addEventListener(evtLoginRequested, executeLogin);