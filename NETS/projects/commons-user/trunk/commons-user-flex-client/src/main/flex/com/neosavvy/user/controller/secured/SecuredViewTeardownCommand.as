package com.neosavvy.user.controller.secured {
    import com.neosavvy.user.view.secured.SecuredContainer;

    import com.neosavvy.user.view.secured.SecuredContainerMediator;
    import com.neosavvy.user.view.secured.clientManagement.ClientManagementMediator;
    import com.neosavvy.user.view.secured.employeeInvitation.EmployeeManagementMediator;

    import com.neosavvy.user.view.secured.leftNavigation.admin.AdminNavigationMediator;

    import com.neosavvy.user.view.secured.projectManagement.ProjectManagementMediator;

    import com.neosavvy.user.view.secured.projectManagement.assignments.ManageAssignmentsMediator;
    import com.neosavvy.user.view.secured.projectManagement.projects.ManageProjectsMediator;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class SecuredViewTeardownCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {
            if(facade.hasMediator(EmployeeManagementMediator.NAME))
                facade.removeMediator( EmployeeManagementMediator.NAME );

            if(facade.hasMediator(AdminNavigationMediator.NAME))
                facade.removeMediator( AdminNavigationMediator.NAME );

            if(facade.hasMediator(SecuredContainerMediator.NAME))
                facade.removeMediator( SecuredContainerMediator.NAME );

            if(facade.hasMediator(ClientManagementMediator.NAME))
                facade.removeMediator( ClientManagementMediator.NAME );

            if(facade.hasMediator(ProjectManagementMediator.NAME))
                facade.removeMediator( ProjectManagementMediator.NAME );

            if(facade.hasMediator(ManageProjectsMediator.NAME))
                facade.removeMediator( ManageProjectsMediator.NAME );

            if(facade.hasMediator(ManageAssignmentsMediator.NAME))
                facade.removeMediator( ManageAssignmentsMediator.NAME );
        }
    }
}