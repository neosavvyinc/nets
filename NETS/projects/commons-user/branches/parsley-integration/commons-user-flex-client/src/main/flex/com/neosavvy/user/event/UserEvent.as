package com.neosavvy.user.event {
import flash.events.Event;

public class UserEvent extends Event {

    public static const TYPE_GET:String = "get";

        public function UserEvent(type:String, bubbles:Boolean, cancelable:Boolean) {
            super(type, bubbles, cancelable);
        }

    }
}