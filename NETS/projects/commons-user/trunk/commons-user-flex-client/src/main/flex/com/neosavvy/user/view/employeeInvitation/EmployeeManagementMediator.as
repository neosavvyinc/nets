package com.neosavvy.user.view.employeeInvitation {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.CompanyDTO;
    import com.neosavvy.user.dto.UserDTO;

    import com.neosavvy.user.model.CompanyServiceProxy;

    import flash.events.MouseEvent;

    import mx.controls.Button;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class EmployeeManagementMediator extends Mediator implements IMediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.employeeInvitation.EmployeeManagementMediator")

        public static const NAME:String = "employeeManagementMediator";

        public function EmployeeManagementMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            addUserButton.addEventListener(MouseEvent.CLICK, addUserButtonClickListener);
        }


        public function get employeeManagement():EmployeeManagement {
            return viewComponent as EmployeeManagement;
        }

        public function get addUserButton():Button {
            return employeeManagement.addUserButton;
        }

        private function addUserButtonClickListener(event:MouseEvent):void {
            var user:UserDTO = new UserDTO();
            user.firstName = employeeManagement.empFName.text;
            user.lastName = employeeManagement.empLName.text;
            user.emailAddress = employeeManagement.empEmail.text;

            var company:CompanyDTO = (facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy).activeCompany;

            sendNotification(ApplicationFacade.SAVE_USER_TO_COMPANY_REQUEST, [company,user]);
        }

    }
}