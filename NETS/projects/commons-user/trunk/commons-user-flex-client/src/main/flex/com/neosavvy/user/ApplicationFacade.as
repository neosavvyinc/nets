package com.neosavvy.user {
    import com.neosavvy.user.controller.CommonsUserStartupCommand;

    import com.neosavvy.user.controller.company.InviteUsersToCompanyCommand;
    import com.neosavvy.user.controller.company.SaveCompanyCommand;
    import com.neosavvy.user.controller.secured.SecuredViewPrepCommand;
    import com.neosavvy.user.controller.secured.SecuredViewTeardownCommand;
    import com.neosavvy.user.controller.security.CheckLoggedIn;
    import com.neosavvy.user.controller.security.LoginCommand;

    import com.neosavvy.user.controller.security.LogoutCommand;
    import com.neosavvy.user.controller.user.GetUsersCommand;

    import com.neosavvy.user.controller.user.SaveEmployeeToCompanyCommand;
    import com.neosavvy.user.controller.user.SaveUserCommand;

    import com.neosavvy.user.controller.user.ConfirmAccountCommand;

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

        public static const INVITE_USER_TO_COMPANY_REQUEST:String = "inviteEmployeeToCompanyRequest";
        public static const INVITE_USER_TO_COMPANY_SUCCESS:String = "inviteEmployeeToCompanySuccess";
        public static const INVITE_USER_TO_COMPANY_FAILED:String = "inviteEmployeeToCompanyFailed";

        public static const SAVE_USER_TO_COMPANY_REQUEST:String = "saveEmployeeToCompanyRequest";
        public static const SAVE_USER_TO_COMPANY_SUCCESS:String = "saveEmployeeToCompanySuccess";
        public static const SAVE_USER_TO_COMPANY_FAILED:String = "saveEmployeeToCompanyFailed";

        public static const CONFIRM_ACCOUNT_REQUEST:String = "confirmAccountRequest";
        public static const CONFIRM_ACCOUNT_SUCCESS:String = "confirmAccountSuccess";
        public static const CONFIRM_ACCOUNT_FAILED:String = "confirmAccountFailed";

        public static const INITIALIZE_SECURED_VIEW:String = "initializeSecuredViewRequest";
        public static const DEINITIALIZE_SECURED_VIEW:String = "deinitializeSecuredViewRequest";

        public static var ACTIVE_EMPLOYEES_REQUEST:String="activeEmployeesRequest";
        public static var ACTIVE_EMPLOYEES_SUCCESS:String="activeEmployeesSuccess";
        public static var ACTIVE_EMPLOYEES_FAILED:String ="activeEmployeesFailed";

        public static var NON_ACTIVE_EMPLOYEES_REQUEST:String="nonActiveEmployeesRequest";
        public static var NON_ACTIVE_EMPLOYEES_SUCCESS:String="nonActiveEmployeesSuccess";
        public static var NON_ACTIVE_EMPLOYEES_FAILED:String="nonActiveEmployeesFailed";

        public static var NAVIGATE_TO_INVITE_EMPLOYEES:String="navigateToInviteEmployees";
        public static var NAVIGATE_TO_WELCOME:String="navigateToWelcome";
        
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
            registerCommand(CONFIRM_ACCOUNT_REQUEST, ConfirmAccountCommand);

            registerCommand(INITIALIZE_SECURED_VIEW, SecuredViewPrepCommand);
            registerCommand(DEINITIALIZE_SECURED_VIEW, SecuredViewTeardownCommand);

            registerCommand(INVITE_USER_TO_COMPANY_REQUEST, InviteUsersToCompanyCommand);
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