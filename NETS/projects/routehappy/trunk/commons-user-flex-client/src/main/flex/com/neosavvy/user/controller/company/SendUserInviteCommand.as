package com.neosavvy.user.controller.company {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class SendUserInviteCommand extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.company.SendUserInviteCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var userInvite:UserInviteDTO = notification.getBody() as UserInviteDTO;
            companyServiceProxy.sendInvite(userInvite, this);

        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            LOGGER.debug("User invite success");
            sendNotification(ApplicationFacade.SEND_USER_INVITE_SUCCESS);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            LOGGER.debug("User invite failed" + faultEvent.toString());
            sendNotification(ApplicationFacade.SEND_USER_INVITE_FAILED);
        }
    }
}