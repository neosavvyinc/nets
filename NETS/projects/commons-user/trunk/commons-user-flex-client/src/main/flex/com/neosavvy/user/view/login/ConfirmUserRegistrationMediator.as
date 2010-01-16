package com.neosavvy.user.view.login {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.companyManagement.UserDTO;

    import flash.events.MouseEvent;

    import mx.containers.Panel;
    import mx.containers.ViewStack;
    import mx.controls.Alert;
    import mx.controls.Button;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.validators.Validator;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ConfirmUserRegistrationMediator extends Mediator implements IMediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.loginConfirmUserRegistrationMediator");

        public static const NAME:String = "ConfirmUserRegistrationMediator";

        public static const CONFIRMATION_INDEX:int          = 0;
        public static const CONFIRMATION_SUCCESS_INDEX:int  = 1;
        public static const CONFIRMATION_FAILED_INDEX:int   = 2;

        public function ConfirmUserRegistrationMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            confirmUserBtn.addEventListener(MouseEvent.CLICK, handleConfirmUserButtonClickHandler);
            retryConfirmationButton.addEventListener(MouseEvent.CLICK, handleRetryConfirmationHandler);
            loginButton.addEventListener(MouseEvent.CLICK, handleLoginHandler);
        }

        public function get confirmUserRegistration():ConfirmUserRegistration {
            return viewComponent as ConfirmUserRegistration;
        }

        public function get confirmationViewStack():ViewStack {
            return confirmUserRegistration.confirmationViewStack;
        }

        public function get confirmationPanel():ConfirmationPanel {
            return confirmUserRegistration.confirmationPanel;
        }

        public function get confirmUserBtn():Button {
            return confirmUserRegistration.confirmationPanel.confirmUserBtn;
        }

        public function get confirmationErrorPanel():ConfirmationErrorPanel {
            return confirmUserRegistration.confirmationErrorPanel;
        }

        public function get retryConfirmationButton():Button {
            return confirmationErrorPanel.retryButton;
        }

        public function get confirmationSuccessPanel():ConfirmationSuccessPanel {
            return confirmUserRegistration.confirmationSuccessPanel;
        }

        public function get loginButton():Button {
            return confirmationSuccessPanel.loginButton;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.SAVE_USER_TO_COMPANY_FAILED
                ,ApplicationFacade.SAVE_USER_TO_COMPANY_SUCCESS
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
                case ApplicationFacade.SAVE_USER_TO_COMPANY_FAILED:
                    confirmationErrorPanel.confirmationErrorText.text = notification.getBody().toString();
                    confirmationViewStack.selectedIndex = CONFIRMATION_FAILED_INDEX;
                    break;
                case ApplicationFacade.SAVE_USER_TO_COMPANY_SUCCESS:
                    confirmationSuccessPanel.confirmationText.text = notification.getBody().toString();
                    confirmationViewStack.selectedIndex = CONFIRMATION_SUCCESS_INDEX;
                    break;
            }
        }

        private function handleConfirmUserButtonClickHandler(event:MouseEvent):void {
            if (isUserConfirmationFormValid()) {

                var user:UserDTO = new UserDTO();

                user.registrationToken = confirmationPanel.confirmationKey.text;
                user.username = confirmationPanel.username.text;
                user.firstName = confirmationPanel.firstName.text;
                user.middleName = confirmationPanel.middleName.text;
                user.lastName = confirmationPanel.lastName.text;
                user.password = confirmationPanel.password.text;

                sendNotification(ApplicationFacade.SAVE_USER_TO_COMPANY_REQUEST, user);

            }
        }

        private function handleLoginHandler(event:MouseEvent):void {
            sendNotification(ApplicationFacade.CHECK_USER_LOGGED_IN);
        }

        private function handleRetryConfirmationHandler(event:MouseEvent):void {
            confirmationViewStack.selectedIndex = CONFIRMATION_INDEX;
        }

        private function isUserConfirmationFormValid():Boolean {
            var validators:Array = new Array();
            validators.push(confirmationPanel.confirmationKeyValidator);
            validators.push(confirmationPanel.userNameValidator)
            validators.push(confirmationPanel.firstNameValidator);
            validators.push(confirmationPanel.lastNameValidator);
            validators.push(confirmationPanel.passwordValidator);
            validators.push(confirmationPanel.confirmPasswordValidator);
            var validationResults:Array = Validator.validateAll(validators);

            for each (var result:Object in validationResults) {
                LOGGER.debug(result.message);
            }

            return validationResults.length == 0 ? true : false;
        }

        /*********
         * END NAVIGATION RELATED HANDLERS
         *********/
    }
}