package com.neosavvy.user.model {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.ProxyConstants;


    import com.neosavvy.user.dto.companyManagement.UserDTO;

    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import mx.messaging.ChannelSet;
    import mx.messaging.channels.AMFChannel;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.mxml.RemoteObject;

    import org.puremvc.as3.multicore.patterns.proxy.Proxy;

    public class UserServiceProxy extends Proxy {
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

        public function getUsers():void {
            var userService:RemoteObject = getUserService();
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

        public function saveUser(param:UserDTO):void {
            var userService:RemoteObject = getUserService();
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

        public function confirmUser(userName:String, hashCode:String):void {
            var userService:RemoteObject = getUserService();
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

        public function getActiveUser():void {
            var userService:RemoteObject = getUserService();
            userService.addEventListener(ResultEvent.RESULT, handleGetActiveUserSuccess);
            userService.addEventListener(FaultEvent.FAULT, handleGetActiveUserFault);
            var securityProxy:SecurityProxy = facade.retrieveProxy( SecurityProxy.NAME ) as SecurityProxy;
            var user:UserDTO = new UserDTO();
            user.username = securityProxy.user;
            userService.findUsers( user );
        }

        private function handleGetActiveUserFault(event:FaultEvent):void {
            LOGGER.debug("User retrieval for active user failed");
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);
        }

        private function handleGetActiveUserSuccess(event:ResultEvent):void {
            LOGGER.debug("User retrieval for active user succeeded");
            var users:ArrayCollection = event.result as ArrayCollection;
            _activeUser = users.getItemAt(0) as UserDTO;

            trace("ADAM LOOK HERE I HAVE AN ACTIVE USER!!!!!!!!!!!");
        }

        public function resetPassword(user:UserDTO):void {
            var userService:RemoteObject = getUserService();
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

        /****
         *
         * Helper functions
         *
         ****/
        private function getUserServiceChannelSet():ChannelSet {
            var channel:AMFChannel = new AMFChannel(ProxyConstants.channelName, ProxyConstants.url);
            var channelSet:ChannelSet = new ChannelSet();
            channelSet.addChannel(channel);
            return channelSet;
        }

        private function getUserService():RemoteObject {
            var userService:RemoteObject = new RemoteObject();
            userService.channelSet = getUserServiceChannelSet();
            userService.destination = ProxyConstants.userServiceDestination;
            return userService;
        }


    }
}