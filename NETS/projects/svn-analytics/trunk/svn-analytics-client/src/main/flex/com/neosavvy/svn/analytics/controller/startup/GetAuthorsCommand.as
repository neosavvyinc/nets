package com.neosavvy.svn.analytics.controller.startup
{
	import com.neosavvy.svn.analytics.model.SvnAnalyticsProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class GetAuthorsCommand extends SimpleCommand
	{

		override public function execute( note:INotification ):void {

			var proxy:SvnAnalyticsProxy = facade.retrieveProxy( SvnAnalyticsProxy.NAME ) as SvnAnalyticsProxy;
			proxy.getAuthors();

		}
		
	}
}