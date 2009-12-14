package com.neosavvy.user.view.userManagement {
    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class UserManagementMediator extends Mediator implements IMediator {

        static public const NAME:String = "UserManagementMediator";

        public function UserManagementMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

    }
}