package com.neosavvy.user.service;

import com.neosavvy.user.dto.CompanyDTO;
import com.neosavvy.user.dao.CompanyDAO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 4, 2009
 * Time: 4:18:34 PM
 * To change this template use File | Settings | File Templates.
 */
public class CompanyServiceImpl implements CompanyService{
    private CompanyDAO companyDao;

    public List<CompanyDTO> getCompanies() {
        return companyDao.getCompanies();
    }

    public void saveCompany(CompanyDTO company) {
        companyDao.saveCompany(company);
    }

    public CompanyDTO findCompanyById(int id) {
        return companyDao.findCompanyById(id);
    }

    public List<CompanyDTO> findCompanies(CompanyDTO company) {
        return companyDao.findCompanies(company);
    }

    public void setCompanyDao(CompanyDAO companyDao) {
        this.companyDao = companyDao;
    }

    public CompanyDAO getCompanyDao(){
        return companyDao;
    }
}
