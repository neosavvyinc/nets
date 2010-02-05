package com.neosavvy.user.controller.expenses.report {
    import com.neosavvy.user.controller.clientManagement.*;
    import com.neosavvy.user.controller.client.GetClientsForCompany;
    import com.neosavvy.user.controller.progress.HideProgressBarCommand;
    import com.neosavvy.user.controller.progress.ShowProgressBarCommand;
    import com.neosavvy.user.controller.project.GetAssignedUsersForProject;
    import com.neosavvy.user.controller.project.GetAvailableUsersForProject;
    import com.neosavvy.user.controller.project.GetProjectsForCompany;

    import com.neosavvy.user.controller.project.GetProjectsForUser;

    import org.puremvc.as3.multicore.patterns.command.AsyncMacroCommand;

    public class InitializeExpenseReportView extends AsyncMacroCommand {

        override protected function initializeAsyncMacroCommand():void {
            addSubCommand(ShowProgressBarCommand);
            addSubCommand(GetProjectsForUser);
            addSubCommand(InitializeExpenseReportViewCompleteCommand);
            addSubCommand(HideProgressBarCommand);
        }

    }
}