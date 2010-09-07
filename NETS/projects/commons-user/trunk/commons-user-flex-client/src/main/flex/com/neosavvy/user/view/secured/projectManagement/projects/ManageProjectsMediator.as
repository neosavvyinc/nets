package com.neosavvy.user.view.secured.projectManagement.projects {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.project.ClientCompany;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.model.ClientServiceProxy;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.ProjectServiceProxy;

    import flash.events.MouseEvent;

    import mx.collections.ArrayCollection;
    import mx.controls.AdvancedDataGrid;
    import mx.controls.Button;
    import mx.controls.ComboBox;
    import mx.controls.DataGrid;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ManageProjectsMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.projectManagement.projects.ManageProjectsMediator")

        public static const NAME:String = "manageProjectsMediator";

        public function ManageProjectsMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        private var _companyProxy:CompanyServiceProxy;
        private var _projectProxy:ProjectServiceProxy;
        private var _clientProxy:ClientServiceProxy;

        override public function onRegister():void {
            _companyProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            _projectProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;
            _clientProxy = facade.retrieveProxy(ClientServiceProxy.NAME) as ClientServiceProxy;
            saveProjectButton.addEventListener(MouseEvent.CLICK, handleSaveButtonClickedHandler);
        }

        override public function onRemove():void {
            _companyProxy = null;
            _projectProxy = null;
            _clientProxy = null
        }

        public function get manageProjects():ManageProjects {
            return viewComponent as ManageProjects;
        }

        public function get saveProjectButton():Button {
            return manageProjects.saveProject;
        }

        public function get clientSelectorDropdown():ComboBox {
            return manageProjects.clientSelectorDropdown;
        }

        public function get projectmanagementGrid():DataGrid {
            return manageProjects.projectManagementGrid;
        }


        private function handleSaveButtonClickedHandler(event:MouseEvent):void {
            var activeCompany:CompanyDTO = _companyProxy.activeCompany;
            var project:Project = getProject();
            var clientCompany:ClientCompany = getClientCompany();
            var params:Array = [project,activeCompany, clientCompany];
            sendNotification(ApplicationFacade.SAVE_PROJECT_REQUEST, params);
        }

        private function getClientCompany():ClientCompany {
            return clientSelectorDropdown.selectedItem as ClientCompany;
        }

        private function getProject():Project {
            var project:Project = new Project();
            project.startDate = manageProjects.startDate.selectedDate;
            project.endDate = manageProjects.endDate.selectedDate;
            project.name = manageProjects.projectName.text;
            project.code = manageProjects.projectCode.text;
            return project;
        }

        public function resetForm():void {
            manageProjects.startDate.selectedDate = null;
            manageProjects.startDate.errorString = null;
            manageProjects.endDate.selectedDate = null;
            manageProjects.endDate.errorString = null;
            manageProjects.projectName.text = null;
            manageProjects.projectName.errorString = null;
            manageProjects.projectCode.text = null;
            manageProjects.projectCode.errorString = null;
            manageProjects.ongoingProject.selected = false;
            manageProjects.ongoingProject.errorString = null;
            clientSelectorDropdown.selectedIndex = 0;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_MANAGE_PROJECTS
                ,ApplicationFacade.INITIALIZE_MANAGE_PROJECTS_VIEW_COMPLETE
                ,ApplicationFacade.GET_PROJECTS_FOR_COMPANY_SUCCESS
                ,ApplicationFacade.SAVE_PROJECT_SUCCESS
            ];
        }


        override public function handleNotification(notification:INotification):void {

            switch (notification.getName()) {
                case ApplicationFacade.NAVIGATE_TO_MANAGE_PROJECTS:
                    sendNotification(ApplicationFacade.INITIALIZE_MANAGE_PROJECTS_VIEW);
                    break;
                case ApplicationFacade.INITIALIZE_MANAGE_PROJECTS_VIEW_COMPLETE:
                    manageProjects.clientCompanies = _clientProxy.clientCompanies;
                    resetForm();
                    break;
                case ApplicationFacade.GET_PROJECTS_FOR_COMPANY_SUCCESS:
                    projectmanagementGrid.dataProvider = _projectProxy.projects;
                    break;
                case ApplicationFacade.SAVE_PROJECT_SUCCESS:
                    sendNotification(ApplicationFacade.GET_PROJECTS_FOR_COMPANY_REQUEST);
                    resetForm();
                    break;
                case ApplicationFacade.REQUEST_LOGOUT:
                    resetForm();
                    projectmanagementGrid.dataProvider = null;
                    manageProjects.clientCompanies = null;
                    break;
            }

        }

    }
}