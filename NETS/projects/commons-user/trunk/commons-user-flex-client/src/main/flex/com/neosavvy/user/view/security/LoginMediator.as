package com.neosavvy.user.view.security {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.view.security.popup.ForgotPasswordFailedPopup;
    import com.neosavvy.user.view.security.popup.ForgotPasswordSuccessPopup;

    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.ui.Keyboard;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.managers.PopUpManager;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class LoginMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.security.LoginMediator")

        public static const NAME:String = "LoginMediator";

        public function LoginMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            login.username.addEventListener(KeyboardEvent.KEY_DOWN, onEnter);
            login.password.addEventListener(KeyboardEvent.KEY_DOWN, onEnter);
            login.loginButton.addEventListener(KeyboardEvent.KEY_DOWN, onEnter);


            login.loginButton.addEventListener(MouseEvent.CLICK, handleLoginClickedEvent);
            login.forgotPasswordPopup.addEventListener("userSelected", onForgotPasswordUserSelected);
        }

        private function onEnter( event : KeyboardEvent ) : void
        {
            if( event.keyCode == Keyboard.ENTER )
            {
                loginUser();        
            }
        }

        private function onForgotPasswordUserSelected(event:Event):void {
            var user:UserDTO = new UserDTO();
            user.username = login.forgotPasswordPopup.userNameString;
            sendNotification(ApplicationFacade.FORGOT_PASSWORD_REQUEST, user);
        }

        public function get login():Login {
            return viewComponent as Login;
        }

        public function resetForm():void {
           login.username.text = null;
           login.password.text = null;
           login.errorLbl.text = null;
           login.errorLbl.includeInLayout = false;
           login.errorLbl.visible = false;
        }

        private function handleLoginClickedEvent(event:MouseEvent):void {
            loginUser();
        }

        private function loginUser():void {
            var user:UserDTO = new UserDTO();
            user.username = login.username.text;
            user.password = login.password.text;
            sendNotification(ApplicationFacade.REQUEST_USER_LOGIN, user);
        }



        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.USER_LOGIN_SUCCESS
                ,ApplicationFacade.USER_LOGIN_FAILED
                ,ApplicationFacade.FORGOT_PASSWORD_FAULT
                ,ApplicationFacade.FORGOT_PASSWORD_SUCCESS
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch ( notification.getName() ) {
                case ApplicationFacade.USER_LOGIN_SUCCESS:
                    resetForm();
                    break;
                case ApplicationFacade.USER_LOGIN_FAILED:
                    login.errorLbl.text = "Username or Password were not valid";
                    login.errorLbl.includeInLayout = true;
                    login.errorLbl.visible = true;
                    break;
                case ApplicationFacade.FORGOT_PASSWORD_SUCCESS:
                    handleForgotPasswordSuccess( notification );
                    break;
                case ApplicationFacade.FORGOT_PASSWORD_FAULT:
                    handleForgotPasswordFault( notification );
                    break;
            }
        }

        private function handleForgotPasswordFault(notification:INotification):void {
            login.stack.toggle();
            login.stack.addEventListener("endFlip", onFlipFinishedFault);

        }

        private function onFlipFinishedFault(event:Event):void {
            PopUpManager.centerPopUp(PopUpManager.createPopUp(login, ForgotPasswordFailedPopup, true));
            login.stack.removeEventListener("endFlip", onFlipFinishedFault);
        }

        private function handleForgotPasswordSuccess(notification:INotification):void {
            login.stack.toggle();
            login.stack.addEventListener("endFlip", onFlipFinishedSuccess);
        }


        private function onFlipFinishedSuccess(event:Event):void {
            PopUpManager.centerPopUp(PopUpManager.createPopUp(login, ForgotPasswordSuccessPopup, true));
            login.stack.removeEventListener("endFlip", onFlipFinishedSuccess);
        }
    }
}