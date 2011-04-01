package com.neosavvy.user {
    import com.neosavvy.user.controller.CommonsUserStartupCommand;
    import com.neosavvy.user.controller.base.DisplayErrorCommand;
    import com.neosavvy.user.controller.client.GetClientsForCompany;
    import com.neosavvy.user.controller.client.SaveClientCompany;
    import com.neosavvy.user.controller.clientManagement.InitializeAssignmentsForProject;
    import com.neosavvy.user.controller.clientManagement.InitializeManageAssignments;
    import com.neosavvy.user.controller.clientManagement.InitializeManageProjects;
    import com.neosavvy.user.controller.company.DeleteUserCompanyInviteCommand;
    import com.neosavvy.user.controller.company.GetActiveUsersForCompany;
    import com.neosavvy.user.controller.company.GetAllUsersForCompany;
    import com.neosavvy.user.controller.company.GetInActiveUsersForCompany;
    import com.neosavvy.user.controller.company.GetInvitedUsersForCompanyCommand;
    import com.neosavvy.user.controller.company.InviteUsersToCompanyCommand;
    import com.neosavvy.user.controller.company.SaveCompanyCommand;
    import com.neosavvy.user.controller.company.SendUserInviteCommand;
    import com.neosavvy.user.controller.expenses.report.init.FindExpenseTypes;
    import com.neosavvy.user.controller.expenses.report.init.FindPaymentMethods;
    import com.neosavvy.user.controller.expenses.report.init.FindProjectTypes;
    import com.neosavvy.user.controller.expenses.report.init.InitializeEditExpenseReportView;
    import com.neosavvy.user.controller.expenses.report.init.InitializeExpenseReportView;
    import com.neosavvy.user.controller.expenses.report.init.InitializeViewAwaitingApprovalExpenseReportView;
    import com.neosavvy.user.controller.expenses.report.init.InitializeViewExpenseReportView;
    import com.neosavvy.user.controller.expenses.report.init.InitializeViewOpenExpenseReportView;
    import com.neosavvy.user.controller.expenses.report.init.InitializeViewSubmittedExpenseReportView;
    import com.neosavvy.user.controller.expenses.report.save.DeleteExpenseReport;
    import com.neosavvy.user.controller.expenses.report.save.FindExpenseReport;
    import com.neosavvy.user.controller.expenses.report.save.SaveExpenseReport;
    import com.neosavvy.user.controller.expenses.report.view.FindOpenExpenseReportsForUser;
    import com.neosavvy.user.controller.expenses.report.workflow.AddReceiptToExpenseReport;
    import com.neosavvy.user.controller.expenses.report.workflow.ApproveExpenseReport;
    import com.neosavvy.user.controller.expenses.report.workflow.DeclineExpenseReport;
    import com.neosavvy.user.controller.expenses.report.workflow.ReopenExpenseReport;
    import com.neosavvy.user.controller.expenses.report.workflow.SubmitExpenseReport;
    import com.neosavvy.user.controller.mail.SendSystemMail;
    import com.neosavvy.user.controller.project.GetAssignedUsersForProject;
    import com.neosavvy.user.controller.project.GetAvailableUsersForProject;
    import com.neosavvy.user.controller.project.GetProjectsForCompany;
    import com.neosavvy.user.controller.project.GetProjectsForUser;
    import com.neosavvy.user.controller.project.SaveAssignmentsForProjectChain;
    import com.neosavvy.user.controller.project.SaveProject;
    import com.neosavvy.user.controller.project.SaveProjectAssignments;
    import com.neosavvy.user.controller.secured.SecuredViewTeardownCommand;
    import com.neosavvy.user.controller.secured.UserLoggedInStartupCommand;
    import com.neosavvy.user.controller.security.CheckLoggedIn;
    import com.neosavvy.user.controller.security.ForgotPasswordCommand;
    import com.neosavvy.user.controller.security.LoginCommand;
    import com.neosavvy.user.controller.security.LogoutCommand;
    import com.neosavvy.user.controller.user.ConfirmAccountCommand;
    import com.neosavvy.user.controller.user.GetUsersCommand;
    import com.neosavvy.user.controller.user.ResetUserPasswordCommand;
    import com.neosavvy.user.controller.user.SaveEmployeeToCompanyCommand;
    import com.neosavvy.user.controller.user.SaveUserCommand;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.SecurityProxy;
    import com.neosavvy.user.model.UserServiceProxy;

    import org.puremvc.as3.multicore.patterns.facade.Facade;

    public class ApplicationFacade extends Facade
    {

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
            registerCommand(FORGOT_PASSWORD_REQUEST, ForgotPasswordCommand);
            registerCommand(GET_USERS_REQUEST, GetUsersCommand);
            registerCommand(SAVE_USER_REQUEST, SaveUserCommand);
            registerCommand(SAVE_COMPANY_REQUEST, SaveCompanyCommand);
            registerCommand(SAVE_USER_TO_COMPANY_REQUEST, SaveEmployeeToCompanyCommand)
            registerCommand(CONFIRM_ACCOUNT_REQUEST, ConfirmAccountCommand);
            registerCommand(DISPLAY_ERROR, DisplayErrorCommand);

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
            registerCommand(SEND_SYSTEM_MAIL, SendSystemMail);
            registerCommand(SAVE_CLIENT_COMPANY_REQUEST, SaveClientCompany);
            registerCommand(INITIALIZE_MANAGE_PROJECTS_VIEW, InitializeManageProjects);
            registerCommand(INITIALIZE_MANAGE_ASSIGNMENTS_VIEW, InitializeManageAssignments);
            registerCommand(SAVE_PROJECT_REQUEST, SaveProject);
            registerCommand(GET_PROJECTS_FOR_COMPANY_REQUEST, GetProjectsForCompany);

            registerCommand(INITIALIZE_ASSIGNMENTS_FOR_PROJECT, InitializeAssignmentsForProject);
            registerCommand(GET_ASSIGNED_USERS_FOR_PROJECT_REQUEST, GetAssignedUsersForProject);
            registerCommand(GET_AVAILABLE_USERS_FOR_PROJECT_REQUEST, GetAvailableUsersForProject);
            registerCommand(GET_PROJECTS_FOR_USER_REQUEST, GetProjectsForUser);

            registerCommand(SAVE_PROJECT_ASSIGNMENTS_REQUEST, SaveProjectAssignments);
            registerCommand(SAVE_PROJECT_ASSIGNMENTS_CHAIN_START, SaveAssignmentsForProjectChain);

            registerCommand(INITIALIZE_EXPENSE_REPORT_VIEW, InitializeExpenseReportView);
            registerCommand(SAVE_EXPENSE_REPORT_REQUEST, SaveExpenseReport);
            registerCommand(FIND_EXPENSE_REPORT_REQUEST, FindExpenseReport);
            registerCommand(FIND_EXPENSE_ITEM_TYPES_REQUEST, FindExpenseTypes);
            registerCommand(FIND_PAYMENT_METHODS_REQUEST, FindPaymentMethods);
            registerCommand(FIND_PROJECT_TYPES_REQUEST, FindProjectTypes);
            registerCommand(FIND_OPEN_EXPENSE_REPORTS_FOR_USER_REQUEST, FindOpenExpenseReportsForUser);
            registerCommand(ADD_RECEIPT_TO_EXPENSE_REPORT_REQUEST, AddReceiptToExpenseReport);

            registerCommand(APPROVE_EXPENSE_REPORT_REQUEST, ApproveExpenseReport);
            registerCommand(DECLINE_EXPENSE_REPORT_REQUEST, DeclineExpenseReport);
            registerCommand(SUBMIT_EXPENSE_REPORT_REQUEST, SubmitExpenseReport);
            registerCommand(REOPEN_EXPENSE_REPORT_REQUEST, ReopenExpenseReport);

            registerCommand(INITIALIZE_VIEW_OPEN_EXPENSE_REPORTS_VIEW, InitializeViewOpenExpenseReportView);
            registerCommand(INITIALIZE_EDIT_EXPENSE_REPORT_VIEW, InitializeEditExpenseReportView);
            registerCommand(INITIALIZE_VIEW_EXPENSE_REPORT_VIEW, InitializeViewExpenseReportView);

            registerCommand(DELETE_ACTIVE_EXPENSE_REPORT_REQUEST, DeleteExpenseReport);

            registerCommand(INITIALIZE_VIEW_SUBMITTED_EXPENSE_REPORTS_VIEW, InitializeViewSubmittedExpenseReportView);
            registerCommand(INITIALIZE_AWAITING_EXPENSE_REPORT_VIEW, InitializeViewAwaitingApprovalExpenseReportView);


        }

        /**
         * Application startup
         *
         * @param app a reference to the application component
         */
        public function startup(app:NETS):void
        {
            sendNotification(STARTUP, app);
        }

        public static const defaultApplicationKey:String = "NETS";

        public static function getSecurityProxy(key:String = defaultApplicationKey):SecurityProxy {
            return ApplicationFacade.getInstance(key).retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
        }

        public static function getCompanyProxy(key:String = defaultApplicationKey):CompanyServiceProxy {
            return ApplicationFacade.getInstance(key).retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
        }

        public static function getUserProxy(key:String = defaultApplicationKey):UserServiceProxy {
            return ApplicationFacade.getInstance(key).retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;
        }
        
        public static const STARTUP:String = 'startup';


        /**
         * Login / Security related notifications
         */
        public static const REQUEST_USER_LOGIN:String = "requestUserLogin";
        public static const USER_LOGIN_SUCCESS:String = "userLoginSuccess";
        public static const USER_LOGIN_FAILED:String = "userLoginFailed";
        public static const DISPLAY_LOGIN_SCREEN:String = "displayLogin";

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
        public static const SAVE_COMPANY_FAILED_DUPLICATE_USER:String = "saveCompanyFailedDupeUser";

        public static const INVITE_USER_TO_COMPANY_REQUEST:String = "inviteEmployeeToCompanyRequest";
        public static const INVITE_USER_TO_COMPANY_SUCCESS:String = "inviteEmployeeToCompanySuccess";
        public static const INVITE_USER_TO_COMPANY_FAILED:String = "inviteEmployeeToCompanyFailed";

        public static const SAVE_USER_TO_COMPANY_REQUEST:String = "saveEmployeeToCompanyRequest";
        public static const SAVE_USER_TO_COMPANY_SUCCESS:String = "saveEmployeeToCompanySuccess";
        public static const SAVE_USER_TO_COMPANY_FAILED:String = "saveEmployeeToCompanyFailed";
        public static const SAVE_USER_TO_COMPANY_FAILED_DUPLICATE:String = "saveEmployeeToCompanyFailedDuplicate";

        public static const CONFIRM_ACCOUNT_REQUEST:String = "confirmAccountRequest";
        public static const CONFIRM_ACCOUNT_SUCCESS:String = "confirmAccountSuccess";
        public static const CONFIRM_ACCOUNT_FAILED:String = "confirmAccountFailed";

        public static const INITIALIZE_SECURED_VIEW:String = "initializeSecuredViewRequest";
        public static const DEINITIALIZE_SECURED_VIEW:String = "deinitializeSecuredViewRequest";

        public static const ACTIVE_EMPLOYEES_REQUEST:String = "activeEmployeesRequest";
        public static const ACTIVE_EMPLOYEES_SUCCESS:String = "activeEmployeesSuccess";
        public static const ACTIVE_EMPLOYEES_FAILED:String = "activeEmployeesFailed";

        public static const NON_ACTIVE_EMPLOYEES_REQUEST:String = "nonActiveEmployeesRequest";
        public static const NON_ACTIVE_EMPLOYEES_SUCCESS:String = "nonActiveEmployeesSuccess";
        public static const NON_ACTIVE_EMPLOYEES_FAILED:String = "nonActiveEmployeesFailed";

        public static const ALL_EMPLOYEES_REQUEST:String = "allEmployeesRequest";
        public static const ALL_EMPLOYEES_SUCCESS:String = "allEmployeesSuccess";
        public static const ALL_EMPLOYEES_FAILED:String = "allEmployeesFailed";

        public static const NAVIGATE_TO_INVITE_EMPLOYEES:String = "navigateToInviteEmployees";
        public static const NAVIGATE_TO_COMPANY_REGISTRATION:String = "navigateToCompanyRegistration";
        public static const NAVIGATE_TO_CLIENT_MANAGEMENT:String = "navigateToClientManagement";

        public static const NAVIGATE_TO_CREATE_EXPENSE_REPORT:String = "navigateToCreateExpenseReport";
        public static const NAVIGATE_TO_YOUR_INFORMATION:String ="navigateToYourInformation";
        public static const NAVIGATE_TO_EDIT_EXPENSE_REPORT:String = "navigateToEditExpenseReport";
        public static const NAVIGATE_TO_VIEW_OPEN_EXPENSE_REPORTS:String = "navigateToViewOpenExpenses";
        public static const NAVIGATE_TO_VIEW_AWAITING_EXPENSE_REPORTS:String = "navigateToViewAwaitingExpenses";
        public static const NAVIGATE_TO_VIEW_SUBMITTED_EXPENSE_REPORTS:String = "navigateToViewSubmittedExpenseReports";
        public static const NAVIGATE_TO_RECONCILE_EXPENSE_REPORTS:String = "navigateToReconcileExpenseReports";
        public static const NAVIGATE_TO_MANAGE_RECEIPTS:String = "navigateToManageReceipts";

        public static const GET_INVITED_USERS_REQUEST:String = "getInvitedUsersRequest";
        public static const GET_INVITED_USERS_FAILED:String = "getInvitedUsersFailed";
        public static const GET_INVITED_USERS_SUCCESS:String = "getInvitedUsersSuccess";

        public static const DELETE_USER_COMPANY_INVITE:String = "deleteUserCompanyInvite";
        public static const DELETE_USER_COMPANY_INVITE_FAILED:String = "deleteUserCompanyInviteFailed";
        public static const DELETE_USER_COMPANY_INVITE_SUCCESS:String = "deleteUserCompanyInviteSuccess";

        public static const NAVIGATE_TO_WELCOME:String = "navigateToWelcome";

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

        public static const SEND_SYSTEM_MAIL : String = "sendSystemMail";

        public static const SAVE_CLIENT_COMPANY_REQUEST:String = "saveClientCompanyRequest";
        public static const SAVE_CLIENT_COMPANY_SUCCESS:String = "saveClientCompanySuccess";
        public static const SAVE_CLIENT_COMPANY_FAILED:String = "saveClientCompanyFailed";

        public static const SAVE_PROJECT_REQUEST:String = "saveProjectRequest";
        public static const SAVE_PROJECT_SUCCESS:String = "saveProjectSuccess";
        public static const SAVE_PROJECT_FAILED:String = "saveProjectFailed";

        public static const INITIALIZE_MANAGE_PROJECTS_VIEW:String = "initializeManageProjectsView";
        public static const INITIALIZE_MANAGE_PROJECTS_VIEW_COMPLETE:String = "initializeManageProjectsViewComplete";

        public static const INITIALIZE_MANAGE_ASSIGNMENTS_VIEW:String = "initializeManageAssignments";
        public static const INITIALIZE_MANAGE_ASSIGNMENTS_VIEW_COMPLETE:String = "initializeManageAssignmentsComplete";

        public static const GET_PROJECTS_FOR_COMPANY_REQUEST:String = "getProjectsForCompanyRequest";
        public static const GET_PROJECTS_FOR_COMPANY_SUCCESS:String = "getProjectsForCompanySuccess";
        public static const GET_PROJECTS_FOR_COMPANY_FAILED:String = "getProjectsForCompanyFailed";

        public static const SHOW_PROGRESS_INDICATOR:String = "showProgressIndicator";
        public static const UPDATE_PROGRESS_INDICATOR:String = "updateProgressIndicator";
        public static const HIDE_PROGRESS_INDICATOR:String = "hideProgressIndicator";

        public static const USER_LOGIN_STARTUP_COMPLETE:String = "userLoginStartupComplete";
        public static const NAVIGATE_TO_ASSIGNMENTS:String = "navigateToAssignments";
        public static const NAVIGATE_TO_MANAGE_PROJECTS:String = "navigateToManageProjects";
        public static const DISPLAY_ERROR:String = "displayError";

        public static const INITIALIZE_ASSIGNMENTS_FOR_PROJECT:String = "initializeAssignmentsForProject";
        public static const INITIALIZE_ASSIGNMENTS_FOR_PROJECT_COMPLETE:String = "initializeAssignmentsForProjectComplete";

        public static const GET_AVAILABLE_USERS_FOR_PROJECT_REQUEST:String = "getAvailableUsersForProjectRequest";
        public static const GET_AVAILABLE_USERS_FOR_PROJECT_SUCCESS:String = "getAvailableUsersForProjectSuccess";
        public static const GET_AVAILABLE_USERS_FOR_PROJECT_FAILED:String = "getAvailableUsersForProjectFailed";

        public static const GET_ASSIGNED_USERS_FOR_PROJECT_REQUEST:String = "getAssignedUsersForProjectRequest";
        public static const GET_ASSIGNED_USERS_FOR_PROJECT_SUCCESS:String = "getAssignedUsersForProjectSuccess";
        public static const GET_ASSIGNED_USERS_FOR_PROJECT_FAILED:String = "getAssignedUsersForProjectFailed";

        public static const SAVE_PROJECT_ASSIGNMENTS_CHAIN_START:String = "saveProjectAssignmentsChainStart";
        public static const SAVE_PROJECT_ASSIGNMENTS_REQUEST:String = "saveProjectAssignmentsRequest";
        public static const SAVE_PROJECT_ASSIGNMENTS_SUCCESS:String = "saveProjectAssignmentsSuccess";
        public static const SAVE_PROJECT_ASSIGNMENTS_FAILED:String = "saveProjectAssignmentsFailed";
        public static const SAVE_PROJECT_ASSIGNMENTS_CHAIN_COMPLETE:String = "saveProjectAssignmentsChainComplte";

        public static const GET_PROJECTS_FOR_USER_SUCCESS:String = "getProjectsForUserSuccess";
        public static const GET_PROJECTS_FOR_USER_FAILURE:String = "getProjectsForUserFailure";
        public static const GET_PROJECTS_FOR_USER_REQUEST:String = "getProjectsForUserRequest";

        public static const INITIALIZE_EXPENSE_REPORT_VIEW_COMPLETE:String = "initializeExpenseReportViewComplete";
        public static const INITIALIZE_EXPENSE_REPORT_VIEW:String = "initializeExpenseReportView";

        public static const INITIALIZE_OPEN_EXPENSE_REPORT_VIEW_COMPLETE:String = "initializeOpenExpenseReportViewComplete";
        public static const INITIALIZE_OPEN_EXPENSE_REPORT_VIEW:String = "initializeOpenExpenseReportView";
        
        public static const SAVE_EXPENSE_REPORT_REQUEST:String = "saveExpenseReportRequest";
        public static const SAVE_EXPENSE_REPORT_SUCCESS:String = "saveExpenseReportSuccess";
        public static const SAVE_EXPENSE_REPORT_FAILURE:String = "saveExpenseReportFailure";

        public static const APPROVE_EXPENSE_REPORT_REQUEST:String = "approveExpenseReportRequest";
        public static const APPROVE_EXPENSE_REPORT_SUCCESS:String = "approveExpenseReportSuccess";
        public static const APPROVE_EXPENSE_REPORT_FAILURE:String = "approveExpenseReportFailure";

        public static const DECLINE_EXPENSE_REPORT_REQUEST:String = "declineExpenseReportRequest";
        public static const DECLINE_EXPENSE_REPORT_SUCCESS:String = "declineExpenseReportSuccess";
        public static const DECLINE_EXPENSE_REPORT_FAILURE:String = "declineExpenseReportFailure";

        public static const SUBMIT_EXPENSE_REPORT_REQUEST:String = "submitExpenseReportRequest";
        public static const SUBMIT_EXPENSE_REPORT_SUCCESS:String = "submitExpenseReportSuccess";
        public static const SUBMIT_EXPENSE_REPORT_FAILURE:String = "submitExpenseReportFailure";

        public static const REOPEN_EXPENSE_REPORT_REQUEST:String = "reopenExpenseReportRequest";
        public static const REOPEN_EXPENSE_REPORT_SUCCESS:String = "reopenExpenseReportSuccess";
        public static const REOPEN_EXPENSE_REPORT_FAILURE:String = "reopenExpenseReportFailure";

        public static const FIND_EXPENSE_REPORT_REQUEST:String = "findExpenseReportRequest";
        public static const FIND_EXPENSE_REPORT_SUCCESS:String = "findExpenseReportSuccess";
        public static const FIND_EXPENSE_REPORT_FAILURE:String = "findExpenseReportFailure";

        public static const FIND_PAYMENT_METHODS_REQUEST:String = "findPaymentMethodsRequest";
        public static const FIND_PAYMENT_METHODS_SUCCESS:String = "findPaymentMethodsSuccess";
        public static const FIND_PAYMENT_METHODS_FAILURE:String = "findPaymentMethodsFailure";

        public static const FIND_EXPENSE_ITEM_TYPES_REQUEST:String = "findExpenseItemTypesRequest";
        public static const FIND_EXPENSE_ITEM_TYPES_SUCCESS:String = "findExpenseItemTypesSuccess";
        public static const FIND_EXPENSE_ITEM_TYPES_FAILURE:String = "findExpenseItemTypesFailure";

        public static const FIND_PROJECT_TYPES_REQUEST:String = "findProjectTypesRequest";
        public static const FIND_PROJECT_TYPES_SUCCESS:String = "findProjectTypesSuccess";
        public static const FIND_PROJECT_TYPES_FAILURE:String = "findProjectTypesFailure";

        public static const INITIALIZE_VIEW_OPEN_EXPENSE_REPORTS_VIEW:String = "initializeOpenExpenseReportsView";
        public static const INITIALIZE_VIEW_OPEN_EXPENSE_REPORTS_VIEW_COMPLETE:String = "initializeOpenExpenseReportsViewComplete";

        public static const FIND_OPEN_EXPENSE_REPORTS_FOR_USER_REQUEST:String = "findOpenExpenseReportsForUserRequest";
        public static const FIND_OPEN_EXPENSE_REPORTS_FOR_USER_SUCCESS:String = "findOpenExpenseReportsForUserSuccess";
        public static const FIND_OPEN_EXPENSE_REPORTS_FOR_USER_FAILURE:String = "findOpenExpenseReportsForUserFailure";

        public static const INITIALIZE_VIEW_SUBMITTED_EXPENSE_REPORTS_VIEW:String = "initializeSubmittedExpenseReportsView";
        public static const INITIALIZE_VIEW_SUBMITTED_EXPENSE_REPORTS_VIEW_COMPLETE:String = "initializeSubmittedExpenseReportsViewComplete";

        public static const FIND_SUBMITTED_EXPENSE_REPORTS_FOR_USER_REQUEST:String = "findSubmittedExpenseReportsForUserRequest";
        public static const FIND_SUBMITTED_EXPENSE_REPORTS_FOR_USER_SUCCESS:String = "findSubmittedExpenseReportsForUserSuccess";
        public static const FIND_SUBMITTED_EXPENSE_REPORTS_FOR_USER_FAILURE:String = "findSubmittedExpenseReportsForUserFailure";

        public static const FIND_EXPENSE_REPORT_BY_ID_REQUEST:String = "findExpenseReportByIdRequest";
        public static const FIND_EXPENSE_REPORT_BY_ID_SUCCESS:String = "findExpenseReportByIdSuccess";
        public static const FIND_EXPENSE_REPORT_BY_ID_FAILURE:String = "findExpenseReportByIdFailure";

        public static const DELETE_ACTIVE_EXPENSE_REPORT_REQUEST:String = "deleteActiveExpenseReportRequest";
        public static const DELETE_ACTIVE_EXPENSE_REPORT_SUCCESS:String = "deleteActiveExpenseReportSuccess";
        public static const DELETE_ACTIVE_EXPENSE_REPORT_FAILURE:String = "deleteActiveExpenseReportFailure";

        public static const INITIALIZE_EDIT_EXPENSE_REPORT_VIEW:String = "initializeEditExpenseReportView";
        public static const INITIALIZE_EDIT_EXPENSE_REPORT_VIEW_COMPLETE:String = "initializeEditExpenseReportViewComplete";

        public static const INITIALIZE_VIEW_EXPENSE_REPORT_VIEW:String = "initializeViewExpenseReportView";
        public static const INITIALIZE_VIEW_EXPENSE_REPORT_VIEW_COMPLETE:String = "initializeViewExpenseReportViewComplete";

        public static const GET_EXPENSE_ITEMS_SUCCESS:String = "getExpenseItemsSuccess";
        public static const GET_EXPENSE_ITEMS_FAILURE:String = "getExpenseItemsFailure";

        public static const INITIALIZE_AWAITING_EXPENSE_REPORT_VIEW:String = "initializeAwaitingExpenseReportView";
        public static const INITIALIZE_AWAITING_EXPENSE_REPORT_VIEW_COMPLETE:String = "initializeAwaitingExpenseReportViewComplete";

        public static const FIND_AWAITING_EXPENSE_REPORTS_FOR_USER_REQUEST:String = "findAwaitingExpenseReportsForUserRequest";
        public static const FIND_AWAITING_EXPENSE_REPORTS_FOR_USER_SUCCESS:String = "findAwaitingExpenseReportsForUserSuccess";
        public static const FIND_AWAITING_EXPENSE_REPORTS_FOR_USER_FAILURE:String = "findAwaitingExpenseReportsForUserFailure";

        public static const SHOW_DECLINE_DIALOG:String = "showDeclineExpenseReportDialog";
        public static const SHOW_APPROVE_DIALOG:String = "showApproveExpenseReportDialog";
        public static const SHOW_VIEW_DIALOG:String = "showViewExpenseReportDialog";

        public static const ADD_RECEIPT_TO_EXPENSE_REPORT_REQUEST:String = "addReceiptToExpenseReportRequest";
        public static const ADD_RECEIPT_TO_EXPENSE_REPORT_SUCCESS:String = "addReceiptToExpenseReportSuccess";
        public static const ADD_RECEIPT_TO_EXPENSE_REPORT_FAILED:String = "addReceiptToExpenseReportFailed";

        public static const FORGOT_PASSWORD_REQUEST:String = "forgotPasswordRequest";
        public static const FORGOT_PASSWORD_FAULT:String = "forgotPasswordFault";
        public static const FORGOT_PASSWORD_SUCCESS:String = "forgotPasswordSuccess";
    }
}