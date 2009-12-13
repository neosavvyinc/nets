
package com.neosavvy.user.controller.security {
    import com.neosavvy.user.model.SecurityProxy;
    import com.neosavvy.user.model.SecurityProxy;

    import com.neosavvy.user.model.security.LoginRequest;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class RequestLoginCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {

            var loginRequest:LoginRequest = notification.getBody() as LoginRequest;
            var securityProxy:SecurityProxy = facade.retrieveProxy( SecurityProxy.NAME ) as SecurityProxy;
            securityProxy.login(loginRequest)

        }
    }
}