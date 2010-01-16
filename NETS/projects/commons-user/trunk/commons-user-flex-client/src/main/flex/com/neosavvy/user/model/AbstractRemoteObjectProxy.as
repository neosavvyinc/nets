package com.neosavvy.user.model {
    import com.neosavvy.user.ProxyConstants;

    import flash.errors.IllegalOperationError;

    import mx.messaging.ChannelSet;
    import mx.messaging.channels.AMFChannel;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.mxml.RemoteObject;

    import org.puremvc.as3.multicore.patterns.proxy.Proxy;

    public class AbstractRemoteObjectProxy extends Proxy {

        public function AbstractRemoteObjectProxy(proxyName:String = null, data:Object = null)
        {
            super(proxyName, null);
        }

        protected function getServiceChannelSet():ChannelSet {
            var channel:AMFChannel = new AMFChannel(ProxyConstants.channelName, ProxyConstants.url);
            var channelSet:ChannelSet = new ChannelSet();
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
