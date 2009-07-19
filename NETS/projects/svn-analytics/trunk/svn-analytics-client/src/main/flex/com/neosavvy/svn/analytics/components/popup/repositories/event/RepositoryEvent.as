package com.neosavvy.svn.analytics.components.popup.repositories.event
{
	import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
	
	import flash.events.Event;

	public class RepositoryEvent extends Event
	{
		public static var REP_EVENT_TYPE_ADD:String = "add";
		public static var REP_EVENT_TYPE_DELETE:String = "delete";
		public static var REP_EVENT_TYPE_REFRESH:String = "refresh";
		
		private var _repEventType:String;
		private var _svnRepositoryDto:SVNRepositoryDTO;
		
		public function RepositoryEvent(repTypeEvent:String, repository:SVNRepositoryDTO)
		{
			super(repTypeEvent, true, true);
			_repEventType = repTypeEvent;
			_svnRepositoryDto = repository;
		}
		
		public function get eventType():String {
			return _repEventType;
		}
		
		public function get svnRepositoryDto():SVNRepositoryDTO {
			return _svnRepositoryDto;
		}
		
	}
}