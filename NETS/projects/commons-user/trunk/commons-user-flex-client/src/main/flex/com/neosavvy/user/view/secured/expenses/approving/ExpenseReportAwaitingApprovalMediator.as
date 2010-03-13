package com.neosavvy.user.view.secured.expenses.approving {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;
    import com.neosavvy.user.model.UserServiceProxy;

    import mx.controls.AdvancedDataGrid;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ExpenseReportAwaitingApprovalMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.expenses.approving.ExpenseReportAwaitingApprovalMediator");

        public static const NAME:String = "expenseReportAwaitingApprovalMediator";

        private var _userServiceProxy:UserServiceProxy;
        private var _expenseServiceProxy:ExpenseReportServiceProxy;

        public function ExpenseReportAwaitingApprovalMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            _userServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;
            _expenseServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
        }

        override public function onRemove():void {
            _userServiceProxy = null;
            _expenseServiceProxy = null;
        }

        public function get expenseReportAwaitingApproval():ExpenseReportAwaitingApproval
        {
            return viewComponent as ExpenseReportAwaitingApproval;
        }

        public function get expenseReportAwaitingApprovalGrid():AdvancedDataGrid
        {
            return expenseReportAwaitingApproval.awaitingApprovalExpenseGrid;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_VIEW_AWAITING_EXPENSE_REPORTS
                ,ApplicationFacade.FIND_AWAITING_EXPENSE_REPORTS_FOR_USER_SUCCESS
            ];
        }

        override public function handleNotification(notification:INotification):void {

            switch ( notification.getName() ) {
                case ApplicationFacade.NAVIGATE_TO_VIEW_AWAITING_EXPENSE_REPORTS:
                    sendNotification(ApplicationFacade.INITIALIZE_AWAITING_EXPENSE_REPORT_VIEW, _userServiceProxy.activeUser);
                    break;
                case ApplicationFacade.FIND_AWAITING_EXPENSE_REPORTS_FOR_USER_SUCCESS:
                    expenseReportAwaitingApprovalGrid.dataProvider = _expenseServiceProxy.awaitingExpenseReportItems;
                    break;
            }
        }

    }
}