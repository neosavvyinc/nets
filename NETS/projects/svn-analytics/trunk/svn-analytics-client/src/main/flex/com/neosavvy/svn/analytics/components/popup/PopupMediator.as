package com.neosavvy.svn.analytics.components.popup
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.components.popup.repositories.RepositoryManagementDialog;
	import com.neosavvy.svn.analytics.model.SVNRepositoryProxy;
	
	import flash.display.DisplayObject;
	
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class PopupMediator extends Mediator
	{
		public static var MEDIATOR_NAME:String = "PopupMediator";
		
		var repositoryPopup:IFlexDisplayObject;
		
		public function PopupMediator( viewComponent:Object )
		{
			super(MEDIATOR_NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.DISPLAY_MANAGE_REPOSITORIES_DIALOG
				,ApplicationFacade.LOADED_REPOSITORIES
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			
			switch ( notification.getName() ) {
				case ApplicationFacade.DISPLAY_MANAGE_REPOSITORIES_DIALOG:
					sendNotification( ApplicationFacade.LOAD_REPOSITORIES );
					break; 
				case ApplicationFacade.LOADED_REPOSITORIES:
					var repositoryProxy:SVNRepositoryProxy = facade.retrieveProxy( SVNRepositoryProxy.NAME ) as SVNRepositoryProxy;
					repositoryPopup = PopUpManager.createPopUp( viewComponent as DisplayObject, RepositoryManagementDialog, true);
					(repositoryPopup as RepositoryManagementDialog).repositoryGrid.dataProvider = repositoryProxy.repositories;
					PopUpManager.centerPopUp(repositoryPopup);
					break;
				default:
					break;
			}
			
		}
		
	}
}