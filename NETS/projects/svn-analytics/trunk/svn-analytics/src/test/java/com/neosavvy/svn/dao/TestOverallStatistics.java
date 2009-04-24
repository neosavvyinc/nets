package com.neosavvy.svn.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import org.apache.log4j.Logger;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.neosavvy.junit4.BaseSpringAwareTestCase;
import com.neosavvy.svn.TestUtils;
import com.neosavvy.svn.analytics.dao.SVNStatisticDAO;
import com.neosavvy.svn.analytics.dto.Author;
import com.neosavvy.svn.analytics.dto.HistoricalTeamStatistic;
import com.neosavvy.svn.analytics.dto.OverallTeamStatistic;
import com.neosavvy.svn.analytics.dto.SVNRepositoryInterval;
import com.neosavvy.svn.analytics.dto.request.RefineSearchRequest;

public class TestOverallStatistics extends BaseSpringAwareTestCase {

    private static final Logger logger = Logger
            .getLogger(TestOverallStatistics.class);

    private SVNStatisticDAO dao;

    @Before
    @Override
    public void setup() {
        super.setup();
        
        dao = (SVNStatisticDAO) getContext().getBean("svnAnalyticsDAO");

        logger.info("Setup Complete");
    }
    

    @Test
    public void testGetOverallStats() {
    	logger.info("Running testGetOverallStats()");
        OverallTeamStatistic[] overallTeamStats = dao.getOverallTeamStats();
        Assert.assertNotNull(overallTeamStats);
    }
    
    @Test
    public void testRefinedTeamStats() {
    	
    	RefineSearchRequest request = new RefineSearchRequest();
    	request.setUserNames(new String[]{"aparrish"});
    	request.setStartDate(TestUtils.getDate("2008-01-01"));
    	request.setEndDate(TestUtils.getDate("2009-01-01"));
    	OverallTeamStatistic[] overallTeamStatistics = dao.getRefinedTeamStats(request);
    	Assert.assertNotNull(overallTeamStatistics);
    	Assert.assertEquals(1, overallTeamStatistics.length);
    	
    }
    
    
}
