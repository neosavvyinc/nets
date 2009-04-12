package com.neosavvy.svn.analytics.model
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.dto.SVNRepositoryInterval;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class ReportIntervalProxy extends Proxy
	{
		public static var NAME:String = "reportIntervalProxy";
		
		private var svnAnalyticsService:RemoteObject;
		
		public function ReportIntervalProxy()
		{
			super(NAME, SVNRepositoryInterval);
			svnAnalyticsService = new RemoteObject();
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
		
		public function onReportIntervalFault( fault:Object ):void {
			trace("FAULT");
		}
		
		public function get reportInterval():SVNRepositoryInterval {
			return data as SVNRepositoryInterval
		}
		
	}
}