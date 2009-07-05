package com.neosavvy.svn.analytics.controller.startup
{
	import com.neosavvy.svn.analytics.ApplicationMediator;
	import com.neosavvy.svn.analytics.SvnAnalyticsApplication;
	import com.neosavvy.svn.analytics.components.chart.ChartMediator;
	import com.neosavvy.svn.analytics.components.grid.GridMediator;
	import com.neosavvy.svn.analytics.components.popup.PopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class ViewPrepCommand extends SimpleCommand
	{

		override public function execute( note:INotification ):void {
			//register all mediators
			var application:SvnAnalyticsApplication = note.getBody() as SvnAnalyticsApplication;
			facade.registerMediator( new ApplicationMediator( application ) );
			facade.registerMediator( new PopupMediator( application ) );
			facade.registerMediator( new ChartMediator( application.chartContainer ) );
			 facade.registerMediator( new GridMediator( application.gridContainer ) ); 
		}
		
	}
}