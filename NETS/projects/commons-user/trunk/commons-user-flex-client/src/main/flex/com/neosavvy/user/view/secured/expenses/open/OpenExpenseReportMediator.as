package com.neosavvy.user.view.secured.expenses.open {
    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.dto.project.ExpenseReportStatus;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;
    import com.neosavvy.user.model.UserServiceProxy;
    import com.neosavvy.user.ApplicationFacade;

    import com.neosavvy.user.view.secured.expenses.open.event.ExpenseReportEvent;

    import com.neosavvy.user.view.secured.expenses.open.popup.SubmitConfirmationPanel;
    import com.neosavvy.user.view.secured.expenses.report.popup.DeleteConfirmationPanel;

    import flash.display.DisplayObject;

    import flash.events.MouseEvent;

    import mx.collections.ArrayCollection;
    import mx.controls.AdvancedDataGrid;
    import mx.core.Application;
    import mx.core.IFlexDisplayObject;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import mx.managers.PopUpManager;

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

            openExpenseGrid.addEventListener(ExpenseReportEvent.TYPE, handleExpenseReportEvent);
        }

        override public function onRemove():void {
            _userServiceProxy = null;
            _expenseServiceProxy = null;

            openExpenseGrid.removeEventListener(ExpenseReportEvent.TYPE, handleExpenseReportEvent);
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
                ,ApplicationFacade.FIND_OPEN_EXPENSE_REPORTS_FOR_USER_SUCCESS
                ,ApplicationFacade.SAVE_EXPENSE_REPORT_SUCCESS
            ];
        }

        override public function handleNotification(notification:INotification):void {

            switch ( notification.getName() ) {
                case ApplicationFacade.NAVIGATE_TO_VIEW_OPEN_EXPENSE_REPORTS:
                    sendNotification(ApplicationFacade.INITIALIZE_VIEW_OPEN_EXPENSE_REPORTS_VIEW, _userServiceProxy.activeUser);
                    break;
                case ApplicationFacade.FIND_OPEN_EXPENSE_REPORTS_FOR_USER_SUCCESS:
                    openExpenseGrid.dataProvider = _expenseServiceProxy.openExpenseReports;
                    break;
                case ApplicationFacade.SAVE_EXPENSE_REPORT_SUCCESS:
                    if( _statusChangedExpenseReport && _statusChangedExpenseReport.id == _expenseServiceProxy.activeExpenseReportId)
                    {
                        // only send the notification if the active expense matches the one that was just saved
                        sendNotification(ApplicationFacade.INITIALIZE_VIEW_OPEN_EXPENSE_REPORTS_VIEW, _userServiceProxy.activeUser);
                        _statusChangedExpenseReport = null;
                    }
                    break;
            }
        }

        private function handleExpenseReportEvent(event:ExpenseReportEvent):void {

            var expenseReport:ExpenseReport = event.expenseReport;

            switch ( event.action ) {
                case ExpenseReportEvent.ACTION_EDIT:
                    sendNotification(ApplicationFacade.INITIALIZE_EDIT_EXPENSE_REPORT_VIEW, expenseReport.id);
                    sendNotification(ApplicationFacade.NAVIGATE_TO_EDIT_EXPENSE_REPORT);
                    break;
                case ExpenseReportEvent.ACTION_SUBMIT:
                    handleSubmitExpenseReportDialog(event.expenseReport);
                    break;
            }

        }

        var submitExpenseReportPopup:IFlexDisplayObject;
        private var _statusChangedExpenseReport:ExpenseReport;

        private function handleSubmitExpenseReportDialog(expenseReport:ExpenseReport):void {
            submitExpenseReportPopup = PopUpManager.createPopUp(Application.application as DisplayObject, SubmitConfirmationPanel, true);
            (submitExpenseReportPopup as SubmitConfirmationPanel).expenseReport = expenseReport;
            PopUpManager.centerPopUp( submitExpenseReportPopup );
            submitExpenseReportPopup.addEventListener(ExpenseReportEvent.TYPE, handleSubmitExpenseReportConfirmed);

        }

        private function handleSubmitExpenseReportConfirmed(event:ExpenseReportEvent):void {
            submitExpenseReportPopup.removeEventListener(ExpenseReportEvent.TYPE, handleSubmitExpenseReportConfirmed);
            var params:Array = new Array();
            event.expenseReport.status = ExpenseReportStatus.SUBMITTED;

            params[0] = event.expenseReport.project;
            params[1] = event.expenseReport;
            var arrayCollection:ArrayCollection = event.expenseReport.expenseItems as ArrayCollection;
            params[2] = arrayCollection;
            _statusChangedExpenseReport = event.expenseReport;
            sendNotification(ApplicationFacade.SAVE_EXPENSE_REPORT_REQUEST, params);
        }
    }
}