package com.neosavvy.svn.analytics.dao;

import java.util.List;

import com.neosavvy.svn.analytics.dto.SVNStatistic;

public interface SVNStatisticDAO {

    public void saveStatistics(List<SVNStatistic> statistics);

}
