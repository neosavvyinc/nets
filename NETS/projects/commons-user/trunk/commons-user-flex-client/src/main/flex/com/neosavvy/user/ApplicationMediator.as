package com.neosavvy.user {

    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.SecurityProxy;
    import com.neosavvy.user.model.UserServiceProxy;
    import com.neosavvy.user.view.secured.SecuredContainer;

    import com.neosavvy.user.view.security.Login;

    import flash.events.Event;
    import flash.events.MouseEvent;

    import mx.containers.Box;
    import mx.containers.VBox;
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

        public static var EMPLOYEE_MANAGEMENT_NAVIGATION_INDEX:Number = 3;
        public static var NEW_USER_CONFIRMATION_INDEX:Number = 5;


        public static var LOGIN_NAVIGATION_INDEX:Number = 3;
        public static var SECURED_CONTAINER_NAVIGATION_INDEX:Number = 4;


        public function ApplicationMediator(viewComponent:NETS)
        {
            super(NAME, viewComponent);
        }



        public function get app():NETS
        {
            return viewComponent as NETS;
        }

        public function get navigationViewStack():ViewStack {
            return app.navigationViewStack;
        }

        public function get login():Login
        {
            return app.login;
        }

        public function get loginButton():Button {
            return app.loginButton;
        }

        public function get headerBar():Box {
            return app.headerBar;
        }

        public function get secureHeaderBar():Box {
            return app.secureHeaderBar;
        }

        public function get securedContainer():SecuredContainer {
            return app.securedContainer;
        }

        public function get logoutButton():Button {
            return app.logoutButton;
        }

        override public function onRegister():void
        {
            this.loginButton.addEventListener(MouseEvent.CLICK, loginButtonClickedHandler);
            this.logoutButton.addEventListener(MouseEvent.CLICK, logoutButtonClickedHandler)
            this.login.addEventListener("goHomeClicked",goHomeClickHandler);
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
            toggleHeader(false);
            toggleSecuredHeader(false);
            sendNotification(ApplicationFacade.DEINITIALIZE_SECURED_VIEW);
        }

        public function hideLogin():void
        {
            this.navigationViewStack.selectedIndex = LANDING_NAVIGATION_INDEX;
            toggleHeader(true);
            toggleSecuredHeader(false);
            sendNotification(ApplicationFacade.INITIALIZE_SECURED_VIEW);
        }

        private function toggleSecuredHeader( toggleValue:Boolean ):void {
            this.secureHeaderBar.visible = toggleValue;
            this.secureHeaderBar.includeInLayout = toggleValue;
            var cs:CompanyServiceProxy = ApplicationFacade.getCompanyProxy() as CompanyServiceProxy;
            var comp:CompanyDTO = cs.activeCompany;
            if(comp && comp.companyName){
                this.app.companyNameHeader.text = comp.companyName.toUpperCase();
            }

            var us:UserServiceProxy = ApplicationFacade.getUserProxy() as UserServiceProxy;
            var user:UserDTO = us.activeUser;
            if(user) {
                this.app.loggedInUser.text = user.fullName;
            }
        }

        private function toggleHeader( toggleValue:Boolean ):void {
            this.headerBar.visible = toggleValue;
            this.headerBar.includeInLayout = toggleValue;
        }

        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
                case ApplicationFacade.USER_LOGIN_SUCCESS:
                case ApplicationFacade.USER_LOGGED_IN:
                    this.navigationViewStack.selectedIndex = SECURED_CONTAINER_NAVIGATION_INDEX;
                    toggleHeader(false);
                    toggleSecuredHeader(true);
                    sendNotification(ApplicationFacade.INITIALIZE_SECURED_VIEW, securedContainer);
                    break;
                case ApplicationFacade.DISPLAY_LOGIN_SCREEN:
                case ApplicationFacade.USER_NOT_LOGGED_IN:
                    displayLogin();
                    break;
            }
        }


        private function loginButtonClickedHandler(event:MouseEvent):void {
            displayLogin();
        }

        private function logoutButtonClickedHandler(event:MouseEvent):void {
            sendNotification(ApplicationFacade.REQUEST_LOGOUT);
            displayLogin();
        }

        private function goHomeClickHandler(event:Event):void {
            hideLogin();
        }

    }

}
