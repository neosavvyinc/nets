package com.neosavvy.user.controller.company {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;

    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

    public class DeleteUserCompanyInviteCommand extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.company.DeleteUserCompanyInviteCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var userInvite:UserInviteDTO = notification.getBody() as UserInviteDTO;
            companyServiceProxy.deleteUserCompanyInvite(userInvite, this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            LOGGER.debug("User Invite Delete Succeeded");
            sendNotification(ApplicationFacade.DELETE_USER_COMPANY_INVITE_SUCCESS);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            var faultEvent:FaultEvent = faultEvent as FaultEvent;
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.DELETE_USER_COMPANY_INVITE_FAILED);
        }
    }
}