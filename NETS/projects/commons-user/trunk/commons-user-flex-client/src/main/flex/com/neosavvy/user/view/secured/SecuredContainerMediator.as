package com.neosavvy.user.view.secured {
    import com.neosavvy.user.view.secured.leftNavigation.admin.*;
    import com.neosavvy.user.ApplicationFacade;

    import flash.events.MouseEvent;

    import mx.containers.ViewStack;
    import mx.controls.LinkButton;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class SecuredContainerMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.SecuredContainerMediator");

        public static const NAME:String = "securedContainerMediator";

        public function SecuredContainerMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        public static const NAV_INDEX_WELCOME:Number = 0;
        public static const NAV_INDEX_INVITE_EMPLOYEES:Number = 1;
        public static const NAV_INDEX_VIEW_ACTIVE_EMPLOYEES:Number = 2;
        public static const NAV_INDEX_VIEW_INACTIVE_EMPLOYEES:Number = 3;

        override public function onRegister():void {
        }

        public function get securedContainer():SecuredContainer {
            return viewComponent as SecuredContainer;
        }

        public function get navigationViewStack():ViewStack {
            return securedContainer.navigationViewStack;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch ( notification.getBody() ) {
                case ApplicationFacade.NAVIGATE_TO_WELCOME:
                    navigationViewStack.selectedIndex = NAV_INDEX_WELCOME;
                    break;
                case ApplicationFacade.NAVIGATE_TO_INVITE_EMPLOYEES:
                    navigationViewStack.selectedIndex = NAV_INDEX_INVITE_EMPLOYEES;
                    break;
            }
        }

    }
}