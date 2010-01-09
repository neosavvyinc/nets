package com.neosavvy.user.controller.clientManagement {
    import com.neosavvy.user.controller.client.GetClientsForCompany;

    import com.neosavvy.user.controller.project.GetProjectsForCompany;

    import org.puremvc.as3.multicore.patterns.command.MacroCommand;

    public class InitializeManageProjects extends MacroCommand {

        override protected function initializeMacroCommand():void {
            addSubCommand(GetClientsForCompany);
            addSubCommand(GetProjectsForCompany);
            addSubCommand(InitializeCompleteCommand);
        }

    }
}