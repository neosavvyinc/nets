package com.neosavvy.user.service;

import org.springframework.security.annotation.Secured;

import java.util.List;

import com.neosavvy.user.dto.CompanyDTO;
import com.neosavvy.user.dto.UserDTO;
import com.neosavvy.user.dao.CompanyDAO;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 4, 2009
 * Time: 4:15:26 PM
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public interface CompanyService {
    @Secured("ROLE_ADMIN")
	public List<CompanyDTO> getCompanies();

	public void saveCompany(CompanyDTO company);

    public void addCompany(CompanyDTO company, UserDTO user);

    @Secured("ROLE_ADMIN")
	public CompanyDTO findCompanyById(int id);

    @Secured("ROLE_ADMIN")
	public List<CompanyDTO> findCompanies(CompanyDTO company);
    
}
