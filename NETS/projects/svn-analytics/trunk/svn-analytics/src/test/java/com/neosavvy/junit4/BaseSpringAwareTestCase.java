package com.neosavvy.junit4;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

public class BaseSpringAwareTestCase extends AbstractDependencyInjectionSpringContextTests {

    private static final Logger logger = Logger
            .getLogger(BaseSpringAwareTestCase.class);


    @Override
	protected String[] getConfigLocations() {
		 return 
		 	new String[] { 
				"classpath:svnAnalyticsContext.xml",
		 		"classpath:svnRepositoryConfigurations.xml" };
	}
    
    @Override
    protected void onSetUp() {
    	PropertyConfigurator.configure(BaseSpringAwareTestCase.class.getClassLoader().getResource("log4j.test.properties"));
        logger.info("Setting up testcase");
    }

}
