package com.neosavvy.svn.importer;

import org.junit.Before;
import org.junit.Test;

import com.neosavvy.junit4.BaseSpringAwareTestCase;
import com.neosavvy.svn.analytics.importer.SVNRepositoryDatabaseConverter;

public class TestSVNRepositoryConverter extends BaseSpringAwareTestCase {

    private SVNRepositoryDatabaseConverter converter;

    @Before
    public void setup() {
        super.setup();
        converter = (SVNRepositoryDatabaseConverter) getContext().getBean(
                "svnRepositoryConverter");
    }

    // @Test
    // public void testInitialize() {
    //
    // }
    //
    // @Test
    // public void testConvert() {
    //
    // }
    //
    // @Test
    // public void testTearDown() {
    //
    // }

    @Test
    public void testRun() {
        converter.run();
    }

}
