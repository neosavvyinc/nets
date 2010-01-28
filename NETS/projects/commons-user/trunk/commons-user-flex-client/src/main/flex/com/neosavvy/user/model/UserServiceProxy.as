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

        private var _activeUser:UserDTO;

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
            return _activeUser;
        }

        public function set activeUser(activeUser:UserDTO):void {
            _activeUser = activeUser;
        }

        override public function clearCachedValues():void {
            data = null;
            _activeUser = null;
        }

        public function getUsers(responder:IResponder):void {
            var userService:RemoteObject = getService(ProxyConstants.userServiceDestination);
            addCallbackHandler(userService, responder);
            userService.getUsers();
        }

        public function saveUser(param:UserDTO, responder:IResponder):void {
            var userService:RemoteObject = getService(ProxyConstants.userServiceDestination);
            addCallbackHandler(userService, responder);
            userService.saveUser(param);
        }

        public function confirmUser(userName:String, hashCode:String, responder:IResponder):void {
            var userService:RemoteObject = getService(ProxyConstants.userServiceDestination);
            addCallbackHandler(userService, responder);
            userService.confirmUser(userName, hashCode);
        }

        public function getActiveUser(responder:IResponder):void {
            var userService:RemoteObject = getService(ProxyConstants.userServiceDestination);
            addCallbackHandler(userService, responder);
            var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
            var user:UserDTO = new UserDTO();
            user.username = securityProxy.user;
            userService.findUsers(user);
        }

        public function resetPassword(user:UserDTO, responder:IResponder):void {
            var userService:RemoteObject = getService(ProxyConstants.userServiceDestination);
            addCallbackHandler(userService, responder);
            userService.resetPassword(user);
        }
    }
}
