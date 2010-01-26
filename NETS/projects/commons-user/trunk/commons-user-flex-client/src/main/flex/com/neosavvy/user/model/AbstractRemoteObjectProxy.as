package com.neosavvy.user.model {
    import com.neosavvy.user.ProxyConstants;

    import flash.errors.IllegalOperationError;

    import flash.external.ExternalInterface;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.messaging.ChannelSet;
    import mx.messaging.channels.AMFChannel;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.mxml.RemoteObject;

    import org.puremvc.as3.multicore.patterns.proxy.Proxy;

    public class AbstractRemoteObjectProxy extends Proxy {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.model.AbstractRemoteObjectProxy");

        public function AbstractRemoteObjectProxy(proxyName:String = null, data:Object = null)
        {
            super(proxyName, null);
        }

        protected function getServiceChannelSet():ChannelSet {
            var channel:AMFChannel = new AMFChannel(ProxyConstants.channelName, ProxyConstants.url);
            var channelSet:ChannelSet = new ChannelSet();
            var swfLocation:String = ExternalInterface.call("function(){ return document.location.toString();}");
			if (swfLocation.indexOf("http:") >= 0 || swfLocation.indexOf("https") >= 0)
			{
                channel.url = swfLocation.substr(0, swfLocation.lastIndexOf("/")) + "/messagebroker/amf";

			}
            LOGGER.debug("Connecting to AMF over the following URL " + channel.url);
            channelSet.addChannel(channel);
            return channelSet;
        }

        protected function getService(destinationName:String):RemoteObject {
            var userService:RemoteObject = new RemoteObject();
            userService.channelSet = getServiceChannelSet();
            userService.destination = destinationName;
            return userService;
        }

        protected function addCallbackHandler(service:RemoteObject, responder:IResponder):void {
            service.addEventListener(ResultEvent.RESULT, responder.result);
            service.addEventListener(FaultEvent.FAULT, responder.fault);
        }

        public function clearCachedValues():void {
            throw new IllegalOperationError("Must implement AbstractRemoteObjectProxy::clearCachedValues() to ensure data is properly removed when logging out"); 
        }
    }
}
