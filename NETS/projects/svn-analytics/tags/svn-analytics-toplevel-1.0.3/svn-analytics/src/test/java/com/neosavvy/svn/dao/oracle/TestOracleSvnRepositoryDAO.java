package com.neosavvy.svn.dao.oracle;

import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
import com.neosavvy.svn.analytics.service.SvnRepositoryService;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;

import com.neosavvy.svn.dao.abst.AbstractTestSvnRepositoryDAO;

@ContextConfiguration(locations = { "classpath:oracleDatasource.xml" })
public class TestOracleSvnRepositoryDAO extends AbstractTestSvnRepositoryDAO {

    @Test
    public void testGetDerivedRoot() {
        SVNRepositoryDTO dto = new SVNRepositoryDTO();
        dto.setName("Neosavvy");
        dto.setPassword("aparrish");
        dto.setUserName("aparrish");
        dto.setUrl("http://www.neosavvy.com/svn/projects/svn-analytics/");
        String s = dto.getRoot();
        Assert.assertEquals("/projects",s);
    }

    @Test
    public void testGetActualRoot() {
        SVNRepositoryDTO dto = new SVNRepositoryDTO();
        dto.setName("Neosavvy");
        dto.setPassword("aparrish");
        dto.setUserName("aparrish");
        dto.setUrl("http://www.neosavvy.com/svn/");
        String s = dto.getRoot();
        Assert.assertEquals(null,s);
    }

}
