package com.neosavvy.user.controller.company {
    import com.neosavvy.user.dto.UserInviteDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;

    import com.neosavvy.user.view.secured.employeeInvitation.event.UserCompanyInviteEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class DeleteUserCompanyInviteCommand extends SimpleCommand {
        override public function execute(notification:INotification):void {
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var userInvite:UserInviteDTO = notification.getBody() as UserInviteDTO;
            companyServiceProxy.deleteUserCompanyInvite(userInvite);
        }
    }
}