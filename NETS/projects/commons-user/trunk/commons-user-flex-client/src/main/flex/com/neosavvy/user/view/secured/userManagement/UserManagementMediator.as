package com.neosavvy.user.view.secured.userManagement {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.UserDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;

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


        override public function onRegister():void {
            grid.addEventListener(ListEvent.ITEM_CLICK, handleGridItemClicked);
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
                ,ApplicationFacade.NON_ACTIVE_EMPLOYEES_REQUEST
                ,ApplicationFacade.ALL_EMPLOYEES_SUCCESS
            ];
        }

        private function getCompanyProxy():CompanyServiceProxy {
            return facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
        }

        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
                case ApplicationFacade.ACTIVE_EMPLOYEES_SUCCESS:
                    grid.dataProvider = getCompanyProxy().activeUsersForCompany;
                    userManagement.title = "Viewing All Active Employees (" + getCompanyProxy().activeCompany.companyName + ")";
                    break;
                case ApplicationFacade.NON_ACTIVE_EMPLOYEES_REQUEST:
                    grid.dataProvider = getCompanyProxy().inactiveUsersForCompany;
                    userManagement.title = "Viewing All Inactive Employees (" + getCompanyProxy().activeCompany.companyName + ")";
                    break;
                case ApplicationFacade.ALL_EMPLOYEES_SUCCESS:
                    grid.dataProvider = getCompanyProxy().allUsersForCompany;
                    userManagement.title = "Viewing All Employees (" + getCompanyProxy().activeCompany.companyName + ")";
                    break;

            }
        }

        protected function handleGridItemClicked(event:Event):void {
            var selectedItem:UserDTO = grid.selectedItem as UserDTO;
            userManagement.fName.text = selectedItem.firstName;
            userManagement.mName.text = selectedItem.middleName;
            userManagement.lName.text = selectedItem.lastName;
            userManagement.username.text = selectedItem.username;
            userManagement.password.text = selectedItem.password;
            userManagement.identifier.text = String(selectedItem.id);
        }


    }
}