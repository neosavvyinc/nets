package com.neosavvy.user.view.secured.expenses.submitted {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;
    import com.neosavvy.user.model.UserServiceProxy;
    import com.neosavvy.user.view.secured.expenses.approving.event.ExpenseReportApproveEvent;
    import com.neosavvy.user.view.secured.expenses.open.event.ExpenseReportEvent;
    import com.neosavvy.user.view.secured.expenses.submitted.popup.ReopenConfirmationPanel;

    import flash.display.DisplayObject;

    import mx.controls.DataGrid;
    import mx.core.Application;
    import mx.core.IFlexDisplayObject;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.managers.PopUpManager;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class SubmittedExpenseReportMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.expenses.submitted.SubmittedExpenseReportMediator");

        public static const NAME:String = "submittedExpenseReportMediator";

        private var _userServiceProxy:UserServiceProxy;
        private var _expenseServiceProxy:ExpenseReportServiceProxy;

        public function SubmittedExpenseReportMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }


        override public function onRegister():void {
            _userServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;
            _expenseServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;

            submittedExpenseReportGrid.addEventListener(ExpenseReportEvent.TYPE, handleExpenseReportEvent);

            submittedExpenseReportGrid.addEventListener(ExpenseReportApproveEvent.TYPE, handleExpenseReportApprovalEvent);
        }

        override public function onRemove():void {
            _userServiceProxy = null;
            _expenseServiceProxy = null;

             submittedExpenseReportGrid.removeEventListener(ExpenseReportEvent.TYPE, handleExpenseReportEvent);
        }

        public function get submittedExpenseReport():SubmittedExpenseReport {
            return viewComponent as SubmittedExpenseReport;
        }

        public function get submittedExpenseReportGrid():DataGrid {
            return submittedExpenseReport.submittedExpenseGrid;
        }

        override public function listNotificationInterests():Array {
            return [
                    ApplicationFacade.NAVIGATE_TO_VIEW_SUBMITTED_EXPENSE_REPORTS
                    ,ApplicationFacade.FIND_SUBMITTED_EXPENSE_REPORTS_FOR_USER_SUCCESS
                    ,ApplicationFacade.REOPEN_EXPENSE_REPORT_SUCCESS
            ];
        }


        override public function handleNotification(notification:INotification):void {

            switch ( notification.getName() )
            {
                case ApplicationFacade.NAVIGATE_TO_VIEW_SUBMITTED_EXPENSE_REPORTS:
                    sendNotification(ApplicationFacade.INITIALIZE_VIEW_SUBMITTED_EXPENSE_REPORTS_VIEW, _userServiceProxy.activeUser)
                    break;
                case ApplicationFacade.FIND_SUBMITTED_EXPENSE_REPORTS_FOR_USER_SUCCESS:
                    submittedExpenseReportGrid.dataProvider = _expenseServiceProxy.submittedExpenseReports;
                    break;
                case ApplicationFacade.REOPEN_EXPENSE_REPORT_SUCCESS:
                    sendNotification(ApplicationFacade.INITIALIZE_VIEW_SUBMITTED_EXPENSE_REPORTS_VIEW, _userServiceProxy.activeUser);
                    break;
            }

        }

        private function handleExpenseReportApprovalEvent( event : ExpenseReportApproveEvent ) : void
        {
            switch ( event.action )
            {
                case ExpenseReportApproveEvent.ACTION_VIEW:
                    sendNotification(ApplicationFacade.SHOW_VIEW_DIALOG, [event.expenseReport, false]);
                    break;
            }
        }

        private function handleExpenseReportEvent(event:ExpenseReportEvent):void {
            var expenseReport:ExpenseReport = event.expenseReport;
            switch ( event.action ) {
                case ExpenseReportEvent.ACTION_REOPEN:
                    handleReopenExpenseReportDialog(expenseReport);
                    break;
            }
        }

        var reopenExpenseReportPopup:IFlexDisplayObject;
        private function handleReopenExpenseReportDialog(expenseReport:ExpenseReport):void {
            reopenExpenseReportPopup = PopUpManager.createPopUp(Application.application as DisplayObject, ReopenConfirmationPanel, true);
            (reopenExpenseReportPopup as ReopenConfirmationPanel).expenseReport = expenseReport;
            PopUpManager.centerPopUp( reopenExpenseReportPopup );
            reopenExpenseReportPopup.addEventListener(ExpenseReportEvent.TYPE, handleReopenExpenseReportConfirmed);

        }

        private function handleReopenExpenseReportConfirmed(event:ExpenseReportEvent):void {
            reopenExpenseReportPopup.removeEventListener(ExpenseReportEvent.TYPE, handleReopenExpenseReportConfirmed);
            var params:Array = new Array();
            params[0] = event.expenseReport;
            params[1] = "Reopening " + new Date();
            sendNotification(ApplicationFacade.REOPEN_EXPENSE_REPORT_REQUEST, params);
        }

    }
}