package com.neosavvy.user.model {
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.companyManagement.UserDTO;

    import fineline.focal.common.types.v1.StorageServiceFileRef;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.Responder;
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

        public function saveUsers( param:ArrayCollection, responder:IResponder )
        {
            var userService:RemoteObject = getService(ProxyConstants.userServiceDestination);
            addCallbackHandler(userService, responder);
            userService.updateUsers(param);
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

        public function disassociateReceiptUploadWithUser( user:UserDTO ,  fileRef:StorageServiceFileRef, responder:Responder ):void
        {
            var userService:RemoteObject = getService(ProxyConstants.userServiceDestination);
            userService.addEventListener(ResultEvent.RESULT, responder.result);
            userService.addEventListener(FaultEvent.FAULT, responder.fault);
            userService.disassociateReceiptUploadWithUser(user, fileRef);
        }

        private function get securityProxy():SecurityProxy {
            return facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
        }
    }
}
