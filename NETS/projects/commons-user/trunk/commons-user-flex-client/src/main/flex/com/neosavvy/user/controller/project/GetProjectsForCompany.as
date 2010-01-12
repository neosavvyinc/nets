package com.neosavvy.user.controller.project {
    import com.neosavvy.user.ApplicationFacade;
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
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class GetProjectsForCompany extends AsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.project.GetProjectsForCompany");

        override public function execute(notification:INotification):void {

            var projectServiceProxy:ProjectServiceProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            projectServiceProxy.findProjectsForCompany(companyServiceProxy.activeCompany, this);

        }

        public function result(data:Object):void {
            var event:ResultEvent = data as ResultEvent;
            var projectServiceProxy:ProjectServiceProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;
            projectServiceProxy.projects = event.result as ArrayCollection;
            sendNotification(ApplicationFacade.GET_PROJECTS_FOR_COMPANY_SUCCESS);
            commandComplete();
        }

        public function fault(info:Object):void {
            var fault:FaultEvent = info as FaultEvent;
            RemoteObjectUtils.logRemoteServiceFault(fault, LOGGER);
            sendNotification(ApplicationFacade.GET_PROJECTS_FOR_COMPANY_FAILED);
            commandComplete();
        }
    }
}