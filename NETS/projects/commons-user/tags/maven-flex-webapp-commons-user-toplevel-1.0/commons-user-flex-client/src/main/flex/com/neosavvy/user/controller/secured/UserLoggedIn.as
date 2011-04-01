package com.neosavvy.user.controller.secured {
    import com.neosavvy.user.ApplicationFacade;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class UserLoggedIn extends SimpleCommand {
        override public function execute(notification:INotification):void {
            sendNotification(ApplicationFacade.USER_LOGIN_STARTUP_COMPLETE);
        }
    }
}