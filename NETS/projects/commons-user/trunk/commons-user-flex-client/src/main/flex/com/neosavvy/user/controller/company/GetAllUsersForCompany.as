package com.neosavvy.user.controller.company {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.NeosavvyAsyncCommand;
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

    public class GetAllUsersForCompany extends NeosavvyAsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.company.GetAllUsersForCompany");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var companyProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var company:CompanyDTO = notification.getBody() as CompanyDTO;
            companyProxy.findUsersForCompany(company, this);
        }

        public function fault(info:Object):void {
            var event:FaultEvent = info as FaultEvent;
            LOGGER.debug("Unable to find all users: " + event.toString());
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);

            sendNotification(ApplicationFacade.ALL_EMPLOYEES_FAILED);

            commandComplete();
        }

        public function result(data:Object):void {
            var companyProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var event:ResultEvent = data as ResultEvent;
            var _allUsersForCompany:ArrayCollection;
            if (event.result)
                _allUsersForCompany = event.result as ArrayCollection;
            else
                _allUsersForCompany = new ArrayCollection();

            companyProxy.allUsersForCompany = _allUsersForCompany;

            sendNotification(ApplicationFacade.ALL_EMPLOYEES_SUCCESS);

            commandComplete();
        }

    }
}