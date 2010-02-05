package com.neosavvy.user.controller.expenses.report {
    import com.neosavvy.user.ApplicationFacade;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class InitializeExpenseReportViewCompleteCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {

            sendNotification(ApplicationFacade.INITIALIZE_EXPENSE_REPORT_VIEW_COMPLETE);

        }

    }
}