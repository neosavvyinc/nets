package com.neosavvy.svn.dao.hsqldb;

import com.neosavvy.svn.dao.abst.AbstractTestOverallStatistics;
import org.springframework.test.context.ContextConfiguration;

@ContextConfiguration(locations = { "classpath:hsqldbDatasource.xml" })
public class TestHsqldbOverallStatistics extends AbstractTestOverallStatistics {
}