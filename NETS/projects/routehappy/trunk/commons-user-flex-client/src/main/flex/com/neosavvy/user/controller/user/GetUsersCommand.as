package com.neosavvy.user.controller.user {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.model.UserServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class GetUsersCommand extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.user.GetUsersCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var userProxy:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;
            userProxy.getUsers(this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            LOGGER.debug("Users were returned");
            var userProxy:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;
            userProxy.users = resultEvent.result as ArrayCollection;
            sendNotification(ApplicationFacade.GET_USERS_SUCCESS);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            LOGGER.debug("User retrieval failed: " + faultEvent.toString());
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.GET_USERS_FAILED);
        }
    }
}