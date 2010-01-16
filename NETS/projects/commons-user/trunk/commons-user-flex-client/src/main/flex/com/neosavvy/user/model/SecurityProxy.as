package com.neosavvy.user.model {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
    import com.neosavvy.user.dto.companyManagement.UserDTO;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.messaging.ChannelSet;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.mxml.RemoteObject;

    public class SecurityProxy extends AbstractRemoteObjectProxy
    {
        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.model.SecurityProxy");

        public static var NAME:String = "securityProxy";

        private var remote:Boolean = ProxyConstants.isRemoteEnabled;

        public function SecurityProxy()
        {
            super(NAME, null);
        }

        public function get user():String {
            if (data)
                return data.name as String;
            else
                return null;
        }

        public function get authorities():Array {
            if (data)
                return data.authorities as Array;
            else
                return new Array();
        }

        override public function clearCachedValues():void {
            data = null;
        }

        public function isActiveUserEmployee():Boolean {
            for each (var authority:String in authorities) {
                if (authority == "ROLE_EMPLOYEE") {
                    return true
                }
            }
            return false;
        }

        public function isActiveUserAdmin():Boolean {
            for each (var authority:String in authorities) {
                if (authority == "ROLE_ADMIN") {
                    return true
                }
            }
            return false;
        }

        /*******
         *
         * Service Proxied Functions
         *
         *******/

        public function login(user:UserDTO, completionCallback:Function):void {
            var channelSet:ChannelSet = getServiceChannelSet();
            channelSet.login(user.username, user.password);
            channelSet.addEventListener(ResultEvent.RESULT, login_resultHandler);
            channelSet.addEventListener(FaultEvent.FAULT, login_faultHandler);
        }

        public function checkUserLoggedIn(completionCallback:Function):void {
            var userService:RemoteObject = getService(ProxyConstants.userServiceDestination);
            userService.addEventListener(ResultEvent.RESULT, user_loggedAlreadyLoggedInHandler);
            userService.addEventListener(FaultEvent.FAULT, user_notLoggedInHandler);
            userService.checkUserLoggedIn();
        }

        public function logout(completionCallback:Function) {
            var channelSet:ChannelSet = getServiceChannelSet();
            channelSet.logout();
            sendNotification(ApplicationFacade.USER_NOT_LOGGED_IN);
        }

        /********
         *
         * Result Handler functions
         *
         ********/

        protected function login_resultHandler(result:ResultEvent):void {
            setData(result.result);
            sendNotification(ApplicationFacade.USER_LOGIN_SUCCESS, user);
        }

        protected function login_faultHandler(fault:FaultEvent):void {
            LOGGER.debug("Login Failed: " + fault.fault.faultString);
            sendNotification(ApplicationFacade.USER_LOGIN_FAILED);
        }

        protected function user_notLoggedInHandler(event:FaultEvent):void {
            LOGGER.debug("User is not yet logged in");
            sendNotification(ApplicationFacade.USER_NOT_LOGGED_IN);
        }

        protected function user_loggedAlreadyLoggedInHandler(event:ResultEvent):void {
            LOGGER.debug("User is already logged in");
            var security:SecurityWrapperDTO = event.result as SecurityWrapperDTO;
            setData(security);
            sendNotification(ApplicationFacade.USER_LOGGED_IN, user);
        }
    }
}