package com.neosavvy.user.util {
    import mx.logging.ILogger;
    import mx.rpc.events.FaultEvent;

    public class RemoteObjectUtils {
        public static function logRemoteServiceFault(event:FaultEvent, LOGGER:ILogger):void {
            LOGGER.debug("Message: " + event.fault.message);
            LOGGER.debug("ErrorID: " + event.fault.errorID);
            LOGGER.debug("FaultCode: " + event.fault.faultCode);
            LOGGER.debug("FaultDetail: " + event.fault.faultDetail);
            LOGGER.debug("FaultString: " + event.fault.faultString);
        }
    }
}