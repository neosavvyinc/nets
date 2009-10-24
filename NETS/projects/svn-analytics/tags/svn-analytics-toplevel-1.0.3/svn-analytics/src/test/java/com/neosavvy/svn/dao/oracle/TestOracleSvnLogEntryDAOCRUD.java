package com.neosavvy.svn.dao.oracle;

import org.springframework.test.context.ContextConfiguration;

import com.neosavvy.svn.dao.abst.AbstractTestSvnLogEntryDAOCRUD;

@ContextConfiguration(locations = { "classpath:oracleDatasource.xml" })
public class TestOracleSvnLogEntryDAOCRUD extends
		AbstractTestSvnLogEntryDAOCRUD {
}
