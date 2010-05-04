package com.neosavvy.user.view.secured.leftNavigation.admin {
    import com.neosavvy.user.ApplicationFacade;

    import flash.events.MouseEvent;

    import mx.controls.LinkButton;
    import mx.events.ItemClickEvent;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class AdminNavigationMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.leftNavigation.admin.AdminNavigationMediator");

        public static const NAME:String = "adminNavigationMediator";

        public function AdminNavigationMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            adminNavigation.toggleBar.addEventListener(ItemClickEvent.ITEM_CLICK, handleAdminNavigationChanged);
            
//            welcomeButton.addEventListener(MouseEvent.CLICK, handleWelcomeButtonClicked);
//            inviteEmployeesButton.addEventListener(MouseEvent.CLICK, handleInviteEmployeesButtonClicked);
//            viewAllEmployeesButton.addEventListener(MouseEvent.CLICK, handleViewAllEmployeesClicked);
//
//            manageClientsButton.addEventListener(MouseEvent.CLICK, handleManageClientsButtonClicked);
//            manageProjectsButton.addEventListener(MouseEvent.CLICK, handleManageProjectsButtonClicked);
//
//            approveExpenses.addEventListener(MouseEvent.CLICK, handleApproveExpensesButtonClicked);
        }

        private function handleAdminNavigationChanged(event:ItemClickEvent):void {
            switch (event.label) 
            {
                case "Welcome":
                    handleWelcomeButtonClicked();
                    break;
                case "Invite Employees":
                    handleInviteEmployeesButtonClicked();
                    break;
                case "View Employees":
                    handleViewAllEmployeesClicked();
                    break;
                case "Manage Clients":
                    handleManageClientsButtonClicked();
                    break;
                case "Manage Projects":
                    handleManageProjectsButtonClicked();
                    break;
                case "Approve Expenses":
                    handleApproveExpensesButtonClicked();
                    break;
                case "View Open Expenses":
                    handleViewOpenExpensesButtonClicked();
                    break;
                case "Create Expense Report":
                    handleAddExpenseReportsButtonClicked();
                    break;
                case "View Submitted Expenses":
                    handleViewSubmittedExpensesButtonClicked();
                    break;
                case "Reconcile Expenses":
                    handleReconcileExpenseReportsButtonClicked();
                    break;
            }
        }

        private function handleApproveExpensesButtonClicked():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_VIEW_AWAITING_EXPENSE_REPORTS);
        }

        private function handleManageProjectsButtonClicked():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_PROJECT_MANAGEMENT);
        }

        private function handleManageClientsButtonClicked():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_CLIENT_MANAGEMENT);
        }

        private function handleWelcomeButtonClicked():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_WELCOME, ApplicationFacade.NAVIGATE_TO_WELCOME);
        }

        private function handleInviteEmployeesButtonClicked():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES, ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES);
        }

        private function handleViewAllEmployeesClicked():void {
            sendNotification(ApplicationFacade.ALL_EMPLOYEES_REQUEST);
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

        private function handleAddExpenseReportsButtonClicked():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_CREATE_EXPENSE_REPORT);
        }

        public function get adminNavigation():AdminNavigation {
            return viewComponent as AdminNavigation;
        }

        override public function listNotificationInterests():Array {
            return super.listNotificationInterests();
        }

        override public function handleNotification(notification:INotification):void {
        }

    }
}