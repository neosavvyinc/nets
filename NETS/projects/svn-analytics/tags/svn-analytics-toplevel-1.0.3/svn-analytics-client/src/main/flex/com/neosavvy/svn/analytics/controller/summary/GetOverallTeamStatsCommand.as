package com.neosavvy.svn.analytics.controller.summary
{
	import com.neosavvy.svn.analytics.model.OverallTeamStatisticProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class GetOverallTeamStatsCommand extends SimpleCommand
	{

		override public function execute( note:INotification ):void {

			var overallStatsProxy:OverallTeamStatisticProxy = facade.retrieveProxy( OverallTeamStatisticProxy.NAME ) as OverallTeamStatisticProxy;
			overallStatsProxy.getOverallTeamStatistics();

		}
		
	}
}