package com.neosavvy.svn.analytics.dao;

import java.util.List;

import com.neosavvy.svn.analytics.dto.Author;
import com.neosavvy.svn.analytics.dto.HistoricalTeamStatistic;
import com.neosavvy.svn.analytics.dto.OverallTeamStatistic;
import com.neosavvy.svn.analytics.dto.SVNStatistic;

public interface SVNStatisticDAO {

    public void saveStatistics(List<SVNStatistic> statistics);

    public OverallTeamStatistic[] getOverallTeamStats();

    public HistoricalTeamStatistic[] getHistoricalTeamStats();

    public Author[] getAuthors();

}
