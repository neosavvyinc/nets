package com.neosavvy.user.model {
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.project.ClientCompany;
    import com.neosavvy.user.dto.project.ClientUserContact;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.remoting.mxml.RemoteObject;

    public class ClientServiceProxy extends AbstractRemoteObjectProxy {
        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.model.ClientServiceProxy");

        public static var NAME:String = "clientProxy";

        private var remote:Boolean = ProxyConstants.isRemoteEnabled;

        public function ClientServiceProxy()
        {
            super(NAME, null);
        }

        public function get clientCompanies():ArrayCollection {
            return data as ArrayCollection;
        }

        public function set clientCompanies(value:ArrayCollection):void {
            data = value;

        }

        public function findClientsForParentCompany(company:CompanyDTO, responder:IResponder):void
        {
            var companyService:RemoteObject = getService(ProxyConstants.clientServiceDestiation);
            addCallbackHandler(companyService, responder);
            companyService.findClientsForParentCompany(company);
        }


        public function saveClientCompany(clientCompany:ClientCompany, clientUserContact:ClientUserContact, responder:IResponder):void {
            var companyService:RemoteObject = getService(ProxyConstants.clientServiceDestiation);
            addCallbackHandler(companyService, responder);
            companyService.saveClientForCompany(clientCompany, clientUserContact);
        }

    }
}
