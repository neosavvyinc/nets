package com.neosavvy.user.controller.project {
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.ProjectServiceProxy;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class GetProjectsForCompany extends SimpleCommand {
        override public function execute(notification:INotification):void {

            var projectServiceProxy:ProjectServiceProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            projectServiceProxy.findProjectsForCompany(companyServiceProxy.activeCompany);

        }
    }
}