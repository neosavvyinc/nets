package com.neosavvy.user.controller.base {
    import flash.errors.IllegalOperationError;

    import mx.collections.ArrayCollection;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

    public class NeosavvyAsyncCommand extends AsyncCommand {

        override public function setOnComplete(value:Function):void {
            isCallerAsyncMacro = true;
            super.setOnComplete(value);
        }

        override protected function commandComplete():void {
            if( isCallerAsyncMacro )
                super.commandComplete();
        }

        private var _isCallerAsyncMacro:Boolean = false;


        public function get isCallerAsyncMacro():Boolean {
            return _isCallerAsyncMacro;
        }

        public function set isCallerAsyncMacro(value:Boolean):void {
            _isCallerAsyncMacro = value;
        }
    }
}