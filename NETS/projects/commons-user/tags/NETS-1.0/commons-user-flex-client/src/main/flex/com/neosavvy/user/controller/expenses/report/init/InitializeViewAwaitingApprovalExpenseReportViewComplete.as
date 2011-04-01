package com.neosavvy.user.controller.expenses.report.init {
    import com.neosavvy.user.ApplicationFacade;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class InitializeViewAwaitingApprovalExpenseReportViewComplete extends SimpleCommand {

        override public function execute(notification:INotification):void {
            sendNotification(ApplicationFacade.INITIALIZE_AWAITING_EXPENSE_REPORT_VIEW_COMPLETE);
        }

    }
}