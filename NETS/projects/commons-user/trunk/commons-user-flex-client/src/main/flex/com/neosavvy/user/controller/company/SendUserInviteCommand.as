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

    public class SendUserInviteCommand extends NeosavvyAsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.company.SendUserInviteCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var userInvite:UserInviteDTO = notification.getBody() as UserInviteDTO;
            companyServiceProxy.sendInvite(userInvite, this);

        }

        public function fault(info:Object):void {
            var event:FaultEvent = info as FaultEvent;
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);
            LOGGER.debug("User invite failed" + event.toString());
            sendNotification(ApplicationFacade.SEND_USER_INVITE_FAILED);
            commandComplete();
        }

        public function result(data:Object):void {
            LOGGER.debug("User invite success");
            sendNotification(ApplicationFacade.SEND_USER_INVITE_SUCCESS);
            commandComplete();
        }

    }
}