package com.neosavvy.user.controller.clientManagement {
    import com.neosavvy.user.ApplicationFacade;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class InitializeAssignmentsForProjectCompleteCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {

            sendNotification(ApplicationFacade.INITIALIZE_ASSIGNMENTS_FOR_PROJECT_COMPLETE);

        }

    }
}