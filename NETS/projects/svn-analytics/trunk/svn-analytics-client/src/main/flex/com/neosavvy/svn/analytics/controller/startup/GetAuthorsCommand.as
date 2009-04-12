package com.neosavvy.svn.analytics.controller.startup
{
	import com.neosavvy.svn.analytics.model.AuthorProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class GetAuthorsCommand extends SimpleCommand
	{

		override public function execute( note:INotification ):void {

			var proxy:AuthorProxy = facade.retrieveProxy( AuthorProxy.NAME ) as AuthorProxy;
			proxy.getAuthors();

		}
		
	}
}