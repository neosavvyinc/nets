package com.neosavvy.svn;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

public class SpringIntegrationTest extends AbstractDependencyInjectionSpringContextTests {
   
	@Override
	protected String[] getConfigLocations() {
		 return 
		 	new String[] { 
				"classpath:svnAnalyticsContext.xml",
		 		"classpath:svnRepositoryConfigurations.xml" };
	}

    @Test
    public void testSpringContextNotNull() {
    	if(applicationContext == null) {
    		Assert.fail("Application context failed to load");
    	}
    }

}
