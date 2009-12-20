package com.neosavvy.user.controller.secured {
    import com.neosavvy.user.view.secured.SecuredContainer;

    import com.neosavvy.user.view.secured.SecuredContainerMediator;
    import com.neosavvy.user.view.secured.employeeInvitation.EmployeeManagementMediator;

    import com.neosavvy.user.view.secured.leftNavigation.admin.AdminNavigationMediator;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class SecuredViewTeardownCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {
            facade.removeMediator( AdminNavigationMediator.NAME );
            facade.removeMediator( SecuredContainerMediator.NAME );
        }
    }
}