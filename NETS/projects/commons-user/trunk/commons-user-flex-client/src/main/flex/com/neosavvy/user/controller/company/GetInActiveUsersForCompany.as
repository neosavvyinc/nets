package com.neosavvy.user.controller.company {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
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

    public class GetInActiveUsersForCompany extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.company.GetActiveUsersForCompany");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var companyProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var company:CompanyDTO = notification.getBody() as CompanyDTO;
            companyProxy.findInactiveUsersForCompany(company, this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var _inactiveUsersForCompany:ArrayCollection;
            var companyProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            if (resultEvent.result)
                _inactiveUsersForCompany = resultEvent.result as ArrayCollection;
            else
                _inactiveUsersForCompany = new ArrayCollection();

            companyProxy.inactiveUsersForCompany = _inactiveUsersForCompany;
            sendNotification(ApplicationFacade.NON_ACTIVE_EMPLOYEES_SUCCESS);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            LOGGER.debug("Unable to find inactive users: " + faultEvent.toString());
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.NON_ACTIVE_EMPLOYEES_FAILED);
        }
    }
}