package com.neosavvy.user.controller.security {
    import com.neosavvy.user.controller.base.NeosavvyAsyncCommand;
    import com.neosavvy.user.model.SecurityProxy;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

    public class CheckLoggedIn extends NeosavvyAsyncCommand {

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
            securityProxy.checkUserLoggedIn(commandComplete);

        }
    }
}