package com.neosavvy.svn.analytics.model
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
	import com.neosavvy.svn.analytics.dto.file.FileSystemNode;
	
	import flash.errors.IllegalOperationError;
	
	import mx.collections.ArrayCollection;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class SVNRepositoryProxy extends Proxy
	{
		public static var NAME:String = "svnRepositoryProxy";
		
		private var svnRepositoryService:RemoteObject;
		
		private var remote:Boolean = ProxyConstants.isRemoteEnabled;
		
		private var parentDirectory:FileSystemNode;
		
		public function SVNRepositoryProxy()
		{
			super(NAME, new Array());
			svnRepositoryService = new RemoteObject();
			if(remote) {
				var channel:AMFChannel = new AMFChannel("svn-analytics-amf", ProxyConstants.url);
				var channelSet:ChannelSet = new ChannelSet();
				channelSet.addChannel(channel);
				svnRepositoryService.channelSet = channelSet; 
			}
            svnRepositoryService.destination = "svnRepositoryService";
		}
		
		
		public function get repositories():Array {
			return data as Array;
		}
		
		public function getRepositories():void {
			svnRepositoryService.addEventListener(ResultEvent.RESULT, onRepositoriesResult, false, 0, true);
            svnRepositoryService.addEventListener(FaultEvent.FAULT, onRepositoriesFault, false, 0, true);
			svnRepositoryService.getRepositories();
		}
	
		public function getFilesForRepository( parentRepository:SVNRepositoryDTO, parentDirectory:FileSystemNode):void {
			svnRepositoryService.addEventListener(ResultEvent.RESULT, onDirectoriesResult, false, 0, true);
            svnRepositoryService.addEventListener(FaultEvent.FAULT, onDirectoriesFault, false, 0, true);
            this.parentDirectory = parentDirectory;
			//This operation is part of a macro command, so both responses are required to consider it complete            
			svnRepositoryService.getDirectoriesForRepository( parentRepository, parentDirectory );
		}

		public function saveRepository( repository:SVNRepositoryDTO ):void {
			svnRepositoryService.addEventListener(ResultEvent.RESULT, onSaveRepositoriesResult, false, 0, true);
            svnRepositoryService.addEventListener(FaultEvent.FAULT, onSaveRepositoriesFault, false, 0, true);
			svnRepositoryService.saveRepository( repository );
		}
	
		public function deleteRepository( repository:SVNRepositoryDTO ):void {
			svnRepositoryService.addEventListener(ResultEvent.RESULT, onDeleteRepositoryResult, false, 0, true);
			svnRepositoryService.addEventListener(FaultEvent.FAULT, onDeleteRepositoryFault, false, 0, true);
			svnRepositoryService.deleteRepository( repository );
		}
	
		public function updateRepository( repository:SVNRepositoryDTO ):void {
			
		}
		
		public function requestConversion( repository:SVNRepositoryDTO ):void {
			svnRepositoryService.addEventListener(ResultEvent.RESULT, onRefreshRepositoryResult, false, 0, true);
			svnRepositoryService.addEventListener(FaultEvent.FAULT, onRefreshRepositoryFault, false, 0, true);
			svnRepositoryService.requestConversion( repository );
		}
		
		public function findRepositoryForDirectory( directory:FileSystemNode ):SVNRepositoryDTO {
			for each ( var repos:SVNRepositoryDTO in repositories ) {
				if( repos.id = directory.repositoryId ) {
					return repos;
				}
			}
			throw IllegalOperationError("Failed to find repository by id: " + directory.repositoryId );
		}
		
		/**
		 * Event Listeners
		 */
		protected function onRepositoriesResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.LOADED_REPOSITORIES );
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onRepositoriesResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onRepositoriesFault, false);
		}
		
		protected function onRepositoriesFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onRepositoriesResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onRepositoriesFault, false);
		}
		
		protected function onDirectoriesResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            var directories:Array = data.result as Array;
            this.parentDirectory.children = new ArrayCollection(directories);
			sendNotification( ApplicationFacade.ROOT_FILE_NODES_FOR_REPOSITORY_LOADED, parentDirectory );
			this.parentDirectory = null;
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onDirectoriesResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onDirectoriesFault, false);
		}
		
		protected function onDirectoriesFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onDirectoriesResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onDirectoriesFault, false);
		}
		
		protected function onSaveRepositoriesResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.REPOSITORY_ADDED );
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onSaveRepositoriesResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onSaveRepositoriesFault, false);
		}
		
		protected function onSaveRepositoriesFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onSaveRepositoriesResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onSaveRepositoriesFault, false);
		}
		
		protected function onDeleteRepositoryResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.REPOSITORY_DELETED );
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onDeleteRepositoryResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onDeleteRepositoryFault, false);
		}
		
		protected function onDeleteRepositoryFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onDeleteRepositoryResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onDeleteRepositoryFault, false);
		}
		
		protected function onRefreshRepositoryResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.REPOSITORY_REFRESHED );
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onRefreshRepositoryResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onRefreshRepositoryFault, false);
		}
		
		protected function onRefreshRepositoryFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onRefreshRepositoryResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onRefreshRepositoryFault, false);
		}
		
	}
}