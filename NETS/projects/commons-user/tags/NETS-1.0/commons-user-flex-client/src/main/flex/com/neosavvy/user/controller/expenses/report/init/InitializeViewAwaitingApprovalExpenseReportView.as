package com.neosavvy.user.controller.expenses.report.init {
    import com.neosavvy.user.controller.expenses.report.view.FindAwaitingApprovalExpenseReportsForUserCommand;
    import com.neosavvy.user.controller.progress.HideProgressBarCommand;
    import com.neosavvy.user.controller.progress.ShowProgressBarCommand;

    import org.puremvc.as3.multicore.patterns.command.AsyncMacroCommand;

    public class InitializeViewAwaitingApprovalExpenseReportView extends AsyncMacroCommand {

        override protected function initializeAsyncMacroCommand():void {
            addSubCommand(ShowProgressBarCommand);
            addSubCommand(FindAwaitingApprovalExpenseReportsForUserCommand);
            addSubCommand(InitializeViewAwaitingApprovalExpenseReportViewComplete);
            addSubCommand(HideProgressBarCommand);
        }

    }
}