package com.neosavvy.svn.analytics.components.ownership
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.components.ownership.OwnershipChartContainer;
	import com.neosavvy.svn.analytics.model.CodeOwnershipProxy;
	
	import mx.charts.PieChart;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class OwnershipChartMediator extends Mediator
	{
		public static var MEDIATOR_NAME:String = "OwnershipChartMediator";
		
		public function OwnershipChartMediator( viewComponent:Object )
		{
			super(MEDIATOR_NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.STARTUP
				,ApplicationFacade.LOADED_FILE_OWNERSHIP_FOR_PARENT
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			
			switch ( notification.getName() ) {
				case ApplicationFacade.LOADED_FILE_OWNERSHIP_FOR_PARENT:
					var proxy:CodeOwnershipProxy = facade.retrieveProxy( CodeOwnershipProxy.NAME ) as CodeOwnershipProxy;
					var data:Array = proxy.codeOwnership;
					ownershipChart.dataProvider = data;
					break;
				default:
					break;
			}
			
		}

		protected function get chartContainer():OwnershipChartContainer {
			return this.viewComponent as OwnershipChartContainer;
		}
		
		protected function get ownershipChart():PieChart {
			return chartContainer.codeOwnershipChart;
		}
	}
}