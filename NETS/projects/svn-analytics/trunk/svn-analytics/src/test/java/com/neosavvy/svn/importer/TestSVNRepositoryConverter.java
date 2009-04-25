package com.neosavvy.svn.importer;

import org.junit.Test;

import com.neosavvy.junit4.BaseSpringAwareTestCase;
import com.neosavvy.svn.analytics.importer.SVNRepositoryDatabaseConverter;

public class TestSVNRepositoryConverter extends BaseSpringAwareTestCase {

    private SVNRepositoryDatabaseConverter converter;

    @Override
    public void onSetUp() {
        super.onSetUp();
        converter = (SVNRepositoryDatabaseConverter) applicationContext.getBean(
                "svnRepositoryConverter");
    }

    @Test
    public void testRun() {
        converter.run();
    }

}
