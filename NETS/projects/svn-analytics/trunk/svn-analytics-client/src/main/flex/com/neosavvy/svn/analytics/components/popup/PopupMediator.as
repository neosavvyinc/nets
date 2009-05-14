package com.neosavvy.svn.analytics.components.popup
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.SvnAnalyticsApplication;
	import com.neosavvy.svn.analytics.components.popup.repositories.RepositoryManagementDialog;
	import com.neosavvy.svn.analytics.components.popup.repositories.event.RepositoryEvent;
	import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
	import com.neosavvy.svn.analytics.model.SVNRepositoryProxy;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.core.IFlexDisplayObject;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class PopupMediator extends Mediator
	{
		public static var MEDIATOR_NAME:String = "PopupMediator";
		
		private var repositoryPopup:IFlexDisplayObject;
		
		public function PopupMediator( viewComponent:Object )
		{
			super(MEDIATOR_NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.DISPLAY_MANAGE_REPOSITORIES_DIALOG
				,ApplicationFacade.LOADED_REPOSITORIES
				,ApplicationFacade.REPOSITORY_DELETED
				,ApplicationFacade.REPOSITORY_ADDED
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			
			switch ( notification.getName() ) {
				case ApplicationFacade.REPOSITORY_DELETED:
				case ApplicationFacade.REPOSITORY_ADDED:
				case ApplicationFacade.DISPLAY_MANAGE_REPOSITORIES_DIALOG:
					sendNotification( ApplicationFacade.LOAD_REPOSITORIES );
					break; 
				case ApplicationFacade.LOADED_REPOSITORIES:
					var repositoryProxy:SVNRepositoryProxy = facade.retrieveProxy( SVNRepositoryProxy.NAME ) as SVNRepositoryProxy;
					
					if( !repositoryPopup ) { 
						repositoryPopup = PopUpManager.createPopUp( viewComponent as DisplayObject, RepositoryManagementDialog, true);
						repositoryPopup.addEventListener(RepositoryEvent.REP_EVENT_TYPE_ADD, addRepository);
						repositoryPopup.addEventListener(RepositoryEvent.REP_EVENT_TYPE_DELETE, deleteRepository);
						repositoryPopup.addEventListener(CloseEvent.CLOSE, cleanupPopup);
						PopUpManager.centerPopUp(repositoryPopup);
					}
					
					(repositoryPopup as RepositoryManagementDialog).repositoryGrid.dataProvider = repositoryProxy.repositories;
					
					break;
				default:
					break;
			}
			
		}
		
		public function get application():SvnAnalyticsApplication {
			return viewComponent as SvnAnalyticsApplication;
		}
		
		protected function addRepository(event:Event):void {
			if(event is RepositoryEvent) {
				var svnRepos:SVNRepositoryDTO = (event as RepositoryEvent).svnRepositoryDto;
        		sendNotification( ApplicationFacade.ADD_REPOSITORY, svnRepos );	
			}
		} 
		
		protected function deleteRepository(event:Event):void {
			if(event is RepositoryEvent) {
				var svnRepos:SVNRepositoryDTO = (event as RepositoryEvent).svnRepositoryDto;
				sendNotification( ApplicationFacade.DELETE_REPOSITORY, svnRepos );
			}
		}
		
		protected function cleanupPopup(event:Event):void {
			repositoryPopup.removeEventListener(RepositoryEvent.REP_EVENT_TYPE_ADD, addRepository);
			repositoryPopup.removeEventListener(RepositoryEvent.REP_EVENT_TYPE_DELETE, deleteRepository);
			repositoryPopup.removeEventListener(CloseEvent.CLOSE, cleanupPopup);
			repositoryPopup = null;
		}
		
	}
}