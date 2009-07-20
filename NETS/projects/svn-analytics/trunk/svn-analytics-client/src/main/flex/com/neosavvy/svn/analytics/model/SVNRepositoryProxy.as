package com.neosavvy.svn.analytics.model
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
	import com.neosavvy.svn.analytics.dto.file.DirectoryNode;
	
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
		
		private var _requestedParentRepository:SVNRepositoryDTO;
		private var _requestedParentDirectory:DirectoryNode;
		
		private var _directoriesRequested:Boolean;
		private var _filesRequested:Boolean;
		private var _isRootRequest:Boolean;
		
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
	
		public function getDirectoriesForRepository( parentRepository:SVNRepositoryDTO, parentDirectory:DirectoryNode):void {
			svnRepositoryService.addEventListener(ResultEvent.RESULT, onDirectoriesResult, false, 0, true);
            svnRepositoryService.addEventListener(FaultEvent.FAULT, onDirectoriesFault, false, 0, true);
            
			//This operation is part of a macro command, so both responses are required to consider it complete            
            _directoriesRequested = true;
            _requestedParentDirectory = parentDirectory;
            _requestedParentRepository = parentRepository;
            _isRootRequest = _requestedParentDirectory.parentDirectory == "/";
			svnRepositoryService.getDirectoriesForRepository( parentRepository, parentDirectory );
		}
		
		public function getFilesForRepository( parentRepository:SVNRepositoryDTO, parentDirectory:DirectoryNode):void {
			svnRepositoryService.addEventListener(ResultEvent.RESULT, onFilesResult, false, 0, true);
            svnRepositoryService.addEventListener(FaultEvent.FAULT, onDirectoriesFault, false, 0, true);
            
            //This operation is part of a macro command, so both responses are required to consider it complete
            _filesRequested = true;
            _requestedParentDirectory = parentDirectory;
            _requestedParentRepository = parentRepository;
            _isRootRequest = _requestedParentDirectory.parentDirectory == "/";
			svnRepositoryService.getFilesForRepository( parentRepository, parentDirectory );			
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
		
		/**
		 * Public data accessor / helper functions
		 */ 
		public function findRepositoryForDirectory( directory:DirectoryNode ):SVNRepositoryDTO {
			for each ( var repository:SVNRepositoryDTO in repositories ) {
				if ( directory.repositoryId == repository.id ) {
					return repository;
				}
			}
			throw IllegalOperationError("No repository was found for this id: " + directory.repositoryId );
		} 
		 
		
		/**
		 * Protected Helper functions
		 */ 
		protected function saveRequestValues( parentDirectory:DirectoryNode, parentRepository:SVNRepositoryDTO ):void {
			_requestedParentDirectory = parentDirectory;
			_requestedParentRepository = parentRepository;
		}
		 
		protected function clearRequests():void {
			if( !_directoriesRequested && !_filesRequested ) {
				
				if( _isRootRequest ) {
					_requestedParentRepository.children = new ArrayCollection([ _requestedParentDirectory ]);
				} 
				_isRootRequest = false;
				_requestedParentDirectory = null;
				_requestedParentRepository = null;
			}
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
			_directoriesRequested = false;
			_requestedParentDirectory.addChildren( directories );
			clearRequests();
			sendNotification( ApplicationFacade.ROOT_DIRECTORY_NODES_FOR_REPOSITORY_LOADED );
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onDirectoriesResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onDirectoriesFault, false);
		}
		
		protected function onDirectoriesFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			_directoriesRequested = false;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
			
			clearRequests();
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onDirectoriesResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onDirectoriesFault, false);
		}
		
		protected function onFilesResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
			var files:Array = data.result as Array;
			_filesRequested = false;	
			_requestedParentDirectory.addChildren( files );
			clearRequests();		
			sendNotification( ApplicationFacade.ROOT_FILE_NODES_FOR_REPOSITORY_LOADED );
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onFilesResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onFilesFault, false);
		}
		
		protected function onFilesFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
			
			_filesRequested = false;
			clearRequests();
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onFilesResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onFilesFault, false);
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