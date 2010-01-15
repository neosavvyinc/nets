package com.neosavvy.user.view.secured.leftNavigation {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.model.SecurityProxy;
    import com.neosavvy.user.view.secured.leftNavigation.admin.AdminNavigation;
    import com.neosavvy.user.view.secured.leftNavigation.employee.EmployeeNavigation;

    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class LeftNavigationMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.leftNavigation.LeftNavigationMediator");

        public static const NAME:String = "leftNavigationMediator";

        public function LeftNavigationMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
        }

        public function get leftNavigation():LeftNavigation {
            return viewComponent as LeftNavigation;
        }

        public function get adminNavigation():AdminNavigation {
            return leftNavigation.adminNavigation;
        }

        public function get employeeNavigation():EmployeeNavigation {
            return leftNavigation.employeeNavigation;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.USER_LOGIN_SUCCESS,
                ApplicationFacade.USER_LOGGED_IN,
                ApplicationFacade.POST_SECURE_VIEW_PREP
            ];
        }

        var removedAdminNavigation:AdminNavigation;

        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
                case ApplicationFacade.USER_LOGIN_SUCCESS:
                case ApplicationFacade.USER_LOGGED_IN:
                case ApplicationFacade.POST_SECURE_VIEW_PREP:
                    var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
                    if (securityProxy.isActiveUserAdmin()) {
                        if (removedAdminNavigation) {
                            leftNavigation.addChildAt(removedAdminNavigation, 0);
                        }
                    } else {
                        removedAdminNavigation = leftNavigation.removeChild(adminNavigation) as AdminNavigation;
                    }
                    break;
            }
        }
    }
}