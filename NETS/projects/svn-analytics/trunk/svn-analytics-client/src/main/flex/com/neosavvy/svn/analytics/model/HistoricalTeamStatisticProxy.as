package com.neosavvy.svn.analytics.model
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	
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
            svnAnalyticsService.destination = "svnStatService";
            svnAnalyticsService.addEventListener(ResultEvent.RESULT, onHistoricalStatResult );
            svnAnalyticsService.addEventListener(FaultEvent.FAULT, onHistoricalStatFault );
		}
		
		public function getHistoricalTeamStatistics():void {
			
			svnAnalyticsService.getHistoricalTeamStatistics();
			
		}
		
		public function onHistoricalStatResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.LOADED_HISTORICAL_STATS );
		}
		
		public function onHistoricalStatFault( fault:Object ):void {
			
			trace("FAULT");
		}
		
		public function get historicalStats():Array {
			return data as Array;
		}
		
	}
}