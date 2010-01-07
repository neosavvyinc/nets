package com.neosavvy.user.model {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;

    import com.neosavvy.user.dto.companyManagement.UserCompanyRoleDTO;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.dto.companyManagement.UserDTO;

    import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
    import com.neosavvy.user.dto.project.ClientCompany;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.model.UserServiceProxy;

    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.collections.ArrayCollection;
    import mx.collections.ListCollectionView;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import mx.messaging.AbstractProducer;
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
        }

        private function handleSaveProjectFault(event:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);
            sendNotification(ApplicationFacade.SAVE_PROJECT_FAILED);
        }

        private function handleSaveProjectResult(event:ResultEvent):void {
            data = event.result as ArrayCollection;
            sendNotification(ApplicationFacade.SAVE_PROJECT_SUCCESS);
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