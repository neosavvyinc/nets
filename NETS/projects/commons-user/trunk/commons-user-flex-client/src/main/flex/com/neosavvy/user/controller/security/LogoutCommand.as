package com.neosavvy.user.controller.security {
    import com.neosavvy.user.controller.base.NeosavvyAsyncCommand;
    import com.neosavvy.user.model.SecurityProxy;

    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;

    import mx.rpc.events.FaultEvent;

    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class LogoutCommand extends NeosavvyAsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.security.LogoutCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
            securityProxy.logout(this)
        }

        public function fault(info:Object):void {
            var faultEvent:FaultEvent = info as FaultEvent;
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            commandComplete();
        }

        public function result(data:Object):void {
            var result:ResultEvent = data as ResultEvent;
            LOGGER.debug("User has successfully been logged out");
            commandComplete();
        }
    }
}