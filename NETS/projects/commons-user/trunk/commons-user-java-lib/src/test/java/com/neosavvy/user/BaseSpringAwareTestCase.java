package com.neosavvy.user;

import com.neosavvy.user.dao.companyManagement.*;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.RoleDTO;
import com.neosavvy.user.dto.companyManagement.UserCompanyRoleDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.transaction.TransactionConfiguration;

import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceContext;
import javax.sql.DataSource;

@ContextConfiguration(locations = {
        "classpath:testSecurityContext.xml"
        })
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

    @PersistenceContext
    protected EntityManager entityManager;

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

    protected void cleanupTables() {
        // not needed, the tests rollback and a separate schema is used
    }

    protected EntityManager getEntityManager() {
        return entityManager;
    }

}
