package com.neosavvy.user.model {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.ProxyConstants;


    import com.neosavvy.user.dto.UserDTO;

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

		public function UserServiceProxy()
		{
			super(NAME, null);
        }

        public function get users():ArrayCollection {
            return data as ArrayCollection;
        }

        public function getUsers():void {
            var userService:RemoteObject = getUserService();
            userService.addEventListener(ResultEvent.RESULT, handleGetUsersResult);
            userService.addEventListener(FaultEvent.FAULT, handleGetUsersFault);
            userService.getUsers();
        }

        public function saveUser(param:UserDTO):void {
            var userService:RemoteObject = getUserService();
            userService.addEventListener(ResultEvent.RESULT, handleSaveUserResult);
            userService.addEventListener(FaultEvent.FAULT, handleSaveUserFault);
            userService.saveUser( param );
        }

        public function confirmUser(userName:String, hashCode:String):void {
            var userService:RemoteObject = getUserService();
            userService.addEventListener(ResultEvent.RESULT, handleConfirmUserSuccess);
            userService.addEventListener(FaultEvent.FAULT, handleConfirmUserFault);
            userService.confirmUser( userName, hashCode );
        }

        private function handleSaveUserFault(event:FaultEvent):void {
            LOGGER.debug("User save failed");
            sendNotification(ApplicationFacade.SAVE_USER_FAILED);
        }

        private function handleSaveUserResult(event:ResultEvent):void {
            LOGGER.debug("User save success");
            sendNotification(ApplicationFacade.SAVE_USER_SUCCESS);
        }


        private function handleGetUsersFault(event:FaultEvent):void {
            LOGGER.debug("User retrieval failed: " + event.toString());
            sendNotification(ApplicationFacade.GET_USERS_FAILED);
        }

        private function handleGetUsersResult(event:ResultEvent):void {
            LOGGER.debug("Users were returned");
            this.data = event.result as ArrayCollection;
            sendNotification(ApplicationFacade.GET_USERS_SUCCESS);
        }


        private function handleConfirmUserSuccess(event:ResultEvent):void {
            LOGGER.debug("Confirmation successful: ");
            sendNotification(ApplicationFacade.CONFIRM_ACCOUNT_SUCCESS);
        }

        private function handleConfirmUserFault(event:FaultEvent):void {
            LOGGER.debug("Fault occurred while trying to confirm user: " + event.toString());
            sendNotification(ApplicationFacade.CONFIRM_ACCOUNT_FAILED);
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