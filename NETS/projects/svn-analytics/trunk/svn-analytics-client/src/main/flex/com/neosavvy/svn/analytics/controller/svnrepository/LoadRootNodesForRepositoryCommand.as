package com.neosavvy.svn.analytics.controller.svnrepository
{
	import org.puremvc.as3.patterns.command.MacroCommand;

	public class LoadRootNodesForRepositoryCommand extends MacroCommand
	{

		override protected function initializeMacroCommand() : void 
		{ 
			addSubCommand( LoadDirectoriesForRepositoryCommand ); 
			/* addSubCommand( LoadFilesForRepositoryCommand ); */
		} 
		
	}
}