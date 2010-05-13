/**
@file constants.js

Application constants cataloged here.
*/

//var MOBILE_SERVICE_BASE_URL = 'http://nets.neosavvy.com:8080/nets/expense/services/mobile';
//var STORAGE_SERVICE_BASE_URL = 'http://nets.neosavvy.com:8080/nets/storage';

var MOBILE_SERVICE_BASE_URL = 'http://localhost:8080/nets/expense/services/mobile';
var STORAGE_SERVICE_BASE_URL = 'http://localhost:8080/nets/storage';

//View Enumerator
var VIEW = {
	LOGIN 					: {value:0, name:'login'},
	DASHBOARD 				: {value:1, name:'dashboard'},
	CONFIRM_RECEIPT_UPLOAD 	: {value:2, name:'confirmReceiptUpload'}
};

//App Properties
var PROPERTY = {
	USERNAME : {value:0, name:'un'},
	PASSWORD : {value:1, name:'pw'}
};
