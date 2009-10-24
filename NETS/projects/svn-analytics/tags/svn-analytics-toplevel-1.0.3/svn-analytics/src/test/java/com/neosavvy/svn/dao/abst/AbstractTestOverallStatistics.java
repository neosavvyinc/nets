package com.neosavvy.svn.dao.abst;

import org.apache.log4j.Logger;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.neosavvy.junit4.BaseSpringAwareTestCase;
import com.neosavvy.svn.TestUtils;
import com.neosavvy.svn.analytics.dao.SVNStatisticDAO;
import com.neosavvy.svn.analytics.dto.OverallTeamStatistic;
import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
import com.neosavvy.svn.analytics.dto.request.RefineSearchRequest;

public abstract class AbstractTestOverallStatistics extends BaseSpringAwareTestCase {

    private static final Logger logger = Logger
            .getLogger(AbstractTestOverallStatistics.class);

    @Autowired
    private SVNStatisticDAO dao;
    

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
    	SVNRepositoryDTO repositoryTest = new SVNRepositoryDTO();
    	repositoryTest.setUrl("TestURL");
    	request.setRepositories(new SVNRepositoryDTO[]{repositoryTest});
    	
    	OverallTeamStatistic[] overallTeamStatistics = dao.getRefinedTeamStats(request);
    	Assert.assertNotNull(overallTeamStatistics);
    	//Assert.assertEquals(1, overallTeamStatistics.length);
    	
    }
    
    
}
