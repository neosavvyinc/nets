package com.neosavvy.user.view.secured.userManagement.event {
    import com.neosavvy.user.dto.companyManagement.UserDTO;

    import flash.events.Event;

    public class UserManagementEvent extends Event {
        public static const TYPE:String = "userManagementEvent";

        public static const ACTION_ACTIVATE:String = "Activate";
        public static const ACTION_DEACTIVATE:String = "Deactivate";
        public static const ACTION_RESET_PASSWORD:String = "resetPassword";

        private var _user:UserDTO;
        private var _action:String;

        public function UserManagementEvent(action:String, user:UserDTO) {
            super(TYPE, true, false);
            _user = user;
            _action = action;
        }

        public function get user():UserDTO {
            return _user;
        }

        public function get action():String {
            return _action;
        }
    }
}