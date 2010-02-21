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

    public class InviteUsersToCompanyCommand extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.company.InviteUsersToCompanyCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            sendNotification(ApplicationFacade.SHOW_PROGRESS_INDICATOR);
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var userInvite:UserInviteDTO = notification.getBody() as UserInviteDTO;
            companyServiceProxy.inviteUsers(userInvite, this);

        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            LOGGER.debug("User invites successful");
            sendNotification(ApplicationFacade.INVITE_USER_TO_COMPANY_SUCCESS);
            sendNotification(ApplicationFacade.HIDE_PROGRESS_INDICATOR);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            LOGGER.debug("User invites failed!");
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.INVITE_USER_TO_COMPANY_FAILED);
            sendNotification(ApplicationFacade.HIDE_PROGRESS_INDICATOR);
        }
    }
}