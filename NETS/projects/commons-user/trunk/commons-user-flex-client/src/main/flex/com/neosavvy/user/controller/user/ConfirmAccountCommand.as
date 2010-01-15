package com.neosavvy.user.controller.user {
    import com.neosavvy.user.controller.base.NeosavvyAsyncCommand;
    import com.neosavvy.user.model.UserServiceProxy;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

    public class ConfirmAccountCommand extends NeosavvyAsyncCommand {


        override public function execute(notification:INotification):void {
            super.execute(notification);
            var userProxy:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;

            var parameters:Array = notification.getBody() as Array;
            var userName:String = parameters[0];
            var hashCode:String = parameters[1];
            userProxy.confirmUser(userName, hashCode, commandComplete);

        }
    }
}