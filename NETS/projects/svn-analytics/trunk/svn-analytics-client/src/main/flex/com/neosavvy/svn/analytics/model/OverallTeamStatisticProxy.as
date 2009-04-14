package com.neosavvy.svn.analytics.model
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.dto.request.RefineSearchRequest;
	
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class OverallTeamStatisticProxy extends Proxy
	{
		public static var NAME:String = "svnSummaryProxy";
		
		private var svnAnalyticsService:RemoteObject;
		
		public function OverallTeamStatisticProxy()
		{
			super(NAME, new Array());
			svnAnalyticsService = new RemoteObject();
			var channel:AMFChannel = new AMFChannel("svn-analytics-amf", "http://sv-scratchy.roundarch.com:9080/svn-analytics/messagebroker/amf");
			var channelSet:ChannelSet = new ChannelSet();
			channelSet.addChannel(channel); 
			svnAnalyticsService.channelSet = channelSet; 
            svnAnalyticsService.destination = "svnStatService";
            svnAnalyticsService.addEventListener(ResultEvent.RESULT, onTeamStatisticResult );
            svnAnalyticsService.addEventListener(FaultEvent.FAULT, onTeamStatisticFault );
		}
		
		public function getOverallTeamStatistics():void {
			
			svnAnalyticsService.getOverallTeamStatistics();
			
		}
		
		public function getRefinedTeamStatistics(refineRequest:RefineSearchRequest):void {
			svnAnalyticsService.getRefinedTeamStatistics(refineRequest);
		}    
		
		public function onTeamStatisticResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.LOADED_SUMMARY_STATS );
		}
		
		public function onTeamStatisticFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
		}
		
		public function get overallTeamStats():Array {
			return data as Array;
		}
		
	}
}