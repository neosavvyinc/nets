package com.neosavvy.svn.analytics.model
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.dto.SVNRepositoryInterval;
	
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class ReportIntervalProxy extends Proxy
	{
		public static var NAME:String = "reportIntervalProxy";
		
		private var svnAnalyticsService:RemoteObject;
		
		private var remote:Boolean = ProxyConstants.isRemoteEnabled;
		
		public function ReportIntervalProxy()
		{
			super(NAME, SVNRepositoryInterval);
			svnAnalyticsService = new RemoteObject();
			if(remote) {
				var channel:AMFChannel = new AMFChannel("svn-analytics-amf", ProxyConstants.url);
				var channelSet:ChannelSet = new ChannelSet();
				channelSet.addChannel(channel); 
				svnAnalyticsService.channelSet = channelSet;
			} 
            svnAnalyticsService.destination = "svnStatService";
            svnAnalyticsService.addEventListener(ResultEvent.RESULT, onReportIntervalResult );
            svnAnalyticsService.addEventListener(FaultEvent.FAULT, onReportIntervalFault );
		}
		
		public function getReportInterval():void {
			svnAnalyticsService.getRepositoryInterval();
		}
		
		public function onReportIntervalResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.LOADED_REPOSITORY_INTERVAL );
		}
		
		public function onReportIntervalFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
		}
		
		public function get reportInterval():SVNRepositoryInterval {
			return data as SVNRepositoryInterval
		}
		
	}
}