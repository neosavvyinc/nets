package com.neosavvy.user.view.secured.welcome {
    import com.neosavvy.user.ApplicationFacade;

    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.CompanyServiceProxy;

    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class WelcomeMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.welcome.WelcomeMediator");

        public static const NAME:String = "welcomeMediator";

        public function WelcomeMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }



        override public function onRegister():void {
        }

        public function get welcome():Welcome {
            return viewComponent as Welcome;
        }



        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_WELCOME
                ,ApplicationFacade.USER_LOGIN_STARTUP_COMPLETE
            ];
        }

        private function setTitle():void {
            var companyProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            welcome.title = "Welcome to " + companyProxy.activeCompany.companyName + "'s expense tracking system";
        }

        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
                case ApplicationFacade.USER_LOGIN_STARTUP_COMPLETE:
                case ApplicationFacade.NAVIGATE_TO_WELCOME:
                    setTitle();
                    break;
            }
        }

    }
}