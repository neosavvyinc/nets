package com.neosavvy.user.controller.clientManagement {
    import com.neosavvy.user.ApplicationFacade;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class InitializeManageProjectsCompleteCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {

            sendNotification(ApplicationFacade.INITIALIZE_MANAGE_PROJECTS_VIEW_COMPLETE);

        }

    }
}