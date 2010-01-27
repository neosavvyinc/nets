package com.neosavvy.user.controller.clientManagement {
    import com.neosavvy.user.controller.client.GetClientsForCompany;
    import com.neosavvy.user.controller.progress.HideProgressBarCommand;
    import com.neosavvy.user.controller.progress.ShowProgressBarCommand;
    import com.neosavvy.user.controller.project.GetAssignedUsersForProject;
    import com.neosavvy.user.controller.project.GetAvailableUsersForProject;
    import com.neosavvy.user.controller.project.GetProjectsForCompany;

    import org.puremvc.as3.multicore.patterns.command.AsyncMacroCommand;

    public class InitializeAssignmentsForProject extends AsyncMacroCommand {

        override protected function initializeAsyncMacroCommand():void {
            addSubCommand(ShowProgressBarCommand);
            addSubCommand(GetAssignedUsersForProject);
            addSubCommand(GetAvailableUsersForProject);            
            addSubCommand(InitializeAssignmentsForProjectCompleteCommand);
            addSubCommand(HideProgressBarCommand);
        }

    }
}