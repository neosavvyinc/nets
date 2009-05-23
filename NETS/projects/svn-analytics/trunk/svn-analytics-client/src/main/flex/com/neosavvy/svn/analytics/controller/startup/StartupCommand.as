package com.neosavvy.svn.analytics.controller.startup
{
	import com.neosavvy.svn.analytics.controller.historical.GetHistoricalTeamStatsCommand;
	import com.neosavvy.svn.analytics.controller.summary.GetOverallTeamStatsCommand;
	import com.neosavvy.svn.analytics.controller.svnrepository.GetSvnRepositoriesCommand;
	
	import org.puremvc.as3.patterns.command.MacroCommand;

	public class StartupCommand extends MacroCommand 
	{ 
		override protected function initializeMacroCommand() : void 
		{ 
			addSubCommand( ModelPrepCommand ); 
			addSubCommand( ViewPrepCommand ); 
			
			addSubCommand( GetRepositoryReportIntervalCommand );
			addSubCommand( GetAuthorsCommand );
			addSubCommand( GetOverallTeamStatsCommand );
			addSubCommand( GetHistoricalTeamStatsCommand );
			addSubCommand( GetSvnRepositoriesCommand );
		} 
	} 
}