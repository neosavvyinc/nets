package com.neosavvy.user.controller.client {
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.model.ClientServiceProxy;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.CompanyServiceProxy;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class GetClientsForCompany extends SimpleCommand {

        override public function execute(notification:INotification):void {
            var companyProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var clientProxy:ClientServiceProxy = facade.retrieveProxy(ClientServiceProxy.NAME) as ClientServiceProxy;
            clientProxy.findClientsForParentCompany(companyProxy.activeCompany);
        }
    }
}