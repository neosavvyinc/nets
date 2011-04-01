package com.neosavvy.user.controller.project {
    import com.neosavvy.user.controller.progress.HideProgressBarCommand;
    import com.neosavvy.user.controller.progress.ShowProgressBarCommand;

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