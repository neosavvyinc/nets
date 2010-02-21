package com.neosavvy.user.controller.project {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.project.ClientCompany;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.model.ProjectServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import flash.errors.IllegalOperationError;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;

    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class SaveProject extends ResponderAsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.project.SaveProject");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            sendNotification(ApplicationFacade.SHOW_PROGRESS_INDICATOR);
            var projectProxy:ProjectServiceProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;

            if (notification.getBody() is Array && (notification.getBody() as Array).length == 3) {
                var project:Project = notification.getBody()[0];
                var company:CompanyDTO = notification.getBody()[1];
                var clientCompany:ClientCompany = notification.getBody()[2];
                projectProxy.addProject(project, company, clientCompany, this);
            } else {
                throw IllegalOperationError("Parameters to SaveProject must be ")
            }

        }


        override protected function resultHandler(resultEvent:ResultEvent):void {
            sendNotification(ApplicationFacade.SAVE_PROJECT_SUCCESS);
            sendNotification(ApplicationFacade.HIDE_PROGRESS_INDICATOR);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.SAVE_PROJECT_FAILED);
            sendNotification(ApplicationFacade.HIDE_PROGRESS_INDICATOR);
        }
    }
}