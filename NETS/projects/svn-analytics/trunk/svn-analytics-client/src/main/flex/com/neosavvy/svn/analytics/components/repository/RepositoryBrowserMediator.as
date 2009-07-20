package com.neosavvy.svn.analytics.components.repository
{
	import assets.FileIcons;
	
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
	import com.neosavvy.svn.analytics.dto.file.FileSystemNode;
	import com.neosavvy.svn.analytics.model.SVNRepositoryProxy;
	
	import mx.events.ListEvent;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class RepositoryBrowserMediator extends Mediator
	{
		public static var MEDIATOR_NAME:String = "RepositoryMediator";
		
		public function RepositoryBrowserMediator( viewComponent:Object )
		{
			super(MEDIATOR_NAME, viewComponent);
			
			this.repositoryBrowser.labelFunction = repositoryBrowserLabelFunction;
			this.repositoryBrowser.iconFunction = repositoryBrowserIconFunction;
			
			this.repositoryBrowser.addEventListener(ListEvent.ITEM_CLICK, repositoryBrowserItemClickEvent);
		}
		
		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.STARTUP
				,ApplicationFacade.LOADED_REPOSITORIES
				,ApplicationFacade.ROOT_FILE_NODES_FOR_REPOSITORY_LOADED
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
		
		protected function repositoryBrowserLabelFunction(item:Object):String {
		    var label:String;
		    
		    if( item is SVNRepositoryDTO) {
		    	label = (item as SVNRepositoryDTO).name;
		    }
		    else if ( item is FileSystemNode ) {
		    	label = (item as FileSystemNode).relativePath;
		    }
		    
		    return label;
		}
		
		protected function repositoryBrowserIconFunction(item:Object):Class {
		    var icon:Class;
		    
		    if( item is SVNRepositoryDTO) {
		    	icon = FileIcons.folder;
		    }
		    else if ( item is FileSystemNode ) {
		    	if( (item as FileSystemNode).fileType == 'F') {
		    		icon = FileIcons.folder;	
		    	} else {
		    		icon = FileIcons.folder;	
		    	}
		    }
		    
		    return icon;
		}
		
		protected function repositoryBrowserItemClickEvent(event:ListEvent):void {
			
			var target:RepositoryBrowser = event.target as RepositoryBrowser;
			var selectedItem:Object = target.selectedItem;
			
			/* if( selectedItem is SVNRepositoryDTO) {
				var selectedRepository:SVNRepositoryDTO = selectedItem as SVNRepositoryDTO;
				var rootNode:DirectoryNode = new DirectoryNode();
				rootNode.parentDirectory = "/";
				sendNotification(ApplicationFacade.LOAD_ROOT_NODES_FOR_REPOSITORY, [selectedRepository,rootNode]);
			}
			else if ( selectedItem is DirectoryNode ) {
				
				var node:DirectoryNode = selectedItem as DirectoryNode;
				var searchNode:DirectoryNode = new DirectoryNode();
				searchNode.parentDirectory = node.relativePath;
				var repositoryProxy:SVNRepositoryProxy = facade.retrieveProxy( SVNRepositoryProxy.NAME ) as SVNRepositoryProxy;
				var repository:SVNRepositoryDTO = repositoryProxy.findRepositoryForDirectory( node );
				sendNotification(ApplicationFacade.LOAD_ROOT_NODES_FOR_REPOSITORY, [repository, searchNode]);
				
			} */
			
		}
	}
}