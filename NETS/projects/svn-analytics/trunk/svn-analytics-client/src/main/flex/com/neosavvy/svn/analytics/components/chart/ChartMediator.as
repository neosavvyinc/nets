package com.neosavvy.svn.analytics.components.chart
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.model.HistoricalTeamStatisticProxy;
	
	import mx.charts.AreaChart;
	import mx.charts.chartClasses.CartesianChart;
	import mx.collections.ArrayCollection;
	import mx.containers.DividedBox;
	import mx.controls.VRule;
	
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
					var data:Array = historyProxy.historicalStats;
					
					mainChart.dataProvider = new ArrayCollection(data);
					smallChart.dataProvider = new ArrayCollection(data);
					intervalChart.dataProvider = new ArrayCollection(data); 
					
					
					leftIndicator.x = data.length - 100;
					rightIndicator.x = data.length;

					chartContainer.setMainData( new ArrayCollection( data ) );
					chartContainer.setRangeData( new ArrayCollection( data ) );
					chartContainer.setRangeDataRatio(((dividedBox.width - 30) / chartContainer.getRangeData().length) ); 
					break;
				default:
					break;
			}
			
		}

		protected function get chartContainer():ChartContainer {
			return this.viewComponent as ChartContainer;
		}
		
		protected function get mainChart():AreaChart {
			return chartContainer.mainChart;
		}
		
		protected function get smallChart():CartesianChart {
			return chartContainer.smallChart;
		}
		
		protected function get intervalChart():AreaChart {
			return chartContainer.intervalChart;
		}
		
		protected function get leftIndicator():VRule {
			return chartContainer.leftIndicator;
		}
		
		protected function get rightIndicator():VRule {
			return chartContainer.rightIndicator;
		}
		
		protected function get dividedBox():DividedBox {
			return chartContainer.dividedBox;
		}
		

	}
}