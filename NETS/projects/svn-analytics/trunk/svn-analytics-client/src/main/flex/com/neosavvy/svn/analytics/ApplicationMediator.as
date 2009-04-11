package com.neosavvy.svn.analytics
{
	import com.neosavvy.svn.analytics.model.HistoricalTeamStatisticProxy;
	import com.neosavvy.svn.analytics.model.OverallTeamStatisticProxy;
	
	import mx.charts.LineChart;
	import mx.controls.AdvancedDataGrid;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class ApplicationMediator extends Mediator
	{
		public static var MEDIATOR_NAME:String = "ApplicationMediator";
		
		public function ApplicationMediator( viewComponent:Object )
		{
			super(MEDIATOR_NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.STARTUP
				,ApplicationFacade.LOADED_SUMMARY_STATS
				,ApplicationFacade.LOADED_HISTORICAL_STATS
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			
			switch ( notification.getName() ) {
				case ApplicationFacade.LOADED_SUMMARY_STATS:
					var summaryProxy:OverallTeamStatisticProxy = facade.retrieveProxy( OverallTeamStatisticProxy.NAME ) as OverallTeamStatisticProxy;
					summaryGrid.dataProvider = summaryProxy.overallTeamStats;
					break;
				case ApplicationFacade.LOADED_HISTORICAL_STATS:
					var historyProxy:HistoricalTeamStatisticProxy = facade.retrieveProxy( HistoricalTeamStatisticProxy.NAME ) as HistoricalTeamStatisticProxy;
					historicalStatisticsChart.dataProvider = historyProxy.historicalStats;
					break;
				default:
					break;
			}
			
		}
		
		protected function get application():SvnAnalyticsApplication {
			return viewComponent as SvnAnalyticsApplication;
		}
		
		protected function get summaryGrid():AdvancedDataGrid {
			
			var grid:AdvancedDataGrid = this.application.summaryStatisticsGrid;
			return grid;
			
		}
		
		protected function get historicalStatisticsChart():LineChart {
			var chart:LineChart = this.application.historicalStatisticsChart;
			return chart;
		}
		
		/**
		 * Event listeners for View spawned actions / user gestures go here
		 **/ 
		protected function refineSearch():void {
			//TODO: Execute refine search
		} 
		 
	}
}