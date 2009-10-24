package com.neosavvy.svn.dao.hsqldb;

import com.neosavvy.svn.dao.abst.AbstractTestSvnRepositoryDAO;
import org.springframework.test.context.ContextConfiguration;

@ContextConfiguration(locations = { "classpath:hsqldbDatasource.xml" })
public class TestHsqldbSvnRepositoryDAO extends AbstractTestSvnRepositoryDAO {
}