package com.neosavvy.svn.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Test;

import com.neosavvy.junit4.BaseSpringAwareTestCase;
import com.neosavvy.svn.analytics.dao.SVNStatisticDAO;
import com.neosavvy.svn.analytics.dto.SVNStatistic;

public class TestSvnLogEntryDAOCRUD extends BaseSpringAwareTestCase {

	private static final Logger logger = Logger
			.getLogger(TestSvnLogEntryDAOCRUD.class);

	private SVNStatisticDAO dao;

	@Before
	@Override
	public void setup() {
		super.setup();

		dao = (SVNStatisticDAO) getContext().getBean("svnAnalyticsDAO");

		logger.info("Setup Complete");
	}

	@Test
	public void testInsert() {

		SVNStatistic statisticWithMessage = new SVNStatistic();
		statisticWithMessage.setAuthor("svn.integration.test");
		statisticWithMessage.setDate(new Date());
		statisticWithMessage.setMessage("Test valid commit message");
		statisticWithMessage.setNumFilesAddedInRevision(0);
		statisticWithMessage.setNumFilesDeletedInRevision(0);
		statisticWithMessage.setNumFilesInRevision(0);
		statisticWithMessage.setNumFilesModifiedInRevision(0);
		statisticWithMessage.setRevision(102);
		statisticWithMessage.setSvnRepositoryUrl("http://test.url/fake");
		
		
		SVNStatistic statisticWithOutMessage = new SVNStatistic();
		statisticWithOutMessage.setAuthor("svn.integration.test");
		statisticWithOutMessage.setDate(new Date());
		statisticWithOutMessage.setMessage("   ");
		statisticWithOutMessage.setNumFilesAddedInRevision(0);
		statisticWithOutMessage.setNumFilesDeletedInRevision(0);
		statisticWithOutMessage.setNumFilesInRevision(0);
		statisticWithOutMessage.setNumFilesModifiedInRevision(0);
		statisticWithOutMessage.setRevision(103);
		statisticWithOutMessage.setSvnRepositoryUrl("http://test.url/fake");
		
		List<SVNStatistic> listToSave = new ArrayList<SVNStatistic>();
		listToSave.add(statisticWithMessage);
		listToSave.add(statisticWithOutMessage);
		
		dao.saveStatistics(listToSave);
		
	}

}
