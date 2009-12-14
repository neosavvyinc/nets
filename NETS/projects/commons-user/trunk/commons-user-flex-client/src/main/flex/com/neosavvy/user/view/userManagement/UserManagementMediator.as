package com.neosavvy.user.view.userManagement {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.UserDTO;
    import com.neosavvy.user.view.login.RegistrationAndLoginWindow;

    import com.neosavvy.user.view.login.RegistrationAndLoginWindowMediator;

    import flash.display.DisplayObject;

    import flash.events.MouseEvent;

    import mx.controls.Label;
    import mx.core.IFlexDisplayObject;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.managers.PopUpManager;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class UserManagementMediator extends Mediator implements IMediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.userManagement.UserManagementMediator")

        public static const NAME:String = "UserManagementMediator";

        public function UserManagementMediator(viewComponent:Object) {
            super(NAME, viewComponent);
            userManagement.logoutButton.addEventListener(MouseEvent.CLICK, handleLogoutButtClicked)
        }

        private function handleLogoutButtClicked(event:MouseEvent):void {
            showRegistrationLoginWindow();
            sendNotification(ApplicationFacade.LOGOUT_USER);
        }

        public function get userManagement():UserManagement {
            return viewComponent as UserManagement;
        }

        public function get usernameLbl():Label {
            return userManagement.usernameLbl;
        }


        var regAndLoginWindow:IFlexDisplayObject = null;

        protected function showRegistrationLoginWindow():void {
            regAndLoginWindow = PopUpManager.createPopUp(userManagement as DisplayObject, RegistrationAndLoginWindow, true);
            PopUpManager.centerPopUp(regAndLoginWindow);
            facade.registerMediator( new RegistrationAndLoginWindowMediator( regAndLoginWindow ) );
        }

        protected function hideRegistrationLoginWindow(name:String):void {
            PopUpManager.removePopUp(regAndLoginWindow);
            usernameLbl.text = name;
        }


        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.USER_LOGIN_FAILED
                ,ApplicationFacade.USER_LOGGED_IN
                ,ApplicationFacade.USER_NOT_LOGGED_IN
                ,ApplicationFacade.USER_LOGIN_SUCCESS
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch ( notification.getName() ) {

                case ApplicationFacade.USER_NOT_LOGGED_IN:
                    showRegistrationLoginWindow();
                    break;
                case ApplicationFacade.USER_LOGIN_SUCCESS:
                    hideRegistrationLoginWindow(notification.getBody() as String);
                    break;
            
            }
        }

        //        protected function handleItemClick():void {
//            var selectedItem:UserDTO = grid.selectedItem as UserDTO;
//            fName.text = selectedItem.firstName;
//            mName.text = selectedItem.middleName;
//            lName.text = selectedItem.lastName;
//            username.text = selectedItem.username;
//            password.text = selectedItem.password;
//            identifier.text = String(selectedItem.id);
//        }


    }
}