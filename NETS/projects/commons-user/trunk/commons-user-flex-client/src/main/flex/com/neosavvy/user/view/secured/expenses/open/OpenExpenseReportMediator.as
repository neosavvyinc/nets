package com.neosavvy.user.view.secured.expenses.open {
    import com.neosavvy.user.model.ExpenseReportServiceProxy;
    import com.neosavvy.user.model.UserServiceProxy;
    import com.neosavvy.user.ApplicationFacade;

    import mx.controls.AdvancedDataGrid;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class OpenExpenseReportMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.expenses.open.OpenExpenseReportMediator");

        public static const NAME:String = "openExpenseReportMediator";

        private var _userServiceProxy:UserServiceProxy;
        private var _expenseServiceProxy:ExpenseReportServiceProxy;

        public function OpenExpenseReportMediator(viewComponent:Object) {
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

        public function get openExpenseReport():OpenExpenseReport {
            return viewComponent as OpenExpenseReport;
        }

        public function get openExpenseGrid():AdvancedDataGrid {
            return openExpenseReport.openExpenseGrid;
        }
        
        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_VIEW_OPEN_EXPENSE_REPORTS
                ,ApplicationFacade.FIND_EXPENSE_REPORTS_FOR_USER_SUCCESS
            ];
        }

        override public function handleNotification(notification:INotification):void {

            switch ( notification.getName() ) {
                case ApplicationFacade.NAVIGATE_TO_VIEW_OPEN_EXPENSE_REPORTS:
                    sendNotification(ApplicationFacade.INITIALIZE_VIEW_OPEN_EXPENSE_REPORTS_VIEW, _userServiceProxy.activeUser);
                    break;
                case ApplicationFacade.FIND_EXPENSE_REPORTS_FOR_USER_SUCCESS:
                    openExpenseGrid.dataProvider = _expenseServiceProxy.openExpenseReports;
                    break;
            }
        }

    }
}