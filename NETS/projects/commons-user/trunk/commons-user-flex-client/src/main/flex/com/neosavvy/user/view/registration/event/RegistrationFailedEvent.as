package com.neosavvy.user.view.registration.event {
import flash.events.Event;

public class RegistrationFailedEvent extends Event {

    public static const TYPE:String = "registrationFailed";

    private var _faultMessage:String;
    private var _faultMessageToString:String;

    public function RegistrationFailedEvent( faultMessage:String, faultToString:String ) {
        super(TYPE,true);
        _faultMessage = faultMessage;
        _faultMessageToString = faultToString;
    }

    public function get faultMessage():String {
        return _faultMessage;
    }

    public function get faultMessageToString():String {
        return _faultMessageToString;
    }
}
}