package com.neosavvy.svn;

import junit.framework.Assert;

import org.junit.Before;
import org.junit.Test;

import com.neosavvy.junit4.BaseSpringAwareTestCase;

public class SpringIntegrationTest extends BaseSpringAwareTestCase {

    @Before
    public void setup() {
        super.setup();
    }

    @Test
    public void testSpringContextNotNull() {
        if (getContext() == null) {
            Assert.fail("Spring context is not valid, must be misconfigured");
        }
    }

}
