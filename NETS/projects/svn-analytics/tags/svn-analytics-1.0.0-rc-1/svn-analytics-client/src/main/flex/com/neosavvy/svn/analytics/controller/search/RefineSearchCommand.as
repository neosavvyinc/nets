package com.neosavvy.svn.analytics.controller.search
{
	import com.neosavvy.svn.analytics.controller.historical.GetRefinedHistoricalTeamStatsCommand;
	import com.neosavvy.svn.analytics.controller.summary.GetRefinedOverallTeamStatsCommand;
	
	import org.puremvc.as3.patterns.command.MacroCommand;

	public class RefineSearchCommand extends MacroCommand 
	{ 
		override protected function initializeMacroCommand() : void 
		{ 
			addSubCommand( GetRefinedHistoricalTeamStatsCommand );
			addSubCommand( GetRefinedOverallTeamStatsCommand );
		} 
	} 
}