package com.neosavvy.svn.analytics.components.chart.event
{
	import flash.events.Event;

	public class SelectChartTypeEvent extends Event
	{
		public static var SELECT_CHART_TYPE:String = "selectChartTypeEvent";
		
		public static var LINE_CHART:String = "lineChart";
		public static var BAR_CHART:String = "barChart";
		
		private var _chartType:String;
		
		public function SelectChartTypeEvent(chartType:String)
		{
			super(SELECT_CHART_TYPE, true, true);
			_chartType = chartType;
		}
		
		public function get chartType():String {
			return _chartType;
		}
		
	}
}