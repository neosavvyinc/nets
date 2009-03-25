package com.neosavvy.svn.analytics.service;

import com.neosavvy.svn.analytics.dto.Author;
import com.neosavvy.svn.analytics.dto.HistoricalTeamStatistic;
import com.neosavvy.svn.analytics.dto.OverallTeamStatistic;

public interface SvnStatService {

    public OverallTeamStatistic[] getOverallTeamStatistics();

    public HistoricalTeamStatistic[] getHistoricalTeamStatistics();

    public Author[] getAuthors();
}
