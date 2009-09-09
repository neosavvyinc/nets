package com.neosavvy.svn.dao.abst;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.transaction.annotation.Transactional;

import com.neosavvy.junit4.BaseTransactionalSpringAwareTestCase;
import com.neosavvy.svn.analytics.dao.SVNStatisticDAO;
import com.neosavvy.svn.analytics.dto.OverallTeamStatistic;
import com.neosavvy.svn.analytics.dto.SVNStatistic;

@Transactional
public abstract class AbstractTestSvnLogEntryDAOCRUD extends BaseTransactionalSpringAwareTestCase {

	@Autowired
	private SVNStatisticDAO dao;

	@Test
	public void saveStatistic() {

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
		statisticWithOutMessage.setNumFilesAddedInRevision(10);
		statisticWithOutMessage.setNumFilesDeletedInRevision(10);
		statisticWithOutMessage.setNumFilesInRevision(10);
		statisticWithOutMessage.setNumFilesModifiedInRevision(10);
		statisticWithOutMessage.setRevision(103);
		statisticWithOutMessage.setSvnRepositoryUrl("http://test.url/fake");
		
		List<SVNStatistic> listToSave = new ArrayList<SVNStatistic>();
		listToSave.add(statisticWithMessage);
		listToSave.add(statisticWithOutMessage);
		
		dao.saveStatistics(listToSave);
		
		OverallTeamStatistic[] stats = dao.getOverallTeamStats();
	}
    
}
