package com.neosavvy.user.model {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;

    import com.neosavvy.user.dto.companyManagement.UserCompanyRoleDTO;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.dto.companyManagement.UserDTO;

    import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
    import com.neosavvy.user.dto.project.ClientCompany;
    import com.neosavvy.user.dto.project.ClientUserContact;
    import com.neosavvy.user.model.UserServiceProxy;

    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.collections.ArrayCollection;
    import mx.collections.ListCollectionView;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import mx.messaging.AbstractProducer;
    import mx.messaging.ChannelSet;
    import mx.messaging.channels.AMFChannel;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.mxml.RemoteObject;

    import org.puremvc.as3.multicore.patterns.proxy.Proxy;

    public class ClientServiceProxy extends Proxy {
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

    //public void saveClientForCompany(ClientCompany client, ClientUserContact contact);


        public function findClientsForParentCompany(company:CompanyDTO):void
        {
            var companyService:RemoteObject = getService();
            companyService.addEventListener(ResultEvent.RESULT, handleFindClientsForParentCompanyResult);
            companyService.addEventListener(FaultEvent.FAULT, handleFindClientsForParentCompanyFault);
            companyService.findClientsForParentCompany( company );
        }

        private function handleFindClientsForParentCompanyResult(event:ResultEvent):void {
            LOGGER.debug("Clients were returned");
            this.data = event.result as ArrayCollection;
            sendNotification(ApplicationFacade.FIND_CLIENTS_FOR_PARENT_COMPANY_SUCCESS);

        }
        
        private function handleFindClientsForParentCompanyFault(event:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);
            sendNotification(ApplicationFacade.FIND_CLIENTS_FOR_PARENT_COMPANY_FAILED);
        }


        public function saveClientCompany(clientCompany:ClientCompany, clientUserContact:ClientUserContact):void {
            var companyService:RemoteObject = getService();
            companyService.addEventListener(ResultEvent.RESULT, handleSaveClientForCompanyResult);
            companyService.addEventListener(FaultEvent.FAULT, handleSaveClientForCompanyFault);
            companyService.saveClientForCompany( clientCompany, clientUserContact);
        }

        private function handleSaveClientForCompanyFault(event:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);
            sendNotification(ApplicationFacade.SAVE_CLIENT_COMPANY_FAILED);
        }

        private function handleSaveClientForCompanyResult(event:ResultEvent):void {
            LOGGER.debug("Save Client For Company was successful");
            sendNotification(ApplicationFacade.SAVE_CLIENT_COMPANY_SUCCESS);
        }


        /****
         *
         * Helper functions
         *
         ****/
        private function getServiceChannelSet():ChannelSet {
            var channel:AMFChannel = new AMFChannel(ProxyConstants.channelName, ProxyConstants.url);
            var channelSet:ChannelSet = new ChannelSet();
            channelSet.addChannel(channel);
            return channelSet;
        }

        private function getService():RemoteObject {
            var userService:RemoteObject = new RemoteObject();
            userService.channelSet = getServiceChannelSet();
            userService.destination = ProxyConstants.clientServiceDestiation;
            return userService;
        }


        }
}