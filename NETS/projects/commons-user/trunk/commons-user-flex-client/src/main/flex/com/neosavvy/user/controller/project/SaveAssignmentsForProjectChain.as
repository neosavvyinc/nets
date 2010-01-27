package com.neosavvy.user.controller.project {
    import com.neosavvy.user.controller.clientManagement.*;
    import com.neosavvy.user.controller.client.GetClientsForCompany;
    import com.neosavvy.user.controller.progress.HideProgressBarCommand;
    import com.neosavvy.user.controller.progress.ShowProgressBarCommand;
    import com.neosavvy.user.controller.project.GetAssignedUsersForProject;
    import com.neosavvy.user.controller.project.GetAvailableUsersForProject;
    import com.neosavvy.user.controller.project.GetProjectsForCompany;

    import org.puremvc.as3.multicore.patterns.command.AsyncMacroCommand;

    public class SaveAssignmentsForProjectChain extends AsyncMacroCommand {

        override protected function initializeAsyncMacroCommand():void {
            addSubCommand(ShowProgressBarCommand);
            addSubCommand(SaveProjectAssignments);
            addSubCommand(GetAssignedUsersForProject);
            addSubCommand(GetAvailableUsersForProject);            
            addSubCommand(SaveAssignmentsForProjectChainCompleteCommand);
            addSubCommand(HideProgressBarCommand);
        }

    }
}