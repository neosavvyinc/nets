package com.neosavvy.user;

import com.neosavvy.user.dao.companyManagement.*;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.RoleDTO;
import com.neosavvy.user.dto.companyManagement.UserCompanyRoleDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 29, 2009
 * Time: 4:45:35 PM
 */
public abstract class BaseSpringAwareTestCase extends AbstractTransactionalJUnit4SpringContextTests {
    @Autowired
    protected CompanyDAO companyDAO;
    @Autowired
    protected UserDAO userDAO;
    @Autowired
    protected RoleDAO roleDAO;
    @Autowired
    protected UserInviteDAO userInviteDAO;
    @Autowired
    protected UserCompanyRoleDAO userCompanyRoleDAO;

    protected UserCompanyRoleDTO createTestUserCompanyRole(RoleDTO role, CompanyDTO company, UserDTO user){
        UserCompanyRoleDTO testUserCompanyRole = new UserCompanyRoleDTO();
        if(role != null)
            testUserCompanyRole.setRole(role);
        if(company != null)
            testUserCompanyRole.setCompany(company);
        if(user != null)
            testUserCompanyRole.setUser(user);


        return testUserCompanyRole;
    }
}
