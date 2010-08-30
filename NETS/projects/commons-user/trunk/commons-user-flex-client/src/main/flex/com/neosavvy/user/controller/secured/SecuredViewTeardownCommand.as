package com.neosavvy.user.controller.secured {
    import com.neosavvy.user.model.ClientServiceProxy;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.ProjectServiceProxy;
    import com.neosavvy.user.model.SecurityProxy;
    import com.neosavvy.user.model.UserServiceProxy;
    import com.neosavvy.user.view.secured.SecuredContainerMediator;
    import com.neosavvy.user.view.secured.clientManagement.ClientManagementMediator;
    import com.neosavvy.user.view.secured.employeeInvitation.EmployeeManagementMediator;
    import com.neosavvy.user.view.secured.expenses.approving.ExpenseReportApprovalPopupMediator;
    import com.neosavvy.user.view.secured.expenses.approving.ExpenseReportAwaitingApprovalMediator;
    import com.neosavvy.user.view.secured.leftNavigation.admin.AdminNavigationMediator;
    import com.neosavvy.user.view.secured.leftNavigation.employee.EmployeeNavigationMediator;
    import com.neosavvy.user.view.secured.projectManagement.ProjectManagementMediator;
    import com.neosavvy.user.view.secured.projectManagement.assignments.ManageAssignmentsMediator;
    import com.neosavvy.user.view.secured.projectManagement.projects.ManageProjectsMediator;

    import com.neosavvy.user.view.secured.welcome.WelcomeMediator;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class SecuredViewTeardownCommand extends SimpleCommand {

        protected function cleanupMediators():void {
            if (facade.hasMediator(EmployeeManagementMediator.NAME))
                facade.removeMediator(EmployeeManagementMediator.NAME);

            if (facade.hasMediator(AdminNavigationMediator.NAME))
                facade.removeMediator(AdminNavigationMediator.NAME);

            if (!facade.hasMediator(EmployeeNavigationMediator.NAME))
                facade.removeMediator(EmployeeNavigationMediator.NAME);

            if (facade.hasMediator(WelcomeMediator.NAME))
                facade.removeMediator(WelcomeMediator.NAME);

            if (facade.hasMediator(SecuredContainerMediator.NAME))
                facade.removeMediator(SecuredContainerMediator.NAME);

            if (facade.hasMediator(ClientManagementMediator.NAME))
                facade.removeMediator(ClientManagementMediator.NAME);

            if (facade.hasMediator(ProjectManagementMediator.NAME))
                facade.removeMediator(ProjectManagementMediator.NAME);

            if (facade.hasMediator(ManageProjectsMediator.NAME))
                facade.removeMediator(ManageProjectsMediator.NAME);

            if (facade.hasMediator(ManageAssignmentsMediator.NAME))
                facade.removeMediator(ManageAssignmentsMediator.NAME);

            if (facade.hasMediator(ExpenseReportAwaitingApprovalMediator.NAME))
                facade.removeMediator(ExpenseReportAwaitingApprovalMediator.NAME);

            if (facade.hasMediator(ExpenseReportApprovalPopupMediator.NAME))
                facade.removeMediator(ExpenseReportApprovalPopupMediator.NAME);
        }

        protected function cleanupProxies():void {

            var clientServiceProxy:ClientServiceProxy = facade.retrieveProxy(ClientServiceProxy.NAME) as ClientServiceProxy;
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var projectServiceProxy:ProjectServiceProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;
            var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
            var userServiceProxy:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;

            clientServiceProxy.clearCachedValues();
            companyServiceProxy.clearCachedValues();
            projectServiceProxy.clearCachedValues();
            securityProxy.clearCachedValues();
            userServiceProxy.clearCachedValues();

        }

        override public function execute(notification:INotification):void {
            cleanupMediators();
            cleanupProxies()
        }
    }
}