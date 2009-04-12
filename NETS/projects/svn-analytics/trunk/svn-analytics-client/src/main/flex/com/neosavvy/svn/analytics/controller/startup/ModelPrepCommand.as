package com.neosavvy.svn.analytics.controller.startup
{
	import com.neosavvy.svn.analytics.model.HistoricalTeamStatisticProxy;
	import com.neosavvy.svn.analytics.model.OverallTeamStatisticProxy;
	import com.neosavvy.svn.analytics.model.SvnAnalyticsProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class ModelPrepCommand extends SimpleCommand
	{

		override public function execute( note:INotification ):void {
			//register all proxies here
			facade.registerProxy( new SvnAnalyticsProxy() );
			facade.registerProxy( new OverallTeamStatisticProxy() );
			facade.registerProxy( new HistoricalTeamStatisticProxy() );
		}
		
	}
}