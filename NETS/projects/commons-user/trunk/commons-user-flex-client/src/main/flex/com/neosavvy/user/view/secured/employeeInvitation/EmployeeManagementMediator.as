package com.neosavvy.user.view.secured.employeeInvitation {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.CompanyDTO;
    import com.neosavvy.user.dto.UserDTO;

    import com.neosavvy.user.dto.UserInviteDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;

    import flash.events.MouseEvent;

    import flash.ui.Mouse;

    import mx.collections.ArrayCollection;
    import mx.controls.AdvancedDataGrid;
    import mx.controls.Button;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class EmployeeManagementMediator extends Mediator implements IMediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.employeeInvitation.EmployeeManagementMediator")

        public static const NAME:String = "employeeManagementMediator";

        private var _userInviteQueue:ArrayCollection = new ArrayCollection();

        public function EmployeeManagementMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            addUserButton.addEventListener(MouseEvent.CLICK, addUserButtonClickListener);
            doneButton.addEventListener(MouseEvent.CLICK, doneButtonClickHandler);
            cancelButton.addEventListener(MouseEvent.CLICK, cancelButtonClickHandler);
        }

        public function get employeeManagement():EmployeeManagement {
            return viewComponent as EmployeeManagement;
        }

        public function get addUserButton():Button {
            return employeeManagement.addUserButton;
        }

        public function get grid():AdvancedDataGrid {
            return employeeManagement.employeesQueuedToInvite;
        }

        public function get doneButton():Button {
            return employeeManagement.doneBtn;
        }

        public function get cancelButton():Button {
            return employeeManagement.cancelBtn;
        }

        private function addUserButtonClickListener(event:MouseEvent):void {
            var user:UserInviteDTO = new UserInviteDTO();
            user.firstName = employeeManagement.empFName.text;
            user.lastName = employeeManagement.empLName.text;
            user.emailAddress = employeeManagement.empEmail.text;

            var company:CompanyDTO = (facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy).activeCompany;

            user.company = company;

            _userInviteQueue.addItem( user );
            grid.dataProvider = _userInviteQueue;
        }

        private function cancelButtonClickHandler(event:MouseEvent):void {
            grid.dataProvider = _userInviteQueue = new ArrayCollection();
        }

        private function doneButtonClickHandler(event:MouseEvent):void {
            var activeCompany:CompanyDTO = (facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy).activeCompany;
            sendNotification(ApplicationFacade.INVITE_USER_TO_COMPANY_REQUEST, [activeCompany, _userInviteQueue]);
        }
    }
}