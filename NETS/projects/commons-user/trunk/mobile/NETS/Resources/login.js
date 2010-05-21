/**
@file login.js
Establish the login view
*/

//let's craft up some objects to hold our image info, url, width, height
//Ideally, I'd like to be able to pull an image into an ImageView, then toImage()
//to get the blob and get the width/height from the image blob.
//However, Android seems to crash when doing that. Thus, this asshattery.
var IMG_LoginLock = {url:'assets/images/Icon_48_lock.png', width:48, height:48};
var IMG_LoginGradient = {url:'assets/images/login_gradient.png', width:280, height:160};

var usernameVal = Titanium.App.Properties.getString(PROPERTY.USERNAME.name);
var passwordVal = Titanium.App.Properties.getString(PROPERTY.PASSWORD.name);
var rememberMeVal = (usernameVal != null && usernameVal != '') && (passwordVal != null && passwordVal != ''); 

var login = Titanium.UI.createView({
  width:320,
  height:420,
  opacity:1
});

//create a container to put all out dialog elements into
var loginDialogView = Titanium.UI.createView({
	width:280,
	height:250, //we'll set height for real at the end after we've stuffed everything in
	borderRadius:7,
	backgroundColor:NETS_COLOR.DIALOG_BG
});
login.add(loginDialogView);

//
//Add our UI elements top to bottom. Order matters since we're calc'ing extents as we go.
//

//LOCK IMAGE
var lockImageView = Titanium.UI.createImageView({
	url:IMG_LoginLock.url,
	width:'auto',
	height:'auto',
	top:5,
	left:5
});
loginDialogView.add(lockImageView);

//grab the image blob so that we know the width/height of the image we pulled into the image view.
var lockImage;
if (Titanium.Platform.name == 'iPhone OS') {
	lockImage = lockImageView.toImage();
} else {
	//since toImage causes Android to die in flames, we'll get hard values
	lockImage = {width:IMG_LoginLock.width, height:IMG_LoginLock.height};
} 

//WELCOME TEXT
var welcomeText = Titanium.UI.createLabel({
	text:'Welcome to NETS',
	textAlign:'left',
	font:{fontSize:15, fontWeight:'bold'},
	color:'#000',
	backgroundColor:'transparent',
	width:(loginDialogView.width - lockImage.width - 15),
	height:25,
	top:lockImageView.top,
	left:(10 + lockImage.width),
	borderWidth:0,
	touchEnabled:false
});

loginDialogView.add(welcomeText);

//LOGIN DESCRIPTIVE TEXT
var loginText = Titanium.UI.createLabel({
	text:'Login with your username and password here',
	textAlign:'left',
	font:{fontSize:14, fontWeight:'normal'},
	color:'#333',
	backgroundColor:'transparent',
	width:welcomeText.width,
	height:50,
	top:(welcomeText.top + welcomeText.height),
	left:welcomeText.left,
	borderWidth:0,
	touchEnabled:false
});

loginDialogView.add(loginText);

//GRADIENT BACKDROP IMAGE
var gradientImageView = Titanium.UI.createImageView({
	url:IMG_LoginGradient.url,
	width:loginDialogView.width,
	height:'auto',
	top:(loginText.top+loginText.height),
	left:0
});
loginDialogView.add(gradientImageView);

//USERNAME TEXT FIELD
var usernameField = Titanium.UI.createTextField({
	hintText:'Enter Username',
	font:{fontSize:14},
	height:35,
	top:(loginText.top + loginText.height + 5),
	left:10,
	width:(loginDialogView.width - 20),
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
loginDialogView.add(usernameField);

//PASSWORD TEXT FIELD
var passwordField = Titanium.UI.createTextField({
	hintText:'Enter Password',
	font:{fontSize:14},
	height:35,
	top:(usernameField.top + usernameField.height + 5),
	left:10,
	width:(loginDialogView.width - 20),
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
loginDialogView.add(passwordField);

//REMEMBER ME LABEL
var rememberMeLabel = Ti.UI.createLabel({
	text:'Remember Login',
	font:{fontSize:15, fontWeight:'bold'},
	backgroundColor:'transparent',
	textAlign:'left',
	height:35,
	width:'auto',
	color:'#333',
	top:(passwordField.top + passwordField.height + 5),
	left:12
});

loginDialogView.add(rememberMeLabel);

//REMEMBER ME SWITCH
var rememberMeField = Titanium.UI.createSwitch({
    value:false,
	top:(passwordField.top + passwordField.height + 5),
	right:10,
	height:'auto'
});

rememberMeField.addEventListener('change', function(e) {
	rememberMeVal = e.value;
});

rememberMeField.value = rememberMeVal;
loginDialogView.add(rememberMeField);

//LOGIN BUTTON
var loginButton = Titanium.UI.createButton({
	title:'Login',
	font:{fontSize:15, fontWeight:'bold'},
	color:'#fff',
	top:(rememberMeLabel.top + rememberMeLabel.height + 10),
	left:10,
	height:30,
	width:(loginDialogView.width - 20),
    backgroundImage:'assets/images/orange_button_unsel.png',
	backgroundSelectedImage:'assets/images/orange_button_sel.png',
	backgroundDisabledImage:'assets/images/orange_button_unsel.png'
});

loginDialogView.add(loginButton);

loginButton.addEventListener('click', function(e) {
	Ti.API.debug('loginButton click:');
	if (e.source.title == 'Login') {
		Ti.API.debug('  clicked login button');
		Ti.App.fireEvent(evtLoginRequested, {username: usernameVal, password: passwordVal, rememberMe: rememberMeVal});
	} else {
		Ti.API.debug('  not interested');
	}
});

//set the height of the login dialog now that we've stuffed everything in
loginDialogView.height = loginButton.top + loginButton.height + 15;
