package com.neosavvy.user.controller.user {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.model.UserServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class ResetUserPasswordCommand extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.user.ResetUserPasswordCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);

            var userProxy:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;
            userProxy.resetPassword(notification.getBody() as UserDTO, this);
        }
        
        override protected function resultHandler(resultEvent:ResultEvent):void {
            LOGGER.debug("User retrieval for active user succeeded");
            sendNotification(ApplicationFacade.RESET_USER_PASSWORD_SUCCESS);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            LOGGER.debug("Resetting the password for user failed");
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.RESET_USER_PASSWORD_FAULT);
        }
    }
}