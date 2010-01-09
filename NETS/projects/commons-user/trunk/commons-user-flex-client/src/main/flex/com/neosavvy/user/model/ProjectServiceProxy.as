package com.neosavvy.user.model {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.project.ClientCompany;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.messaging.ChannelSet;
    import mx.messaging.channels.AMFChannel;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.mxml.RemoteObject;

    import org.puremvc.as3.multicore.patterns.proxy.Proxy;

    public class ProjectServiceProxy extends Proxy {
        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.model.ProjectServiceProxy");

        public static var NAME:String = "projectProxy";

        private var remote:Boolean = ProxyConstants.isRemoteEnabled;

        public function ProjectServiceProxy()
        {
            super(NAME, null);
        }

        public function get projects():ArrayCollection {
            return data as ArrayCollection;
        }

        public function addProject(project:Project, company:CompanyDTO, clientCompany:ClientCompany):void {
            var projectService:RemoteObject = getService();
            projectService.addEventListener(ResultEvent.RESULT, handleSaveProjectResult);
            projectService.addEventListener(FaultEvent.FAULT, handleSaveProjectFault);
            projectService.addProject(project,company,clientCompany);
        }

        private function handleSaveProjectFault(event:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);
            sendNotification(ApplicationFacade.SAVE_PROJECT_FAILED);
        }

        private function handleSaveProjectResult(event:ResultEvent):void {
            sendNotification(ApplicationFacade.SAVE_PROJECT_SUCCESS);
        }

        public function findProjectsForCompany(company:CompanyDTO):void {
            var projectService:RemoteObject = getService();
            projectService.addEventListener(ResultEvent.RESULT, handleFindProjectsForCompanyResult);
            projectService.addEventListener(FaultEvent.FAULT, handleFindProjectsForCompanyFault);
            projectService.findProjectsForParentCompany( company );
        }

        private function handleFindProjectsForCompanyResult(event:ResultEvent):void {
            data = event.result as ArrayCollection;
            sendNotification(ApplicationFacade.GET_PROJECTS_FOR_COMPANY_SUCCESS);
        }

        private function handleFindProjectsForCompanyFault(event:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);
            sendNotification(ApplicationFacade.GET_PROJECTS_FOR_COMPANY_FAILED);
        }

        /****
         *
         * Helper functions
         *
         ****/
        private function getServiceChannelSet():ChannelSet {
            var channel:AMFChannel = new AMFChannel(ProxyConstants.channelName, ProxyConstants.url);
            var channelSet:ChannelSet = new ChannelSet();
            channelSet.addChannel(channel);
            return channelSet;
        }

        private function getService():RemoteObject {
            var userService:RemoteObject = new RemoteObject();
            userService.channelSet = getServiceChannelSet();
            userService.destination = ProxyConstants.projectServiceDestiation;
            return userService;
        }


        }
}