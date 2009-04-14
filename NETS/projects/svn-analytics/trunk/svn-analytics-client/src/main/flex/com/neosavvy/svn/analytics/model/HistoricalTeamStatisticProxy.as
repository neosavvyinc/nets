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

	public class HistoricalTeamStatisticProxy extends Proxy
	{
		public static var NAME:String = "svnHistoricalProxy";
		
		private var svnAnalyticsService:RemoteObject;
		
		public function HistoricalTeamStatisticProxy()
		{
			super(NAME, new Array());
			svnAnalyticsService = new RemoteObject();
			var channel:AMFChannel = new AMFChannel("svn-analytics-amf", "http://sv-scratchy.roundarch.com:9080/svn-analytics/messagebroker/amf");
			var channelSet:ChannelSet = new ChannelSet();
			channelSet.addChannel(channel); 
			svnAnalyticsService.channelSet = channelSet; 
            svnAnalyticsService.destination = "svnStatService";
            svnAnalyticsService.addEventListener(ResultEvent.RESULT, onHistoricalStatResult );
            svnAnalyticsService.addEventListener(FaultEvent.FAULT, onHistoricalStatFault );
		}
		
		public function getHistoricalTeamStatistics():void {
			
			svnAnalyticsService.getHistoricalTeamStatistics();
			
		}
		
		public function getRefinedHistoricalTeamStatistics(refineRequest:RefineSearchRequest):void {
			
			svnAnalyticsService.getRefinedHistoricalTeamStatistics(refineRequest);
			
		}
		
		public function onHistoricalStatResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.LOADED_HISTORICAL_STATS );
		}
		
		public function onHistoricalStatFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
		}
		
		public function get historicalStats():Array {
			return data as Array;
		}
		
	}
}