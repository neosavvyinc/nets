package com.neosavvy.user.controller.expenses.report.init {
    import com.neosavvy.user.ApplicationFacade;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class InitializeViewOpenExpenseReportViewComplete extends SimpleCommand {

        override public function execute(notification:INotification):void {
            sendNotification(ApplicationFacade.INITIALIZE_VIEW_OPEN_EXPENSE_REPORTS_VIEW_COMPLETE);
        }

    }
}