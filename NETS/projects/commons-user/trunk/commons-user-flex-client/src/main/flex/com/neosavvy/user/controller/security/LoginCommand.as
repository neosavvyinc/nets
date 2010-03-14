package com.neosavvy.user.controller.security {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.model.SecurityProxy;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;

    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class LoginCommand extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.security.LoginCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var user:UserDTO = notification.getBody() as UserDTO;
            var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
            securityProxy.login(user, this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;

            securityProxy.checkUserLoggedIn(new Responder(
                function(result:ResultEvent):void {
                    securityProxy.setData(result.result as SecurityWrapperDTO);
                    sendNotification(ApplicationFacade.USER_LOGIN_SUCCESS, securityProxy.user);
                },
                function (faultEvent:FaultEvent):void {
                    LOGGER.debug("Login Failed: " + faultEvent.fault.faultString);
                    sendNotification(ApplicationFacade.USER_LOGIN_FAILED);
                }
            ));
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            LOGGER.debug("Login Failed: " + faultEvent.fault.faultString);
            sendNotification(ApplicationFacade.USER_LOGIN_FAILED);
        }


    }
}