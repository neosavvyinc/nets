package com.neosavvy.user {
    import com.neosavvy.user.controller.CommonsUserStartupCommand;

    import com.neosavvy.user.controller.client.GetClientsForCompany;
    import com.neosavvy.user.controller.client.SaveClientCompany;
    import com.neosavvy.user.controller.clientManagement.InitializeManageProjects;
    import com.neosavvy.user.controller.company.DeleteUserCompanyInviteCommand;
    import com.neosavvy.user.controller.company.GetActiveUsersForCompany;
    import com.neosavvy.user.controller.company.GetAllUsersForCompany;
    import com.neosavvy.user.controller.company.GetInActiveUsersForCompany;
    import com.neosavvy.user.controller.company.GetInvitedUsersForCompanyCommand;
    import com.neosavvy.user.controller.company.InviteUsersToCompanyCommand;
    import com.neosavvy.user.controller.company.SaveCompanyCommand;
    import com.neosavvy.user.controller.company.SendUserInviteCommand;
    import com.neosavvy.user.controller.project.GetProjectsForCompany;
    import com.neosavvy.user.controller.project.SaveProject;
    import com.neosavvy.user.controller.secured.SecuredViewPrepCommand;
    import com.neosavvy.user.controller.secured.SecuredViewTeardownCommand;
    import com.neosavvy.user.controller.secured.UserLoggedInStartupCommand;
    import com.neosavvy.user.controller.security.CheckLoggedIn;
    import com.neosavvy.user.controller.security.LoginCommand;

    import com.neosavvy.user.controller.security.LogoutCommand;
    import com.neosavvy.user.controller.user.GetUsersCommand;

    import com.neosavvy.user.controller.user.ResetUserPasswordCommand;
    import com.neosavvy.user.controller.user.SaveEmployeeToCompanyCommand;
    import com.neosavvy.user.controller.user.SaveUserCommand;

    import com.neosavvy.user.controller.user.ConfirmAccountCommand;

    import com.neosavvy.user.model.SecurityProxy;

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

        public static const ACTIVE_EMPLOYEES_REQUEST:String="activeEmployeesRequest";
        public static const ACTIVE_EMPLOYEES_SUCCESS:String="activeEmployeesSuccess";
        public static const ACTIVE_EMPLOYEES_FAILED:String ="activeEmployeesFailed";

        public static const NON_ACTIVE_EMPLOYEES_REQUEST:String="nonActiveEmployeesRequest";
        public static const NON_ACTIVE_EMPLOYEES_SUCCESS:String="nonActiveEmployeesSuccess";
        public static const NON_ACTIVE_EMPLOYEES_FAILED:String="nonActiveEmployeesFailed";

        public static const ALL_EMPLOYEES_REQUEST:String = "allEmployeesRequest";
        public static const ALL_EMPLOYEES_SUCCESS:String = "allEmployeesSuccess";
        public static const ALL_EMPLOYEES_FAILED:String = "allEmployeesFailed";

        public static const NAVIGATE_TO_INVITE_EMPLOYEES:String="navigateToInviteEmployees";
        public static const NAVIGATE_TO_COMPANY_REGISTRATION:String="navigateToCompanyRegistration";
        public static const NAVIGATE_TO_PROJECT_MANAGEMENT:String = "navigateToProjectManagement";
        public static const NAVIGATE_TO_CLIENT_MANAGEMENT:String = "navigateToClientManagement";

        public static const GET_INVITED_USERS_REQUEST:String = "getInvitedUsersRequest";
        public static const GET_INVITED_USERS_FAILED:String = "getInvitedUsersFailed";
        public static const GET_INVITED_USERS_SUCCESS:String = "getInvitedUsersSuccess";

        public static const DELETE_USER_COMPANY_INVITE:String = "deleteUserCompanyInvite";
        public static const DELETE_USER_COMPANY_INVITE_FAILED:String = "deleteUserCompanyInviteFailed";
        public static const DELETE_USER_COMPANY_INVITE_SUCCESS:String = "deleteUserCompanyInviteSuccess";

        public static const NAVIGATE_TO_WELCOME:String="navigateToWelcome";

        public static const SEND_USER_INVITE_REQUEST:String = "sendUserInviteRequest";
        public static const SEND_USER_INVITE_FAILED:String = "sendUserInviteFailed";
        public static const SEND_USER_INVITE_SUCCESS:String = "sendUserInviteSuccess";

        public static const RESET_USER_PASSWORD_REQUEST:String = "resetUserPasswordRequest";
        public static const RESET_USER_PASSWORD_SUCCESS:String = "resetUserPasswordSuccess";
        public static const RESET_USER_PASSWORD_FAULT:String = "resetUserPasswordFault";

        public static const POST_SECURE_VIEW_PREP:String = "secureViewInitializationComplete";

        public static const FIND_CLIENTS_FOR_PARENT_COMPANY_REQUEST:String = "findClientsForParentCompanyRequest";
        public static const FIND_CLIENTS_FOR_PARENT_COMPANY_FAILED:String = "findClientsForParentCompanyFailed";
        public static const FIND_CLIENTS_FOR_PARENT_COMPANY_SUCCESS:String = "findClientsForParentCompanySuccess";

        public static const SAVE_CLIENT_COMPANY_REQUEST:String = "saveClientCompanyRequest";
        public static const SAVE_CLIENT_COMPANY_SUCCESS:String = "saveClientCompanySuccess";
        public static const SAVE_CLIENT_COMPANY_FAILED:String = "saveClientCompanyFailed";

        public static const SAVE_PROJECT_REQUEST:String = "saveProjectRequest";
        public static const SAVE_PROJECT_SUCCESS:String = "saveProjectSuccess";
        public static const SAVE_PROJECT_FAILED:String = "saveProjectFailed";

        public static const INITIALIZE_MANAGE_PROJECTS_VIEW:String = "initializeManageProjectsView";
        public static const INITIALIZE_MANAGE_PROJECTS_VIEW_COMPLETE:String = "initializeManageProjectsViewComplete";

        public static const GET_PROJECTS_FOR_COMPANY_REQUEST:String = "getProjectsForCompanyRequest";
        public static const GET_PROJECTS_FOR_COMPANY_SUCCESS:String = "getProjectsForCompanySuccess";
        public static const GET_PROJECTS_FOR_COMPANY_FAILED:String = "getProjectsForCompanyFailed";

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

            registerCommand(INITIALIZE_SECURED_VIEW, UserLoggedInStartupCommand);
            registerCommand(DEINITIALIZE_SECURED_VIEW, SecuredViewTeardownCommand);

            registerCommand(INVITE_USER_TO_COMPANY_REQUEST, InviteUsersToCompanyCommand);
            registerCommand(GET_INVITED_USERS_REQUEST, GetInvitedUsersForCompanyCommand);
            registerCommand(DELETE_USER_COMPANY_INVITE, DeleteUserCompanyInviteCommand);
            registerCommand(SEND_USER_INVITE_REQUEST, SendUserInviteCommand);
            registerCommand(RESET_USER_PASSWORD_REQUEST, ResetUserPasswordCommand);

            registerCommand(ACTIVE_EMPLOYEES_REQUEST, GetActiveUsersForCompany);
            registerCommand(NON_ACTIVE_EMPLOYEES_REQUEST, GetInActiveUsersForCompany);
            registerCommand(ALL_EMPLOYEES_REQUEST, GetAllUsersForCompany);

            registerCommand(FIND_CLIENTS_FOR_PARENT_COMPANY_REQUEST, GetClientsForCompany);
            registerCommand(SAVE_CLIENT_COMPANY_REQUEST, SaveClientCompany);
            registerCommand(INITIALIZE_MANAGE_PROJECTS_VIEW, InitializeManageProjects );
            registerCommand(SAVE_PROJECT_REQUEST, SaveProject);
            registerCommand(GET_PROJECTS_FOR_COMPANY_REQUEST, GetProjectsForCompany);
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

        public static function getSecurityProxy(key:String):SecurityProxy {
            return ApplicationFacade.getInstance(key).retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
        }

        }
}