package com.neosavvy.user.controller.security {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
    import com.neosavvy.user.model.SecurityProxy;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class CheckLoggedIn extends ResponderAsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.security.CheckLoggedIn");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
            securityProxy.checkUserLoggedIn(this);

        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var security:SecurityWrapperDTO = resultEvent.result as SecurityWrapperDTO;
            if (security != null) {
                LOGGER.debug("User is already logged in");
                var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
                securityProxy.setData(security);
                sendNotification(ApplicationFacade.USER_LOGGED_IN, securityProxy.user);
            }
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            LOGGER.debug("User is not yet logged in");
            sendNotification(ApplicationFacade.USER_NOT_LOGGED_IN);
        }
    }
}