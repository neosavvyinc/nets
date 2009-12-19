package com.neosavvy.user.model {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.CompanyDTO;

    import com.neosavvy.user.dto.UserDTO;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import mx.messaging.ChannelSet;
    import mx.messaging.channels.AMFChannel;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.mxml.RemoteObject;

    import org.puremvc.as3.multicore.patterns.proxy.Proxy;

    public class CompanyServiceProxy extends Proxy {
        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.model.CompanyServiceProxy");

        public static var NAME:String = "companyProxy";

        private var remote:Boolean = ProxyConstants.isRemoteEnabled;

        public function CompanyServiceProxy()
        {
            super(NAME, null);
        }

        public function addCompany(company:CompanyDTO, user:UserDTO):void
        {
            var companyService:RemoteObject = getCompanyService();
            companyService.addEventListener(ResultEvent.RESULT, handleSaveCompanyResult);
            companyService.addEventListener(FaultEvent.FAULT, handleSaveCompanyFault);
            companyService.addCompany( company, user );
        }

        private function handleSaveCompanyFault(event:FaultEvent):void {
            LOGGER.debug("Save Company failed: " + event.toString());
            sendNotification(ApplicationFacade.SAVE_COMPANY_FAILED);
        }

        private function handleSaveCompanyResult(event:ResultEvent):void {
            LOGGER.debug("Company was returned");
            this.data = event.result as ArrayCollection;
            sendNotification(ApplicationFacade.SAVE_COMPANY_SUCCESS);
        }

        /****
         *
         * Helper functions
         *
         ****/
        private function getCompanyServiceChannelSet():ChannelSet {
            var channel:AMFChannel = new AMFChannel(ProxyConstants.channelName, ProxyConstants.url);
            var channelSet:ChannelSet = new ChannelSet();
            channelSet.addChannel(channel);
            return channelSet;
        }

        private function getCompanyService():RemoteObject {
            var userService:RemoteObject = new RemoteObject();
            userService.channelSet = getCompanyServiceChannelSet();
            userService.destination = ProxyConstants.companyServiceDestiation;
            return userService;
        }


    }
}