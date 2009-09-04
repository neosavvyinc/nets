package com.neosavvy.svn.dao.abst;

import org.apache.log4j.Logger;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.neosavvy.junit4.BaseSpringAwareTestCase;
import com.neosavvy.svn.TestUtils;
import com.neosavvy.svn.analytics.dao.SVNStatisticDAO;
import com.neosavvy.svn.analytics.dto.Author;
import com.neosavvy.svn.analytics.dto.HistoricalTeamStatistic;
import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
import com.neosavvy.svn.analytics.dto.SVNRepositoryInterval;
import com.neosavvy.svn.analytics.dto.request.RefineSearchRequest;

public abstract class AbstractTestSvnLogEntryDAO extends BaseSpringAwareTestCase {

    private static final Logger logger = Logger
            .getLogger(AbstractTestSvnLogEntryDAO.class);

    @Autowired
    private SVNStatisticDAO dao;

    @Test
    public void testRefinedHistoricalStats() {
    	
    	RefineSearchRequest request = new RefineSearchRequest();
    	request.setUserNames(new String[]{"aparrish"});
    	request.setStartDate(TestUtils.getDate("2008-01-01"));
    	request.setEndDate(TestUtils.getDate("2009-01-01"));
    	request.setIncrementType(RefineSearchRequest.CONST_MONTHLY);
    	SVNRepositoryDTO repositoryTest = new SVNRepositoryDTO();
    	repositoryTest.setUrl("TestURL");
    	request.setRepositories(new SVNRepositoryDTO[]{repositoryTest});
    	HistoricalTeamStatistic[] stats = dao.getRefinedHistoricalStats(request);
    	Assert.assertNotNull(stats);
    	//Assert.assertEquals(12, stats.length);
    }
    
    @Test
    public void testGetHistoricalStats() {
    	logger.info("Running testGetHistoricalStats()");
        HistoricalTeamStatistic[] stats = dao.getHistoricalTeamStats();
        Assert.assertNotNull(stats);
    }

    @Test
    public void testGetAuthors() {
    	logger.info("Running testGetAuthors()");
        Author[] authors = dao.getAuthors();
        Assert.assertNotNull(authors);
    }

    @Test
    public void testInterval() {
    	logger.info("Running testInterval()");
    	SVNRepositoryInterval interval = dao.getRepositoryInterval();
    	Assert.assertNotNull(interval);
    	
    }
    
}
