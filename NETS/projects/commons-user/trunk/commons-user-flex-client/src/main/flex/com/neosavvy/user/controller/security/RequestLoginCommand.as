
package com.neosavvy.user.controller.security {
    import com.neosavvy.user.dto.UserDTO;
    import com.neosavvy.user.model.SecurityProxy;
    import com.neosavvy.user.model.SecurityProxy;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class RequestLoginCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {

            var user:UserDTO = notification.getBody() as UserDTO;
            var securityProxy:SecurityProxy = facade.retrieveProxy( SecurityProxy.NAME ) as SecurityProxy;
            securityProxy.login(user)

        }
    }
}