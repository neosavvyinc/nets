package com.neosavvy.user.view.login {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.UserDTO;

    import flash.events.MouseEvent;

    import mx.controls.Label;
    import mx.events.CloseEvent;
    import mx.managers.PopUpManager;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class RegistrationAndLoginWindowMediator extends Mediator implements IMediator {

        public static const NAME:String = "RegistrationAndLoginWindowMediator";

        public function RegistrationAndLoginWindowMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            login.loginButton.addEventListener(MouseEvent.CLICK, handleLogin);
            login.forgotPassword.addEventListener(MouseEvent.CLICK, handleForgotPassword);
            login.forgotUsername.addEventListener(MouseEvent.CLICK, handleForgotUsername);

            newUserReg.newUserBtn.addEventListener(MouseEvent.CLICK, handleNewUser);

            userReg.createButton.addEventListener(MouseEvent.CLICK, handleCreate);
            userReg.cancelButton.addEventListener(MouseEvent.CLICK, handleCancel);

            userFailed.tryAgainButton.addEventListener(MouseEvent.CLICK, handleNewUser);
        }

        public function get registrationAndLoginWindow():RegistrationAndLoginWindow {
            return viewComponent as RegistrationAndLoginWindow;
        }

        public function get login():Login {
            return registrationAndLoginWindow.login;
        }

        public function get errorLabel():Label {
            return login.errorLbl;
        }

        public function get newUserReg():NewUserRegistration {
            return registrationAndLoginWindow.newUserReg;
        }

        public function get userReg():UserRegistration {
            return registrationAndLoginWindow.userReg;
        }

        public function get userConfirmed():UserConfirmed {
            return registrationAndLoginWindow.userConfirmed;
        }

        public function get userFailed():UserFailed {
            return registrationAndLoginWindow.userFailed;
        }


        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.USER_LOGIN_FAILED
                ,ApplicationFacade.SAVE_USER_SUCCESS
                ,ApplicationFacade.SAVE_USER_FAILED
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
                case ApplicationFacade.USER_LOGIN_FAILED:
                    errorLabel.text = "User login failed";
                    break;
                case ApplicationFacade.SAVE_USER_SUCCESS:
                    userConfirmedNavigation();
                    break;
                case ApplicationFacade.SAVE_USER_FAILED:
                    registrationFailedNavigation();
                    break;
            }
        }

        /**
         * Event Handlers
         */

        protected function handleLogin(event:MouseEvent):void {
            var user:UserDTO = new UserDTO();
            user.username = login.username.text;
            user.password = login.password.text;
            errorLabel.text = "";
            sendNotification(ApplicationFacade.REQUEST_USER_LOGIN, user);
        }

        protected function handleForgotUsername(event:MouseEvent):void {
            //TODO: Create handle forgotten username flow
            sendNotification(ApplicationFacade.REQUEST_FORGOT_USERNAME);
        }

        protected function handleForgotPassword(event:MouseEvent):void {
            //TODO: Create handle forgotten password flow
            sendNotification(ApplicationFacade.REQUEST_FORGOT_PASSWORD);
        }

        protected function close(event:CloseEvent):void {
            PopUpManager.removePopUp(registrationAndLoginWindow);
        }

        protected function handleNewUser(event:MouseEvent):void {
            newUserNavigation();
        }

        protected function handleCreate(event:MouseEvent):void {
            if (!validatePasswordsMatch()) {
                userReg.errorBox.text = "Passwords must match and be at least 6 characters";
                return;
            }
            addUser()
        }

        protected function handleCancel(event:MouseEvent):void {
            clearFields();
            cancelButtonNavigation();
        }

        /**
         * Validate the two password fields
         *
         * @return isPasswordValid if the two passwords match, are not null, and exceed at least 6 characters
         */
        protected function validatePasswordsMatch():Boolean {
            var isPasswordValid:Boolean = false;
            if (userReg.password.text && userReg.password.text.length >= 6 &&
                userReg.confirmPassword.text && userReg.confirmPassword.text.length >= 6 &&
                userReg.password.text == userReg.confirmPassword.text
                    ) {
                isPasswordValid = true
            }
            return isPasswordValid;
        }

        protected function clearFields():void {
            userReg.firstName.text = null;
            userReg.middleName.text = null;
            userReg.lastName.text = null;
            userReg.username.text = null;
            userReg.password.text = null;
            userReg.emailAddress.text = null;
            userReg.confirmPassword.text = null;
            userReg.errorBox.text = null;
        }

        protected function getUserFromTextInput():UserDTO {
            var userFromTextInputs:UserDTO = new UserDTO();
            userFromTextInputs.firstName = userReg.firstName.text;
            userFromTextInputs.middleName = userReg.middleName.text;
            userFromTextInputs.lastName = userReg.lastName.text;
            userFromTextInputs.username = userReg.username.text;
            userFromTextInputs.password = userReg.password.text;
            userFromTextInputs.emailAddress = userReg.emailAddress.text;
            return userFromTextInputs;
        }

        protected function addUser():void {
            sendNotification(ApplicationFacade.SAVE_USER_REQUEST, getUserFromTextInput());
        }

        private function savefaultHandler(faultEvent:FaultEvent):void {
            trace("faultEvent: " + faultEvent.message);
            trace("faultEvent: " + faultEvent.fault.toString());
            registrationFailedNavigation();
        }

        private function saveresultHandler(resultEvent:ResultEvent):void {
            userConfirmedNavigation();
        }


        /*********
         * NAVIGATION RELATED HANDLERS
         *********/
        protected function newUserNavigation():void {
            newUserReg.visible = false;
            userReg.visible = true;
            userConfirmed.visible = false;
            userFailed.visible = false;
        }

        protected function cancelButtonNavigation():void {
            newUserReg.visible = false;
            userReg.visible = true;
            userConfirmed.visible = false;
            userFailed.visible = false;
        }

        protected function userConfirmedNavigation():void {
            newUserReg.visible = false;
            userReg.visible = false;
            userConfirmed.visible = true;
            userFailed.visible = false;
        }

        protected function registrationFailedNavigation():void {
            newUserReg.visible = false;
            userReg.visible = false;
            userConfirmed.visible = false;
            userFailed.visible = true;
        }

        /*********
         * END NAVIGATION RELATED HANDLERS
         *********/
    }
}