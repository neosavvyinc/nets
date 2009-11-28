package com.neosavvy.user;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

@ContextConfiguration(locations = {
		"classpath:applicationContext.xml"
        })
public abstract class BaseSpringAwareTestCase extends AbstractTransactionalJUnit4SpringContextTests {

}
