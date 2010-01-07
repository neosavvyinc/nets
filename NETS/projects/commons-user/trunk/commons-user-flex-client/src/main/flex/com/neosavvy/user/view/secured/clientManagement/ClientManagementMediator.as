package com.neosavvy.user.view.secured.clientManagement {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.project.ClientCompany;
    import com.neosavvy.user.dto.project.ClientUserContact;
    import com.neosavvy.user.model.ClientServiceProxy;

    import com.neosavvy.user.model.CompanyServiceProxy;

    import flash.events.MouseEvent;

    import mx.containers.Form;
    import mx.controls.AdvancedDataGrid;
    import mx.controls.Button;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ClientManagementMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.clientManagement.ClientManagementMediator")

        public static const NAME:String = "clientManagementMediator";

        public function ClientManagementMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        private var _companyProxy:CompanyServiceProxy;
        private var _clientProxy:ClientServiceProxy;

        override public function onRegister():void {
            _companyProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            _clientProxy = facade.retrieveProxy(ClientServiceProxy.NAME) as ClientServiceProxy;

            saveClientButton.addEventListener(MouseEvent.CLICK, handleSaveClientButtonClicked);

        }

        override public function onRemove():void {
            _companyProxy = null;
            _clientProxy = null;

            saveClientButton.removeEventListener(MouseEvent.CLICK, handleSaveClientButtonClicked);
        }

        public function get clientManagement():ClientManagement {
            return viewComponent as ClientManagement;
        }

        public function get clientManagementGrid():AdvancedDataGrid {
            return clientManagement.clientManagementGrid;
        }

        public function get saveClientButton():Button {
            return clientManagement.saveButton;
        }

        public function isClientCompanyFormValid():Boolean {
            var formIsValid:Boolean = clientManagement.clientCompanyFormValidator.formIsValid;
            return formIsValid;
        }

        public function isClientContactFormValid():Boolean {
            var boolean:Boolean = clientManagement.clientFormValidator.formIsValid;
            return boolean;
        }

        private function handleSaveClientButtonClicked(event:MouseEvent):void {

            if( isClientCompanyFormValid() && isClientContactFormValid() ) {
                var activeCompany:CompanyDTO = _companyProxy.activeCompany;
                var clientCompany:ClientCompany = getClientCompany();
                clientCompany.parentCompany = activeCompany;
                var clientContact:ClientUserContact = getClientContact();
                var params:Array = [clientCompany,clientContact];
                sendNotification(ApplicationFacade.SAVE_CLIENT_COMPANY_REQUEST, params);                
            } else {

                // should return some messages to the user to show what went wrong...

            }
            
        }

        private function getClientContact():ClientUserContact {
            var clientUserContact:ClientUserContact = new ClientUserContact();
            clientUserContact.firstName = clientManagement.firstName.text;
            clientUserContact.middleName = clientManagement.middleName.text;
            clientUserContact.lastName = clientManagement.lastName.text;
            clientUserContact.emailAddress = clientManagement.email.text;
            clientUserContact.contactPhoneNumber = clientManagement.phone.text;
            return clientUserContact;
        }

        private function getClientCompany():ClientCompany {
            var clientCompany:ClientCompany = new ClientCompany();
            clientCompany.companyName = clientManagement.companyName.text;
            clientCompany.addressOne = clientManagement.billingAddressOne.text;
            clientCompany.addressTwo = clientManagement.billingAddressTwo.text;
            clientCompany.city = clientManagement.city.text;
            clientCompany.postalCode = clientManagement.zipCode.text;
            clientCompany.state = clientManagement.state.text;
            return clientCompany;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_CLIENT_MANAGEMENT
                ,ApplicationFacade.SAVE_CLIENT_COMPANY_SUCCESS
                ,ApplicationFacade.FIND_CLIENTS_FOR_PARENT_COMPANY_SUCCESS    
            ];
        }


        override public function handleNotification(notification:INotification):void {

            switch(notification.getName()) {
                case ApplicationFacade.SAVE_CLIENT_COMPANY_SUCCESS:
                case ApplicationFacade.NAVIGATE_TO_CLIENT_MANAGEMENT:
                    sendNotification(ApplicationFacade.FIND_CLIENTS_FOR_PARENT_COMPANY_REQUEST);
                    break;
                case ApplicationFacade.FIND_CLIENTS_FOR_PARENT_COMPANY_SUCCESS:
                    clientManagementGrid.dataProvider = _clientProxy.clientCompanies;
                    break;
            }

        }
    }
}