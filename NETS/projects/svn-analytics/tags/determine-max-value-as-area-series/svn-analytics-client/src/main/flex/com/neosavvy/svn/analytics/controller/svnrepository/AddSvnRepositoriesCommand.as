package com.neosavvy.svn.analytics.controller.svnrepository
{
	import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
	import com.neosavvy.svn.analytics.model.SVNRepositoryProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class AddSvnRepositoriesCommand extends SimpleCommand
	{

		override public function execute( note:INotification ):void {

			var repositoryProxy:SVNRepositoryProxy = facade.retrieveProxy( SVNRepositoryProxy.NAME ) as SVNRepositoryProxy;
			repositoryProxy.saveRepository( note.getBody() as SVNRepositoryDTO );

		}
		
	}
}