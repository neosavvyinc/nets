package com.neosavvy.user.controller.secured {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.model.SecurityProxy;
    import com.neosavvy.user.view.secured.SecuredContainer;

    import com.neosavvy.user.view.secured.SecuredContainerMediator;
    import com.neosavvy.user.view.secured.employeeInvitation.EmployeeManagementMediator;

    import com.neosavvy.user.view.secured.leftNavigation.LeftNavigationMediator;
    import com.neosavvy.user.view.secured.leftNavigation.admin.AdminNavigationMediator;

    import com.neosavvy.user.view.secured.userManagement.UserManagementMediator;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class SecuredViewPrepCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {
            var securedContainer:SecuredContainer = notification.getBody() as SecuredContainer;
            facade.registerMediator(new SecuredContainerMediator(securedContainer));

            var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;

            if( securityProxy.isActiveUserAdmin() ) {
                // Admin related registrations - these should later be secured and not registered if a user doesn't have necessary roles
                facade.registerMediator(new AdminNavigationMediator(securedContainer.leftNavigation.adminNavigation) );
                facade.registerMediator( new EmployeeManagementMediator( securedContainer.employeeInvitationManagement ) );
                facade.registerMediator( new UserManagementMediator( securedContainer.userManagement ) );
            }


            if( securityProxy.isActiveUserEmployee() || securityProxy.isActiveUserAdmin() ) {
                //User or Admin related registrations -- these are registered regardless of role
                facade.registerMediator( new LeftNavigationMediator( securedContainer.leftNavigation ) );
            }


            sendNotification(ApplicationFacade.POST_SECURE_VIEW_PREP);
        }
    }
}