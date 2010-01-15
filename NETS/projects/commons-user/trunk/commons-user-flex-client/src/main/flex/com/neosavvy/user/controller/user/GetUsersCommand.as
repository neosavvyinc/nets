package com.neosavvy.user.controller.user {
    import com.neosavvy.user.controller.base.NeosavvyAsyncCommand;
    import com.neosavvy.user.model.UserServiceProxy;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

    public class GetUsersCommand extends NeosavvyAsyncCommand {

        override public function execute(notification:INotification):void {
            super.execute(notification);

            var userProxy:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;
            userProxy.getUsers(commandComplete);

        }
    }
}