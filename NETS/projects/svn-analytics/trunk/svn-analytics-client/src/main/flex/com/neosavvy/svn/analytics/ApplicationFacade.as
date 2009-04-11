package com.neosavvy.svn.analytics
{
	import com.neosavvy.svn.analytics.controller.startup.StartupCommand;
	
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade
	{
		public static const STARTUP:String  = "startup"; 
		
		public static const LOAD_SUMMARY_STATS:String = "loadSummaryStats";
		public static const LOADED_SUMMARY_STATS:String = "loadedSummaryStats";
		
		public static const LOAD_HISTORICAL_STATS:String = "loadedHistoricalStats";
		public static const LOADED_HISTORICAL_STATS:String = "loadedHistoricalStats";
		
		public static function getInstance():ApplicationFacade { 
			if( instance == null) {
				instance = new ApplicationFacade();
			}
			return instance as ApplicationFacade;
		}
		

		override protected function initializeController():void {
			super.initializeController();
			registerCommand( STARTUP, StartupCommand );
		}
		
		public function startup( app:SvnAnalyticsApplication ) : void  
		{  
			sendNotification( STARTUP, app ); 
		} 


	}
}