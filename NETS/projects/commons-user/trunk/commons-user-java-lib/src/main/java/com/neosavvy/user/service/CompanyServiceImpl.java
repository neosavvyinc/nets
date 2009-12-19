package com.neosavvy.user.service;

import com.neosavvy.user.dao.*;
import com.neosavvy.user.dto.CompanyDTO;
import com.neosavvy.user.dto.UserDTO;
import com.neosavvy.user.dto.RoleDTO;
import com.neosavvy.user.dto.UserCompanyRoleDTO;
import com.neosavvy.user.service.exception.CompanyServiceException;

import java.util.List;
import java.util.HashSet;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 4, 2009
 * Time: 4:18:34 PM
 * To change this template use File | Settings | File Templates.
 */
public class CompanyServiceImpl implements CompanyService{
    private CompanyDAO companyDao;
    private UserCompanyRoleDAO userCompanyRoleDao;
    private RoleDAO roleDao;
    private UserDAO userDao;
    private NumEmployeesRangeDAO numEmployeesRangeDao;

    public List<CompanyDTO> getCompanies() {
        return companyDao.getCompanies();
    }

    public CompanyDTO saveCompany(CompanyDTO company) {
        if( company.getNumEmployeesRange() != null )
            numEmployeesRangeDao.saveRange(company.getNumEmployeesRange());

        return companyDao.saveCompany(company);
    }

    public CompanyDTO findCompanyById(int id) {
        return companyDao.findCompanyById(id);
    }

    public List<CompanyDTO> findCompanies(CompanyDTO company) {
        return companyDao.findCompanies(company);
    }

    public void addCompany(CompanyDTO company, UserDTO user) {
        userDao.saveUser(user);
        saveCompany(company);
        // At some point we should look at getting rid of this hard coding.
        RoleDTO roleToFind = new RoleDTO();
        roleToFind.setShortName("ROLE_ADMIN");
        List<RoleDTO> adminRoles = roleDao.findRoles(roleToFind);
        if((adminRoles.size() > 1) || (adminRoles.size() < 1)){
          throw new CompanyServiceException("invalid number of ROLE_ADIMS found " + adminRoles.size(), null);    
        }
        UserCompanyRoleDTO userCompanyRole = new UserCompanyRoleDTO();
        userCompanyRole.setRole(adminRoles.get(0));
        userCompanyRole.setUser(user);
        userCompanyRole.setCompany(company);
        userCompanyRoleDao.saveUserCompanyRole(userCompanyRole);
        HashSet<UserCompanyRoleDTO> userCompanyRoles = new HashSet<UserCompanyRoleDTO>();
        userCompanyRoles.add(userCompanyRole);
        company.setUserCompanyRoles(userCompanyRoles);
        companyDao.saveCompany(company);
    }

    public void setCompanyDao(CompanyDAO companyDao) {
        this.companyDao = companyDao;
    }

    public CompanyDAO getCompanyDao(){
        return companyDao;
    }

    public UserCompanyRoleDAO getUserCompanyRoleDao() {
        return userCompanyRoleDao;
    }

    public void setUserCompanyRoleDao(UserCompanyRoleDAO userCompanyRoleDao) {
        this.userCompanyRoleDao = userCompanyRoleDao;
    }

    public RoleDAO getRoleDao() {
        return roleDao;
    }

    public void setRoleDao(RoleDAO roleDao) {
        this.roleDao = roleDao;
    }

    public UserDAO getUserDao() {
        return userDao;
    }

    public void setUserDao(UserDAO userDao) {
        this.userDao = userDao;
    }

    public NumEmployeesRangeDAO getNumEmployeesRangeDao() {
        return numEmployeesRangeDao;
    }

    public void setNumEmployeesRangeDao(NumEmployeesRangeDAO numEmployeesRangeDao) {
        this.numEmployeesRangeDao = numEmployeesRangeDao;
    }
}
