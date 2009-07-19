package com.neosavvy.svn.analytics.model
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
	
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
		 * Event Listeners
		 */
		public function onRepositoriesResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.LOADED_REPOSITORIES );
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onRepositoriesResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onRepositoriesFault, false);
		}
		
		public function onRepositoriesFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onRepositoriesResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onRepositoriesFault, false);
		}
		
		public function onSaveRepositoriesResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.REPOSITORY_ADDED );
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onSaveRepositoriesResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onSaveRepositoriesFault, false);
		}
		
		public function onSaveRepositoriesFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onSaveRepositoriesResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onSaveRepositoriesFault, false);
		}
		
		public function onDeleteRepositoryResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.REPOSITORY_DELETED );
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onDeleteRepositoryResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onDeleteRepositoryFault, false);
		}
		
		public function onDeleteRepositoryFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onDeleteRepositoryResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onDeleteRepositoryFault, false);
		}
		
		public function onRefreshRepositoryResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.REPOSITORY_REFRESHED );
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onRefreshRepositoryResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onRefreshRepositoryResult, false);
		}
		
		public function onRefreshRepositoryFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
			
			svnRepositoryService.removeEventListener(ResultEvent.RESULT, onRefreshRepositoryResult, false);
            svnRepositoryService.removeEventListener(FaultEvent.FAULT, onRefreshRepositoryResult, false);
		}
		
	}
}