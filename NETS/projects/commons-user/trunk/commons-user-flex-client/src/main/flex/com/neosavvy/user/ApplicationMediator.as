package com.neosavvy.user {

    import com.neosavvy.user.model.SecurityProxy;
    import com.neosavvy.user.view.secured.SecuredContainer;

    import flash.events.MouseEvent;

    import mx.containers.ViewStack;
    import mx.controls.Button;
    import mx.controls.Label;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    /**
     * User: adamparrish
     * Date: Dec 9, 2009
     * Time: 10:54:23 PM
     */
    public class ApplicationMediator extends Mediator implements IMediator {

        public static var LANDING_NAVIGATION_INDEX:Number = 0;
        public static var COMPANY_MANAGEMENT_NAVIGATION_INDEX:Number = 1;
        public static var SECURED_CONTAINER_NAVIGATION_INDEX:Number = 2;
        public static var EMPLOYEE_MANAGEMENT_NAVIGATION_INDEX:Number = 3;
        public static var LOGIN_NAVIGATION_INDEX:Number = 4;
        public static var NEW_USER_CONFIRMATION_INDEX:Number = 5;

        private var _lastNavigationIndex:Number = 0;

        public function ApplicationMediator(viewComponent:CommonsUser)
        {
            super(NAME, viewComponent);
        }

        public function get app():CommonsUser
        {
            return viewComponent as CommonsUser;
        }

        public function get newCompanyButton():Button {
            return app.newCompanyButton;
        }

        public function get existingUserButton():Button {
            return app.existingUsersButton;
        }

        public function get invitationButton():Button {
            return app.invitationButton;
        }

        public function get navigationViewStack():ViewStack {
            return app.navigationViewStack;
        }

        public function get loginButton():Button {
            return app.loginButton;
        }

        public function get logoutButton():Button {
            return app.logoutButton;
        }

        public function get newCompanyConfirmationButton():Button {
            return app.newCompanyConfirmationButton;
        }

        public function get loggedInUserName():Label {
            return app.loggedInUserName;
        }

        public function get securedContainer():SecuredContainer {
            return app.securedContainer;
        }

        override public function onRegister():void
        {
            this.newCompanyButton.addEventListener(MouseEvent.CLICK, newCompanyButtonClicked);
            this.existingUserButton.addEventListener(MouseEvent.CLICK, existingUserButtonClicked);
            this.loginButton.addEventListener(MouseEvent.CLICK, loginButtonClickedHandler);
            this.logoutButton.addEventListener(MouseEvent.CLICK, logoutButtonClickHandler);
            this.invitationButton.addEventListener(MouseEvent.CLICK, invitationButtonClickHandler);
            this.newCompanyConfirmationButton.addEventListener(MouseEvent.CLICK, newCompanyConfirmationButtonClickHandler);
        }


        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.USER_LOGGED_IN
                ,ApplicationFacade.DISPLAY_LOGIN_SCREEN
                ,ApplicationFacade.USER_NOT_LOGGED_IN
                ,ApplicationFacade.USER_LOGIN_SUCCESS
                ,ApplicationFacade.NAVIGATE_TO_COMPANY_REGISTRATION
            ];
        }

        private function displayLogin():void {
            this.navigationViewStack.selectedIndex = LOGIN_NAVIGATION_INDEX;
            loginButton.visible = true;
            logoutButton.visible = false;
            loggedInUserName.text = "You are not logged in";
            sendNotification(ApplicationFacade.DEINITIALIZE_SECURED_VIEW);
        }

        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
                case ApplicationFacade.USER_LOGIN_SUCCESS:
                case ApplicationFacade.USER_LOGGED_IN:
                    this.navigationViewStack.selectedIndex = SECURED_CONTAINER_NAVIGATION_INDEX;
                    var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
                    var roles:String = securityProxy.authorities.join(",");
                    var activeUser:String = notification.getBody() as String;
                    loggedInUserName.text = "You are logged in as " + activeUser + " with role(s): " + roles;
                    loginButton.visible = false;
                    logoutButton.visible = true;
                    sendNotification(ApplicationFacade.INITIALIZE_SECURED_VIEW, securedContainer);
                    break;
                case ApplicationFacade.DISPLAY_LOGIN_SCREEN:
                case ApplicationFacade.USER_NOT_LOGGED_IN:
                    displayLogin();
                    break;
                case ApplicationFacade.NAVIGATE_TO_COMPANY_REGISTRATION:
                    this.navigationViewStack.selectedIndex = COMPANY_MANAGEMENT_NAVIGATION_INDEX;
                    break;
            }
        }

        private function newCompanyButtonClicked(event:MouseEvent):void {
            this.navigationViewStack.selectedIndex = COMPANY_MANAGEMENT_NAVIGATION_INDEX;
        }

        private function existingUserButtonClicked(event:MouseEvent):void {
            displayLogin();
        }

        private function logoutButtonClickHandler(event:MouseEvent):void {
            sendNotification(ApplicationFacade.REQUEST_LOGOUT);
        }

        private function loginButtonClickedHandler(event:MouseEvent):void {
            displayLogin();
        }

        private function invitationButtonClickHandler(event:MouseEvent):void {
            this.navigationViewStack.selectedIndex = NEW_USER_CONFIRMATION_INDEX;
        }

        private function newCompanyConfirmationButtonClickHandler(event:MouseEvent):void {
            this.navigationViewStack.selectedIndex = COMPANY_MANAGEMENT_NAVIGATION_INDEX;
            sendNotification(ApplicationFacade.SAVE_COMPANY_SUCCESS);
        }

    }

}
