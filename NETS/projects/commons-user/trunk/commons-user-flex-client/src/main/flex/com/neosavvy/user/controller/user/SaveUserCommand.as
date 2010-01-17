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

    public class SaveUserCommand extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.user.SaveUserCommand");
        
        override public function execute(notification:INotification):void {
            super.execute(notification);
            var userServiceProxy:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;
            userServiceProxy.saveUser(notification.getBody() as UserDTO, this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            LOGGER.debug("User save success");
            sendNotification(ApplicationFacade.SAVE_USER_SUCCESS);
        }

        override protected function faultHandler(faultEvent:FaultEvent):void {
            LOGGER.debug("User save failed");
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.SAVE_USER_FAILED);
        }
    }
}