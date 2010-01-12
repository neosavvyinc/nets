package com.neosavvy.user.controller.user {
    import com.neosavvy.user.model.UserServiceProxy;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class ConfirmAccountCommand extends AsyncCommand {


        override public function execute(notification:INotification):void {

            var userProxy:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;

            var parameters:Array = notification.getBody() as Array;
            var userName:String = parameters[0];
            var hashCode:String = parameters[1];
            userProxy.confirmUser(userName,hashCode, commandComplete);

        }
    }
}