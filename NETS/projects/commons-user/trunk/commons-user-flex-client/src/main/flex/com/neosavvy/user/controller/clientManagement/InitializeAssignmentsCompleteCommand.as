package com.neosavvy.user.controller.clientManagement {
    import com.neosavvy.user.ApplicationFacade;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class InitializeAssignmentsCompleteCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {

            sendNotification(ApplicationFacade.INITIALIZE_MANAGE_ASSIGNMENTS_VIEW_COMPLETE);

        }

    }
}