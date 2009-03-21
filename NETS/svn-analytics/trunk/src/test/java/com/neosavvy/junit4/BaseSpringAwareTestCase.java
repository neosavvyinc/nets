package com.neosavvy.junit4;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.junit.After;
import org.junit.Before;

public class BaseSpringAwareTestCase {

    private static final Logger logger = Logger
            .getLogger(BaseSpringAwareTestCase.class);

    static {
        PropertyConfigurator
                .configure("target/test-classes/com/neosavvy/log4j.test.properties");
    }

    @Before
    public void setup() {

        logger.info("Setting up testcase");

    }

    @After
    public void tearDown() {

        logger.info("Tearing down testcase");

    }
}
