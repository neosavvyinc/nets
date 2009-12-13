package com.neosavvy.user {
    import com.neosavvy.user.controller.CommonsUserStartupCommand;

    import org.puremvc.as3.multicore.patterns.facade.Facade;

    public class ApplicationFacade extends Facade
    {

        public static const STARTUP:String = 'startup';


        /**
         * Login / Security related notifications
         */
        public static const REQUEST_USER_LOGIN:String = "requestUserLogin";
        public static const USER_LOGIN_SUCCESS:String = "userLoginSuccess";
        public static const USER_LOGIN_FAILED:String = "userLoginFailed";
        public static const REQUEST_FORGOT_USERNAME:String = "requestForgotUsername";
        public static const REQUEST_FORGOT_PASSWORD:String = "requestForgotPassword";
        public static const LOGOUT_USER:String = "requestLogout";
        public static const USER_NOT_LOGGED_IN:String = "userNotLoggedIn";
        public static const USER_LOGGED_IN:String = "userLoggedIn";


        public function ApplicationFacade(key:String)
        {
            super(key);
        }

        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance(key:String):ApplicationFacade
        {
            if (instanceMap[key ] == null) instanceMap[ key ] = new ApplicationFacade(key);
            return instanceMap[ key ] as ApplicationFacade;
        }

        /**
         * Register Commands with the Controller
         */
        override protected function initializeController():void
        {
            super.initializeController();

            registerCommand(STARTUP, CommonsUserStartupCommand);
        }

        /**
         * Application startup
         *
         * @param app a reference to the application component
         */
        public function startup(app:CommonsUser):void
        {
            sendNotification(STARTUP, app);
        }



    }
}