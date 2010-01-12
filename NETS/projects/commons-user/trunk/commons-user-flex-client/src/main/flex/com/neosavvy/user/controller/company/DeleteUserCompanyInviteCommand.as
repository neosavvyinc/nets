package com.neosavvy.user.controller.company {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;

    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;

    import mx.rpc.events.FaultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

    public class DeleteUserCompanyInviteCommand extends AsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.company.DeleteUserCompanyInviteCommand");

        override public function execute(notification:INotification):void {
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var userInvite:UserInviteDTO = notification.getBody() as UserInviteDTO;
            companyServiceProxy.deleteUserCompanyInvite(userInvite, this);
        }

        public function fault(info:Object):void {
            var faultEvent:FaultEvent = info as FaultEvent;
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);

            sendNotification(ApplicationFacade.DELETE_USER_COMPANY_INVITE_FAILED);
            commandComplete();
        }

        public function result(data:Object):void {
            LOGGER.debug("User Invite Delete Succeeded");
            sendNotification(ApplicationFacade.DELETE_USER_COMPANY_INVITE_SUCCESS);
            commandComplete();
        }
    }
}