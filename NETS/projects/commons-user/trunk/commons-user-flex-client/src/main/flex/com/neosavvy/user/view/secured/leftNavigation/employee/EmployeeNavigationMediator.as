package com.neosavvy.user.view.secured.leftNavigation.employee {
    import com.neosavvy.user.model.SecurityProxy;
    import com.neosavvy.user.view.secured.leftNavigation.admin.*;
    import com.neosavvy.user.ApplicationFacade;

    import flash.events.MouseEvent;

    import mx.controls.LinkButton;
    import mx.events.ItemClickEvent;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class EmployeeNavigationMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.leftNavigation.employee.EmployeeNavigationMediator");

        public static const NAME:String = "employeeNavigationMediator";

        public function EmployeeNavigationMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            adminNavigation.toggleBar.addEventListener(ItemClickEvent.ITEM_CLICK, handleAdminNavigationChanged);
            adminNavigation.toggleBarEmployee.addEventListener(ItemClickEvent.ITEM_CLICK, handleAdminNavigationChanged);
        }

        private function toggleBarFocus(index:Number):void{
            adminNavigation.toggleBar.selectedIndex = index;
            adminNavigation.toggleBarEmployee.selectedIndex = -1;
        }


        private function toggleBarEmployeeFocus(index:Number):void{
            adminNavigation.toggleBarEmployee.selectedIndex = index;
            adminNavigation.toggleBar.selectedIndex = -1;
        }

        private function handleAdminNavigationChanged(event:ItemClickEvent):void {
            switch (event.label) 
            {
                case "Welcome":
                    toggleBarFocus(0);
                    handleWelcomeButtonClicked();
                    break;
                case "View Open Expenses":
                    toggleBarEmployeeFocus(0);
                    handleViewOpenExpensesButtonClicked();
                    break;
                case "Create Expense Report":
                    toggleBarEmployeeFocus(1);
                    handleAddExpenseReportsButtonClicked();
                    break;
                case "View Submitted Expenses":
                    toggleBarEmployeeFocus(2);
                    handleViewSubmittedExpensesButtonClicked();
                    break;
//                case "Reconcile Expenses":
//                    toggleBarEmployeeFocus(3);
//                    handleReconcileExpenseReportsButtonClicked();
//                    break;
                case "Manage Receipts":
                    toggleBarEmployeeFocus(3);
                    handleManageReceipts();
                    break;
            }
        }

        private function handleWelcomeButtonClicked():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_WELCOME, ApplicationFacade.NAVIGATE_TO_WELCOME);
        }


        private function handleViewSubmittedExpensesButtonClicked():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_VIEW_SUBMITTED_EXPENSE_REPORTS);
        }

        private function handleViewOpenExpensesButtonClicked():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_VIEW_OPEN_EXPENSE_REPORTS);
        }

        private function handleReconcileExpenseReportsButtonClicked():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_RECONCILE_EXPENSE_REPORTS);
        }

        private function handleManageReceipts():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_MANAGE_RECEIPTS);
        }

        private function handleAddExpenseReportsButtonClicked():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_CREATE_EXPENSE_REPORT);
        }

        public function get adminNavigation():EmployeeNavigation {
            return viewComponent as EmployeeNavigation;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.USER_LOGIN_SUCCESS
                ,ApplicationFacade.USER_LOGGED_IN
                ,ApplicationFacade.POST_SECURE_VIEW_PREP
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch ( notification.getName() )
            {
                case ApplicationFacade.USER_LOGIN_SUCCESS:
                case ApplicationFacade.USER_LOGGED_IN:
                case ApplicationFacade.POST_SECURE_VIEW_PREP:
                    toggleBarFocus(0);
                    handleWelcomeButtonClicked();
                    break;
            }
        }

    }
}