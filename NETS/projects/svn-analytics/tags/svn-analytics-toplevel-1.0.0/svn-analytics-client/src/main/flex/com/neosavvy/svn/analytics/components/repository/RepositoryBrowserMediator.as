package com.neosavvy.svn.analytics.components.repository
{
	import assets.FileIcons;
	
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
	import com.neosavvy.svn.analytics.dto.file.FileSystemNode;
	import com.neosavvy.svn.analytics.model.SVNRepositoryProxy;
	
	import mx.collections.ArrayCollection;
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
			var svnRepositoryProxy:SVNRepositoryProxy = facade.retrieveProxy( SVNRepositoryProxy.NAME ) as SVNRepositoryProxy;
			switch ( notification.getName() ) {
				case ApplicationFacade.LOADED_REPOSITORIES:
					repositoryBrowser.dataProvider = svnRepositoryProxy.repositories;
					break;
				case ApplicationFacade.ROOT_FILE_NODES_FOR_REPOSITORY_LOADED:
					var dataToUpdate:Array = svnRepositoryProxy.repositories;
					var parentToUpdate:Object = notification.getBody();
					for each (var repos:SVNRepositoryDTO in dataToUpdate ) {
						if ( repos.id == parentToUpdate.repositoryId ) {
							findNodeInTree( repos.children as ArrayCollection, parentToUpdate as FileSystemNode, 1 );
						} 
					}
				default:
					break;
			}
			
		}
		
		protected function findNodeInTree( children:ArrayCollection, parentToUpdate:FileSystemNode, depth:int ) : void {
			trace("parentToUpdatePath:" + parentToUpdate.parentDirectory);
			var directoryPath:Array = parentToUpdate.parentDirectory.split("/");
			var directoryToLoad:String = "";
			for ( var i:int = 0; i <= depth; i++) {
				directoryToLoad = directoryToLoad + directoryPath[i] + "/";
			}
			trace("directoryToLoad:::"+directoryToLoad);
			directoryToLoad = directoryToLoad.substr(0, directoryToLoad.lastIndexOf("/") );
			trace("directoryToLoad:::"+directoryToLoad);
			for each ( var fileSysNode:FileSystemNode in children ) {
				trace("fileSysNode:" + fileSysNode.relativePath);				
				if( directoryToLoad == fileSysNode.relativePath &&
					fileSysNode.fileType == "D" ) {
					
						if( parentToUpdate.parentDirectory == fileSysNode.relativePath &&
						parentToUpdate.fileType == fileSysNode.fileType ) {
							
							fileSysNode.children = parentToUpdate.children;
							
						} else {
							findNodeInTree( fileSysNode.children as ArrayCollection, parentToUpdate, depth+1 );
						}
						
					}
				
				
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
		    	label = (item as FileSystemNode).fileName;
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
		    		icon = FileIcons.file;	
		    	} else if( (item as FileSystemNode).fileType == 'D') {
		    		icon = FileIcons.folder;	
		    	}
		    }
		    
		    return icon;
		}
		
		protected function repositoryBrowserItemClickEvent(event:ListEvent):void {
			
			var target:RepositoryBrowser = event.target as RepositoryBrowser;
			var selectedItem:Object = target.selectedItem;
			
			if ( selectedItem is FileSystemNode && (selectedItem as FileSystemNode).fileType == 'D' ) {
				trace("clicking directory");
				var node:FileSystemNode = selectedItem as FileSystemNode;
				var searchNode:FileSystemNode = new FileSystemNode();
				searchNode.parentDirectory = node.relativePath;
				searchNode.repositoryId = node.repositoryId;
				searchNode.fileType = node.fileType;
				trace("Loading child directories for: " + searchNode.parentDirectory);
				trace("For Repository by ID: " + searchNode.repositoryId);
				trace("For file type: " + searchNode.fileType);
				var repositoryProxy:SVNRepositoryProxy = facade.retrieveProxy( SVNRepositoryProxy.NAME ) as SVNRepositoryProxy;
				var repository:SVNRepositoryDTO = repositoryProxy.findRepositoryForDirectory( node );
				sendNotification(ApplicationFacade.LOAD_ROOT_NODES_FOR_REPOSITORY, [repository, searchNode]);
				
			} 
			
		}
		
	}
}