package com.neosavvy.junit4;

import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Before;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class BaseSpringAwareTestCase {

    private static final Logger logger = Logger
            .getLogger(BaseSpringAwareTestCase.class);

    private static ApplicationContext context;

    // static {
    // PropertyConfigurator
    // .configure("target/test-classes/log4j.test.properties");
    // }

    @Before
    public void setup() {

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
