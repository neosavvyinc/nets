package com.neosavvy.user.controller.company {
    import com.neosavvy.user.model.CompanyServiceProxy;

    import mx.collections.ArrayCollection;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class GetInvitedUsersForCompanyCommand extends SimpleCommand {
        override public function execute(notification:INotification):void {
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            companyServiceProxy.getInvitedUsers();
        }
    }
}