package com.neosavvy.user.controller.user {
    import com.neosavvy.user.model.UserServiceProxy;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class GetUsersCommand extends AsyncCommand {

        override public function execute(notification:INotification):void {

            var userProxy:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;
            userProxy.getUsers( commandComplete );

        }
    }
}