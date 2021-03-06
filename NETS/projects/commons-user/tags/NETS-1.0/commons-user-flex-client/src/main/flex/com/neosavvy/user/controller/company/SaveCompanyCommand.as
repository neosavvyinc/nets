package com.neosavvy.user.controller.company {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class SaveCompanyCommand extends ResponderAsyncCommand implements IResponder {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.company.SaveCompanyCommand");

        override public function execute(notification:INotification):void {
            var companyServiceProxy:CompanyServiceProxy = facade.retrieveProxy(CompanyServiceProxy.NAME) as CompanyServiceProxy;
            var params:Array = notification.getBody() as Array;
            companyServiceProxy.addCompany(params[0] as CompanyDTO, params[1] as UserDTO, this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            LOGGER.debug("Company was returned");
            sendNotification(ApplicationFacade.SAVE_COMPANY_SUCCESS);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {

            var faultString : String = faultEvent.fault.faultString;
            if( faultString.indexOf("javax.persistence.PersistenceException") > -1 &&
                faultString.indexOf("duplicate key value violates unique constraint") > -1 )
            {
                sendNotification(ApplicationFacade.SAVE_COMPANY_FAILED_DUPLICATE_USER);
            }
            else
            {
                sendNotification(ApplicationFacade.DISPLAY_ERROR, faultEvent.message);
                sendNotification(ApplicationFacade.SAVE_COMPANY_FAILED);
            }
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
        }
    }
}