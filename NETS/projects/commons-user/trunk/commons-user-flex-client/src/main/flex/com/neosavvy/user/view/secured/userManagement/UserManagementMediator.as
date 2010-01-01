package com.neosavvy.user.view.secured.userManagement {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.UserDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;

    import com.neosavvy.user.view.secured.userManagement.event.UserManagementEvent;

    import flash.events.Event;

    import mx.controls.AdvancedDataGrid;
    import mx.events.ListEvent;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class UserManagementMediator extends Mediator implements IMediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.userManagement.UserManagementMediator")

        public static const NAME:String = "UserManagementMediator";

        public function UserManagementMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        private var _companyProxy:CompanyServiceProxy;

        private var _userManagementMode:String;

        override public function onRegister():void {
            grid.addEventListener(UserManagementEvent.TYPE, userManagementEventHandler);
            _companyProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
        }

        override public function onRemove():void {
            grid.removeEventListener(UserManagementEvent.TYPE, userManagementEventHandler);
            _companyProxy = null;
        }


        public function get userManagement():UserManagement {
            return viewComponent as UserManagement;
        }

        public function get grid():AdvancedDataGrid {
            return userManagement.grid;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.ACTIVE_EMPLOYEES_SUCCESS
                ,ApplicationFacade.NON_ACTIVE_EMPLOYEES_SUCCESS
                ,ApplicationFacade.ALL_EMPLOYEES_SUCCESS
                ,ApplicationFacade.SAVE_USER_SUCCESS
            ];
        }


        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
                case ApplicationFacade.ACTIVE_EMPLOYEES_SUCCESS:
                    _userManagementMode = ApplicationFacade.ACTIVE_EMPLOYEES_SUCCESS;
                    grid.dataProvider = _companyProxy.activeUsersForCompany;
                    userManagement.title = "Viewing All Active Employees (" + _companyProxy.activeCompany.companyName + ")";
                    break;
                case ApplicationFacade.NON_ACTIVE_EMPLOYEES_SUCCESS:
                    _userManagementMode = ApplicationFacade.NON_ACTIVE_EMPLOYEES_SUCCESS;
                    grid.dataProvider = _companyProxy.inactiveUsersForCompany;
                    userManagement.title = "Viewing All Inactive Employees (" + _companyProxy.activeCompany.companyName + ")";
                    break;
                case ApplicationFacade.ALL_EMPLOYEES_SUCCESS:
                    _userManagementMode = ApplicationFacade.ALL_EMPLOYEES_SUCCESS;
                    grid.dataProvider = _companyProxy.allUsersForCompany;
                    userManagement.title = "Viewing All Employees (" + _companyProxy.activeCompany.companyName + ")";
                    break;
                case ApplicationFacade.SAVE_USER_SUCCESS:
                    refreshLastUserNotifcation();
                    break;

            }
        }

        private function refreshLastUserNotifcation():void {
            switch(_userManagementMode) {
                case ApplicationFacade.ACTIVE_EMPLOYEES_SUCCESS:
                    sendNotification(ApplicationFacade.ACTIVE_EMPLOYEES_REQUEST);
                    break;
                case ApplicationFacade.NON_ACTIVE_EMPLOYEES_SUCCESS:
                    sendNotification(ApplicationFacade.NON_ACTIVE_EMPLOYEES_REQUEST);
                    break;
                case ApplicationFacade.ALL_EMPLOYEES_SUCCESS:
                    sendNotification(ApplicationFacade.ALL_EMPLOYEES_REQUEST);
                    break;
            }
        }


        private function userManagementEventHandler(event:UserManagementEvent):void {
             switch ( event.action ) {
                case UserManagementEvent.ACTION_ACTIVATE:
                case UserManagementEvent.ACTION_DEACTIVATE:
                    var userToUpdate:UserDTO = event.user;
                    userToUpdate.active = !userToUpdate.active;
                    sendNotification(ApplicationFacade.SAVE_USER_REQUEST, userToUpdate );
                    break;
            }
        }
    }
}