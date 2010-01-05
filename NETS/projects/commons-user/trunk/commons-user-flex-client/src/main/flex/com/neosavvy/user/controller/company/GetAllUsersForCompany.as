package com.neosavvy.user.controller.company {
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.CompanyServiceProxy;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class GetAllUsersForCompany extends SimpleCommand {

        override public function execute(notification:INotification):void {
            var companyProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var company:CompanyDTO = notification.getBody() as CompanyDTO;
            companyProxy.findUsersForCompany( company );
        }
    }
}