package com.neosavvy.user.view.secured.welcome {
    import com.neosavvy.user.ApplicationFacade;

    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.CompanyServiceProxy;

    import flash.events.MouseEvent;

    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class WelcomeMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.welcome.WelcomeMediator");

        public static const NAME:String = "welcomeMediator";

        public function WelcomeMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            welcome.inviteEmployeesBtn.addEventListener( MouseEvent.CLICK, handleInviteEmployeesButtonClicked );
            welcome.setupClientsBtn.addEventListener( MouseEvent.CLICK, handleManageClientsButtonClicked );
            welcome.setupProjectsBtn.addEventListener( MouseEvent.CLICK, handleManageProjectsButtonClicked );
        }


        override public function onRemove():void {
            welcome.inviteEmployeesBtn.removeEventListener( MouseEvent.CLICK, handleInviteEmployeesButtonClicked );
            welcome.setupClientsBtn.removeEventListener( MouseEvent.CLICK, handleManageClientsButtonClicked );
            welcome.setupProjectsBtn.removeEventListener( MouseEvent.CLICK, handleManageProjectsButtonClicked );
        }

        public function get welcome():Welcome {
            return viewComponent as Welcome;
        }



        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_WELCOME
                ,ApplicationFacade.USER_LOGIN_STARTUP_COMPLETE
            ];
        }


        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
                case ApplicationFacade.USER_LOGIN_STARTUP_COMPLETE:
                    break;
                case ApplicationFacade.NAVIGATE_TO_WELCOME:
                    break;
            }
        }

        private function handleInviteEmployeesButtonClicked( event : MouseEvent ):void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES, ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES);
        }

        private function handleManageClientsButtonClicked( event : MouseEvent ):void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_CLIENT_MANAGEMENT);
        }

        private function handleManageProjectsButtonClicked( event : MouseEvent ):void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_PROJECT_MANAGEMENT);
        }

    }
}