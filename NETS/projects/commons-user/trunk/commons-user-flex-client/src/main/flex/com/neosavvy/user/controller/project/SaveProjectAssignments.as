package com.neosavvy.user.controller.project {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.project.ClientCompany;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.model.ProjectServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import flash.errors.IllegalOperationError;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;

    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class SaveProjectAssignments extends ResponderAsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.project.SaveProject");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            sendNotification(ApplicationFacade.SHOW_PROGRESS_INDICATOR);
            var projectProxy:ProjectServiceProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;

            if (notification.getBody() is Array && (notification.getBody() as Array).length == 2) {
                var project:Project = notification.getBody()[0];
                var assignments:ArrayCollection = notification.getBody()[1];
                projectProxy.saveProjectAssignments(project, assignments, this);
            } else {
                throw IllegalOperationError("There must be a project and an assignments array to save project assignments");
            }

        }


        override protected function resultHandler(resultEvent:ResultEvent):void {
            sendNotification(ApplicationFacade.SAVE_PROJECT_ASSIGNMENTS_SUCCESS);
            sendNotification(ApplicationFacade.HIDE_PROGRESS_INDICATOR);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.SAVE_PROJECT_ASSIGNMENTS_FAILED);
            sendNotification(ApplicationFacade.HIDE_PROGRESS_INDICATOR);
        }
    }
}