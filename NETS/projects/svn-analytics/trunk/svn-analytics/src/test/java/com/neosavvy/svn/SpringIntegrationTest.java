package com.neosavvy.svn;

import org.junit.Assert;
import org.junit.Test;

import com.neosavvy.junit4.BaseSpringAwareTestCase;

public class SpringIntegrationTest extends BaseSpringAwareTestCase {

    @Test
    public void testSpringContextNotNull() {
    	if(applicationContext == null) {
    		Assert.fail("Application context failed to load");
    	}
    }

}