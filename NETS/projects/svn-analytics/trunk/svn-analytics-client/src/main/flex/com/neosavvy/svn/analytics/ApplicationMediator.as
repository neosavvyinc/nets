package com.neosavvy.svn.analytics
{
	import com.neosavvy.svn.analytics.dto.Author;
	import com.neosavvy.svn.analytics.dto.request.RefineSearchRequest;
	import com.neosavvy.svn.analytics.model.AuthorProxy;
	import com.neosavvy.svn.analytics.model.ReportIntervalProxy;
	import com.neosavvy.svn.analytics.model.SVNRepositoryProxy;
	
	import flash.events.Event;
	
	import mx.controls.DateField;
	import mx.controls.List;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class ApplicationMediator extends Mediator
	{
		public static var MEDIATOR_NAME:String = "ApplicationMediator";
		
		public function ApplicationMediator( viewComponent:Object )
		{
			super(MEDIATOR_NAME, viewComponent);
			this.application.addEventListener(SvnAnalyticsApplication.REFINE_SEARCH, refineSearch);
			this.application.addEventListener(SvnAnalyticsApplication.RESET_SEARCH, resetSearch);
			this.application.addEventListener(SvnAnalyticsApplication.MANAGE_REPOSITORIES, manageRepositories);
		}
		
		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.STARTUP
				,ApplicationFacade.LOADED_AUTHORS
				,ApplicationFacade.LOADED_REPOSITORY_INTERVAL
				,ApplicationFacade.LOADED_REPOSITORIES
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			
			switch ( notification.getName() ) {
				case ApplicationFacade.LOADED_AUTHORS:
					var svnAnalyticsProxy:AuthorProxy = facade.retrieveProxy( AuthorProxy.NAME ) as AuthorProxy;
					authorsSelector.dataProvider = svnAnalyticsProxy.authors;
					
					var allindices:Array = new Array();
					var index:Number = 0;
					for each (var obj:Object in svnAnalyticsProxy.authors) {
						allindices.push(index);
						index = index + 1;	
					}
					
					authorsSelector.selectedIndices = allindices;
					break;
				case ApplicationFacade.LOADED_REPOSITORY_INTERVAL:
					var svnRepositoryIntervalProxy:ReportIntervalProxy = facade.retrieveProxy( ReportIntervalProxy.NAME ) as ReportIntervalProxy;
				
					var startDateFromService:Date = svnRepositoryIntervalProxy.reportInterval.startDayLevelDate;
	            	var endDateFromService:Date = svnRepositoryIntervalProxy.reportInterval.endDayLevelDate;
	            	
	            	startDate.selectedDate = startDateFromService;
	            	startDate.selectableRange = {rangeStart: startDateFromService, rangeEnd: endDateFromService};
	
	            	endDate.selectedDate = endDateFromService
	            	startDate.selectableRange = {rangeStart: startDateFromService, rangeEnd: endDateFromService};
					break;
					
				case ApplicationFacade.LOADED_REPOSITORIES:
					var svnRepositoryProxy:SVNRepositoryProxy = facade.retrieveProxy( SVNRepositoryProxy.NAME ) as SVNRepositoryProxy;
					svnRepositorySelector.dataProvider = svnRepositoryProxy.repositories;
					
					var allindices:Array = new Array();
					var index:Number = 0;
					for each (var obj:Object in svnRepositoryProxy.repositories) {
						allindices.push(index);
						index = index + 1;	
					}
					
					svnRepositorySelector.selectedIndices = allindices;
					
					break;
				default:
					break;
			}
			
		}
		
		protected function get application():SvnAnalyticsApplication {
			return viewComponent as SvnAnalyticsApplication;
		}
		
		protected function get authorsSelector():List {
			return this.application.authorsSelector;
		}
		
		protected function get startDate():DateField {
			return this.application.startDate;
		}
		
		protected function get endDate():DateField {
			return this.application.endDate;
		}
		
		protected function get svnRepositorySelector():List {
			return this.application.svnRepositorySelector;
		}
		
		protected function get increment():String {
			if( this.application.daily.selected ) {
				return "daily";
			} else if ( this.application.monthly.selected ) {
				return "monthly";
			}
			
			return "monthly";
		}
		
		/**
		 * Event listeners for View spawned actions / user gestures go here
		 **/ 
		protected function refineSearch(event:Event):void {
			var refineRequest:RefineSearchRequest = new RefineSearchRequest();
			
			var authors:Array = authorsSelector.selectedItems;
			var authorStrings:Array = new Array();
			for each (var author:Author in authors) {
				authorStrings.push(author.author);
			}
        	refineRequest.userNames = authorStrings;
        	refineRequest.startDate = startDate.selectedDate;
        	refineRequest.endDate = endDate.selectedDate;
        	refineRequest.incrementType = increment;
        	
        	refineRequest.repositories = svnRepositorySelector.selectedItems;
        	
        	sendNotification( ApplicationFacade.REFINE_SEARCH_REQUEST, refineRequest );
		} 
		 
		protected function resetSearch(event:Event):void {
			sendNotification( ApplicationFacade.RESET_SEARCH_REQUEST );
		} 
		
		protected function manageRepositories(event:Event):void {
			sendNotification( ApplicationFacade.DISPLAY_MANAGE_REPOSITORIES_DIALOG);
		}
	}
}