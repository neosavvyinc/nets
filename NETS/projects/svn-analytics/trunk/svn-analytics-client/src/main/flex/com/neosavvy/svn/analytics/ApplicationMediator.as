package com.neosavvy.svn.analytics
{
	import com.neosavvy.svn.analytics.model.AuthorProxy;
	import com.neosavvy.svn.analytics.model.HistoricalTeamStatisticProxy;
	import com.neosavvy.svn.analytics.model.OverallTeamStatisticProxy;
	import com.neosavvy.svn.analytics.model.ReportIntervalProxy;
	
	import mx.charts.LineChart;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.ComboBox;
	import mx.controls.DateField;
	
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
				,ApplicationFacade.LOADED_AUTHORS
				,ApplicationFacade.LOADED_REPOSITORY_INTERVAL
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
				case ApplicationFacade.LOADED_AUTHORS:
					var svnAnalyticsProxy:AuthorProxy = facade.retrieveProxy( AuthorProxy.NAME ) as AuthorProxy;
					authorsSelector.dataProvider = svnAnalyticsProxy.authors;
					break;
				case ApplicationFacade.LOADED_REPOSITORY_INTERVAL:
					var svnRepositoryIntervalProxy:ReportIntervalProxy = facade.retrieveProxy( ReportIntervalProxy.NAME ) as ReportIntervalProxy;
				
					var startDateFromService:Date = svnRepositoryIntervalProxy.reportInterval.startDayLevelDate;
	            	var endDateFromService:Date = svnRepositoryIntervalProxy.reportInterval.endDayLevelDate;
	            	
	            	startDate.selectedDate = startDateFromService;
	            	startDate.selectableRange = {rangeStart: startDateFromService, rangeEnd: endDateFromService};
	
	            	endDate.selectedDate = endDateFromService
	            	startDate.selectableRange = {rangeStart: startDateFromService, rangeEnd: endDateFromService};
					break;
				default:
					break;
			}
			
		}
		
		protected function get application():SvnAnalyticsApplication {
			return viewComponent as SvnAnalyticsApplication;
		}
		
		protected function get summaryGrid():AdvancedDataGrid {
			return this.application.summaryStatisticsGrid;
		}
		
		protected function get historicalStatisticsChart():LineChart {
			return this.application.historicalStatisticsChart;
		}
		
		protected function get authorsSelector():ComboBox {
			return this.application.authorsSelector;
		}
		
		protected function get startDate():DateField {
			return this.application.startDate;
		}
		
		protected function get endDate():DateField {
			return this.application.endDate;
		}
		
		/**
		 * Event listeners for View spawned actions / user gestures go here
		 **/ 
		protected function refineSearch():void {
			//TODO: Execute refine search
		} 
		 
	}
}