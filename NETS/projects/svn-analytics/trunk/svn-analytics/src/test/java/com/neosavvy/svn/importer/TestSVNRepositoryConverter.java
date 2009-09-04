package com.neosavvy.svn.importer;

import org.apache.log4j.Logger;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;

import com.neosavvy.junit4.BaseSpringAwareTestCase;
import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
import com.neosavvy.svn.analytics.importer.SVNRepositoryDatabaseConverter;

@ContextConfiguration(locations = {
		"classpath:mysqlDatasource.xml"
        })
public class TestSVNRepositoryConverter extends BaseSpringAwareTestCase {

	private static final Logger logger = Logger
			.getLogger(TestSVNRepositoryConverter.class);

	@Autowired
	private SVNRepositoryDatabaseConverter converter;

	@Test
	@Ignore
	public void testRun() {
		converter.run();
	}
	
	@Test
	@Ignore
	public void testRefreshRequest() {
		SVNRepositoryDTO repository = new SVNRepositoryDTO();
		repository.setId(34);
		repository.setUrl("http://neosavvy.com/svn/neosavvy");
		repository.setUserName("aparrish");
		repository.setPassword("subw@y1");
		
		converter.requestRefresh(repository);
	}
	
	@Test
	@Ignore
	public void testRefreshRequest1() {
		SVNRepositoryDTO repository = new SVNRepositoryDTO();
		repository.setId(34);
		repository.setUrl("https://svn.roundarch.com/repos/USADS");
		repository.setUserName("aparrish");
		repository.setPassword("subw@y1");
		
		converter.requestRefresh(repository);
	}

}
