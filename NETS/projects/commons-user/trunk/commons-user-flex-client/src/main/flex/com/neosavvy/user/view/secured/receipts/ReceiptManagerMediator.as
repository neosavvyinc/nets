package com.neosavvy.user.view.secured.receipts {
    import com.neosavvy.user.ApplicationFacade;

    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.model.SecurityProxy;

    import mx.controls.TileList;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ReceiptManagerMediator extends Mediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.receipts.ReceiptManagerMediator");

        public static const NAME:String = "receiptManagerMediator";

        private var securityProxy : SecurityProxy


        public function ReceiptManagerMediator( viewComponent : Object ) {
            super(NAME, viewComponent);
        }


        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_MANAGE_RECEIPTS
            ];
        }

        public function get receiptManager():ReceiptManager
        {
            return viewComponent as ReceiptManager;
        }

        public function get receiptViewer():TileList
        {
            return receiptManager.receiptViewer;
        }

        override public function onRegister():void {
            super.onRegister();

            securityProxy = ApplicationFacade.getSecurityProxy();
        }

        override public function onRemove():void {
            super.onRemove();

            securityProxy = null;
        }

        override public function handleNotification(notification:INotification):void {
            switch( notification.getName() )
            {
                case ApplicationFacade.NAVIGATE_TO_MANAGE_RECEIPTS:
                    var activeUser : UserDTO = securityProxy.activeUser;
                    receiptViewer.dataProvider = activeUser.uncategorizedReceipts;
                    break;
            }
        }
    }
}