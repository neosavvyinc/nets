package com.neosavvy.junit4;

import org.apache.log4j.PropertyConfigurator;
import org.junit.Before;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

@ContextConfiguration(locations = {
		"classpath:baseApplicationContext.xml"
		,"classpath:oracleDataSource.xml"
		,"classpath:ibatisDataContext.xml"
		,"classpath:serviceContext.xml"
		,"classpath:svnRepositoryConfigurations.xml"
        })
public abstract class BaseSpringAwareTestCase extends AbstractJUnit4SpringContextTests {

    @Before
    public void setUp() {
    	PropertyConfigurator.configure(BaseSpringAwareTestCase.class.getClassLoader().getResource("log4j.test.properties"));
    }

}
