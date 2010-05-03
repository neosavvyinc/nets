function onLoginFailure(e) {
	Ti.App.fireEvent('hideActivityIndicator');
    var a = Titanium.UI.createAlertDialog({ 
	    title:'Oops...',
	    message: "We weren't able to log you in at this time.  Please try again."
	  });
	a.show();    
}

function onLoginComplete(wrapper, username, password, rememberMe) {
	Ti.App.fireEvent('hideActivityIndicator');
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
        Titanium.App.Properties.setString("un", username);
        Titanium.App.Properties.setString("pw", password);
    }
    else {
        Titanium.App.Properties.setString("un", null);
        Titanium.App.Properties.setString("pw", null);
    }
    
    showDashboard();
}

function executeLogin(e) {
	Ti.App.fireEvent('displayActivityIndicator', {message: 'Logging in...'});
	serviceLogin(e.username, e.password, function(wrapper) { onLoginComplete(wrapper, e.username, e.password, e.rememberMe); }, onLoginFailure);
}

Titanium.App.addEventListener("loginRequested", executeLogin);