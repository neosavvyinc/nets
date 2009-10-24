package com.neosavvy.svn.analytics.dao;

import java.util.List;

import com.neosavvy.svn.analytics.dto.Author;
import com.neosavvy.svn.analytics.dto.HistoricalTeamStatistic;
import com.neosavvy.svn.analytics.dto.OverallTeamStatistic;
import com.neosavvy.svn.analytics.dto.SVNRepositoryConversionInfo;
import com.neosavvy.svn.analytics.dto.SVNRepositoryInterval;
import com.neosavvy.svn.analytics.dto.SVNStatistic;
import com.neosavvy.svn.analytics.dto.request.RefineSearchRequest;

public interface SVNStatisticDAO {

    public void saveStatistics(List<SVNStatistic> statistics);

    public OverallTeamStatistic[] getOverallTeamStats();
    
    public OverallTeamStatistic[] getRefinedTeamStats(RefineSearchRequest request);

    public HistoricalTeamStatistic[] getHistoricalTeamStats();
    
    public HistoricalTeamStatistic[] getRefinedHistoricalStats(RefineSearchRequest request);

    public Author[] getAuthors();

    public SVNRepositoryInterval getRepositoryInterval();
    
    public SVNRepositoryConversionInfo getRepositoryInfo(String url);
    
}
