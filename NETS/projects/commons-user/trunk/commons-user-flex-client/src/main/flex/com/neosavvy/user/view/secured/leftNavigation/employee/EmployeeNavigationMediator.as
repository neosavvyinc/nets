package com.neosavvy.user.view.secured.leftNavigation.employee {
    import com.neosavvy.user.ApplicationFacade;

    import flash.events.MouseEvent;

    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class EmployeeNavigationMediator extends Mediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.leftNavigation.admin.EmployeeNavigationMediator");

        public static const NAME:String = "employeeNavigationMediator";
        
        public function EmployeeNavigationMediator(viewComponent:Object) {
            super(NAME,viewComponent);
        }

        public function get employeeNavigation():EmployeeNavigation {
            return viewComponent as EmployeeNavigation;
        }

        override public function onRegister():void {
            this.employeeNavigation.addExpenseReportBtn.addEventListener(MouseEvent.CLICK, handleAddExpenseReportsButtonClicked);
            this.employeeNavigation.reconcileExpensesBtn.addEventListener(MouseEvent.CLICK, handleReconcileExpenseReportsButtonClicked);
            this.employeeNavigation.viewOpenExpensesBtn.addEventListener(MouseEvent.CLICK, handleViewOpenExpensesButtonClicked);
            this.employeeNavigation.viewSubmittedExpensesBtn.addEventListener(MouseEvent.CLICK, handleViewSubmittedExpensesButtonClicked);
        }

        override public function listNotificationInterests():Array {
            return super.listNotificationInterests();
        }

        override public function handleNotification(notification:INotification):void {
            super.handleNotification(notification);
        }

        private function handleViewSubmittedExpensesButtonClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_VIEW_SUBMITTED_EXPENSE_REPORTS);
        }

        private function handleViewOpenExpensesButtonClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_VIEW_OPEN_EXPENSE_REPORTS);
        }

        private function handleReconcileExpenseReportsButtonClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_RECONCILE_EXPENSE_REPORTS);
        }

        private function handleAddExpenseReportsButtonClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_CREATE_EXPENSE_REPORT);
        }
    }
}