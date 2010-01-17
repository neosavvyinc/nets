package com.neosavvy.user.controller.company {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class GetActiveUsersForCompany extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.company.GetActiveUsersForCompany");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var companyProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            companyProxy.findActiveUsersForCompany(this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var companyProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var _activeUsersForCompany:ArrayCollection;

            if (resultEvent.result)
                _activeUsersForCompany = resultEvent.result as ArrayCollection;
            else
                _activeUsersForCompany = new ArrayCollection();

            companyProxy.activeUsersForCompany = _activeUsersForCompany;
            sendNotification(ApplicationFacade.ACTIVE_EMPLOYEES_SUCCESS);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.ACTIVE_EMPLOYEES_FAILED);
        }
    }
}