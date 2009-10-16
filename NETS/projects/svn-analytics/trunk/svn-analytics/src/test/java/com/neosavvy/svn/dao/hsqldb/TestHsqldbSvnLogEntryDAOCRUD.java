package com.neosavvy.svn.dao.hsqldb;

import com.neosavvy.svn.dao.abst.AbstractTestSvnLogEntryDAOCRUD;
import org.springframework.test.context.ContextConfiguration;

@ContextConfiguration(locations = { "classpath:hsqldbDatasource.xml" })
public class TestHsqldbSvnLogEntryDAOCRUD extends
		AbstractTestSvnLogEntryDAOCRUD {
}