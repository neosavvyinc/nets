package com.neosavvy.user.controller.expenses.report.init {
    import com.neosavvy.user.controller.expenses.report.view.FindExpenseReportById;
    import com.neosavvy.user.controller.expenses.report.view.GetExpenseReportItems;
    import com.neosavvy.user.controller.progress.HideProgressBarCommand;
    import com.neosavvy.user.controller.progress.ShowProgressBarCommand;
    import com.neosavvy.user.controller.project.GetProjectsForUser;

    import org.puremvc.as3.multicore.patterns.command.AsyncMacroCommand;

    public class InitializeEditExpenseReportView extends AsyncMacroCommand {

        override protected function initializeAsyncMacroCommand():void {
            addSubCommand(ShowProgressBarCommand);
            addSubCommand(GetProjectsForUser);
            addSubCommand(FindExpenseTypes);
            addSubCommand(FindPaymentMethods);
            addSubCommand(FindProjectTypes);
            addSubCommand(FindExpenseReportById);
            addSubCommand(GetExpenseReportItems);
            addSubCommand(InitializeExpenseReportViewCompleteCommand);
            addSubCommand(HideProgressBarCommand);
        }

    }
}