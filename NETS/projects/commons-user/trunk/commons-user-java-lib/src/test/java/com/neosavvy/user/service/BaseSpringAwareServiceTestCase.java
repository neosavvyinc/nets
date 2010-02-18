package com.neosavvy.user.service;

import com.neosavvy.user.BaseSpringAwareTestCase;
import com.neosavvy.user.dao.companyManagement.CompanyDAO;
import com.neosavvy.user.dao.companyManagement.RoleDAO;
import com.neosavvy.user.dao.companyManagement.UserCompanyRoleDAO;
import com.neosavvy.user.dao.companyManagement.UserDAO;
import com.neosavvy.user.dto.companyManagement.*;
import com.neosavvy.user.util.ProjectTestUtil;
import org.easymock.EasyMock;
import org.springframework.aop.framework.Advised;
import org.springframework.mail.MailSender;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.context.SecurityContextHolder;
import org.junit.Before;

import java.util.List;

public abstract class BaseSpringAwareServiceTestCase extends BaseSpringAwareTestCase {

    @Autowired
    protected UserService userService;
    @Autowired
    protected CompanyService companyService;
    @Autowired
    protected UserDAO userDAO;
    @Autowired
    protected RoleDAO roleDAO;
    @Autowired
    protected CompanyDAO companyDAO;
    @Autowired
    protected UserCompanyRoleDAO userCompanyRoleDAO;
    @Autowired
    protected MailService mailService;    

    protected CompanyDTO adminCompany;
    protected CompanyDTO admin2Company;
    protected RoleDTO adminRole;
    protected RoleDTO employeeRole;

    @Before
    public void setup() {
        MailSender mockMailSender = EasyMock.createMock(MailSender.class);
        getMailServiceImpl().setMailSender(mockMailSender);

        adminRole = findOrCreateRole(ProjectTestUtil.createAdminTestRole());
        employeeRole = findOrCreateRole(ProjectTestUtil.createEmployeeTestRole());
    }

    public UserDTO setupAsAdminUser() {
        adminCompany = findOrCreateCompany(ProjectTestUtil.createTestCompany());
        UserDTO adminUser = ProjectTestUtil.createAdminUser();
        companyService.addCompany(adminCompany, adminUser);
        loginAsUser(adminUser);
        return adminUser;
    }

    public UserDTO setupAsAdmin2User() {
        admin2Company = findOrCreateCompany(ProjectTestUtil.createAltTestCompany());
        UserDTO admin2User = ProjectTestUtil.createAdmin2User();
        companyService.addCompany(admin2Company, admin2User);
        loginAsUser(admin2User);
        return admin2User;
    }

    public UserDTO setupAsEmployeeUser() {
        adminCompany = findOrCreateCompany(ProjectTestUtil.createTestCompany());
        return loginTestEmployee1();
    }

    protected void loginAsUser(UserDTO user) {
        SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword()));
    }

    public void clearAuthentication() {
        SecurityContextHolder.getContext().setAuthentication(null);
    }

    public UserDTO loginTestEmployee1() {
        UserDTO empUser = findOrCreateUser(ProjectTestUtil.createEmployee1User(), adminCompany, ProjectTestUtil.createEmployeeTestRole());
        loginAsUser(empUser);
        return empUser;
    }

    public void loginTestEmployee2() {
        UserDTO empUser = findOrCreateUser(ProjectTestUtil.createEmployee1User(), adminCompany, ProjectTestUtil.createEmployeeTestRole());
        loginAsUser(empUser);
    }

    protected CompanyServiceImpl getCompanyServiceImpl() {
        Advised advised = (Advised)companyService;
        try {
            return (CompanyServiceImpl)advised.getTargetSource().getTarget();
        }
        catch (Exception e) {
            throw new RuntimeException("Failed to cast to company service impl", e);
        }
    }

    protected MailServiceImpl getMailServiceImpl() {
        return (MailServiceImpl)mailService;
    }

    protected UserDTO findOrCreateUser(UserDTO user, CompanyDTO company, RoleDTO role) {
        List<UserDTO> users = userDAO.findUsers(user);
        if (!users.isEmpty()) {
            return users.get(0);
        }
        else {
            role = findOrCreateRole(role);
            company = findOrCreateCompany(company);
            user = userDAO.saveUser(user);
            UserCompanyRoleDTO userCompanyRole = new UserCompanyRoleDTO();
            userCompanyRole.setRole(role);
            userCompanyRole.setUser(user);
            userCompanyRole.setCompany(company);
            userCompanyRoleDAO.saveUserCompanyRole(userCompanyRole);

            return user;
        }
    }

    protected CompanyDTO findOrCreateCompany(CompanyDTO company) {
        List<CompanyDTO> companies = companyDAO.findCompanies(company);

        if (!companies.isEmpty()) {
            return companies.get(0);
        }
        else {
            return companyDAO.saveCompany(company);
        }
    }

    protected RoleDTO findOrCreateRole(RoleDTO role) {
        List<RoleDTO> roles = roleDAO.findRoles(role);

        if (!roles.isEmpty()) {
            return roles.get(0);
        }
        else {
            return roleDAO.saveRole(role);
        }
    }

}
