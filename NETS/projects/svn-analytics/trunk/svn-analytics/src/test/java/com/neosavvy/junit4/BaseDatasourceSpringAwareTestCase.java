package com.neosavvy.junit4;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.springframework.test.AbstractTransactionalSpringContextTests;

public class BaseDatasourceSpringAwareTestCase extends
		AbstractTransactionalSpringContextTests {

	private static final Logger logger = Logger
			.getLogger(BaseDatasourceSpringAwareTestCase.class);

	@Override
	protected String[] getConfigLocations() {
		return new String[] { "classpath:svnAnalyticsContext.xml",
				"classpath:svnRepositoryConfigurations.xml" };
	}

	@Override
	protected void onSetUp() {
		PropertyConfigurator.configure(BaseSpringAwareTestCase.class
				.getClassLoader().getResource("log4j.test.properties"));
		logger.info("Setting up testcase");
	}
}
