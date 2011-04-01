package com.neosavvy.user.controller.progress {
    import com.neosavvy.user.ApplicationFacade;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class ShowProgressBarCommand extends SimpleCommand {
        override public function execute(notification:INotification):void {
            sendNotification(ApplicationFacade.SHOW_PROGRESS_INDICATOR);
        }
    }
}