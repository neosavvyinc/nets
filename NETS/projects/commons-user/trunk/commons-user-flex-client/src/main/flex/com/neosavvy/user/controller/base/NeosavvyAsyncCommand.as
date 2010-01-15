package com.neosavvy.user.controller.base {
    import flash.errors.IllegalOperationError;

    import mx.collections.ArrayCollection;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

    public class NeosavvyAsyncCommand extends AsyncCommand {


        override public function execute(notification:INotification):void {

           isCallerAsyncMacro = isCallerAsyncMacroCommand();

        }

        protected function isCallerAsyncMacroCommand():Boolean {
            try {
                throw new Error("Throwing an error to attempt to get the stack trace");
            } catch ( e:Error ) {
                var stackTrace:String = e.getStackTrace();
                var stackElements:Array = stackTrace.split("\n");
                var stack:ArrayCollection = new ArrayCollection();
                for each (var item:String in stackElements) {
                    stack.addItem( item.substr(4,item.indexOf("/")-4));
                }
                if ( stack.contains("org.puremvc.as3.multicore.patterns.command::AsyncMacroCommand")) {
                    return true;
                }
                return false
            }
            throw new IllegalOperationError("Could not determine if the caller was a macro command or simple command");
        }


        override protected function commandComplete():void {
            if( isCallerAsyncMacro )
                super.commandComplete();
        }

        private var _isCallerAsyncMacro:Boolean;


        public function get isCallerAsyncMacro():Boolean {
            return _isCallerAsyncMacro;
        }

        public function set isCallerAsyncMacro(value:Boolean):void {
            _isCallerAsyncMacro = value;
        }
    }
}