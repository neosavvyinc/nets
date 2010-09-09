package com.neosavvy.user.controller.base {
    import mx.controls.Alert;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class DisplayErrorCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {
            Alert.show("An unexpected error occurred.  Please try again or contact nets@neosavvy.com for assistance.", 'Oops!');
        }
    }
}