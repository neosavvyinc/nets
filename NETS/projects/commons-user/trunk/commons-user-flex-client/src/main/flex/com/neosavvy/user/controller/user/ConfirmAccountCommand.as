package com.neosavvy.user.controller.user {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.model.UserServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class ConfirmAccountCommand extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.user.ConfirmAccountCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var userProxy:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;

            var parameters:Array = notification.getBody() as Array;
            var userName:String = parameters[0];
            var hashCode:String = parameters[1];
            userProxy.confirmUser(userName, hashCode, this);
        }


        override protected function resultHandler(resultEvent:ResultEvent):void {
            LOGGER.debug("Confirmation successful: ");
            sendNotification(ApplicationFacade.CONFIRM_ACCOUNT_SUCCESS);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            LOGGER.debug("Fault occurred while trying to confirm user: " + faultEvent.toString());
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.CONFIRM_ACCOUNT_FAILED);
        }
    }
}