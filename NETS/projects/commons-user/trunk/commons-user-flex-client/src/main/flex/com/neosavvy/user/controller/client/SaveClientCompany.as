package com.neosavvy.user.controller.client {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.NeosavvyAsyncCommand;
    import com.neosavvy.user.dto.project.ClientCompany;
    import com.neosavvy.user.dto.project.ClientUserContact;
    import com.neosavvy.user.model.ClientServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import flash.errors.IllegalOperationError;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

    public class SaveClientCompany extends NeosavvyAsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.client.SaveClientCompany");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var clientProxy:ClientServiceProxy = facade.retrieveProxy(ClientServiceProxy.NAME) as ClientServiceProxy;

            if (notification.getBody() is Array && (notification.getBody() as Array).length == 2) {

                var clientCompany:ClientCompany = notification.getBody()[0];
                var clientUserContact:ClientUserContact = notification.getBody()[1];

                clientProxy.saveClientCompany(clientCompany, clientUserContact, this);
            } else {
                throw new IllegalOperationError("Parameters passed to SaveClientCompany were incorrect");
            }
        }


        public function fault(info:Object):void {
            var event:FaultEvent = info as FaultEvent;
            RemoteObjectUtils.logRemoteServiceFault(event, LOGGER);

            sendNotification(ApplicationFacade.SAVE_CLIENT_COMPANY_FAILED);
            commandComplete();
        }

        public function result(data:Object):void {
            LOGGER.debug("Save Client For Company was successful");
            sendNotification(ApplicationFacade.SAVE_CLIENT_COMPANY_SUCCESS);
            commandComplete();
        }
    }
}