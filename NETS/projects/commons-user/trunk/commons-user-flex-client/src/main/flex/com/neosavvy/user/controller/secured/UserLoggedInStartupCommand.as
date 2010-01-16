package com.neosavvy.user.controller.secured {
    import com.neosavvy.user.controller.progress.HideProgressBarCommand;
    import com.neosavvy.user.controller.progress.ShowProgressBarCommand;
    import com.neosavvy.user.controller.user.GetActiveUserCommand;

    import org.puremvc.as3.multicore.patterns.command.AsyncMacroCommand;

    public class UserLoggedInStartupCommand extends AsyncMacroCommand {

        override protected function initializeAsyncMacroCommand():void {
            addSubCommand(ShowProgressBarCommand);
            addSubCommand(SecuredViewPrepCommand);
            addSubCommand(GetActiveUserCommand);
            addSubCommand(UserLoggedIn);            
            addSubCommand(HideProgressBarCommand);

        }

    }
}