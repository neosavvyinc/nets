package com.neosavvy.user.controller.expenses.report.init {
    import com.neosavvy.user.controller.expenses.report.view.FindExpenseReportById;
    import com.neosavvy.user.controller.expenses.report.view.GetExpenseReportItems;
    import com.neosavvy.user.controller.progress.HideProgressBarCommand;
    import com.neosavvy.user.controller.progress.ShowProgressBarCommand;

    import org.puremvc.as3.multicore.patterns.command.AsyncMacroCommand;

    public class InitializeViewExpenseReportView extends AsyncMacroCommand {

        override protected function initializeAsyncMacroCommand():void {
            addSubCommand(ShowProgressBarCommand);
            addSubCommand(FindExpenseReportById);
            addSubCommand(GetExpenseReportItems);
            addSubCommand(InitializeViewExpenseReportViewCompleteCommand);
            addSubCommand(HideProgressBarCommand);
        }

    }
}