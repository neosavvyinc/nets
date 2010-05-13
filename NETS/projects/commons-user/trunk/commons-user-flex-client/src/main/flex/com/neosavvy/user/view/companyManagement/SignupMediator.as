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
        public static const CONFIRMATION_SUCCESS_INDEX:Number = 2;
        public static const CONFIRMATION_FAILED_INDEX:Number = 3;

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
            return signup.signupButton;
        }

        public function get signupViewStack():ViewStack {
            return signup.signupViewStack;
        }

        public function get confirmAccountButton():Button {
            return signup.confirmAccountButton;
        }

        public function get confirmedLoginButton():Button {
            return signup.confirmedLoginButton;
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
                    signup.usernameConfirmation.text = userName;
                    if (userName != null && userName.length > 0) {
                        signup.usernameConfirmation.editable = signup.usernameConfirmation.enabled = false;
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
                company.addressOne = signup.addressOne.text;
                company.addressTwo = signup.addressTwo.text;
                company.city = signup.city.text;
                company.companyName = signup.companyName.text;
                company.country = signup.country.selectedItem as String;
                company.postalCode = signup.postalCode.text;

                var user:UserDTO = new UserDTO();
                userName = user.username = signup.administrativeUser.text;
                user.password = signup.administrativePassword.text;
                user.emailAddress = signup.administrativeEmail.text;
                user.firstName = signup.administrativeFirstName.text;
                user.middleName = signup.administrativeMiddleName.text;
                user.lastName = signup.administrativeLastName.text;
                sendNotification(ApplicationFacade.SAVE_COMPANY_REQUEST, [company,user]);
            }
        }

        private function confirmAccountButtonClickHandler(event:MouseEvent):void {
            var hashCode:String = signup.confirmationToken.text;
            userName = this.signup.usernameConfirmation.text;
            sendNotification(ApplicationFacade.CONFIRM_ACCOUNT_REQUEST, [userName, hashCode]);
        }

        private function loginClicked( event:MouseEvent ):void {
            sendNotification(ApplicationFacade.DISPLAY_LOGIN_SCREEN);
        }

        private function isEmployeeFormValid():Boolean {
            var validators:Array = new Array();
            validators.push(signup.companyNameValidator);
            validators.push(signup.addressOneValidator);
            validators.push(signup.cityValidator);
            validators.push(signup.stateValidator);
            validators.push(signup.zipValidator);
            validators.push(signup.adminUserValidator);
            validators.push(signup.adminFirstNameValidator);
            validators.push(signup.adminLastNameValidator);
            validators.push(signup.adminEmailValidator);
            var validationResults:Array = Validator.validateAll(validators);

            for each (var result:Object in validationResults) {
                LOGGER.debug(result.message);
            }

            return validationResults.length == 0 ? true : false;
        }
    }
}