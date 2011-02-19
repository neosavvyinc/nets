package com.neosavvy.user.model {
import com.neosavvy.user.event.UserEvent;

import flash.events.EventDispatcher;

import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;

[Event(name="userModelChanged",type="com.neosavvy.user.event.UserEvent")]
[ManagedEvents("userModelChanged")]
public class UserModel extends EventDispatcher {

        [Bindable]
        private var _users:ArrayCollection;

        public function get users():ArrayCollection {
            return _users;
        }

        public function set users(value:ArrayCollection):void {
            _users = value;
            dispatchEvent(new UserEvent(UserEvent.TYPE_USER_MODEL_CHANGED, true, true));
        }
    }
}