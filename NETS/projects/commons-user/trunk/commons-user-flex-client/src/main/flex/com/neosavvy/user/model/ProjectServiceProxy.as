package com.neosavvy.user.model {
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.project.ClientCompany;
    import com.neosavvy.user.dto.project.Project;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.remoting.mxml.RemoteObject;

    public class ProjectServiceProxy extends AbstractRemoteObjectProxy {
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

        public function set projects(value:ArrayCollection):void {
            data = value;
        }


        public function addProject(project:Project, company:CompanyDTO, clientCompany:ClientCompany, responder:IResponder):void {
            var projectService:RemoteObject = getService(ProxyConstants.projectServiceDestiation);
            addCallbackHandler(projectService, responder);
            projectService.addProject(project, company, clientCompany);
        }


        public function findProjectsForCompany(company:CompanyDTO, responder:IResponder):void {
            var projectService:RemoteObject = getService(ProxyConstants.projectServiceDestiation);
            addCallbackHandler(projectService, responder);
            projectService.findProjectsForParentCompany(company);
        }
    }
}
