package com.neosavvy.svn.analytics.controller.svnrepository
{
	import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
	import com.neosavvy.svn.analytics.dto.file.FileSystemNode;
	import com.neosavvy.svn.analytics.model.SVNRepositoryProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class LoadFilesForRepositoryCommand extends SimpleCommand
	{
		override public function execute( note:INotification ):void {
			var repositoryProxy:SVNRepositoryProxy = facade.retrieveProxy( SVNRepositoryProxy.NAME ) as SVNRepositoryProxy;
			var body:Object = note.getBody();
			
			var parentRepository:SVNRepositoryDTO;
			var parentDirectory:FileSystemNode;
			if( body is Array && body != null && (body as Array).length == 2) {
				parentRepository = (body as Array)[0] as SVNRepositoryDTO;
				parentDirectory = (body as Array)[1] as FileSystemNode;
			}
			
			repositoryProxy.getFilesForRepository(parentRepository, parentDirectory);
		}
	}
}