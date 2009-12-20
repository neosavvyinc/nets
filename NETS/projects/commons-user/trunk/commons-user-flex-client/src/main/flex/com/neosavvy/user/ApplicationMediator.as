package com.neosavvy.user {

    import flash.events.MouseEvent;

    import mx.containers.ViewStack;
    import mx.controls.Button;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    /**
     * User: adamparrish
     * Date: Dec 9, 2009
     * Time: 10:54:23 PM
     */
    public class ApplicationMediator extends Mediator implements IMediator {
        public function ApplicationMediator(viewComponent:CommonsUser)
        {
            super(NAME, viewComponent);
        }

        public function get app():CommonsUser
        {
            return viewComponent as CommonsUser;
        }

        public function get newCompanyButton():Button{
            return app.newCompanyButton;
        }

        public function get existingUserButton():Button {
            return app.existingUsersButton;
        }

        public function get navigationViewStack():ViewStack {
            return app.navigationViewStack;
        }

        override public function onRegister():void
        {
            this.newCompanyButton.addEventListener(MouseEvent.CLICK, newCompanyButtonClicked);
            this.existingUserButton.addEventListener(MouseEvent.CLICK, existingUserButtonClicked);
        }


        override public function listNotificationInterests():Array {
            return [
                //ApplicationFacade.SAVE_COMPANY_SUCCESS
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch ( notification.getName() ) {
//                case ApplicationFacade.SAVE_COMPANY_SUCCESS:
//                    this.navigationViewStack.selectedIndex = 3;
//                    break;
            }
        }

        private function newCompanyButtonClicked(event:MouseEvent):void {
            this.navigationViewStack.selectedIndex = 1;
        }

        private function existingUserButtonClicked(event:MouseEvent):void {
            sendNotification(ApplicationFacade.CHECK_USER_LOGGED_IN);
            this.navigationViewStack.selectedIndex = 2;
        }
    }


}
