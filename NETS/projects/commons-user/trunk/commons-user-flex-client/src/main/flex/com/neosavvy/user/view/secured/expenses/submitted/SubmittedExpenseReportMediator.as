package com.neosavvy.user.view.secured.expenses.submitted {
    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.dto.project.ExpenseReportStatus;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;
    import com.neosavvy.user.model.UserServiceProxy;
    import com.neosavvy.user.view.secured.expenses.open.event.ExpenseReportEvent;
    import com.neosavvy.user.view.secured.expenses.open.popup.SubmitConfirmationPanel;
    import com.neosavvy.user.view.secured.expenses.submitted.popup.ReopenConfirmationPanel;
    import com.neosavvy.user.view.secured.projectManagement.assignments.*;
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.ProjectServiceProxy;
    import com.neosavvy.user.view.secured.projectManagement.*;

    import flash.display.DisplayObject;
    import flash.events.MouseEvent;

    import mx.collections.ArrayCollection;
    import mx.controls.AdvancedDataGrid;
    import mx.controls.Button;
    import mx.controls.ComboBox;
    import mx.controls.List;
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
        }

        override public function onRemove():void {
            _userServiceProxy = null;
            _expenseServiceProxy = null;

             submittedExpenseReportGrid.removeEventListener(ExpenseReportEvent.TYPE, handleExpenseReportEvent);
        }

        public function get submittedExpenseReport():SubmittedExpenseReport {
            return viewComponent as SubmittedExpenseReport;
        }

        public function get submittedExpenseReportGrid():AdvancedDataGrid {
            return submittedExpenseReport.submittedExpenseGrid;
        }

        override public function listNotificationInterests():Array {
            return [
                    ApplicationFacade.NAVIGATE_TO_VIEW_SUBMITTED_EXPENSE_REPORTS
                    ,ApplicationFacade.FIND_SUBMITTED_EXPENSE_REPORTS_FOR_USER_SUCCESS
                    ,ApplicationFacade.SAVE_EXPENSE_REPORT_SUCCESS
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
                case ApplicationFacade.SAVE_EXPENSE_REPORT_SUCCESS:
                    if(_statusChangedExpenseReport && _statusChangedExpenseReport.id == _expenseServiceProxy.activeExpenseReport.id)
                    {
                        // only send the notification if the active expense matches the one that was just saved
                        sendNotification(ApplicationFacade.INITIALIZE_VIEW_SUBMITTED_EXPENSE_REPORTS_VIEW, _userServiceProxy.activeUser);
                        _statusChangedExpenseReport = null;
                    }
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
        var _statusChangedExpenseReport:ExpenseReport;
        private function handleReopenExpenseReportDialog(expenseReport:ExpenseReport):void {
            reopenExpenseReportPopup = PopUpManager.createPopUp(Application.application as DisplayObject, ReopenConfirmationPanel, true);
            (reopenExpenseReportPopup as ReopenConfirmationPanel).expenseReport = expenseReport;
            PopUpManager.centerPopUp( reopenExpenseReportPopup );
            reopenExpenseReportPopup.addEventListener(ExpenseReportEvent.TYPE, handleReopenExpenseReportConfirmed);

        }

        private function handleReopenExpenseReportConfirmed(event:ExpenseReportEvent):void {
            reopenExpenseReportPopup.removeEventListener(ExpenseReportEvent.TYPE, handleReopenExpenseReportConfirmed);
            var params:Array = new Array();
            event.expenseReport.status = ExpenseReportStatus.OPEN;

            params[0] = event.expenseReport.project;
            params[1] = event.expenseReport;
            var arrayCollection:ArrayCollection = event.expenseReport.expenseItems as ArrayCollection;
            params[2] = arrayCollection;

            _statusChangedExpenseReport = event.expenseReport;

            sendNotification(ApplicationFacade.SAVE_EXPENSE_REPORT_REQUEST, params);
        }

    }
}