package com.neosavvy.svn.analytics.components.chart
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.model.HistoricalTeamStatisticProxy;
	
	import mx.charts.ColumnChart;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class ChartMediator extends Mediator
	{
		public static var MEDIATOR_NAME:String = "ChartMediator";
		
		public function ChartMediator( viewComponent:Object )
		{
			super(MEDIATOR_NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.STARTUP
				,ApplicationFacade.LOADED_HISTORICAL_STATS
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			
			switch ( notification.getName() ) {
				case ApplicationFacade.LOADED_HISTORICAL_STATS:
					var historyProxy:HistoricalTeamStatisticProxy = facade.retrieveProxy( HistoricalTeamStatisticProxy.NAME ) as HistoricalTeamStatisticProxy;
					columnChart.dataProvider = historyProxy.historicalStats;
					break;
				default:
					break;
			}
			
		}

		protected function get chartContainer():ChartContainer {
			return this.viewComponent as ChartContainer;
		}
		
		protected function get columnChart():ColumnChart {
			return chartContainer.historicalStatisticsChart;
		}

	}
}