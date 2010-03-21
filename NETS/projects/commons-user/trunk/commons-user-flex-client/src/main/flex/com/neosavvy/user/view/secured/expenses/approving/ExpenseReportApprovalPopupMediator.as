package com.neosavvy.user.view.secured.expenses.approving {
    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;
    import com.neosavvy.user.view.secured.expenses.approving.event.ExpenseReportApproveEvent;
    import com.neosavvy.user.view.secured.expenses.approving.popup.ConfirmExpenseReportApproved;
    import com.neosavvy.user.view.secured.expenses.approving.popup.ConfirmExpenseReportDeclined;
    import com.neosavvy.user.view.secured.expenses.approving.popup.ViewSubmittedExpenseReport;
    import com.neosavvy.user.view.secured.progress.*;
    import com.neosavvy.user.ApplicationFacade;

    import flash.display.DisplayObject;

    import mx.controls.Alert;
    import mx.controls.ProgressBar;
    import mx.controls.ProgressBarMode;
    import mx.core.Application;
    import mx.core.IFlexDisplayObject;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.managers.PopUpManager;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ExpenseReportApprovalPopupMediator extends Mediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.expenses.approving.ExpenseReportApprovalPopupMediator");

        public static const NAME:String = "expenseReportApprovalPopupMediator";

        private var _expenseServiceProxy:ExpenseReportServiceProxy;

        var approvalPopup:IFlexDisplayObject;
        var declinePopup:IFlexDisplayObject;
        var viewExpenseReportPopup:IFlexDisplayObject;

        public function ExpenseReportApprovalPopupMediator(viewComponent:Object) {
            super(NAME, viewComponent);

        }

        override public function onRegister():void {
            super.onRegister();

            _expenseServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
        }

        override public function onRemove():void {
            super.onRemove();

            _expenseServiceProxy = null;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.SHOW_APPROVE_DIALOG
                ,ApplicationFacade.SHOW_DECLINE_DIALOG
                ,ApplicationFacade.SHOW_VIEW_DIALOG

            ];
        }

        private function handleApproval( selectedReport:ExpenseReport ):void {
            approvalPopup = PopUpManager.createPopUp(viewComponent as DisplayObject, ConfirmExpenseReportApproved, true);
            approvalPopup.addEventListener(ExpenseReportApproveEvent.TYPE, handleApprovalEvent);
            (approvalPopup as ConfirmExpenseReportApproved).expenseReport = selectedReport;
            PopUpManager.centerPopUp(approvalPopup);
        }

        private function handleApprovalEvent(event:ExpenseReportApproveEvent):void {

            if ( approvalPopup )
            {
                approvalPopup.removeEventListener(ExpenseReportApproveEvent.TYPE, handleApprovalEvent);
                approvalPopup = null
            }

            handleExpenseReportEvent(event);

        }

        private function handleDecline( selectedReport:ExpenseReport ):void {
            declinePopup = PopUpManager.createPopUp(viewComponent as DisplayObject, ConfirmExpenseReportDeclined, true);
            declinePopup.addEventListener(ExpenseReportApproveEvent.TYPE, handleDeclineEvent);
            (declinePopup as ConfirmExpenseReportDeclined).expenseReport = selectedReport;
            PopUpManager.centerPopUp(declinePopup);
        }

        private function handleExpenseReportEvent(event:ExpenseReportApproveEvent):void {
            var expenseReport:ExpenseReport = event.expenseReport;
            var comment:String = event.note;
            switch (event.action)
            {
                case ExpenseReportApproveEvent.ACTION_DECLINE_CONFIRM:

                    sendNotification(ApplicationFacade.DECLINE_EXPENSE_REPORT_REQUEST, [expenseReport, comment]);
                    break;
                case ExpenseReportApproveEvent.ACTION_APPROVE_CONFIRM:

                    sendNotification(ApplicationFacade.APPROVE_EXPENSE_REPORT_REQUEST,[expenseReport, comment]);
                    break;
            }
        }

        private function handleDeclineEvent(event:ExpenseReportApproveEvent):void {

            if ( declinePopup )
            {
                declinePopup.removeEventListener(ExpenseReportApproveEvent.TYPE, handleDeclineEvent);
                declinePopup = null
            }

            handleExpenseReportEvent(event);


        }

        private function handleView( selectedReport:ExpenseReport ):void {
            viewExpenseReportPopup = PopUpManager.createPopUp(viewComponent as DisplayObject, ViewSubmittedExpenseReport, true);
            (viewExpenseReportPopup as ViewSubmittedExpenseReport).expenseReport = selectedReport;
            viewExpenseReportPopup.addEventListener(ExpenseReportApproveEvent.TYPE, handleViewEvent);
            PopUpManager.centerPopUp(viewExpenseReportPopup);
        }

        private function handleViewEvent(event:ExpenseReportApproveEvent):void {

            if ( viewExpenseReportPopup )
            {
                viewExpenseReportPopup.removeEventListener(ExpenseReportApproveEvent.TYPE, handleViewEvent);
                viewExpenseReportPopup = null
            }

            handleExpenseReportEvent(event);
        }

        override public function handleNotification(notification:INotification):void {
            var selectedReport:ExpenseReport = notification.getBody() as ExpenseReport
            switch (notification.getName()) {
                case ApplicationFacade.SHOW_APPROVE_DIALOG:
                    handleApproval( selectedReport );
                    break;
                case ApplicationFacade.SHOW_DECLINE_DIALOG:
                    handleDecline( selectedReport );
                    break;
                case ApplicationFacade.SHOW_VIEW_DIALOG:
                    handleView( selectedReport );
                    break;
            }
        }


    }
}