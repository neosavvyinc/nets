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

    public class GetAllUsersForCompany extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.company.GetAllUsersForCompany");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var companyProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var company:CompanyDTO = notification.getBody() as CompanyDTO;
            companyProxy.findUsersForCompany(company, this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var companyProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var _allUsersForCompany:ArrayCollection;
            if (resultEvent.result)
                _allUsersForCompany = resultEvent.result as ArrayCollection;
            else
                _allUsersForCompany = new ArrayCollection();

            companyProxy.allUsersForCompany = _allUsersForCompany;

            sendNotification(ApplicationFacade.ALL_EMPLOYEES_SUCCESS);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            LOGGER.debug("Unable to find all users: " + faultEvent.toString());
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);

            sendNotification(ApplicationFacade.ALL_EMPLOYEES_FAILED);
        }
    }
}