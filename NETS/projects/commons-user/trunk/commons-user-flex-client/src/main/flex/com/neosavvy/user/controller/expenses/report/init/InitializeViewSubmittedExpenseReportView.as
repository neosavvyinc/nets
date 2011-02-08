package com.neosavvy.user.controller.expenses.report.init {
    import com.neosavvy.user.controller.expenses.report.view.FindSubmittedExpenseReportsForUser;
    import com.neosavvy.user.controller.progress.HideProgressBarCommand;
    import com.neosavvy.user.controller.progress.ShowProgressBarCommand;

    import org.puremvc.as3.multicore.patterns.command.AsyncMacroCommand;

    public class InitializeViewSubmittedExpenseReportView extends AsyncMacroCommand {

        override protected function initializeAsyncMacroCommand():void {
            addSubCommand(ShowProgressBarCommand);
            addSubCommand(FindSubmittedExpenseReportsForUser);
            addSubCommand(InitializeViewSubmittedExpenseReportViewComplete);
            addSubCommand(HideProgressBarCommand);
        }

    }
}