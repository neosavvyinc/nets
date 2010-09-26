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
            adminNavigation.toggleBarAdmin.addEventListener(ItemClickEvent.ITEM_CLICK, handleAdminNavigationChanged);
            adminNavigation.toggleBarEmployee.addEventListener(ItemClickEvent.ITEM_CLICK, handleAdminNavigationChanged);
            
//            welcomeButton.addEventListener(MouseEvent.CLICK, handleWelcomeButtonClicked);
//            inviteEmployeesButton.addEventListener(MouseEvent.CLICK, handleInviteEmployeesButtonClicked);
//            viewAllEmployeesButton.addEventListener(MouseEvent.CLICK, handleViewAllEmployeesClicked);
//
//            manageClientsButton.addEventListener(MouseEvent.CLICK, handleManageClientsButtonClicked);
//            manageProjectsButton.addEventListener(MouseEvent.CLICK, handleManageProjectsButtonClicked);
//
//            approveExpenses.addEventListener(MouseEvent.CLICK, handleApproveExpensesButtonClicked);
        }

        private function toggleBarFocus(index:Number):void{
            adminNavigation.toggleBar.selectedIndex = index;
            adminNavigation.toggleBarAdmin.selectedIndex = -1;
            adminNavigation.toggleBarEmployee.selectedIndex = -1;
        }


        private function toggleBarAdminFocus(index:Number):void{
            adminNavigation.toggleBarAdmin.selectedIndex = index;
            adminNavigation.toggleBar.selectedIndex = -1;
            adminNavigation.toggleBarEmployee.selectedIndex = -1;
        }


        private function toggleBarEmployeeFocus(index:Number):void{
            adminNavigation.toggleBarEmployee.selectedIndex = index;
            adminNavigation.toggleBarAdmin.selectedIndex = -1;
            adminNavigation.toggleBar.selectedIndex = -1;
        }

        private function handleAdminNavigationChanged(event:ItemClickEvent):void {
            switch (event.label) 
            {
                case "Welcome":
                    toggleBarFocus(0);
                    handleWelcomeButtonClicked();
                    break;
                case "Invite Employees":
                    toggleBarAdminFocus(0);
                    handleInviteEmployeesButtonClicked();
                    break;
                case "View Employees":
                    toggleBarAdminFocus(1);
                    handleViewAllEmployeesClicked();
                    break;
                case "Manage Clients":
                    toggleBarAdminFocus(2);
                    handleManageClientsButtonClicked();
                    break;
                case "Manage Projects":
                    toggleBarAdminFocus(3);
                    handleManageProjectsButtonClicked();
                    break;
                case "Approve Expenses":
                    toggleBarAdminFocus(4);
                    handleApproveExpensesButtonClicked();
                    break;
                case "Manage Assignments":
                    toggleBarAdminFocus(5);
                    handleManageAssignmentsButtonClicked();
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

        private function handleManageAssignmentsButtonClicked():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_ASSIGNMENTS);
        }

        private function handleApproveExpensesButtonClicked():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_VIEW_AWAITING_EXPENSE_REPORTS);
        }

        private function handleManageProjectsButtonClicked():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_MANAGE_PROJECTS);
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

        private function handleManageReceipts():void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_MANAGE_RECEIPTS);
        }

        public function get adminNavigation():AdminNavigation {
            return viewComponent as AdminNavigation;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES
                ,ApplicationFacade.NAVIGATE_TO_CLIENT_MANAGEMENT
                ,ApplicationFacade.NAVIGATE_TO_MANAGE_PROJECTS
            ];
        }

        override public function handleNotification(notification:INotification):void {

            switch ( notification.getName() )
            {
                case ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES:
                    toggleBarAdminFocus(0);
                    break;
                case ApplicationFacade.NAVIGATE_TO_CLIENT_MANAGEMENT:
                    toggleBarAdminFocus(2);
                    break;
                case ApplicationFacade.NAVIGATE_TO_MANAGE_PROJECTS:
                    toggleBarAdminFocus(3);
                    break;
            }

        }

    }
}