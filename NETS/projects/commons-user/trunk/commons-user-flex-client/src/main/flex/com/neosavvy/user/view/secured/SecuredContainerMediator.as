package com.neosavvy.user.view.secured {
    import com.neosavvy.user.ApplicationFacade;

    import mx.containers.ViewStack;
    import mx.logging.ILogger;
    import mx.logging.Log;

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

        public static const NAV_INDEX_CREATE_EXPENSE_REPORT:Number  = 5;
        public static const NAV_INDEX_VIEW_OPEN_EXPENSES:Number     = 6;
        public static const NAV_INDEX_VIEW_APPROVED_EXPENSES:Number = 7;
        public static const NAV_INDEX_RECONCILE_EXPENSES:Number     = 8;

        public static const NAV_INDEX_APPROVE_EXPENSES:Number       = 9;

        override public function onRegister():void {
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
                ,ApplicationFacade.NAVIGATE_TO_PROJECT_MANAGEMENT

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

                ,ApplicationFacade.REQUEST_LOGOUT
            ];
        }

        override public function handleNotification(notification:INotification):void {
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
                case ApplicationFacade.NAVIGATE_TO_PROJECT_MANAGEMENT:
                    navigationViewStack.selectedIndex = NAV_INDEX_PROJECT_MANAGEMENT;
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




            }
        }

    }
}