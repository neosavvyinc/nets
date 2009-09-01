package com.neosavvy.svn.analytics.controller.search
{
	import com.neosavvy.svn.analytics.controller.historical.GetHistoricalTeamStatsCommand;
	import com.neosavvy.svn.analytics.controller.summary.GetOverallTeamStatsCommand;
	
	import org.puremvc.as3.patterns.command.MacroCommand;

	public class ResetSearchCommand extends MacroCommand 
	{ 
		override protected function initializeMacroCommand() : void 
		{ 
			addSubCommand( GetHistoricalTeamStatsCommand );
			addSubCommand( GetOverallTeamStatsCommand );
		} 
	} 
}