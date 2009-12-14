package com.neosavvy.user.service;

import org.junit.Test;
import junit.framework.Assert;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 13, 2009
 * Time: 11:58:37 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestNumEmployeesRangeService extends BaseSpringAwareServiceTestCase{
    @Test
    public void testGetNumEmployeesRange() throws Exception{
        cleanDatabase();
        numEmployeesRangeDAO.saveRange(createTestRange());
        Assert.assertFalse(numEmployeesRangeService.getNumEmployeesRange().isEmpty());
    }
}
