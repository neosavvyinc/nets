package com.neosavvy.svn.analytics.service;

import com.neosavvy.svn.analytics.dto.Author;
import com.neosavvy.svn.analytics.dto.HistoricalTeamStatistic;
import com.neosavvy.svn.analytics.dto.OverallTeamStatistic;
import com.neosavvy.svn.analytics.dto.SVNRepositoryInterval;
import com.neosavvy.svn.analytics.dto.request.RefineSearchRequest;

public interface SvnStatService {

	public OverallTeamStatistic[] getOverallTeamStatistics();
	
	public OverallTeamStatistic[] getRefinedTeamStatistics(RefineSearchRequest request);

	public HistoricalTeamStatistic[] getHistoricalTeamStatistics();
	
	public HistoricalTeamStatistic[] getRefinedHistoricalTeamStatistics(RefineSearchRequest request);

	public Author[] getAuthors();

	public SVNRepositoryInterval getRepositoryInterval();

}
