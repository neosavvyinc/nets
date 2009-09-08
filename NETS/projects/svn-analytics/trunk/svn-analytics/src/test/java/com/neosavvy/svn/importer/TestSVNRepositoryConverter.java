package com.neosavvy.svn.importer;

import org.apache.log4j.Logger;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;

import com.neosavvy.junit4.BaseTransactionalSpringAwareTestCase;
import com.neosavvy.svn.analytics.dao.SVNRepositoryDAO;
import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
import com.neosavvy.svn.analytics.importer.SVNRepositoryDatabaseConverter;

@ContextConfiguration(locations = {
		"classpath:mysqlDatasource.xml"
        })
public class TestSVNRepositoryConverter extends BaseTransactionalSpringAwareTestCase {

	private static final Logger logger = Logger
			.getLogger(TestSVNRepositoryConverter.class);
	
	@Autowired
	private SVNRepositoryDatabaseConverter converter;
	
	@Autowired
	private SVNRepositoryDAO repositoryDAO;

	@Test
	@Ignore
	public void testRun() {
		
		deleteFromTables(new String[]{"SVN_FILE_SYSTEM_STATISTIC","SVN_REPOSITORY","SVN_STATISTIC"});
		
		SVNRepositoryDTO neosavvyRepos = new SVNRepositoryDTO();
		neosavvyRepos.setName("Neosavvy");
		neosavvyRepos.setPassword("aparrish");
		neosavvyRepos.setUserName("aparrish");
		neosavvyRepos.setUrl("http://www.neosavvy.com/svn");
		repositoryDAO.saveRepository(neosavvyRepos);
		
		converter.run();
	}
	
	@Test
	@Ignore
	public void testRefreshRequest() {
		SVNRepositoryDTO repository = new SVNRepositoryDTO();
		repository.setId(34);
		repository.setUrl("http://neosavvy.com/svn/neosavvy");
		repository.setUserName("aparrish");
		repository.setPassword("aparrish");
		
		converter.requestRefresh(repository);
	}
	
}
