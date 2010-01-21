package com.neosavvy.user.service;

import com.neosavvy.user.BaseSpringAwareTestCase;
import com.neosavvy.user.dto.companyManagement.RoleDTO;
import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.context.SecurityContextHolder;
import org.junit.Before;

public abstract class BaseSpringAwareServiceTestCase extends BaseSpringAwareTestCase {

    @Autowired
    protected UserService userService;
    @Autowired
    protected CompanyService companyService;
    @Autowired
    protected MailService mailService;    

    @Before
    public void loginTestUser() {
       SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken("admin", "admin"));
    }

}
