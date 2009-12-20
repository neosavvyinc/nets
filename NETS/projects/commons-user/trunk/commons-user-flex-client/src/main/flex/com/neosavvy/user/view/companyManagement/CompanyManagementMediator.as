package com.neosavvy.user.view.companyManagement {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.CompanyDTO;

    import com.neosavvy.user.dto.NumEmployeesRangeDTO;

    import com.neosavvy.user.dto.UserDTO;

    import flash.events.MouseEvent;

    import mx.containers.ViewStack;
    import mx.controls.Button;
    import mx.controls.RadioButtonGroup;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class CompanyManagementMediator extends Mediator implements IMediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.companyManagement.CompanyManagementMediator")

        public static const NAME:String = "CompanyManagementMediator";

        public static const REGISTRATION_INDEX:Number = 0;
        public static const CONFIRMATION_INDEX:Number = 1;
        public static const CONFIRMATION_SUCCESS_INDEX:Number = 2;
        public static const CONFIRMATION_FAILED_INDEX:Number = 3;

        private var userName:String = null;

        public function CompanyManagementMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            registerButton.addEventListener(MouseEvent.CLICK, registerCompanyButtonClickHandler);
            confirmAccountButton.addEventListener(MouseEvent.CLICK, confirmAccountButtonClickHandler);
            loginButton.addEventListener(MouseEvent.CLICK, loginButtonClickHandler);
        }

        public function get companyManagement():CompanyManagement {
            return this.viewComponent as CompanyManagement;
        }

        public function get registerButton():Button {
            return companyManagement.registerCompanyButton;
        }

        public function get confirmAccountButton():Button {
            return companyManagement.confirmAccountButton;
        }

        public function get companyManavementViewStack():ViewStack {
            return companyManagement.companyRegistrationProcessViewStack;
        }

        public function get loginButton():Button {
            return companyManagement.loginButton;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.SAVE_COMPANY_FAILED
                ,ApplicationFacade.SAVE_COMPANY_SUCCESS
                ,ApplicationFacade.CONFIRM_ACCOUNT_FAILED
                ,ApplicationFacade.CONFIRM_ACCOUNT_SUCCESS
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
                case ApplicationFacade.SAVE_COMPANY_SUCCESS:
                    LOGGER.debug("Save company succeeded");
                    companyManavementViewStack.selectedIndex = CONFIRMATION_INDEX;
                    break;
                case ApplicationFacade.SAVE_COMPANY_FAILED:
                    LOGGER.debug("Save company failed");
                    break;
                case ApplicationFacade.CONFIRM_ACCOUNT_FAILED:
                    LOGGER.debug("Account confirmation failed");
                    companyManavementViewStack.selectedIndex = CONFIRMATION_FAILED_INDEX;
                    break;
                case ApplicationFacade.CONFIRM_ACCOUNT_SUCCESS:
                    LOGGER.debug("Account confirmation succeeded");
                    companyManavementViewStack.selectedIndex = CONFIRMATION_SUCCESS_INDEX;
                    break;
            }
        }

        private function registerCompanyButtonClickHandler(event:MouseEvent):void {
            var company:CompanyDTO = new CompanyDTO();
            company.addressOne = companyManagement.addressOne.text;
            company.addressTwo = companyManagement.addressTwo.text;
            company.city = companyManagement.city.text;
            company.companyName = companyManagement.companyName.text;
            company.country = companyManagement.country.selectedItem as String;
            company.postalCode = companyManagement.postalCode.text;
            company.numEmployeesRange = new NumEmployeesRangeDTO();

            var radioButtonGroup:RadioButtonGroup = companyManagement.numberOfEmployeesGroup;
            var selectedValue:Object = radioButtonGroup.selectedValue;
            var numEmployeesSelected:String = selectedValue as String;
            if (numEmployeesSelected.indexOf(">") == -1) {
                company.numEmployeesRange.rangeFrom = numEmployeesSelected.split("-")[0] as Number;
                company.numEmployeesRange.rangeTo = numEmployeesSelected.split("-")[1] as Number;
            } else {
                company.numEmployeesRange.rangeFrom = 10001;
                company.numEmployeesRange.rangeTo = Number.MAX_VALUE;
            }

            var user:UserDTO = new UserDTO();
            userName = user.username = companyManagement.administrativeUser.text;
            user.password = companyManagement.administrativePassword.text;
            user.emailAddress = companyManagement.administrativeEmail.text;
            user.firstName = companyManagement.administrativeFirstName.text;
            user.middleName = companyManagement.administrativeMiddleName.text;
            user.lastName = companyManagement.administrativeLastName.text;
            sendNotification(ApplicationFacade.SAVE_COMPANY_REQUEST, [company,user]);
        }


        private function confirmAccountButtonClickHandler(event:MouseEvent):void {
            var hashCode:String = companyManagement.confirmationToken.text;
            sendNotification(ApplicationFacade.CONFIRM_ACCOUNT_REQUEST, [userName, hashCode]);
        }


        private function loginButtonClickHandler(event:MouseEvent):void {
            sendNotification(ApplicationFacade.CHECK_USER_LOGGED_IN);
        }


    }
}