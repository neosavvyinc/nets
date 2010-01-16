package com.neosavvy.user.controller.user {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.NeosavvyAsyncCommand;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

    public class SaveEmployeeToCompanyCommand extends NeosavvyAsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.user.SaveEmployeeToCompanyCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var user:UserDTO = notification.getBody() as UserDTO;
            companyServiceProxy.addEmployeeToCompany(user, this);
        }

        public function fault(info:Object):void {
            RemoteObjectUtils.logRemoteServiceFault(info as FaultEvent, LOGGER);
            var faultEvent:FaultEvent = info as FaultEvent;
            commandComplete()
            var faultString:String = faultEvent.fault.faultString;
            var faultParts:Array = faultString.split(":");
            sendNotification(ApplicationFacade.SAVE_USER_TO_COMPANY_FAILED, faultParts[1]);
        }

        public function result(data:Object):void {
            commandComplete()
            var message:String = "Confirmation Success! Thanks for registering, please login to continue."
            sendNotification(ApplicationFacade.SAVE_USER_TO_COMPANY_SUCCESS, message);
        }
    }
}