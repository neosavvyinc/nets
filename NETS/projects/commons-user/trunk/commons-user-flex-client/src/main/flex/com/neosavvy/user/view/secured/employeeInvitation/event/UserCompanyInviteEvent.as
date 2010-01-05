package com.neosavvy.user.view.secured.employeeInvitation.event {
    import com.neosavvy.user.dto.companyManagement.UserInviteDTO;

    import flash.events.Event;

    public class UserCompanyInviteEvent extends Event {

        public static const TYPE:String = "userCompanyInviteEvent";

        public static const ACTION_DELETE:String = "delete";
        public static const ACTION_INVITE:String = "invite";

        private var _userInvite:UserInviteDTO;
        private var _action:String;

        public function UserCompanyInviteEvent(action:String, object:UserInviteDTO) {
            super(TYPE,true, false);
            _userInvite = object;
            _action = action;
        }


        public function get userInvite():UserInviteDTO {
            return _userInvite;
        }

        public function get action():String {
            return _action;
        }

    }
}