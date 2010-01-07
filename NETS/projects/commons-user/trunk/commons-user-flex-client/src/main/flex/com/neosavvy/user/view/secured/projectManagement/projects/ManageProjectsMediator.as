package com.neosavvy.user.view.secured.projectManagement.projects {
    import com.neosavvy.user.view.secured.projectManagement.*;
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.model.ClientServiceProxy;

    import com.neosavvy.user.model.CompanyServiceProxy;

    import com.neosavvy.user.model.ProjectServiceProxy;

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
        private var _projectProject:ProjectServiceProxy;

        override public function onRegister():void {
            _companyProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            _projectProject = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;
        }

        override public function onRemove():void {
            _companyProxy = null;
            _projectProject = null;
        }

        public function get projectManagement():ProjectManagement {
            return viewComponent as ProjectManagement;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_PROJECT_MANAGEMENT
                ,ApplicationFacade.INITIALIZE_MANAGE_PROJECTS_VIEW    
            ];
        }


        override public function handleNotification(notification:INotification):void {

            switch(notification.getName()) {
                case ApplicationFacade.NAVIGATE_TO_PROJECT_MANAGEMENT:
                    sendNotification(ApplicationFacade.INITIALIZE_MANAGE_PROJECTS_VIEW);
                    break;
            }

        }

    }
}