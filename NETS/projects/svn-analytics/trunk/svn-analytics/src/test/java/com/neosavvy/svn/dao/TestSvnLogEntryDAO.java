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
import com.neosavvy.svn.analytics.dao.SVNStatisticDAO;
import com.neosavvy.svn.analytics.dto.Author;
import com.neosavvy.svn.analytics.dto.HistoricalTeamStatistic;
import com.neosavvy.svn.analytics.dto.OverallTeamStatistic;
import com.neosavvy.svn.analytics.dto.SVNRepositoryInterval;
import com.neosavvy.svn.analytics.dto.request.RefineSearchRequest;

public class TestSvnLogEntryDAO extends BaseSpringAwareTestCase {

    private static final Logger logger = Logger
            .getLogger(TestSvnLogEntryDAO.class);

    private SVNStatisticDAO dao;

    @Before
    @Override
    public void setup() {
        super.setup();
        
        dao = (SVNStatisticDAO) getContext().getBean("svnAnalyticsDAO");

        logger.info("Setup Complete");
    }
    
    /*
    @SuppressWarnings("unchecked")
    @Test
    @Ignore
    public void testSaveBatchStatistics() throws SVNException {

    	logger.info("Running testSaveBatchStatistics()");
    	
        String url = "https://svn.roundarch.com/repos/USADS";
        String name = "aparrish";
        String password = "subw@y1";
        long startRevision = 0;
        long endRevision = -1;// HEAD (the latest) revision
        SvnKitUtil.setupLibrary();
        SVNRepository repository = null;
        repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(url));
        ISVNAuthenticationManager authManager = SVNWCUtil
                .createDefaultAuthenticationManager(name, password);
        repository.setAuthenticationManager(authManager);
        endRevision = repository.getLatestRevision();

        Collection log = null;

        while (startRevision <= endRevision) {

            if (startRevision + 100 >= endRevision) {
                log = repository.log(new String[] { "" }, null, startRevision,
                        endRevision, true, true);
            } else {
                log = repository.log(new String[] { "" }, null, startRevision,
                        startRevision + 100, true, true);
            }
            List<SVNStatistic> stats = new ArrayList<SVNStatistic>();
            for (Object entry : log.toArray()) {
                if (entry instanceof SVNLogEntry) {
                    stats.add(new SVNStatistic((SVNLogEntry) entry));
                }
            }

            dao.saveStatistics(stats);
            startRevision += 100;
        }
    }*/

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
    	request.setStartDate(getDate("2008-01-01"));
    	request.setEndDate(getDate("2009-01-01"));
    	OverallTeamStatistic[] overallTeamStatistics = dao.getRefinedTeamStats(request);
    	Assert.assertNotNull(overallTeamStatistics);
    	Assert.assertEquals(1, overallTeamStatistics.length);
    	
    }
    
    @Test
    public void testRefinedHistoricalStats() {
    	
    	RefineSearchRequest request = new RefineSearchRequest();
    	request.setUserNames(new String[]{"aparrish"});
    	request.setStartDate(getDate("2008-01-01"));
    	request.setEndDate(getDate("2009-01-01"));
    	HistoricalTeamStatistic[] stats = dao.getRefinedHistoricalStats(request);
    	Assert.assertNotNull(stats);
    	Assert.assertEquals(12, stats.length);
    }
    
    public Date getDate(String date) {
	    try {
			return getDate(date, "yyyy-MM-dd");
		} catch (ParseException e) {
			logger.error(e);
			Assert.fail();
			throw new RuntimeException("Failed parsing date: " + date);
		}
	}
	
	
	public Date getDate(String date, String format) throws ParseException {
	    SimpleDateFormat formatter = new SimpleDateFormat(format);
	    formatter.setTimeZone(TimeZone.getTimeZone("GMT-0"));
	    return formatter.parse(date);
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
