package com.neosavvy.user.controller.secured {
    import com.neosavvy.user.controller.user.GetActiveUserCommand;

    import org.puremvc.as3.multicore.patterns.command.MacroCommand;

    public class UserLoggedInStartupCommand extends MacroCommand {

        override protected function initializeMacroCommand():void {
            addSubCommand(SecuredViewPrepCommand);
            addSubCommand(GetActiveUserCommand);
        }
    }
}