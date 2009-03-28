package com.neosavvy.svn.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.SVNURL;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.io.SVNRepository;
import org.tmatesoft.svn.core.io.SVNRepositoryFactory;
import org.tmatesoft.svn.core.wc.SVNWCUtil;

import com.neosavvy.junit4.BaseSpringAwareTestCase;
import com.neosavvy.svn.analytics.dao.SVNStatisticDAO;
import com.neosavvy.svn.analytics.dto.Author;
import com.neosavvy.svn.analytics.dto.HistoricalTeamStatistic;
import com.neosavvy.svn.analytics.dto.OverallTeamStatistic;
import com.neosavvy.svn.analytics.dto.SVNStatistic;
import com.neosavvy.svn.analytics.util.SvnKitUtil;

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

    @SuppressWarnings("unchecked")
    @Test
    public void testSaveBatchStatistics() throws SVNException {

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
    }

    @Test
    public void testGetOverallStats() {
        OverallTeamStatistic[] overallTeamStats = dao.getOverallTeamStats();
        Assert.assertNotNull(overallTeamStats);
    }

    @Test
    public void testGetHistoricalStats() {
        HistoricalTeamStatistic[] stats = dao.getHistoricalTeamStats();
        Assert.assertNotNull(stats);
    }

    @Test
    public void testGetAuthors() {
        Author[] authors = dao.getAuthors();
        Assert.assertNotNull(authors);
    }
}
