package com.neosavvy.user.view.secured.projectManagement {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.ProjectServiceProxy;

    import mx.containers.TabNavigator;
    import mx.events.IndexChangedEvent;
    import mx.events.ItemClickEvent;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ProjectManagementMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.projectManagement.ProjectManagementMediator")

        public static const NAME:String = "projectManagementMediator";

        public function ProjectManagementMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        public static const MANAGE_PROJECTS_NAV_INDEX:int = 0;
        public static const MANAGE_ASSIGNMENTS_NAV_INDEX:int = 1;

        private var _previousIndex:int = MANAGE_PROJECTS_NAV_INDEX;

        private var _companyProxy:CompanyServiceProxy;
        private var _projectProject:ProjectServiceProxy;

        override public function onRegister():void {
            _companyProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            _projectProject = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;

            projectManagementTabNavigator.addEventListener(IndexChangedEvent.CHANGE, handleProjectManagementTabNavigatorClicked);
        }

        override public function onRemove():void {
            _companyProxy = null;
            _projectProject = null;
        }

        public function get projectManagement():ProjectManagement {
            return viewComponent as ProjectManagement;
        }

        public function get projectManagementTabNavigator():TabNavigator {
            return projectManagement.projectManagementTabNavigator;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_PROJECT_MANAGEMENT
            ];
        }

        override public function handleNotification(notification:INotification):void {

        }

        private function handleProjectManagementTabNavigatorClicked(event:IndexChangedEvent):void {

            switch (projectManagementTabNavigator.selectedIndex) {
                case MANAGE_PROJECTS_NAV_INDEX:
                    sendNotification(ApplicationFacade.NAVIGATE_TO_MANAGE_PROJECTS);
                    break;
                case MANAGE_ASSIGNMENTS_NAV_INDEX:
                    sendNotification(ApplicationFacade.NAVIGATE_TO_ASSIGNMENTS);
                    break;
            }

        }


    }
}