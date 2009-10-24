package com.neosavvy.svn.analytics.controller.historical
{
	import com.neosavvy.svn.analytics.dto.request.RefineSearchRequest;
	import com.neosavvy.svn.analytics.model.HistoricalTeamStatisticProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class GetRefinedHistoricalTeamStatsCommand extends SimpleCommand
	{

		override public function execute( note:INotification ):void {

			var proxy:HistoricalTeamStatisticProxy = facade.retrieveProxy( HistoricalTeamStatisticProxy.NAME ) as HistoricalTeamStatisticProxy;
			proxy.getRefinedHistoricalTeamStatistics(note.getBody() as RefineSearchRequest);

		}
		
	}
}