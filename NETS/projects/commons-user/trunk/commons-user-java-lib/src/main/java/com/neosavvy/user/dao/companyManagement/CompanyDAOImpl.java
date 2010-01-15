package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dao.base.BaseCompanyDAO;
import com.neosavvy.user.dao.base.BaseCompanyDAOImpl;
import com.neosavvy.user.dao.base.BaseDAO;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;

import java.util.List;


public class CompanyDAOImpl extends BaseCompanyDAOImpl<CompanyDTO> implements CompanyDAO {

    @Override
    protected Class<CompanyDTO> getTypeClass() {
        return CompanyDTO.class;
    }
}
