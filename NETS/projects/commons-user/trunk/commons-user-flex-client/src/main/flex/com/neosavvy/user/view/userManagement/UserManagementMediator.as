package com.neosavvy.user.view.userManagement {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.UserDTO;
    import com.neosavvy.user.model.UserServiceProxy;
    import com.neosavvy.user.view.login.RegistrationAndLoginWindow;

    import com.neosavvy.user.view.login.RegistrationAndLoginWindowMediator;

    import flash.display.DisplayObject;

    import flash.events.MouseEvent;

    import mx.controls.AdvancedDataGrid;
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
        }


        override public function onRegister():void {
            userManagement.logoutButton.addEventListener(MouseEvent.CLICK, handleLogoutButtClicked);
        }

        private function handleLogoutButtClicked(event:MouseEvent):void {
            showRegistrationLoginWindow();
            sendNotification(ApplicationFacade.REQUEST_LOGOUT);
        }

        public function get userManagement():UserManagement {
            return viewComponent as UserManagement;
        }

        public function get usernameLbl():Label {
            return userManagement.usernameLbl;
        }

        public function get grid():AdvancedDataGrid {
            return userManagement.grid;
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
                ,ApplicationFacade.GET_USERS_SUCCESS
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch ( notification.getName() ) {

                case ApplicationFacade.USER_NOT_LOGGED_IN:
                    showRegistrationLoginWindow();
                    break;
                case ApplicationFacade.USER_LOGIN_SUCCESS:
                    hideRegistrationLoginWindow(notification.getBody() as String);
                    sendNotification(ApplicationFacade.GET_USERS_REQUEST)
                    break;
                case ApplicationFacade.GET_USERS_SUCCESS:
                    var userServiceProxy:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;
                    grid.dataProvider = userServiceProxy.users;
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