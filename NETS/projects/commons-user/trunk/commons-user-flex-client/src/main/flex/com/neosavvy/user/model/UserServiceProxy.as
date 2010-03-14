package com.neosavvy.user.model {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.mxml.RemoteObject;

    public class UserServiceProxy extends AbstractRemoteObjectProxy {
        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.model.UserServiceProxy");

        public static var NAME:String = "userProxy";

        public function UserServiceProxy()
        {
            super(NAME, null, ProxyConstants.expenseContextRoot);
        }

        public function set users(value:ArrayCollection):void {
            this.data = value;
        }

        public function get users():ArrayCollection {
            return data as ArrayCollection;
        }

        public function get activeUser():UserDTO {
            return securityProxy.activeUser;
        }

        override public function clearCachedValues():void {
            data = null;
        }

        public function getUsers(responder:IResponder):void {
            var userService:RemoteObject = getService(ProxyConstants.userServiceDestination);
            addCallbackHandler(userService, responder);
            userService.getUsers();
        }

        public function saveUser(param:UserDTO, responder:IResponder):void {
            var userService:RemoteObject = getService(ProxyConstants.userServiceDestination);
            addCallbackHandler(userService, responder);
            userService.updateUser(param);
        }

        public function confirmUser(userName:String, hashCode:String, responder:IResponder):void {
            var userService:RemoteObject = getService(ProxyConstants.userServiceDestination);
            addCallbackHandler(userService, responder);
            userService.confirmUser(userName, hashCode);
        }

        public function resetPassword(user:UserDTO, responder:IResponder):void {
            var userService:RemoteObject = getService(ProxyConstants.userServiceDestination);
            addCallbackHandler(userService, responder);
            userService.resetPassword(user);
        }

        private function get securityProxy():SecurityProxy {
            return facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
        }
    }
}
