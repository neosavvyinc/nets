package com.neosavvy.user.controller.secured {
    import com.neosavvy.user.view.secured.SecuredContainer;

    import com.neosavvy.user.view.secured.SecuredContainerMediator;
    import com.neosavvy.user.view.secured.employeeInvitation.EmployeeManagementMediator;

    import com.neosavvy.user.view.secured.leftNavigation.admin.AdminNavigationMediator;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class SecuredViewPrepCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {
            var securedContainer:SecuredContainer = notification.getBody() as SecuredContainer;
            facade.registerMediator(new SecuredContainerMediator(securedContainer));
            facade.registerMediator(new AdminNavigationMediator(securedContainer.leftNavigation.adminNavigation) );
            facade.registerMediator( new EmployeeManagementMediator( securedContainer.employeeInvitationManagement ) );
        }
    }
}