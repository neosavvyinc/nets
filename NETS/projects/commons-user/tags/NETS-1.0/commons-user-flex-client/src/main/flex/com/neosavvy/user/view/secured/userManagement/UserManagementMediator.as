package com.neosavvy.user.view.secured.userManagement {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.view.secured.userManagement.event.UserManagementEvent;

    import flash.events.MouseEvent;

    import mx.collections.ArrayCollection;
    import mx.controls.DataGrid;
    import mx.controls.ToggleButtonBar;
    import mx.events.ItemClickEvent;
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
            userStatusFilterButtonBar.addEventListener(ItemClickEvent.ITEM_CLICK, handleStatusFilterChanged);

//            deactivateAllSelected.addEventListener(MouseEvent.CLICK, handleDeactivateAllSelected);
//            activateAllSelected.addEventListener(MouseEvent.CLICK, handleActivateAllSelected);
            _companyProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
        }

        override public function onRemove():void {
            grid.removeEventListener(UserManagementEvent.TYPE, userManagementEventHandler);
            _companyProxy = null;
        }


        public function get userManagement():UserManagement {
            return viewComponent as UserManagement;
        }

        public function get grid():DataGrid {
            return userManagement.grid;
        }

        public function get userStatusFilterButtonBar():ToggleButtonBar
        {
            return userManagement.userStatusFilterButtonBar;
        }

//        public function get deactivateAllSelected():Button
//        {
//            return userManagement.deactivateAllSelected;
//        }
//
//        public function get activateAllSelected():Button
//        {
//            return userManagement.activateAllSelected;
//        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.ACTIVE_EMPLOYEES_SUCCESS
                ,ApplicationFacade.NON_ACTIVE_EMPLOYEES_SUCCESS
                ,ApplicationFacade.ALL_EMPLOYEES_SUCCESS
                ,ApplicationFacade.SAVE_USER_SUCCESS
                ,ApplicationFacade.REQUEST_LOGOUT
            ];
        }


        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
                case ApplicationFacade.ACTIVE_EMPLOYEES_SUCCESS:
                    _userManagementMode = ApplicationFacade.ACTIVE_EMPLOYEES_SUCCESS;
                    grid.dataProvider = _companyProxy.activeUsersForCompany;
                    break;
                case ApplicationFacade.NON_ACTIVE_EMPLOYEES_SUCCESS:
                    _userManagementMode = ApplicationFacade.NON_ACTIVE_EMPLOYEES_SUCCESS;
                    grid.dataProvider = _companyProxy.inactiveUsersForCompany;
                    break;
                case ApplicationFacade.ALL_EMPLOYEES_SUCCESS:
                    _userManagementMode = ApplicationFacade.ALL_EMPLOYEES_SUCCESS;
                    grid.dataProvider = _companyProxy.allUsersForCompany;
                    break;
                case ApplicationFacade.SAVE_USER_SUCCESS:
                    refreshLastUserNotifcation();
                    break;
                case ApplicationFacade.REQUEST_LOGOUT:
                    grid.dataProvider = null;
                    break;

            }
        }

        private function refreshLastUserNotifcation():void {
            switch (_userManagementMode) {
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


        private function handleStatusFilterChanged(event:ItemClickEvent):void {
            switch ( event.label )
            {
                case "All":
                    sendNotification(ApplicationFacade.ALL_EMPLOYEES_REQUEST);
                    break;
                case "Active":
                    sendNotification(ApplicationFacade.ACTIVE_EMPLOYEES_REQUEST);
                    break;
                case "Inactive":
                    sendNotification(ApplicationFacade.NON_ACTIVE_EMPLOYEES_REQUEST);
                    break;
            }


        }


        private function userManagementEventHandler(event:UserManagementEvent):void {
            switch (event.action) {
                case UserManagementEvent.ACTION_ACTIVATE:
                case UserManagementEvent.ACTION_DEACTIVATE:
                    var userToUpdate:UserDTO = event.user;
                    userToUpdate.active = !userToUpdate.active;
                    sendNotification(ApplicationFacade.SAVE_USER_REQUEST, userToUpdate);
                    break;
                case UserManagementEvent.ACTION_RESET_PASSWORD:
                    var userToReset:UserDTO = event.user;
                    sendNotification(ApplicationFacade.RESET_USER_PASSWORD_REQUEST, userToReset);
                    break;
            }
        }

        private function handleActivateAllSelected(event:MouseEvent):void {

            var selectedItems:ArrayCollection = grid.dataProvider as ArrayCollection;
            for each ( var item:UserDTO in selectedItems )
            {
                item.active = true;
            }
            sendNotification(ApplicationFacade.SAVE_USER_REQUEST, selectedItems);

        }

        private function handleDeactivateAllSelected(event:MouseEvent):void {

            var selectedItems:ArrayCollection = grid.dataProvider as ArrayCollection;
            for each ( var item:UserDTO in selectedItems )
            {
                item.active = false;
            }
            sendNotification(ApplicationFacade.SAVE_USER_REQUEST,selectedItems);

        }
    }
}