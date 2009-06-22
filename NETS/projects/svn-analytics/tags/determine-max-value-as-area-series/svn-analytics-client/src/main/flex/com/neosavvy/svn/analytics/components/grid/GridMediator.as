package com.neosavvy.svn.analytics.components.grid
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.model.OverallTeamStatisticProxy;
	
	import mx.controls.AdvancedDataGrid;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class GridMediator extends Mediator
	{
		public static var MEDIATOR_NAME:String = "GridMediator";
		
		public function GridMediator( viewComponent:Object )
		{
			super(MEDIATOR_NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.LOADED_SUMMARY_STATS
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			
			switch ( notification.getName() ) {
				case ApplicationFacade.LOADED_SUMMARY_STATS:
					var summaryProxy:OverallTeamStatisticProxy = facade.retrieveProxy( OverallTeamStatisticProxy.NAME ) as OverallTeamStatisticProxy;
					grid.dataProvider = summaryProxy.overallTeamStats;
					break;
				default:
					break;
			}
			
		}
		
		protected function get gridContainer():GridContainer {
			return this.viewComponent as GridContainer;
		}
		
		protected function get grid():AdvancedDataGrid {
			return this.gridContainer.summaryStatisticsGrid;
		}
	}
}