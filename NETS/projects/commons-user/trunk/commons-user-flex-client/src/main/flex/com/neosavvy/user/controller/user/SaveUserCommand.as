package com.neosavvy.user.controller.user {
    import com.neosavvy.user.controller.base.NeosavvyAsyncCommand;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.model.UserServiceProxy;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

    public class SaveUserCommand extends NeosavvyAsyncCommand {

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var userServiceProxy:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;
            userServiceProxy.saveUser(notification.getBody() as UserDTO, commandComplete);
        }
    }
}