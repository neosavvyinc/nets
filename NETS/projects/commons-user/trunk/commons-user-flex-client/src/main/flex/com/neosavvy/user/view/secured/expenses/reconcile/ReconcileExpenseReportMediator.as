package com.neosavvy.user.view.secured.expenses.reconcile {
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ReconcileExpenseReportMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.expenses.reconcile.ReconcileExpenseReportMediator");

        public static const NAME:String = "reconcileExpenseReportMediator";

        public function ReconcileExpenseReportMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }


        override public function onRegister():void {
        }

        override public function onRemove():void {
        }

        override public function listNotificationInterests():Array {
            return [
            ];
        }


        override public function handleNotification(notification:INotification):void {
        }

    }
}