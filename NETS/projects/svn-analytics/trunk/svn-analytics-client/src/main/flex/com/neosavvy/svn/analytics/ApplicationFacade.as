package com.neosavvy.svn.analytics
{
	import com.neosavvy.svn.analytics.controller.search.RefineSearchCommand;
	import com.neosavvy.svn.analytics.controller.search.ResetSearchCommand;
	import com.neosavvy.svn.analytics.controller.startup.StartupCommand;
	import com.neosavvy.svn.analytics.controller.svnrepository.AddSvnRepositoriesCommand;
	import com.neosavvy.svn.analytics.controller.svnrepository.DeleteSvnRepositoriesCommand;
	import com.neosavvy.svn.analytics.controller.svnrepository.GetSvnRepositoriesCommand;
	import com.neosavvy.svn.analytics.controller.svnrepository.RefreshSvnRepositoriesCommand;
	
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade
	{
		public static const STARTUP:String  = "startup"; 
		
		public static const LOAD_SUMMARY_STATS:String = "loadSummaryStats";
		public static const LOADED_SUMMARY_STATS:String = "loadedSummaryStats";
		
		public static const LOAD_HISTORICAL_STATS:String = "loadHistoricalStats";
		public static const LOADED_HISTORICAL_STATS:String = "loadedHistoricalStats";
		
		public static const LOAD_AUTHORS:String = "loadAuthors";
		public static const LOADED_AUTHORS:String = "loadedAuthors";
		
		public static const LOAD_REPOSITORY_INTERVAL:String = "loadRepositoryInterval";
		public static const LOADED_REPOSITORY_INTERVAL:String = "loadedRepositoryInterval";
		
		public static const LOAD_REPOSITORIES:String = "loadRepositories";
		public static const LOADED_REPOSITORIES:String = "loadedRepositories";
		
		public static const REFINE_SEARCH_REQUEST:String = "refineSearchRequest";
		public static const RESET_SEARCH_REQUEST:String = "resetSearchRequest";
		
		public static const DISPLAY_MANAGE_REPOSITORIES_DIALOG:String = "displayManageRepositoriesDialog";
		public static const ADD_REPOSITORY:String = "addRepositoryNotification";
		public static const REPOSITORY_ADDED:String = "repositoryAdded";
		public static const DELETE_REPOSITORY:String = "deleteRepositoryNotification";
		public static const REPOSITORY_DELETED:String = "repositoryDeleted";
		public static const REFRESH_REPOSITORY:String = "refreshRepositoryNotification";
		public static const REPOSITORY_REFRESHED:String = "repositoryRefresh";
		
		public static function getInstance():ApplicationFacade { 
			if( instance == null) {
				instance = new ApplicationFacade();
			}
			return instance as ApplicationFacade;
		}
		

		override protected function initializeController():void {
			super.initializeController();
			registerCommand( STARTUP, StartupCommand );
			registerCommand( REFINE_SEARCH_REQUEST, RefineSearchCommand );
			registerCommand( RESET_SEARCH_REQUEST, ResetSearchCommand );
			registerCommand( LOAD_REPOSITORIES, GetSvnRepositoriesCommand );
			registerCommand( ADD_REPOSITORY, AddSvnRepositoriesCommand );
			registerCommand( DELETE_REPOSITORY, DeleteSvnRepositoriesCommand );
			registerCommand( REFRESH_REPOSITORY, RefreshSvnRepositoriesCommand );
		}
		
		public function startup( app:SvnAnalyticsApplication ) : void  
		{  
			sendNotification( STARTUP, app ); 
		} 


	}
}