package com.neosavvy.user {

    import org.puremvc.as3.multicore.interfaces.IMediator;
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

        override public function onRegister():void
        {
            //add event listeners here...
        }
    }


}
