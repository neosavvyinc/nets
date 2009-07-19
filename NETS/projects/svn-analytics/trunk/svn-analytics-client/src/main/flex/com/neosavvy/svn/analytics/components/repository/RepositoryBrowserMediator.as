package com.neosavvy.svn.analytics.components.repository
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.model.SVNRepositoryProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class RepositoryBrowserMediator extends Mediator
	{
		public static var MEDIATOR_NAME:String = "RepositoryMediator";
		
		public function RepositoryBrowserMediator( viewComponent:Object )
		{
			super(MEDIATOR_NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.STARTUP
				,ApplicationFacade.LOADED_REPOSITORIES
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			
			switch ( notification.getName() ) {
				case ApplicationFacade.LOADED_REPOSITORIES:
					var svnRepositoryProxy:SVNRepositoryProxy = facade.retrieveProxy( SVNRepositoryProxy.NAME ) as SVNRepositoryProxy;
					repositoryBrowser.dataProvider = svnRepositoryProxy.repositories;
					break;
				default:
					break;
			}
			
		}

		protected function get repositoryBrowser():RepositoryBrowser {
			return this.viewComponent as RepositoryBrowser;
		}

	}
}