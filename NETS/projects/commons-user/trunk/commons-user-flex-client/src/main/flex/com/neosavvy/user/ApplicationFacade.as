package com.neosavvy.user {
    import com.neosavvy.user.controller.CommonsUserStartupCommand;

    import com.neosavvy.user.controller.company.SaveCompanyCommand;
    import com.neosavvy.user.controller.security.CheckLoggedIn;
    import com.neosavvy.user.controller.security.LoginCommand;

    import com.neosavvy.user.controller.security.LogoutCommand;
    import com.neosavvy.user.controller.user.GetUsersCommand;

    import com.neosavvy.user.controller.user.SaveEmployeeToCompanyCommand;
    import com.neosavvy.user.controller.user.SaveUserCommand;

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

        public static const REQUEST_LOGOUT:String = "requestLogout";
        public static const USER_NOT_LOGGED_IN:String = "userNotLoggedIn";
        public static const USER_LOGGED_IN:String = "userLoggedIn";

        public static const GET_USERS_REQUEST:String = "getUsersRequest";
        public static const GET_USERS_SUCCESS:String = "getUsersSuccess";
        public static const GET_USERS_FAILED:String = "getUsersFailed";

        public static const SAVE_USER_REQUEST:String = "saveUserRequest";
        public static const SAVE_USER_SUCCESS:String = "saveUserSuccess";
        public static const SAVE_USER_FAILED:String = "saveUserFailed";

        public static const CHECK_USER_LOGGED_IN:String = "checkUserLoggedIn";

        public static const SAVE_COMPANY_REQUEST:String = "saveCompanyRequest";
        public static const SAVE_COMPANY_SUCCESS:String = "saveCompanySuccess";
        public static const SAVE_COMPANY_FAILED:String = "saveCompanyFailed";

        public static const SAVE_USER_TO_COMPANY_REQUEST:String = "saveEmployeeToCompanyRequest";
        public static const SAVE_USER_TO_COMPANY_SUCCESS:String = "saveEmployeeToCompanySuccess";
        public static const SAVE_USER_TO_COMPANY_FAILED:String = "saveEmployeeToCompanyFailed"; 


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
            registerCommand(CHECK_USER_LOGGED_IN, CheckLoggedIn)
            registerCommand(REQUEST_USER_LOGIN, LoginCommand);
            registerCommand(REQUEST_LOGOUT, LogoutCommand);
            registerCommand(GET_USERS_REQUEST, GetUsersCommand);
            registerCommand(SAVE_USER_REQUEST, SaveUserCommand);
            registerCommand(SAVE_COMPANY_REQUEST, SaveCompanyCommand);
            registerCommand(SAVE_USER_TO_COMPANY_REQUEST, SaveEmployeeToCompanyCommand)
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