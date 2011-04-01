package com.neosavvy.user.service.companyManagement;

import com.neosavvy.user.dto.companyManagement.*;
import com.neosavvy.user.service.BaseSpringAwareServiceTestCase;
import com.neosavvy.user.service.exception.CompanyServiceException;
import com.neosavvy.user.util.ProjectTestUtil;
import junit.framework.Assert;
import org.junit.Test;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;


public abstract class TestCompanyService extends BaseSpringAwareServiceTestCase {

    protected int getUserId(String username) {
        return simpleJdbcTemplate.queryForInt("SELECT ID FROM USERS WHERE USERNAME = ?",new Object[]{username});
    }

    protected int getRoleId(String shortName) {
        return simpleJdbcTemplate.queryForInt("SELECT ID FROM ROLE WHERE SHORT_NAME = ?", new Object[]{shortName});
    }

    protected int getCompanyId(String companyName) {
        return simpleJdbcTemplate.queryForInt("SELECT ID FROM COMPANY WHERE COMPANY_NAME = ?", new Object[]{companyName});
    }


    protected List<CompanyDTO> findCompanies() {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery query = builder.createQuery(CompanyDTO.class);
        query.from(CompanyDTO.class);
        return getEntityManager().createQuery(query).getResultList();
    }

}
