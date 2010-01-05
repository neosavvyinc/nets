package com.neosavvy.user.view.secured.leftNavigation.admin {
    import com.neosavvy.user.ApplicationFacade;

    import com.neosavvy.user.model.SecurityProxy;

    import flash.events.MouseEvent;

    import mx.controls.Button;
    import mx.controls.LinkButton;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class AdminNavigationMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.leftNavigation.admin.AdminNavigationMediator");

        public static const NAME:String = "adminNavigationMediator";

        public function AdminNavigationMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            welcomeButton.addEventListener(MouseEvent.CLICK, handleWelcomeButtonClicked);
            inviteEmployeesButton.addEventListener(MouseEvent.CLICK, handleInviteEmployeesButtonClicked);
            viewActiveEmployeesButton.addEventListener(MouseEvent.CLICK, handleViewActiveEmployeesClicked);
            viewNonActiveEmployeesButton.addEventListener(MouseEvent.CLICK, handleViewNonActiveEmployeesClicked);
            viewAllEmployeesButton.addEventListener(MouseEvent.CLICK, handleViewAllEmployeesClicked);
        }

        private function handleWelcomeButtonClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_WELCOME,ApplicationFacade.NAVIGATE_TO_WELCOME);
        }

        private function handleViewNonActiveEmployeesClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.NON_ACTIVE_EMPLOYEES_REQUEST);
        }

        private function handleViewActiveEmployeesClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.ACTIVE_EMPLOYEES_REQUEST);
        }

        private function handleInviteEmployeesButtonClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES, ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES);
        }

        private function handleViewAllEmployeesClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.ALL_EMPLOYEES_REQUEST);
        }

        public function get adminNavigation():AdminNavigation {
            return viewComponent as AdminNavigation;
        }

        public function get welcomeButton():LinkButton {
            return adminNavigation.welcomeButton;
        }

        public function get inviteEmployeesButton():LinkButton {
            return adminNavigation.inviteEmployeesButton;
        }

        public function get viewActiveEmployeesButton():LinkButton {
            return adminNavigation.viewActiveEmployeesButton;
        }

        public function get viewNonActiveEmployeesButton():LinkButton {
            return adminNavigation.viewNonActiveEmployeesButton;
        }

        public function get viewAllEmployeesButton():LinkButton {
            return adminNavigation.viewAllEmployeesButton;
        }

        override public function listNotificationInterests():Array {
            return super.listNotificationInterests();
        }

        override public function handleNotification(notification:INotification):void {
            
        }

    }
}