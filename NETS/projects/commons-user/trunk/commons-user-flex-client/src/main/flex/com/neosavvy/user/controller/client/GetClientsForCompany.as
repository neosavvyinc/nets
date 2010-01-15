package com.neosavvy.user.controller.client {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.NeosavvyAsyncCommand;
    import com.neosavvy.user.model.ClientServiceProxy;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class GetClientsForCompany extends NeosavvyAsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.model.ClientServiceProxy");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var companyProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var clientProxy:ClientServiceProxy = facade.retrieveProxy(ClientServiceProxy.NAME) as ClientServiceProxy;
            clientProxy.findClientsForParentCompany(companyProxy.activeCompany, this);
        }

        public function result(data:Object):void {
            LOGGER.debug("Clients were returned");
            var event:ResultEvent = data as ResultEvent;
            var clientProxy:ClientServiceProxy = facade.retrieveProxy(ClientServiceProxy.NAME) as ClientServiceProxy;
            clientProxy.clientCompanies = event.result as ArrayCollection;

            sendNotification(ApplicationFacade.FIND_CLIENTS_FOR_PARENT_COMPANY_SUCCESS);
            commandComplete();
        }

        public function fault(info:Object):void {
            var event:FaultEvent = info as FaultEvent;
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);
            sendNotification(ApplicationFacade.FIND_CLIENTS_FOR_PARENT_COMPANY_FAILED);
            commandComplete();
        }


    }
}