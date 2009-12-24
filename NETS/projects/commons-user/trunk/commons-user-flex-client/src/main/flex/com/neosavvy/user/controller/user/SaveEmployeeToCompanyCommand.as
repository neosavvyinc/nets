package com.neosavvy.user.controller.user {
    import com.neosavvy.user.dto.CompanyDTO;
    import com.neosavvy.user.dto.UserDTO;

    import com.neosavvy.user.model.CompanyServiceProxy;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class SaveEmployeeToCompanyCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var user:UserDTO = notification.getBody() as UserDTO;
            companyServiceProxy.addEmployeeToCompany(user);

        }

    }
}