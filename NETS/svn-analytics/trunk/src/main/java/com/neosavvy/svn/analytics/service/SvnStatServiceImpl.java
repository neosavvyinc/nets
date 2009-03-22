package com.neosavvy.svn.analytics.service;

import com.neosavvy.svn.analytics.dao.SVNStatisticDAO;
import com.neosavvy.svn.analytics.dto.OverallTeamStatistic;

public class SvnStatServiceImpl implements SvnStatService {

    private SVNStatisticDAO dao;

    public OverallTeamStatistic[] getOverallTeamStatistics() {
        return dao.getOverallTeamStats();
    }

    public SVNStatisticDAO getDao() {
        return dao;
    }

    public void setDao(SVNStatisticDAO dao) {
        this.dao = dao;
    }

}
