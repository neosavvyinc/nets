package com.neosavvy.user.view.companyManagement {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.CompanyDTO;

    import com.neosavvy.user.dto.NumEmployeesRangeDTO;

    import com.neosavvy.user.dto.UserDTO;

    import flash.events.MouseEvent;

    import mx.containers.ViewStack;
    import mx.controls.Button;
    import mx.controls.RadioButtonGroup;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class CompanyManagementMediator extends Mediator implements IMediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.companyManagement.CompanyManagementMediator")

        public static const NAME:String = "CompanyManagementMediator";

        public static const REGISTRATION_INDEX:Number = 0;
        public static const CONFIRMATION_INDEX:Number = 1;

        public function CompanyManagementMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            registerButton.addEventListener(MouseEvent.CLICK, registerCompanyButtonClickHandler);
        }

        public function get companyManagement():CompanyManagement {
            return this.viewComponent as CompanyManagement;
        }

        public function get registerButton():Button {
            return companyManagement.registerCompanyButton;
        }

        public function get companyManavementViewStack():ViewStack {
            return companyManagement.companyRegistrationProcessViewStack;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.SAVE_COMPANY_FAILED
                ,ApplicationFacade.SAVE_COMPANY_SUCCESS
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
                case ApplicationFacade.SAVE_COMPANY_SUCCESS:
                    LOGGER.debug("Save company succeeded");
                    companyManavementViewStack.selectedIndex = CONFIRMATION_INDEX;
                    break;
                case ApplicationFacade.SAVE_COMPANY_FAILED:
                    LOGGER.debug("Save company failed");
                    break;
            }
        }

        private function registerCompanyButtonClickHandler(event:MouseEvent):void {
            var company:CompanyDTO = new CompanyDTO();
            company.addressOne = companyManagement.addressOne.text;
            company.addressTwo = companyManagement.addressTwo.text;
            company.city = companyManagement.city.text;
            company.companyName = companyManagement.companyName.text;
            company.country = companyManagement.country.selectedItem as String;
            company.postalCode = companyManagement.postalCode.text;
            company.numEmployeesRange = new NumEmployeesRangeDTO();

            var radioButtonGroup:RadioButtonGroup = companyManagement.numberOfEmployeesGroup;
            var selectedValue:Object = radioButtonGroup.selectedValue;
            var numEmployeesSelected:String = selectedValue as String;
            if (numEmployeesSelected.indexOf(">") == -1) {
                company.numEmployeesRange.rangeFrom = numEmployeesSelected.split("-")[0] as Number;
                company.numEmployeesRange.rangeTo = numEmployeesSelected.split("-")[1] as Number;
            } else {
                company.numEmployeesRange.rangeFrom = 10001;
                company.numEmployeesRange.rangeTo = Number.MAX_VALUE;
            }

            var user:UserDTO = new UserDTO();
            user.username = companyManagement.administrativeUser.text;
            user.password = companyManagement.administrativePassword.text;
            user.emailAddress = companyManagement.administrativeEmail.text;
            user.firstName = companyManagement.administrativeFirstName.text;
            user.middleName = companyManagement.administrativeMiddleName.text;
            user.lastName = companyManagement.administrativeLastName.text;
            sendNotification(ApplicationFacade.SAVE_COMPANY_REQUEST, [company,user]);
        }

    }
}