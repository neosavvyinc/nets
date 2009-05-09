package com.neosavvy.svn.analytics.model
{
	import com.neosavvy.svn.analytics.ApplicationFacade;
	
	import mx.collections.ArrayCollection;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;

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
		
		public function getRepositories():void {
			svnRepositoryService.addEventListener(ResultEvent.RESULT, onRepositoriesResult );
            svnRepositoryService.addEventListener(FaultEvent.FAULT, onRepositoriesFault );
			svnRepositoryService.getRepositories();
		}

		public function saveRepository( repository:SVNRepositoryDTO ):void {
			
		}
	
		public function deleteRepository( repository:SVNRepositoryDTO ):void {
			
		}
	
		public function updateRepository( repository:SVNRepositoryDTO ):void {
			
		}
		
		
		public function onRepositoriesResult( object:Object ):void {
			var data:ResultEvent = object as ResultEvent;
            setData(data.result);
			sendNotification( ApplicationFacade.LOADED_REPOSITORIES );
		}
		
		public function get repositories():Array {
			return data as Array;
		}
		
		public function onRepositoriesFault( faultObject:Object ):void {
			var fault:FaultEvent = faultObject as FaultEvent;
			trace("Fault: " + fault.fault.faultCode);
			trace("FaultDetail: " + fault.fault.faultDetail);
			trace("FaultString: " + fault.fault.faultString);
		}
		
	}
}