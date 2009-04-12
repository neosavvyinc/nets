package com.neosavvy.svn.analytics.model
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class AuthorProxy extends Proxy
	{
		public static var NAME:String = "authorProxy";
		
		private var svnAnalyticsService:RemoteObject;
		
		public function AuthorProxy()
		{
			super(NAME, new Array());
			svnAnalyticsService = new RemoteObject();
            svnAnalyticsService.destination = "svnStatService";
            svnAnalyticsService.addEventListener(ResultEvent.RESULT, onAuthorsResult );
            svnAnalyticsService.addEventListener(FaultEvent.FAULT, onAuthorsFault );
		}
		
		public function getAuthors():void {
			svnAnalyticsService.getAuthors();
		}
		
		public function onAuthorsResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.LOADED_AUTHORS );
		}
		
		public function onAuthorsFault( fault:Object ):void {
			trace("FAULT");
		}
		
		public function get authors():Array {
			return data as Array;
		}
		
	}
}