package com.neosavvy.user.model {
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
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

        public function ProjectServiceProxy()
        {
            super(NAME, null, ProxyConstants.expenseContextRoot);
        }

        public function get projects():ArrayCollection {
            return data as ArrayCollection;
        }

        public function set projects(value:ArrayCollection):void {
            data = value;
        }

        override public function clearCachedValues():void {
            data = null;
        }

        private var _availableEmployees:ArrayCollection;

        private var _assignedEmployees:ArrayCollection;

        public function get availableEmployees():ArrayCollection {
            return _availableEmployees;
        }

        public function set availableEmployees(value:ArrayCollection):void {
            _availableEmployees = value;
        }

        public function get assignedEmployees():ArrayCollection {
            return _assignedEmployees;
        }

        public function set assignedEmployees(value:ArrayCollection):void {
            _assignedEmployees = value;
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

        public function findAvailableUsersForProject(project:Project, responder:IResponder):void {
            var projectService:RemoteObject = getService(ProxyConstants.projectServiceDestiation);
            addCallbackHandler(projectService, responder);
            projectService.findAvailableUsersForProject(project);
        }

        public function findAssignedUsersForProject(project:Project, responder:IResponder):void {
            var projectService:RemoteObject = getService(ProxyConstants.projectServiceDestiation);
            addCallbackHandler(projectService, responder);
            projectService.findAssignedUsersForProject(project);
        }

        public function saveProjectAssignments(project:Project, assignments:ArrayCollection, responder:IResponder):void {
            var projectService:RemoteObject = getService(ProxyConstants.projectServiceDestiation);
            addCallbackHandler(projectService, responder);
            projectService.saveProjectAssignments(project, assignments);
        }

        public function findProjectsForUser(activeUser:UserDTO, responder:IResponder):void {
            var projectService:RemoteObject = getService(ProxyConstants.projectServiceDestiation);
            addCallbackHandler(projectService, responder);
            projectService.findProjectsForUser(activeUser);
        }
    }
}
