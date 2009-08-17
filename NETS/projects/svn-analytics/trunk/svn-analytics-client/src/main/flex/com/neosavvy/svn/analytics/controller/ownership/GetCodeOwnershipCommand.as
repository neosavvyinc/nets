package com.neosavvy.svn.analytics.controller.ownership
{
	import com.neosavvy.svn.analytics.dto.file.FileSystemNode;
	import com.neosavvy.svn.analytics.model.CodeOwnershipProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class GetCodeOwnershipCommand extends SimpleCommand
	{

		override public function execute( note:INotification ):void {

			var proxy:CodeOwnershipProxy = facade.retrieveProxy( CodeOwnershipProxy.NAME ) as CodeOwnershipProxy;
			var parent:FileSystemNode = note.getBody() as FileSystemNode;
			proxy.getCodeOwnership( parent );

		}
		
	}
}