package com.neosavvy.svn.analytics.components.chart
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.components.chart.event.SelectChartTypeEvent;
	import com.neosavvy.svn.analytics.dto.HistoricalTeamStatistic;
	import com.neosavvy.svn.analytics.model.HistoricalTeamStatisticProxy;
	
	import flexlib.controls.HSlider;
	
	import mx.charts.ColumnChart;
	import mx.charts.LineChart;
	import mx.charts.effects.SeriesSlide;
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class ChartMediator extends Mediator
	{
		public static var MEDIATOR_NAME:String = "ChartMediator";
		
		public function ChartMediator( viewComponent:Object )
		{
			super(MEDIATOR_NAME, viewComponent);
			
			this.chartContainer.addEventListener(SelectChartTypeEvent.SELECT_CHART_TYPE, selectChartType);
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
					addEffect();
					columnChart.dataProvider = historyProxy.historicalStats;
					lineChart.dataProvider = historyProxy.historicalStats;
					initializeIncrementSelector(historyProxy.historicalStats);
					break;
				default:
					break;
			}
			
		}

		protected function addEffect():void {
			var slideUp:SeriesSlide = new SeriesSlide();
			slideUp.duration = 1000;
			slideUp.direction = "up";
			var slideDown:SeriesSlide = new SeriesSlide();
			slideDown.duration = 1000;
			slideDown.direction = "down";

			for each ( var colSer:Object in columnChart.series ) {
				colSer.setStyle("showDataEffect", slideUp);
				colSer.setStyle("hideDataEffect", slideDown);
			}

			for each ( var lineSer:Object in lineChart.series ) {
				lineSer.setStyle("showDataEffect", slideUp);
				lineSer.setStyle("hideDataEffect", slideDown);
			}
		}
		
		protected function initializeIncrementSelector(stats:Array):void {
			incrementSelector.minimum = 0;
			incrementSelector.maximum = stats.length;
			incrementSelector.snapInterval = 1;
			
			var labels:Array = new Array();
			var tickInt:Number = 5;
			var tickCount:Number = tickInt - 1;
			for each (var stat:HistoricalTeamStatistic in stats) {
				tickCount = tickCount+1;
				if( tickCount == tickInt) {
					labels.push( stat.revisionDate );
					tickCount = 0;
				}
			}
			labels.push(stat.revisionDate);
			incrementSelector.labels = labels;
			//incrementSelector.tickInterval = tickInt;
			incrementSelector.dataTipFormatFunction = showDateFunction;
			incrementSelector.allowThumbOverlap = true;
		}
		
		protected function showDateFunction( val:String ):String {
			 var stats:ArrayCollection = lineChart.dataProvider as ArrayCollection;
			var stat:HistoricalTeamStatistic
			if( Number(val) >= stats.length) {
			 stat = stats.getItemAt( stats.length - 1 ) as HistoricalTeamStatistic;	
			} else {
			 stat = stats.getItemAt( Number(val) ) as HistoricalTeamStatistic;
			}
			trace("stat"+ stat.revisionDate);
			trace("val:" + val);
			return stat.revisionDate; 
		}

		protected function get chartContainer():ChartContainer {
			return this.viewComponent as ChartContainer;
		}
		
		protected function get columnChart():ColumnChart {
			return chartContainer.statChartColumn;
		}
		
		protected function get lineChart():LineChart {
			return chartContainer.statChartLine;
		}
		
		protected function get incrementSelector():HSlider {
			return chartContainer.incrementSelector;
		}
		
		protected function selectChartType(event:SelectChartTypeEvent):void {
			
			this.lineChart.visible = false;
			this.columnChart.visible = false;
			
			switch ( event.chartType ) {
				case SelectChartTypeEvent.BAR_CHART:
					this.columnChart.visible = true;
					break;
				case SelectChartTypeEvent.LINE_CHART:
					this.lineChart.visible = true;
					break;
			}
			
		}

	}
}