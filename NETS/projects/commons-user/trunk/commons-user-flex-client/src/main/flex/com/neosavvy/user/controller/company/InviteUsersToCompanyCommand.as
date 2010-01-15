package com.neosavvy.user.controller.company {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.NeosavvyAsyncCommand;
    import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

    public class InviteUsersToCompanyCommand extends NeosavvyAsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.company.InviteUsersToCompanyCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var userInvite:UserInviteDTO = notification.getBody() as UserInviteDTO;
            companyServiceProxy.inviteUsers(userInvite, this);

        }

        public function fault(info:Object):void {
            var faultEvent:FaultEvent = info as FaultEvent;
            LOGGER.debug("User invites failed!");
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.INVITE_USER_TO_COMPANY_FAILED);
            commandComplete();

        }

        public function result(data:Object):void {
            LOGGER.debug("User invites successful");
            sendNotification(ApplicationFacade.INVITE_USER_TO_COMPANY_SUCCESS);
            commandComplete();

        }
    }
}