package com.neosavvy.user.view.login {
    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class RegistrationAndLoginWindowMediator extends Mediator implements IMediator {

        static public const NAME:String = "RegistrationAndLoginWindowMediator";

        public function RegistrationAndLoginWindowMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }


    }
}