package com.neosavvy.user.view.secured.expenses.approving {
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


        public function ExpenseReportApprovalPopupMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.SHOW_APPROVE_DIALOG
                ,ApplicationFacade.SHOW_DECLINE_DIALOG
                ,ApplicationFacade.SHOW_VIEW_DIALOG

            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
                case ApplicationFacade.SHOW_APPROVE_DIALOG:
                    var approvalPopup:IFlexDisplayObject = PopUpManager.createPopUp(viewComponent as DisplayObject, ConfirmExpenseReportApproved, true);
                    PopUpManager.centerPopUp(approvalPopup);
                    break;
                case ApplicationFacade.SHOW_DECLINE_DIALOG:
                    var declinePopup:IFlexDisplayObject = PopUpManager.createPopUp(viewComponent as DisplayObject, ConfirmExpenseReportDeclined, true);
                    PopUpManager.centerPopUp(declinePopup);
                    break;
                case ApplicationFacade.SHOW_VIEW_DIALOG:
                    var viewExpenseReportPopup:IFlexDisplayObject = PopUpManager.createPopUp(viewComponent as DisplayObject, ViewSubmittedExpenseReport, true);
                    PopUpManager.centerPopUp(viewExpenseReportPopup);
                    break;
            }
        }


    }
}