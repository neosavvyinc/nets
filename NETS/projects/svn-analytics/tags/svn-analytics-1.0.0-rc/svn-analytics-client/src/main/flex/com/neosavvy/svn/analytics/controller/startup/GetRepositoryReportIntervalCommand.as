package com.neosavvy.svn.analytics.controller.startup
{
	import com.neosavvy.svn.analytics.model.ReportIntervalProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class GetRepositoryReportIntervalCommand extends SimpleCommand
	{

		override public function execute( note:INotification ):void {

			var proxy:ReportIntervalProxy = facade.retrieveProxy( ReportIntervalProxy.NAME ) as ReportIntervalProxy;
			proxy.getReportInterval();

		}
		
	}
}