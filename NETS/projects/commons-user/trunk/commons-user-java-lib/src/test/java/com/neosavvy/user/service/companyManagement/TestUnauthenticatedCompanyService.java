package com.neosavvy.user.service.companyManagement;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserCompanyRoleDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.service.MailServiceImpl;
import com.neosavvy.user.service.exception.CompanyServiceException;
import com.neosavvy.user.util.ProjectTestUtil;
import junit.framework.Assert;
import org.easymock.EasyMock;
import org.junit.Before;
import org.junit.Test;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;

/**
 * Created by IntelliJ IDEA.
 * User: tommyodom
 * Date: Jan 19, 2010
 * Time: 7:05:20 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestUnauthenticatedCompanyService extends TestCompanyService {
    @Before
    public void initializeUnauthenticatedTest() {

    }

    @Test
    public void testAddCompany() {
        CompanyDTO testCompany = ProjectTestUtil.createTestCompany();
        UserDTO testUser = ProjectTestUtil.createAdminUser();

        MailSender mailSender = EasyMock.createMock(MailSender.class);
        mailSender.send((SimpleMailMessage) EasyMock.anyObject());
        EasyMock.replay(mailSender);
        MailSender originalSender = ((MailServiceImpl)getCompanyServiceImpl().getMailService()).getMailSender();
        ((MailServiceImpl)getCompanyServiceImpl().getMailService()).setMailSender(mailSender);
        
        try {
            companyService.addCompany(testCompany, testUser);
            int numUserCompanyRoles = countRowsInTable("USER_COMPANY_ROLE");
            Assert.assertEquals("a row was added to the USER_COMPANY_ROLE table",
                    1,
                    numUserCompanyRoles);

            loginAsUser(testUser);
            CompanyDTO foundCompany = companyService.findCompanyById(testCompany.getId());
            UserCompanyRoleDTO foundUserCompanyRole = (UserCompanyRoleDTO) foundCompany.getUserCompanyRoles().toArray()[0];
            Assert.assertEquals("role for found company is the same as what we saved",
                    adminRole.getId(),
                    foundUserCompanyRole.getRole().getId());
            Assert.assertEquals("user for found company is the same as what we saved",
                    testUser.getId(),
                    foundUserCompanyRole.getUser().getId());
        }
        finally {
            ((MailServiceImpl)getCompanyServiceImpl().getMailService()).setMailSender(originalSender);
        }
    }


    @Test(expected = CompanyServiceException.class)
    public void testAddCompanyMissingAdminRole() {
        cleanupTables();
        //this expects to throw an exception
        CompanyDTO testCompany = ProjectTestUtil.createAltTestCompany();
        UserDTO testUser = ProjectTestUtil.createTestUser();

        companyService.addCompany(testCompany, testUser);
    }
}
