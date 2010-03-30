package com.neosavvy.user.view.secured.leftNavigation.admin {
    import com.neosavvy.user.ApplicationFacade;

    import flash.events.MouseEvent;

    import mx.controls.LinkButton;
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
            welcomeButton.addEventListener(MouseEvent.CLICK, handleWelcomeButtonClicked);
            inviteEmployeesButton.addEventListener(MouseEvent.CLICK, handleInviteEmployeesButtonClicked);
            viewAllEmployeesButton.addEventListener(MouseEvent.CLICK, handleViewAllEmployeesClicked);

            manageClientsButton.addEventListener(MouseEvent.CLICK, handleManageClientsButtonClicked);
            manageProjectsButton.addEventListener(MouseEvent.CLICK, handleManageProjectsButtonClicked);

            approveExpenses.addEventListener(MouseEvent.CLICK, handleApproveExpensesButtonClicked);
        }

        private function handleApproveExpensesButtonClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_VIEW_AWAITING_EXPENSE_REPORTS);
        }

        private function handleManageProjectsButtonClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_PROJECT_MANAGEMENT);
        }

        private function handleManageClientsButtonClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_CLIENT_MANAGEMENT);
        }

        private function handleWelcomeButtonClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_WELCOME, ApplicationFacade.NAVIGATE_TO_WELCOME);
        }

        private function handleInviteEmployeesButtonClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES, ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES);
        }

        private function handleViewAllEmployeesClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.ALL_EMPLOYEES_REQUEST);
        }

        public function get adminNavigation():AdminNavigation {
            return viewComponent as AdminNavigation;
        }

        public function get welcomeButton():LinkButton {
            return adminNavigation.welcomeButton;
        }

        public function get inviteEmployeesButton():LinkButton {
            return adminNavigation.inviteEmployeesButton;
        }

        public function get viewAllEmployeesButton():LinkButton {
            return adminNavigation.viewAllEmployeesButton;
        }

        public function get manageProjectsButton():LinkButton {
            return adminNavigation.manageProjectsButton;
        }

        public function get manageClientsButton():LinkButton {
            return adminNavigation.manageClientsButton;
        }

        public function get approveExpenses():LinkButton {
            return adminNavigation.approveExpenses;
        }

        override public function listNotificationInterests():Array {
            return super.listNotificationInterests();
        }

        override public function handleNotification(notification:INotification):void {
        }

    }
}