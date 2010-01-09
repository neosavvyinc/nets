package com.neosavvy.user.controller.project {
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.project.ClientCompany;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.model.ProjectServiceProxy;
    import com.neosavvy.user.model.ProjectServiceProxy;

    import flash.errors.IllegalOperationError;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class SaveProject extends SimpleCommand {
        override public function execute(notification:INotification):void {

            var projectProxy:ProjectServiceProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;

            if( notification.getBody() is Array && (notification.getBody() as Array).length == 3 ) {
                var project:Project = notification.getBody()[0];
                var company:CompanyDTO = notification.getBody()[1];
                var clientCompany:ClientCompany = notification.getBody()[2];
                projectProxy.addProject(project, company, clientCompany);
            } else {
                throw IllegalOperationError("Parameters to SaveProject must be ")
            }

        }
    }
}