package com.neosavvy.svn.analytics.controller.startup
{
	import com.neosavvy.svn.analytics.controller.historical.GetHistoricalTeamStatsCommand;
	import com.neosavvy.svn.analytics.controller.ownership.GetCodeOwnershipCommand;
	import com.neosavvy.svn.analytics.controller.summary.GetOverallTeamStatsCommand;
	import com.neosavvy.svn.analytics.controller.svnrepository.GetSvnRepositoriesCommand;
	
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	import mx.logging.targets.TraceTarget;
	
	import org.puremvc.as3.patterns.command.MacroCommand;

	public class StartupCommand extends MacroCommand 
	{ 
		override protected function initializeMacroCommand() : void 
		{ 
			initLogging();
			
			addSubCommand( ModelPrepCommand ); 
			addSubCommand( ViewPrepCommand ); 
			
			addSubCommand( GetRepositoryReportIntervalCommand );
			addSubCommand( GetAuthorsCommand );
			addSubCommand( GetOverallTeamStatsCommand );
			addSubCommand( GetHistoricalTeamStatsCommand );
			addSubCommand( GetSvnRepositoriesCommand );
			
			addSubCommand( GetCodeOwnershipCommand );
		} 
		
		private function initLogging():void {
            // Create a target.
            var logTarget:TraceTarget = new TraceTarget();

            // Log only messages for the classes in the mx.rpc.* and 
            // mx.messaging packages.
            logTarget.filters=["mx.rpc.*","mx.messaging.*", "mx.*", "flash.*"];

            // Log all log levels.
            logTarget.level = LogEventLevel.ALL;

            // Add date, time, category, and log level to the output.
            logTarget.includeDate = true;
            logTarget.includeTime = true;
            logTarget.includeCategory = true;
            logTarget.includeLevel = true;

            // Begin logging.
            Log.addTarget(logTarget);
        }
	} 
}