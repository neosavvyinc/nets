var usernameVal = Titanium.App.Properties.getString("un");
var passwordVal = Titanium.App.Properties.getString("pw");
var rememberMeVal = (usernameVal != null && usernameVal != '') && (passwordVal != null && passwordVal != ''); 

var login = Titanium.UI.createView({
  top:60,
  width:320,
  height:420,
  opacity:1
});

var usernameField = Titanium.UI.createTextField({
	hintText:'Enter Username',
	height:35,
	top:10,
	left:30,
	width:250,
	keyboardType:Titanium.UI.KEYBOARD_DEFAULT,
	returnKeyType:Titanium.UI.RETURNKEY_DEFAULT,
	borderStyle:Titanium.UI.INPUT_BORDERSTYLE_ROUNDED,
	autocorrect:false
});

usernameField.addEventListener('return', function() {
	usernameField.blur();
});
usernameField.addEventListener('change', function(e) {
	usernameVal = e.value;
});

usernameField.value = usernameVal;
login.add(usernameField);

var passwordField = Titanium.UI.createTextField({
	hintText:'Enter Password',
	height:35,
	top:65,
	left:30,
	width:250,
	keyboardType:Titanium.UI.KEYBOARD_DEFAULT,
	returnKeyType:Titanium.UI.RETURNKEY_DEFAULT,
	borderStyle:Titanium.UI.INPUT_BORDERSTYLE_ROUNDED,
	autocorrect:false,
	passwordMask:true
});

passwordField.addEventListener('return', function() {
	passwordField.blur();
});
passwordField.addEventListener('change', function(e) {
	passwordVal = e.value;
});
passwordField.value = passwordVal;
login.add(passwordField);

var rememberMeField = Titanium.UI.createSwitch({
    value:false,
	top:120,
	left:30,
	height:'auto'
});

rememberMeField.addEventListener('change', function(e) {
	rememberMeVal = e.value;
});

rememberMeField.value = rememberMeVal;
login.add(rememberMeField);

var rememberMeLabel = Ti.UI.createLabel({
  text: 'Remember Login',
  textAlign:'Left',
  height:'auto',
  width:'auto',
  color:'#fff',
  top:120,
  left:130
});

login.add(rememberMeLabel);

var loginButton = Titanium.UI.createButton({
	title:'Login',
	top:170,
	left:30,
	height:30,
	width:250
});
login.add(loginButton);

loginButton.addEventListener("click", function(e) {
	Ti.App.fireEvent("loginRequested", {username: usernameVal, password: passwordVal, rememberMe: rememberMeVal});
});

