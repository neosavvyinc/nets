package com.neosavvy.user.view.mail {
    import flash.events.Event;

    public class MailMessageEvent extends Event {

        public static const TYPE:String = "mailMessageEvent";

        private var _message:Object;

        public function MailMessageEvent( message : Object ) {
            super( TYPE, true );
            _message = message;
        }

        public function get message():Object {
            return _message;
        }
    }
}