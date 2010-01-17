package com.neosavvy.user.controller.user {
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.model.UserServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

    public class GetActiveUserCommand extends ResponderAsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.user.GetActiveUserCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var userProxy:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;
            userProxy.getActiveUser(this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            LOGGER.debug("User retrieval for active user succeeded");
            var users:ArrayCollection = resultEvent.result as ArrayCollection;
            var _activeUser:UserDTO = users.getItemAt(0) as UserDTO;
            var userProxy:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;
            userProxy.activeUser = _activeUser;
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            LOGGER.debug("User retrieval for active user failed");
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
        }
    }
}