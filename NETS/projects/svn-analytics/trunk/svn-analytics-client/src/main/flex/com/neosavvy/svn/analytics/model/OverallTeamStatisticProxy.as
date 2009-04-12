package com.neosavvy.svn.analytics.model
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	
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
            svnAnalyticsService.destination = "svnStatService";
            svnAnalyticsService.addEventListener(ResultEvent.RESULT, onTeamStatisticResult );
            svnAnalyticsService.addEventListener(FaultEvent.FAULT, onTeamStatisticFault );
		}
		
		public function getOverallTeamStatistics():void {
			
			svnAnalyticsService.getOverallTeamStatistics();
			
		}
		
		public function onTeamStatisticResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.LOADED_SUMMARY_STATS );
		}
		
		public function onTeamStatisticFault( fault:Object ):void {
			
			trace("FAULT");
		}
		
		public function get overallTeamStats():Array {
			return data as Array;
		}
		
	}
}