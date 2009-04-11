package com.neosavvy.junit4;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.junit.After;
import org.junit.Before;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.neosavvy.svn.dao.TestSvnLogEntryDAO;

public class BaseSpringAwareTestCase {

    private static final Logger logger = Logger
            .getLogger(BaseSpringAwareTestCase.class);

    private static ApplicationContext context;

    @Before
    public void setup() {

    	PropertyConfigurator.configure(BaseSpringAwareTestCase.class.getClassLoader().getResource("log4j.test.properties"));
    	
        logger.info("Setting up testcase");

        AbstractApplicationContext ctx = new ClassPathXmlApplicationContext(
                new String[] { "svnAnalyticsContext.xml",
                        "svnRepositoryConfigurations.xml" });
        ctx.registerShutdownHook();
        context = ctx;

    }

    protected ApplicationContext getContext() {
        return context;
    }

    @After
    public void tearDown() {

        logger.info("Tearing down testcase");

    }
}
