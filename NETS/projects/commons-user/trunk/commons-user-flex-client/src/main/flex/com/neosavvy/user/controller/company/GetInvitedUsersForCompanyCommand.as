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
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

    public class GetInvitedUsersForCompanyCommand extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.company.GetInvitedUsersForCompanyCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            companyServiceProxy.getInvitedUsers(this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            LOGGER.debug("Get Invited Users Success");
            var _invitedUsersForActiveCompany:ArrayCollection;
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;

            if (resultEvent.result != null)
                _invitedUsersForActiveCompany = resultEvent.result as ArrayCollection;
            else
                _invitedUsersForActiveCompany = new ArrayCollection();

            companyServiceProxy.invitedUsersForActiveCompany = _invitedUsersForActiveCompany;
            sendNotification(ApplicationFacade.GET_INVITED_USERS_SUCCESS);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            LOGGER.debug("Get Invited Users Failed");
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.GET_INVITED_USERS_FAILED);
        }
    }
}