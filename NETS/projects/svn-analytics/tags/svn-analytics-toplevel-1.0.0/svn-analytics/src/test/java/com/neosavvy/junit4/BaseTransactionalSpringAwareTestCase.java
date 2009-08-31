package com.neosavvy.junit4;

import org.junit.Before;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;


@ContextConfiguration(locations = {
		"classpath:baseApplicationContext.xml"
		,"classpath:ibatisDataContext.xml"
		,"classpath:serviceContext.xml"
		,"classpath:svnRepositoryConfigurations.xml"
        })
public abstract class BaseTransactionalSpringAwareTestCase extends AbstractTransactionalJUnit4SpringContextTests {

	@Before
	public void setUp() {
		logger.info("Setting up testcase");
	}
}
