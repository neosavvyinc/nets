package com.neosavvy.user.controller.company {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.NeosavvyAsyncCommand;
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

    public class GetInvitedUsersForCompanyCommand extends NeosavvyAsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.company.GetInvitedUsersForCompanyCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            companyServiceProxy.getInvitedUsers(this);
        }

        public function fault(info:Object):void {
            var event:FaultEvent = info as FaultEvent;
            LOGGER.debug("Get Invited Users Failed");
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);
            sendNotification(ApplicationFacade.GET_INVITED_USERS_FAILED);
            commandComplete();
        }

        public function result(data:Object):void {
            LOGGER.debug("Get Invited Users Success");
            var event:ResultEvent = data as ResultEvent;
            var _invitedUsersForActiveCompany:ArrayCollection;
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;

            if (event.result != null)
                _invitedUsersForActiveCompany = event.result as ArrayCollection;
            else
                _invitedUsersForActiveCompany = new ArrayCollection();

            companyServiceProxy.invitedUsersForActiveCompany = _invitedUsersForActiveCompany;
            sendNotification(ApplicationFacade.GET_INVITED_USERS_SUCCESS);

            commandComplete();
        }
    }
}