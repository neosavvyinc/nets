package com.neosavvy.user.controller.company {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.model.CompanyServiceProxy;

    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

    public class GetActiveUsersForCompany extends AsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.company.GetActiveUsersForCompany");

        override public function execute(notification:INotification):void {
            var companyProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            companyProxy.findActiveUsersForCompany(this);
        }

        public function fault(info:Object):void {
            var faultEvent:FaultEvent = info as FaultEvent;
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.ACTIVE_EMPLOYEES_FAILED);
            commandComplete();
        }

        public function result(data:Object):void {
            var event:ResultEvent = data as ResultEvent;
            var companyProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var _activeUsersForCompany:ArrayCollection;

            if( event.result )
                _activeUsersForCompany = event.result as ArrayCollection;
            else
                _activeUsersForCompany = new ArrayCollection();

            companyProxy.activeUsersForCompany = _activeUsersForCompany;
            sendNotification(ApplicationFacade.ACTIVE_EMPLOYEES_SUCCESS);

            commandComplete();
        }

        
    }
}