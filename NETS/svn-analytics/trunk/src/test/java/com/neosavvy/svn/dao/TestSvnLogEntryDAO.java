package com.neosavvy.svn.dao;

import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Test;

import com.neosavvy.junit4.BaseSpringAwareTestCase;
import com.neosavvy.svn.analytics.dao.SVNStatisticDAO;

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

    @Test
    public void testSaveBatchStatistics() {

    }
}
