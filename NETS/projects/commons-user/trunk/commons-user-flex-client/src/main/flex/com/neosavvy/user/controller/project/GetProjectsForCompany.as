package com.neosavvy.user.controller.project {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.ProjectServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class GetProjectsForCompany extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.project.GetProjectsForCompany");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var projectServiceProxy:ProjectServiceProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            projectServiceProxy.findProjectsForCompany(companyServiceProxy.activeCompany, this);

        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var projectServiceProxy:ProjectServiceProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;
            projectServiceProxy.projects = resultEvent.result as ArrayCollection;
            sendNotification(ApplicationFacade.GET_PROJECTS_FOR_COMPANY_SUCCESS);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.GET_PROJECTS_FOR_COMPANY_FAILED);
        }
        
    }
}