package com.neosavvy.user.controller.project {
    import com.neosavvy.user.ApplicationFacade;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class SaveAssignmentsForProjectChainCompleteCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {

            sendNotification(ApplicationFacade.SAVE_PROJECT_ASSIGNMENTS_SUCCESS);

        }

    }
}