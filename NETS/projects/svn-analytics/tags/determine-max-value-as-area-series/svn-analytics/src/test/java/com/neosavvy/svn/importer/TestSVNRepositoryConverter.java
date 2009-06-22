package com.neosavvy.svn.importer;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.neosavvy.junit4.BaseSpringAwareTestCase;
import com.neosavvy.svn.analytics.importer.SVNRepositoryDatabaseConverter;

public class TestSVNRepositoryConverter extends BaseSpringAwareTestCase {

	@Autowired
    private SVNRepositoryDatabaseConverter converter;

	@Test
    public void testRun() {
        converter.run();
    }

}
