package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dao.base.BaseUserDAOImpl;
import com.neosavvy.user.dto.base.BaseUserDTO;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserCompanyRoleDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.Project;
import fineline.focal.common.types.v1.StorageServiceFileRef;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl extends BaseUserDAOImpl<UserDTO> implements UserDAO {

    public List<UserDTO> findUsersForCompany(CompanyDTO company, UserDTO user) {

        StringBuilder queryString = new StringBuilder("select user from UserDTO user, UserCompanyRoleDTO ucl, CompanyDTO company " +
                "where user = ucl.user and ucl.company = company " +
                "and company.id = :companyId");
        if( user != null ) {
            queryString.append(" and user.active = :userActive");
        }

        Query userQuery = getEntityManager().createQuery(queryString.toString());
        userQuery.setParameter("companyId",company.getId());

        if( user != null) {
            userQuery.setParameter("userActive", user.getActive());
        }

        List resultList = userQuery.getResultList();
        return resultList;
    }

    public List<UserDTO> findAvailableUsersForProject(Project project) {
        Query userQuery = getEntityManager().createQuery("select user from UserDTO user, UserCompanyRoleDTO ucl, Project project " +
                "where user = ucl.user and ucl.company = project.company and user not member of project.participants " +
                "and project.id = :projectId");
        userQuery.setParameter("projectId",project.getId());
        List resultList = userQuery.getResultList();
        return resultList;
    }

    @Override
    protected void addSearchPredicates(UserDTO user, CriteriaBuilder builder, Root<UserDTO> root, List<Predicate> searchPredicates) {
        super.addSearchPredicates(user, builder, root, searchPredicates);
        
        if(user.getUsername() != null && user.getUsername().length() > 0) {
            searchPredicates.add(builder.equal(root.get("username"), user.getUsername()));
        }
        if(user.getPassword() != null && user.getPassword().length() > 0) {
            searchPredicates.add(builder.equal(root.get("password"), user.getPassword()));
        }
    }

    @Override
    protected Class<UserDTO> getTypeClass() {
        return UserDTO.class;
    }

    public String findMostCurrentSessionIdForUser(String username)
    {
        Query nativeQuery = getEntityManager().createNativeQuery(
                "select id from user_sessions " +
                        "where username = ?  " +
                        "and date(creation_date) = current_date " +
                        "order by creation_date desc limit 1");
        nativeQuery.setParameter(1, username);
        String result = (String)nativeQuery.getSingleResult();
        return result;
    }
}
