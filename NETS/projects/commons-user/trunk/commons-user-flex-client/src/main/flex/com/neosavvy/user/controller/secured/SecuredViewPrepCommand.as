package com.neosavvy.user.controller.secured {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.model.SecurityProxy;
    import com.neosavvy.user.view.secured.SecuredContainer;
    import com.neosavvy.user.view.secured.SecuredContainerMediator;
    import com.neosavvy.user.view.secured.clientManagement.ClientManagementMediator;
    import com.neosavvy.user.view.secured.employeeInvitation.EmployeeManagementMediator;
    import com.neosavvy.user.view.secured.expenses.approved.ApprovedExpenseReportMediator;
    import com.neosavvy.user.view.secured.expenses.open.OpenExpenseReportMediator;
    import com.neosavvy.user.view.secured.expenses.reconcile.ReconcileExpenseReportMediator;
    import com.neosavvy.user.view.secured.expenses.report.ExpenseReportDetailMediator;
    import com.neosavvy.user.view.secured.leftNavigation.LeftNavigationMediator;
    import com.neosavvy.user.view.secured.leftNavigation.admin.AdminNavigationMediator;
    import com.neosavvy.user.view.secured.leftNavigation.employee.EmployeeNavigationMediator;
    import com.neosavvy.user.view.secured.projectManagement.ProjectManagementMediator;
    import com.neosavvy.user.view.secured.projectManagement.assignments.ManageAssignmentsMediator;
    import com.neosavvy.user.view.secured.projectManagement.projects.ManageProjectsMediator;
    import com.neosavvy.user.view.secured.userManagement.UserManagementMediator;

    import com.neosavvy.user.view.secured.welcome.WelcomeMediator;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class SecuredViewPrepCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {
            var securedContainer:SecuredContainer = notification.getBody() as SecuredContainer;

            if (!facade.hasMediator(SecuredContainerMediator.NAME))
                facade.registerMediator(new SecuredContainerMediator(securedContainer));

            var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;

            if (securityProxy.isActiveUserAdmin()) {
                // Admin related registrations - these should later be secured and not registered if a user doesn't have necessary roles
                if (!facade.hasMediator(AdminNavigationMediator.NAME))
                    facade.registerMediator(new AdminNavigationMediator(securedContainer.leftNavigation.adminNavigation));

                if (!facade.hasMediator(WelcomeMediator.NAME))
                    facade.registerMediator(new WelcomeMediator(securedContainer.welcomeContainer));
                
                if (!facade.hasMediator(EmployeeManagementMediator.NAME))
                    facade.registerMediator(new EmployeeManagementMediator(securedContainer.employeeInvitationManagement));

                if (!facade.hasMediator(UserManagementMediator.NAME))
                    facade.registerMediator(new UserManagementMediator(securedContainer.userManagement));

                if (!facade.hasMediator(ClientManagementMediator.NAME))
                    facade.registerMediator(new ClientManagementMediator(securedContainer.clientManagement));

                if (!facade.hasMediator(ProjectManagementMediator.NAME))
                    facade.registerMediator(new ProjectManagementMediator(securedContainer.projectManagement));

                if (!facade.hasMediator(ManageProjectsMediator.NAME))
                    facade.registerMediator(new ManageProjectsMediator(securedContainer.projectManagement.manageProjectsTab));

                if (!facade.hasMediator(ManageAssignmentsMediator.NAME))
                    facade.registerMediator(new ManageAssignmentsMediator(securedContainer.projectManagement.manageAssignments));

            }


            if (securityProxy.isActiveUserEmployee() || securityProxy.isActiveUserAdmin()) {
                //User or Admin related registrations -- these are registered regardless of role
                if (!facade.hasMediator(LeftNavigationMediator.NAME))
                    facade.registerMediator(new LeftNavigationMediator(securedContainer.leftNavigation));

                if (!facade.hasMediator(EmployeeNavigationMediator.NAME))
                    facade.registerMediator(new EmployeeNavigationMediator(securedContainer.leftNavigation.employeeNavigation));

                if (!facade.hasMediator(ApprovedExpenseReportMediator.NAME))
                    facade.registerMediator(new ApprovedExpenseReportMediator(securedContainer.expenseReportDetail));

                if (!facade.hasMediator(OpenExpenseReportMediator.NAME))
                    facade.registerMediator(new OpenExpenseReportMediator(securedContainer.openExpenseReportDetail));

                if (!facade.hasMediator(ReconcileExpenseReportMediator.NAME))
                    facade.registerMediator(new ReconcileExpenseReportMediator(securedContainer.reconcileExpenseReports));
                                
                if (!facade.hasMediator(ExpenseReportDetailMediator.NAME))
                    facade.registerMediator(new ExpenseReportDetailMediator(securedContainer.expenseReportDetail));
            }


            sendNotification(ApplicationFacade.POST_SECURE_VIEW_PREP);
        }
    }
}