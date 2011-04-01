package com.neosavvy.user.controller.progress {
    import com.neosavvy.user.ApplicationFacade;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class HideProgressBarCommand extends SimpleCommand {
        override public function execute(notification:INotification):void {
            sendNotification(ApplicationFacade.HIDE_PROGRESS_INDICATOR);
        }
    }
}