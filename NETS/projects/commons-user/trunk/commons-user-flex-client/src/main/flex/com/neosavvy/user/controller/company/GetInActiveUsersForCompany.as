package com.neosavvy.user.controller.company {
    import com.neosavvy.user.ApplicationFacade;
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

    public class GetInActiveUsersForCompany extends AsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.company.GetActiveUsersForCompany");

        override public function execute(notification:INotification):void {
            var companyProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var company:CompanyDTO = notification.getBody() as CompanyDTO;
            companyProxy.findInactiveUsersForCompany(company, this);
        }


        public function fault(info:Object):void {
            var event:FaultEvent = info as FaultEvent;
            LOGGER.debug("Unable to find inactive users: " + event.toString());
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);
            sendNotification(ApplicationFacade.NON_ACTIVE_EMPLOYEES_FAILED);

            commandComplete();
        }

        public function result(data:Object):void {
            var event:ResultEvent = data as ResultEvent;
            var _inactiveUsersForCompany:ArrayCollection;
            if (event.result)
                _inactiveUsersForCompany = event.result as ArrayCollection;
            else
                _inactiveUsersForCompany = new ArrayCollection();
            sendNotification(ApplicationFacade.NON_ACTIVE_EMPLOYEES_SUCCESS);

            commandComplete();
        }
    }
}