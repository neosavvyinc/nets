package com.neosavvy.user.controller.expenses.report.init {
    import com.neosavvy.user.controller.expenses.report.view.FindOpenExpenseReportsForUser;
    import com.neosavvy.user.controller.progress.HideProgressBarCommand;
    import com.neosavvy.user.controller.progress.ShowProgressBarCommand;

    import org.puremvc.as3.multicore.patterns.command.AsyncMacroCommand;

    public class InitializeViewOpenExpenseReportView extends AsyncMacroCommand {

        override protected function initializeAsyncMacroCommand():void {
            addSubCommand(ShowProgressBarCommand);
            addSubCommand(FindOpenExpenseReportsForUser);
            addSubCommand(InitializeViewOpenExpenseReportViewComplete);
            addSubCommand(HideProgressBarCommand);
        }

    }
}