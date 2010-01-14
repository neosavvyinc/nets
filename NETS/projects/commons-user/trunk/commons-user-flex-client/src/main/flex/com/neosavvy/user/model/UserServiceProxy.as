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

		private var remote:Boolean = ProxyConstants.isRemoteEnabled;

        private var _activeUser:UserDTO;

		public function UserServiceProxy()
		{
			super(NAME, null);
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

        public function getUsers(completionCallback:Function ):void {
            var userService:RemoteObject =  getService(ProxyConstants.userServiceDestination);
            //addCallbackHandler(userService, completionCallback);
            userService.addEventListener(ResultEvent.RESULT, handleGetUsersResult);
            userService.addEventListener(FaultEvent.FAULT, handleGetUsersFault);
            userService.getUsers();
        }

        private function handleGetUsersFault(event:FaultEvent):void {
            LOGGER.debug("User retrieval failed: " + event.toString());
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);
            sendNotification(ApplicationFacade.GET_USERS_FAILED);
        }

        private function handleGetUsersResult(event:ResultEvent):void {
            LOGGER.debug("Users were returned");
            this.data = event.result as ArrayCollection;
            sendNotification(ApplicationFacade.GET_USERS_SUCCESS);
        }

        public function saveUser(param:UserDTO, completionCallback:Function ):void {
            var userService:RemoteObject =  getService(ProxyConstants.userServiceDestination);
            //addCallbackHandler(userService, completionCallback);
            userService.addEventListener(ResultEvent.RESULT, handleSaveUserResult);
            userService.addEventListener(FaultEvent.FAULT, handleSaveUserFault);
            userService.saveUser( param );
        }

        private function handleSaveUserFault(event:FaultEvent):void {
            LOGGER.debug("User save failed");
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);
            sendNotification(ApplicationFacade.SAVE_USER_FAILED);
        }

        private function handleSaveUserResult(event:ResultEvent):void {
            LOGGER.debug("User save success");
            sendNotification(ApplicationFacade.SAVE_USER_SUCCESS);
        }

        public function confirmUser(userName:String, hashCode:String, completionCallback:Function ):void {
            var userService:RemoteObject =  getService(ProxyConstants.userServiceDestination);
            //addCallbackHandler(userService, completionCallback);
            userService.addEventListener(ResultEvent.RESULT, handleConfirmUserSuccess);
            userService.addEventListener(FaultEvent.FAULT, handleConfirmUserFault);
            userService.confirmUser( userName, hashCode );
        }

        private function handleConfirmUserSuccess(event:ResultEvent):void {
            LOGGER.debug("Confirmation successful: ");
            sendNotification(ApplicationFacade.CONFIRM_ACCOUNT_SUCCESS);
        }

        private function handleConfirmUserFault(event:FaultEvent):void {
            LOGGER.debug("Fault occurred while trying to confirm user: " + event.toString());
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);
            sendNotification(ApplicationFacade.CONFIRM_ACCOUNT_FAILED);
        }

        public function getActiveUser(responder:IResponder):void {
            var userService:RemoteObject =  getService(ProxyConstants.userServiceDestination);
            addCallbackHandler(userService, responder);
            var securityProxy:SecurityProxy = facade.retrieveProxy( SecurityProxy.NAME ) as SecurityProxy;
            var user:UserDTO = new UserDTO();
            user.username = securityProxy.user;
            userService.findUsers( user );
        }

        public function resetPassword(user:UserDTO, completionCallback:Function ):void {
            var userService:RemoteObject =  getService(ProxyConstants.userServiceDestination);
            //addCallbackHandler(userService, completionCallback);
            userService.addEventListener(ResultEvent.RESULT, handleResetPasswordSuccess);
            userService.addEventListener(FaultEvent.FAULT, handleResetPasswordFault);
            userService.resetPassword( user );
        }

        private function handleResetPasswordFault(event:FaultEvent):void {
            LOGGER.debug("Resetting the password for user failed");
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);
            sendNotification(ApplicationFacade.RESET_USER_PASSWORD_FAULT);
        }

        private function handleResetPasswordSuccess(event:ResultEvent):void {
            LOGGER.debug("User retrieval for active user succeeded");
            sendNotification(ApplicationFacade.RESET_USER_PASSWORD_SUCCESS);
        }

    }
}
