package com.neosavvy.user.view.secured.projectManagement.assignments {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.ProjectServiceProxy;
    import com.neosavvy.user.view.secured.projectManagement.*;

    import flash.events.MouseEvent;

    import mx.controls.Button;
    import mx.controls.ComboBox;
    import mx.controls.List;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ManageAssignmentsMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.projectManagement.assignments.ManageAssignmentsMediator")

        public static const NAME:String = "manageAssignmentsMediator";

        public function ManageAssignmentsMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        private var _companyProxy:CompanyServiceProxy;
        private var _projectProxy:ProjectServiceProxy;

        override public function onRegister():void {
            _companyProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            _projectProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;

            projectLoadButton.addEventListener(MouseEvent.CLICK, handleProjectLoadButtonClicked);
        }

        override public function onRemove():void {
            _companyProxy = null;
            _projectProxy = null;

            projectLoadButton.removeEventListener(MouseEvent.CLICK, handleProjectLoadButtonClicked);
        }

        public function get manageAssignments():ManageAssignments {
            return viewComponent as ManageAssignments;
        }

        public function get projectSelector():ComboBox {
            return manageAssignments.projectSelector;
        }

        public function get availableEmployees():List {
            return manageAssignments.availableEmployees;
        }

        public function get assignedEmployees():List {
            return manageAssignments.assignedEmployees;
        }

        public function get projectLoadButton():Button {
            return manageAssignments.loadProjectBtn;
        }

        private function handleProjectLoadButtonClicked(event:MouseEvent):void {
            var project:Project = projectSelector.selectedItem as Project;
            sendNotification(ApplicationFacade.INITIALIZE_ASSIGNMENTS_FOR_PROJECT, project);
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_ASSIGNMENTS
                ,ApplicationFacade.INITIALIZE_MANAGE_ASSIGNMENTS_VIEW_COMPLETE
                ,ApplicationFacade.INITIALIZE_ASSIGNMENTS_FOR_PROJECT_COMPLETE
            ];
        }


        override public function handleNotification(notification:INotification):void {
            switch ( notification.getName() ) {
                case ApplicationFacade.NAVIGATE_TO_ASSIGNMENTS:
                    sendNotification(ApplicationFacade.INITIALIZE_MANAGE_ASSIGNMENTS_VIEW);
                    break;
                case ApplicationFacade.INITIALIZE_MANAGE_ASSIGNMENTS_VIEW_COMPLETE:

                    projectSelector.dataProvider = _projectProxy.projects;

                    break;
                case ApplicationFacade.INITIALIZE_ASSIGNMENTS_FOR_PROJECT_COMPLETE:

                    availableEmployees.dataProvider = _projectProxy.availableEmployees;
                    assignedEmployees.dataProvider = _projectProxy.assignedEmployees;

                    break;
            }
        }

    }
}