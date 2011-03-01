package com.neosavvy.user.view.secured {
    import com.neosavvy.user.ApplicationFacade;

    import com.neosavvy.user.model.SecurityProxy;

    import com.neosavvy.user.view.secured.userInfo.popup.PasswordChangedReminder;

    import flash.display.DisplayObject;

    import flash.events.Event;

    import mx.containers.ViewStack;
    import mx.controls.Alert;
    import mx.core.Application;
    import mx.core.IFlexDisplayObject;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import mx.managers.PopUpManager;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class SecuredContainerMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.SecuredContainerMediator");

        public static const NAME:String = "securedContainerMediator";

        public function SecuredContainerMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        public static const NAV_INDEX_WELCOME:Number                = 0;
        public static const NAV_INDEX_INVITE_EMPLOYEES:Number       = 1;
        public static const NAV_INDEX_USER_MANAGEMENT:Number        = 2;
        public static const NAV_INDEX_CLIENT_MANAGEMENT:Number      = 3;
        public static const NAV_INDEX_PROJECT_MANAGEMENT:Number     = 4;
        public static const NAV_INDEX_ASSIGNMENTS_MANAGEMENT:Number = 5;

        public static const NAV_INDEX_CREATE_EXPENSE_REPORT:Number  = 6;
        public static const NAV_INDEX_VIEW_OPEN_EXPENSES:Number     = 7;
        public static const NAV_INDEX_VIEW_APPROVED_EXPENSES:Number = 8;
        public static const NAV_INDEX_RECONCILE_EXPENSES:Number     = 9;

        public static const NAV_INDEX_APPROVE_EXPENSES:Number       = 10;

        public static const NAV_INDEX_MANAGE_RECEIPTS:Number        = 11;
        public static const NAV_INDEX_YOUR_INFORMATION:Number       = 12;

        private var _securityProxy:SecurityProxy;

        override public function onRegister():void {
            _securityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
        }

        public function get securedContainer():SecuredContainer {
            return viewComponent as SecuredContainer;
        }

        public function get navigationViewStack():ViewStack {
            return securedContainer.navigationViewStack;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_WELCOME
                ,ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES
                ,ApplicationFacade.NAVIGATE_TO_CLIENT_MANAGEMENT
                ,ApplicationFacade.NAVIGATE_TO_MANAGE_PROJECTS
                ,ApplicationFacade.NAVIGATE_TO_ASSIGNMENTS

                ,ApplicationFacade.ALL_EMPLOYEES_FAILED
                ,ApplicationFacade.ALL_EMPLOYEES_SUCCESS
                ,ApplicationFacade.NON_ACTIVE_EMPLOYEES_SUCCESS
                ,ApplicationFacade.ACTIVE_EMPLOYEES_SUCCESS

                ,ApplicationFacade.NAVIGATE_TO_CREATE_EXPENSE_REPORT
                ,ApplicationFacade.NAVIGATE_TO_EDIT_EXPENSE_REPORT
                ,ApplicationFacade.NAVIGATE_TO_VIEW_OPEN_EXPENSE_REPORTS
                ,ApplicationFacade.NAVIGATE_TO_VIEW_SUBMITTED_EXPENSE_REPORTS
                ,ApplicationFacade.NAVIGATE_TO_RECONCILE_EXPENSE_REPORTS

                ,ApplicationFacade.NAVIGATE_TO_VIEW_AWAITING_EXPENSE_REPORTS
                ,ApplicationFacade.NAVIGATE_TO_MANAGE_RECEIPTS

                ,ApplicationFacade.NAVIGATE_TO_YOUR_INFORMATION

                ,ApplicationFacade.REQUEST_LOGOUT
                ,ApplicationFacade.USER_LOGIN_STARTUP_COMPLETE
            ];
        }

        override public function handleNotification(notification:INotification):void {
            if( navigationViewStack )
            {
                switch (notification.getName()) {
                    case ApplicationFacade.NAVIGATE_TO_WELCOME:
                        navigationViewStack.selectedIndex = NAV_INDEX_WELCOME;
                        break;
                    case ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES:
                        navigationViewStack.selectedIndex = NAV_INDEX_INVITE_EMPLOYEES;
                        break;
                    case ApplicationFacade.NAVIGATE_TO_CLIENT_MANAGEMENT:
                        navigationViewStack.selectedIndex = NAV_INDEX_CLIENT_MANAGEMENT;
                        break;
                    case ApplicationFacade.NAVIGATE_TO_MANAGE_PROJECTS:
                        navigationViewStack.selectedIndex = NAV_INDEX_PROJECT_MANAGEMENT;
                        break;
                    case ApplicationFacade.NAVIGATE_TO_ASSIGNMENTS:
                        navigationViewStack.selectedIndex = NAV_INDEX_ASSIGNMENTS_MANAGEMENT;
                        break;
                    case ApplicationFacade.NAVIGATE_TO_CREATE_EXPENSE_REPORT:
                    case ApplicationFacade.NAVIGATE_TO_EDIT_EXPENSE_REPORT:
                        navigationViewStack.selectedIndex = NAV_INDEX_CREATE_EXPENSE_REPORT;
                        break;
                    case ApplicationFacade.NAVIGATE_TO_VIEW_OPEN_EXPENSE_REPORTS:
                        navigationViewStack.selectedIndex = NAV_INDEX_VIEW_OPEN_EXPENSES;
                        break;

                    case ApplicationFacade.NAVIGATE_TO_VIEW_SUBMITTED_EXPENSE_REPORTS:
                        navigationViewStack.selectedIndex = NAV_INDEX_VIEW_APPROVED_EXPENSES;
                        break;
                    case ApplicationFacade.NAVIGATE_TO_RECONCILE_EXPENSE_REPORTS:
                        navigationViewStack.selectedIndex = NAV_INDEX_RECONCILE_EXPENSES;
                        break;

                    case ApplicationFacade.ALL_EMPLOYEES_SUCCESS:
                    case ApplicationFacade.NON_ACTIVE_EMPLOYEES_SUCCESS:
                    case ApplicationFacade.ACTIVE_EMPLOYEES_SUCCESS:
                        navigationViewStack.selectedIndex = NAV_INDEX_USER_MANAGEMENT;
                        break;
                    case ApplicationFacade.NAVIGATE_TO_VIEW_AWAITING_EXPENSE_REPORTS:
                        navigationViewStack.selectedIndex = NAV_INDEX_APPROVE_EXPENSES;
                        break;

                    case ApplicationFacade.REQUEST_LOGOUT:
                        navigationViewStack.selectedIndex = NAV_INDEX_WELCOME;
                        break;

                    case ApplicationFacade.NAVIGATE_TO_MANAGE_RECEIPTS:
                        navigationViewStack.selectedIndex = NAV_INDEX_MANAGE_RECEIPTS;
                        break;
                    case ApplicationFacade.NAVIGATE_TO_YOUR_INFORMATION:
                        navigationViewStack.selectedIndex = NAV_INDEX_YOUR_INFORMATION;
                        break;

                    case ApplicationFacade.USER_LOGIN_STARTUP_COMPLETE:
                        if( _securityProxy.activeUser && _securityProxy.activeUser.passwordReset )
                        {
                            var passwordChangedReminder : IFlexDisplayObject =
                                    PopUpManager.createPopUp(Application.application as DisplayObject,PasswordChangedReminder);
                            PopUpManager.centerPopUp( passwordChangedReminder );
                            passwordChangedReminder.addEventListener( "changePasswordNow", onChangePassword);
                        }
                        break;
                }
            }
        }

        private function onChangePassword(event:Event):void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_YOUR_INFORMATION);
        }

    }
}