package com.neosavvy.user.event {
import com.neosavvy.user.dto.UserDTO;

import flash.events.Event;

    public class UserEvent extends Event {

        public static const TYPE_GET:String = "get";
        public static const TYPE_SAVE:String = "save";
        public static const TYPE_USER_MODEL_CHANGED:String = "userModelChanged";
        public static const TYPE_DELETE:String = "delete";

        public function UserEvent(type:String, bubbles:Boolean, cancelable:Boolean) {
            super(type, bubbles, cancelable);
        }

        private var _user:UserDTO;

        public function get user():UserDTO {
            return _user;
        }

        public function set user(value:UserDTO):void {
            _user = value;
        }
    }
}