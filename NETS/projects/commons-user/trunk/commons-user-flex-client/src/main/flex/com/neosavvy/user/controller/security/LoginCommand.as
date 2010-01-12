
package com.neosavvy.user.controller.security {
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.model.SecurityProxy;
    import com.neosavvy.user.model.SecurityProxy;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class LoginCommand extends AsyncCommand {

        override public function execute(notification:INotification):void {

            var user:UserDTO = notification.getBody() as UserDTO;
            var securityProxy:SecurityProxy = facade.retrieveProxy( SecurityProxy.NAME ) as SecurityProxy;
            securityProxy.login(user, commandComplete )

        }
    }
}