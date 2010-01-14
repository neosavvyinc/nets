package com.neosavvy.user.service;

import com.neosavvy.user.BaseSpringAwareTestCase;
import com.neosavvy.user.dto.companyManagement.RoleDTO;
import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.context.SecurityContextHolder;
import org.junit.Before;

/**
 * @author lgleason
 * todo: refactor this and the other base service out for common classes
 */
public abstract class BaseSpringAwareServiceTestCase extends BaseSpringAwareTestCase {

    @Autowired
    protected UserService userService;
    @Autowired
    protected CompanyService companyService;

    @Before
    public void loginTestUser() {
       SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken("admin", "admin"));
    }

}
