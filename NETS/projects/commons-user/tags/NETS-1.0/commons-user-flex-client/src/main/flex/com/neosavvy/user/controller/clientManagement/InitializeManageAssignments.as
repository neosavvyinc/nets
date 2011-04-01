package com.neosavvy.user.controller.clientManagement {
    import com.neosavvy.user.controller.progress.HideProgressBarCommand;
    import com.neosavvy.user.controller.progress.ShowProgressBarCommand;
    import com.neosavvy.user.controller.project.GetProjectsForCompany;

    import org.puremvc.as3.multicore.patterns.command.AsyncMacroCommand;

    public class InitializeManageAssignments extends AsyncMacroCommand {

        override protected function initializeAsyncMacroCommand():void {
            addSubCommand(ShowProgressBarCommand);
            addSubCommand(GetProjectsForCompany);
            addSubCommand(InitializeManageAssignmentsCompleteCommand);
            addSubCommand(HideProgressBarCommand);
        }

    }
}