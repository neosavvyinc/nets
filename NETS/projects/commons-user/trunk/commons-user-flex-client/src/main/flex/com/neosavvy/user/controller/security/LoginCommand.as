package com.neosavvy.user.controller.security {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.NeosavvyAsyncCommand;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.model.SecurityProxy;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;

    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class LoginCommand extends NeosavvyAsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.security.LoginCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var user:UserDTO = notification.getBody() as UserDTO;
            var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
            securityProxy.login(user, this);
        }

        public function fault(info:Object):void {
            var faultEvent:FaultEvent = info as FaultEvent;
            LOGGER.debug("Login Failed: " + faultEvent.fault.faultString);
            sendNotification(ApplicationFacade.USER_LOGIN_FAILED);
            commandComplete();
        }

        public function result(data:Object):void {
            var result:ResultEvent = data as ResultEvent;
            var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
            securityProxy.setData(result.result);
            sendNotification(ApplicationFacade.USER_LOGIN_SUCCESS, securityProxy.user);
            commandComplete();
        }
    }
}