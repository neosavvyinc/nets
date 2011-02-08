package com.neosavvy.user.model {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.companyManagement.UserDTO;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.messaging.ChannelSet;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.mxml.RemoteObject;

    public class SecurityProxy extends AbstractRemoteObjectProxy
    {
        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.model.SecurityProxy");

        public static var NAME:String = "securityProxy";

        public function SecurityProxy()
        {
            super(NAME, null, ProxyConstants.expenseContextRoot);
        }

        public function get sessionId():String {
            if (data) {
                return data.sessionId as String;
            }
            else
            {
                return null;
            }
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

        public function get activeUser():UserDTO {
            return (data == null ? null : data.user);
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

        /****
         * This method explicitly does not follow the pattern since it
         * does not require a remoteObject to perform the login - notice
         * that it uses a channelSet to interact with the service rather
         * than a remoteObject.
         * 
         * @param user
         * @param responder
         */
        public function login(user:UserDTO, responder:IResponder):void {
            var channelSet:ChannelSet = getServiceChannelSet();
            channelSet.login(user.username, user.password);
            channelSet.addEventListener(ResultEvent.RESULT, responder.result);
            channelSet.addEventListener(FaultEvent.FAULT, responder.fault);
        }

        public function checkUserLoggedIn(responder:IResponder):void {
            var userService:RemoteObject = getService(ProxyConstants.userServiceDestination);
            addCallbackHandler(userService, responder);
            userService.getUserDetails();
        }

        public function logout(responder:IResponder) {
            var channelSet:ChannelSet = getServiceChannelSet();
            channelSet.logout();
            channelSet.addEventListener(ResultEvent.RESULT, responder.result);
            channelSet.addEventListener(FaultEvent.FAULT, responder.fault);
            sendNotification(ApplicationFacade.USER_NOT_LOGGED_IN);
        }

        public function resetUserPassword(user:UserDTO, responder:IResponder):void {
            var userService:RemoteObject = getService(ProxyConstants.userServiceDestination);
            addCallbackHandler(userService, responder);
            userService.resetPasswordForUser(user.username);
        }
    }
}