package com.neosavvy.svn.analytics.model
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.dto.file.FileSystemNode;
	import com.neosavvy.svn.analytics.dto.request.CodeOwnershipRefineRequest;
	
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class CodeOwnershipProxy extends Proxy
	{
		public static var NAME:String = "codeOwnershipProxy";
		
		private var svnAnalyticsService:RemoteObject;
		
		private var remote:Boolean = ProxyConstants.isRemoteEnabled;
		
		public function CodeOwnershipProxy()
		{
			super(NAME, new Array());
			svnAnalyticsService = new RemoteObject();
			if(remote) {
				var channel:AMFChannel = new AMFChannel("svn-analytics-amf", ProxyConstants.url);
				var channelSet:ChannelSet = new ChannelSet();
				channelSet.addChannel(channel);
				svnAnalyticsService.channelSet = channelSet; 
			}
            svnAnalyticsService.destination = "svnStatService";
            svnAnalyticsService.addEventListener(ResultEvent.RESULT, onOwnershipResult );
            svnAnalyticsService.addEventListener(FaultEvent.FAULT, onOwnershipFault );
		}
		
		public function getCodeOwnership( refineRequest:CodeOwnershipRefineRequest ):void {
			
			if( refineRequest == null ) {
				refineRequest = new CodeOwnershipRefineRequest();
			}
			
			if( refineRequest.parentNode == null) {
				refineRequest.parentNode = new FileSystemNode();
			}
			
			if( refineRequest.parentNode.relativePath == null || refineRequest.parentNode.relativePath == "" ) {
				refineRequest.parentNode.relativePath = "/";
			}
			
			svnAnalyticsService.getOwnership( refineRequest );
			sendNotification( ApplicationFacade.LOAD_FILE_OWNERSHIP_FOR_PARENT );
		}
		
		public function onOwnershipResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.LOADED_FILE_OWNERSHIP_FOR_PARENT );
		}
		
		public function onOwnershipFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
		}
		
		public function get codeOwnership():Array {
			return data as Array;
		}
		
	}
}