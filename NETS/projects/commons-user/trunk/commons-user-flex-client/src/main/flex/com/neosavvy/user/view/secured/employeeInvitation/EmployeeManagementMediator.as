package com.neosavvy.user.view.secured.employeeInvitation {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.CompanyDTO;
    import com.neosavvy.user.dto.UserDTO;

    import com.neosavvy.user.dto.UserInviteDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.CompanyServiceProxy;

    import com.neosavvy.user.view.secured.employeeInvitation.event.UserCompanyInviteEvent;

    import flash.events.MouseEvent;

    import flash.ui.Mouse;

    import mx.collections.ArrayCollection;
    import mx.controls.AdvancedDataGrid;
    import mx.controls.Button;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class EmployeeManagementMediator extends Mediator implements IMediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.employeeInvitation.EmployeeManagementMediator")

        public static const NAME:String = "employeeManagementMediator";

        private var _companyProxy:CompanyServiceProxy;

        public function EmployeeManagementMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            addUserButton.addEventListener(MouseEvent.CLICK, addUserButtonClickListener);
            grid.addEventListener(UserCompanyInviteEvent.TYPE, userCompanyInviteEventHandler);
            _companyProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
        }

        override public function onRemove():void {
            addUserButton.removeEventListener(MouseEvent.CLICK, addUserButtonClickListener);
            grid.removeEventListener(UserCompanyInviteEvent.TYPE, userCompanyInviteEventHandler);
            _companyProxy = null;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.GET_INVITED_USERS_SUCCESS
                ,ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES
                ,ApplicationFacade.INVITE_USER_TO_COMPANY_SUCCESS
                ,ApplicationFacade.DELETE_USER_COMPANY_INVITE_SUCCESS
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch ( notification.getName() ) {
                case ApplicationFacade.GET_INVITED_USERS_SUCCESS:
                    grid.dataProvider = _companyProxy.invitedUsersForActiveCompany;
                    break;
                case ApplicationFacade.DELETE_USER_COMPANY_INVITE_SUCCESS:
                    sendNotification(ApplicationFacade.GET_INVITED_USERS_REQUEST);
                    break;
                case ApplicationFacade.INVITE_USER_TO_COMPANY_SUCCESS:
                    sendNotification(ApplicationFacade.GET_INVITED_USERS_REQUEST);
                    break;
                case ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES:
                    sendNotification(ApplicationFacade.GET_INVITED_USERS_REQUEST);
                    break;
            }
        }

        public function get employeeManagement():EmployeeManagement {
            return viewComponent as EmployeeManagement;
        }

        public function get addUserButton():Button {
            return employeeManagement.addUserButton;
        }

        public function get grid():AdvancedDataGrid {
            return employeeManagement.employeesQueuedToInvite;
        }

        private function addUserButtonClickListener(event:MouseEvent):void {
            LOGGER.debug(">>>>>>>>Adding user");

            var user:UserInviteDTO = new UserInviteDTO();
            user.firstName = employeeManagement.empFName.text;
            user.lastName = employeeManagement.empLName.text;
            user.emailAddress = employeeManagement.empEmail.text;
            sendNotification(ApplicationFacade.INVITE_USER_TO_COMPANY_REQUEST,user);
        }
        
        private function userCompanyInviteEventHandler(event:UserCompanyInviteEvent):void {
            switch ( event.action ) {
                case UserCompanyInviteEvent.ACTION_DELETE:
                    sendNotification(ApplicationFacade.DELETE_USER_COMPANY_INVITE, event.userInvite);
                    break;
            }

        }


    }
}