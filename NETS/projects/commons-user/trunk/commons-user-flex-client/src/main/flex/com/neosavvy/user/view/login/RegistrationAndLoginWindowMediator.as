package com.neosavvy.user.view.login {
    import com.neosavvy.user.ApplicationFacade;

    import com.neosavvy.user.dto.UserDTO;

    import flash.events.MouseEvent;

    import mx.controls.Label;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class RegistrationAndLoginWindowMediator extends Mediator implements IMediator {

        public static const NAME:String = "RegistrationAndLoginWindowMediator";

        public function RegistrationAndLoginWindowMediator(viewComponent:Object) {
            super(NAME, viewComponent);
            login.loginButton.addEventListener(MouseEvent.CLICK, handleLogin);
            login.forgotPassword.addEventListener(MouseEvent.CLICK, handleForgotPassword);
            login.forgotUsername.addEventListener(MouseEvent.CLICK, handleForgotUsername);
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


        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.USER_LOGIN_FAILED
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch ( notification.getName() ) {

                case ApplicationFacade.USER_LOGIN_FAILED:
                    errorLabel.text = "User login failed";
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





    }
}