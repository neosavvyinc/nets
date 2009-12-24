package com.neosavvy.user.view.login {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.UserDTO;

    import flash.events.MouseEvent;

    import mx.controls.Button;
    import mx.controls.Label;
    import mx.events.CloseEvent;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.managers.PopUpManager;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import mx.validators.Validator;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ConfirmUserRegistrationMediator extends Mediator implements IMediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.loginConfirmUserRegistrationMediator");

        public static const NAME:String = "ConfirmUserRegistrationMediator";

        public function ConfirmUserRegistrationMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            confirmUserBtn.addEventListener(MouseEvent.CLICK, handleConfirmUserButtonClickHandler);
        }

        public function get confirmUserRegistration():ConfirmUserRegistration {
            return viewComponent as ConfirmUserRegistration;
        }

        public function get confirmUserBtn():Button {
            return confirmUserRegistration.confirmUserBtn;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.SAVE_USER_TO_COMPANY_FAILED
                ,ApplicationFacade.SAVE_USER_TO_COMPANY_SUCCESS
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
                case ApplicationFacade.SAVE_USER_TO_COMPANY_FAILED:

                    break;
                case ApplicationFacade.SAVE_USER_TO_COMPANY_SUCCESS:
                    break;
            }
        }

        private function handleConfirmUserButtonClickHandler(event:MouseEvent):void {
            if(isUserConfirmationFormValid()){

                var user:UserDTO = new UserDTO();

                user.registrationToken = confirmUserRegistration.confirmationKey.text;
                user.username = confirmUserRegistration.username.text;
                user.firstName = confirmUserRegistration.firstName.text;
                user.middleName = confirmUserRegistration.middleName.text;
                user.lastName = confirmUserRegistration.lastName.text;
                user.password = confirmUserRegistration.password.text;

                sendNotification(ApplicationFacade.SAVE_USER_TO_COMPANY_REQUEST, user);

            }
        }

        private function isUserConfirmationFormValid():Boolean {
            var validators:Array = new Array();
            validators.push(confirmUserRegistration.confirmationKeyValidator);
            validators.push(confirmUserRegistration.userNameValidator)
            validators.push(confirmUserRegistration.firstNameValidator);
            validators.push(confirmUserRegistration.middleNameValidator);
            validators.push(confirmUserRegistration.lastNameValidator);
            validators.push(confirmUserRegistration.passwordValidator);
            validators.push(confirmUserRegistration.confirmPasswordValidator);
            var validationResults:Array = Validator.validateAll(validators);

            for each ( var result:Object in validationResults ) {
                LOGGER.debug(result.message);
            }

            return validationResults.length == 0 ? true : false ;
        }

        /*********
         * END NAVIGATION RELATED HANDLERS
         *********/
    }
}