package com.neosavvy.user.view.secured.employeeInvitation {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.util.FormUtils;
    import com.neosavvy.user.util.StringUtils;
    import com.neosavvy.user.view.secured.employeeInvitation.event.UserCompanyInviteEvent;

    import flash.events.MouseEvent;

    import mx.containers.VBox;
    import mx.controls.AdvancedDataGrid;
    import mx.controls.Button;
    import mx.controls.Label;
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
                ,ApplicationFacade.REQUEST_LOGOUT
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
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
                case ApplicationFacade.REQUEST_LOGOUT:
                    resetFormEntry();
                    resetFormStylesAndErrors();
                    grid.dataProvider = null;
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

        public function get errorContainer():VBox {
            return employeeManagement.errorContainer;
        }

        private function addUserButtonClickListener(event:MouseEvent):void {
            resetFormStylesAndErrors();
            if (isInvitationValid()) {
                var user:UserInviteDTO = new UserInviteDTO();
                user.firstName = employeeManagement.empFName.text;
                user.lastName = employeeManagement.empLName.text;
                user.emailAddress = employeeManagement.empEmail.text;
                sendNotification(ApplicationFacade.INVITE_USER_TO_COMPANY_REQUEST, user);
                resetFormEntry();
            } else {
                var errorLabel:Label = new Label();
                errorLabel.text = "There are errors in your invitation, please correct them at try again";
                errorContainer.addChild(errorLabel);
            }
        }

        private function resetFormStylesAndErrors():void {
            errorContainer.removeAllChildren();
            employeeManagement.empFName.setStyle("borderColor", 0xAAB3B3);
            employeeManagement.empLName.setStyle("borderColor", 0xAAB3B3);
            employeeManagement.empEmail.setStyle("borderColor", 0xAAB3B3);
        }

        private function resetFormEntry():void {
            employeeManagement.empFName.text = null;
            employeeManagement.empLName.text = null;
            employeeManagement.empEmail.text = null;
        }

        private function isInvitationValid():Boolean {
            var invitationValid:Boolean = true;

            if (!FormUtils.isInputSet(employeeManagement.empFName)) {
                employeeManagement.empFName.setStyle("borderColor", "red");
                employeeManagement.empFName.setStyle("borderStyle", "solid");
                invitationValid = false;
            }

            if (!FormUtils.isInputSet(employeeManagement.empLName)) {
                employeeManagement.empLName.setStyle("borderColor", "red");
                employeeManagement.empLName.setStyle("borderStyle", "solid");
                invitationValid = false;
            }

            if (!FormUtils.isInputSet(employeeManagement.empEmail) ||
                !StringUtils.isValidEmail(employeeManagement.empEmail.text)) {
                employeeManagement.empEmail.setStyle("borderColor", "red");
                employeeManagement.empEmail.setStyle("borderStyle", "solid");
                invitationValid = false;
            }

            return invitationValid;

        }

        private function userCompanyInviteEventHandler(event:UserCompanyInviteEvent):void {
            switch (event.action) {
                case UserCompanyInviteEvent.ACTION_DELETE:
                    sendNotification(ApplicationFacade.DELETE_USER_COMPANY_INVITE, event.userInvite);
                    break;
                case UserCompanyInviteEvent.ACTION_INVITE:
                    sendNotification(ApplicationFacade.SEND_USER_INVITE_REQUEST, event.userInvite);
                    break;
            }

        }


    }
}