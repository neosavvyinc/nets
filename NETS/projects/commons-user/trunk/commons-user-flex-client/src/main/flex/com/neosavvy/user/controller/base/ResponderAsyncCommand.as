package com.neosavvy.user.controller.base {
    import com.neosavvy.user.ApplicationFacade;

    import flash.errors.IllegalOperationError;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

    public class ResponderAsyncCommand extends AsyncCommand implements IResponder {
        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.command.base.ResponderAsyncCommand");

        public function fault(info:Object):void {
            var faultEvent:FaultEvent = info as FaultEvent;
            faultHandler(faultEvent);
            commandComplete();
        }

        public function result(data:Object):void {
            var resultEvent:ResultEvent = data as ResultEvent;
            try {
                resultHandler(resultEvent);
            }
            catch (e:Error) {
                LOGGER.error(e.message + "\n" + e.getStackTrace());
                sendNotification(ApplicationFacade.DISPLAY_ERROR, e.message);
            }

            commandComplete();
        }

        protected function faultHandler(faultEvent:FaultEvent):void {
            throw new IllegalOperationError("Subclass must implement the ResponderAsyncCommand::faultHandler(faultEvent:FaultEvent):void method signature");
        }

        protected function resultHandler(resultEvent:ResultEvent):void {
            throw new IllegalOperationError("Subclass must implement the ResponderAsyncCommand::resultHandler(resultEvent:ResultEvent):void method signature");
        }

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