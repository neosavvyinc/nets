package com.neosavvy.user.controller.project {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.ProjectServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class GetAssignedUsersForProject extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.project.GetAssignedUsersForProject");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var projectServiceProxy:ProjectServiceProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;
            projectServiceProxy.findAssignedUsersForProject(notification.getBody() as Project, this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var projectServiceProxy:ProjectServiceProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;
            projectServiceProxy.assignedEmployees = resultEvent.result as ArrayCollection;
            sendNotification(ApplicationFacade.GET_ASSIGNED_USERS_FOR_PROJECT_SUCCESS);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.GET_ASSIGNED_USERS_FOR_PROJECT_FAILED);
        }
        
    }
}