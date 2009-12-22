package com.neosavvy.user.view.security {
    import com.neosavvy.user.ApplicationFacade;

    import com.neosavvy.user.dto.UserDTO;

    import flash.events.MouseEvent;

    import mx.controls.Button;
    import mx.events.ListEvent;

    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class LoginMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.security.LoginMediator")

        public static const NAME:String = "LoginMediator";

        public function LoginMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            login.loginButton.addEventListener(MouseEvent.CLICK, handleLoginClickedEvent);
            newCompanyButtonFromExistingLogin.addEventListener(MouseEvent.CLICK, handleNewCompanyButtonFromExistingLogingClicked);
        }

        public function get login():Login {
            return viewComponent as Login;
        }

        public function get newCompanyButtonFromExistingLogin():Button {
            return login.newCompanyButtonFromExistingLogin;
        }

        private function handleLoginClickedEvent(event:MouseEvent):void {
            var user:UserDTO = new UserDTO();
            user.username = login.username.text;
            user.password = login.password.text;
            sendNotification(ApplicationFacade.REQUEST_USER_LOGIN, user);
        }

        private function handleNewCompanyButtonFromExistingLogingClicked(event:MouseEvent):void {

            sendNotification(ApplicationFacade.NAVIGATE_TO_COMPANY_REGISTRATION);

        }

    }
}