package com.neosavvy.user.controller.user {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class SaveEmployeeToCompanyCommand extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.user.SaveEmployeeToCompanyCommand");

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var user:UserDTO = notification.getBody() as UserDTO;
            companyServiceProxy.addEmployeeToCompany(user, this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var message:String = "Confirmation Success! Thanks for registering, please login to continue."
            sendNotification(ApplicationFacade.SAVE_USER_TO_COMPANY_SUCCESS, message);
        }

        override protected function faultHandler(faultEvent:FaultEvent):void {

            var faultString : String = faultEvent.fault.faultString;
            if( faultString.indexOf("javax.persistence.PersistenceException") > -1 &&
                faultString.indexOf("duplicate key value violates unique constraint") > -1 )
            {
                sendNotification(ApplicationFacade.SAVE_USER_TO_COMPANY_FAILED_DUPLICATE);
            }
            else
            {
                var faultParts:Array = faultString.split(":");
                sendNotification(ApplicationFacade.SAVE_USER_TO_COMPANY_FAILED, faultParts[1]);
            }

            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
                        
        }
    }
}