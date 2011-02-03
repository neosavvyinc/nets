package com.neosavvy.user.view.companyManagement {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.companyManagement.UserDTO;

    import flash.events.MouseEvent;

    import mx.containers.Form;
    import mx.containers.ViewStack;
    import mx.controls.Button;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.validators.Validator;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class SignupMediator extends Mediator implements IMediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.companyManagement.SignupMediator")

        public static const NAME:String = "SignupMediator";

        public static const REGISTRATION_INDEX:Number = 0;
        public static const CONFIRMATION_INDEX:Number = 1;
        public static const CONFIRMATION_SUCCESS_INDEX:Number = 3;
        public static const CONFIRMATION_FAILED_INDEX:Number = 4;

        private var userName:String = null;

        public function SignupMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            signupButton.addEventListener(MouseEvent.CLICK, signupCompanyClicked);
            confirmAccountButton.addEventListener(MouseEvent.CLICK, confirmAccountButtonClickHandler);
            confirmedLoginButton.addEventListener(MouseEvent.CLICK, loginClicked);
        }

        public function get signup():Signup {
            return this.viewComponent as Signup;
        }

        public function get signupButton():Button {
            return signup.signupPanel.signupButton;
        }

        public function get signupViewStack():ViewStack {
            return signup.signupViewStack;
        }

        public function get confirmAccountButton():Button {
            return signup.confirmAccountPanel.confirmAccountButton;
        }

        public function get confirmedLoginButton():Button {
            return signup.successPanel.confirmedLoginButton;
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
                    signupViewStack.selectedIndex = CONFIRMATION_INDEX;
                    signup.confirmAccountPanel.usernameConfirmation.text = userName;
                    if (userName != null && userName.length > 0) {
                        signup.confirmAccountPanel.usernameConfirmation.editable = signup.confirmAccountPanel.usernameConfirmation.enabled = false;
                    }
                    break;
                case ApplicationFacade.SAVE_COMPANY_FAILED:
                    LOGGER.debug("Save company failed");
                    break;
                case ApplicationFacade.CONFIRM_ACCOUNT_FAILED:
                    LOGGER.debug("Account confirmation failed");
                    signupViewStack.selectedIndex = CONFIRMATION_FAILED_INDEX;
                    break;
                case ApplicationFacade.CONFIRM_ACCOUNT_SUCCESS:
                    LOGGER.debug("Account confirmation succeeded");
                    signupViewStack.selectedIndex = CONFIRMATION_SUCCESS_INDEX;
                    break;
            }
        }

        private function signupCompanyClicked(event:MouseEvent):void {
            if (isEmployeeFormValid()) {
                var company:CompanyDTO = new CompanyDTO();
                company.addressOne = signup.signupPanel.addressOne.text;
                company.addressTwo = signup.signupPanel.addressTwo.text;
                company.city = signup.signupPanel.city.text;
                company.companyName = signup.signupPanel.companyName.text;
                company.country = signup.signupPanel.country.selectedItem as String;
                company.postalCode = signup.signupPanel.postalCode.text;

                var user:UserDTO = new UserDTO();
                userName = user.username = signup.signupPanel.administrativeUser.text;
                user.password = signup.signupPanel.administrativePassword.text;
                user.emailAddress = signup.signupPanel.administrativeEmail.text;
                user.firstName = signup.signupPanel.administrativeFirstName.text;
//                user.middleName = signup.signupPanel.administrativeMiddleName.text;
                user.lastName = signup.signupPanel.administrativeLastName.text;
                sendNotification(ApplicationFacade.SAVE_COMPANY_REQUEST, [company,user]);
            }
        }

        private function confirmAccountButtonClickHandler(event:MouseEvent):void {
            var hashCode:String = signup.confirmAccountPanel.confirmationToken.text;
            userName = this.signup.confirmAccountPanel.usernameConfirmation.text;
            sendNotification(ApplicationFacade.CONFIRM_ACCOUNT_REQUEST, [userName, hashCode]);
        }

        private function loginClicked( event:MouseEvent ):void {
            sendNotification(ApplicationFacade.DISPLAY_LOGIN_SCREEN);
        }

        private function isEmployeeFormValid():Boolean {
            var validators:Array = new Array();
            validators.push(signup.signupPanel.companyNameValidator);
            validators.push(signup.signupPanel.addressOneValidator);
            validators.push(signup.signupPanel.cityValidator);
            validators.push(signup.signupPanel.stateValidator);
            validators.push(signup.signupPanel.zipValidator);
            validators.push(signup.signupPanel.adminUserValidator);
            validators.push(signup.signupPanel.adminFirstNameValidator);
            validators.push(signup.signupPanel.adminLastNameValidator);
            validators.push(signup.signupPanel.adminEmailValidator);
            var validationResults:Array = Validator.validateAll(validators);

            for each (var result:Object in validationResults) {
                LOGGER.debug(result.message);
            }

            return validationResults.length == 0 ? true : false;
        }
    }
}