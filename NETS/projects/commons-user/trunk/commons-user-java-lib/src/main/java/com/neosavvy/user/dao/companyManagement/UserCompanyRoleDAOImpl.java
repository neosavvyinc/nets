package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dao.base.BaseDAO;
import com.neosavvy.user.dto.companyManagement.RoleDTO;
import com.neosavvy.user.dto.companyManagement.UserCompanyRoleDTO;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;


public class UserCompanyRoleDAOImpl extends BaseDAO implements UserCompanyRoleDAO{
    public UserCompanyRoleDTO saveUserCompanyRole(UserCompanyRoleDTO userCompanyRole) {
        if (userCompanyRole.getId() == null) {
            getEntityManager().persist(userCompanyRole);
        }
        else {
            userCompanyRole = getEntityManager().merge(userCompanyRole);
        }
        getEntityManager().flush();
        return userCompanyRole;
    }

    public UserCompanyRoleDTO findUserCompanyRoleById(long id) {
        return getEntityManager().find(UserCompanyRoleDTO.class, id);
    }

    public void deleteUserCompanyRole(UserCompanyRoleDTO userCompanyRole) {
        getEntityManager().remove(userCompanyRole);
        getEntityManager().flush();
    }

    public List<UserCompanyRoleDTO> findUserCompanyRoles(UserCompanyRoleDTO userCompanyRole) {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery<UserCompanyRoleDTO> criteria = builder.createQuery(UserCompanyRoleDTO.class);
        Root<UserCompanyRoleDTO> root = criteria.from(UserCompanyRoleDTO.class);
        List<Predicate> searchPredicates = new ArrayList<Predicate>();

        if((userCompanyRole.getRole() != null)){
            searchPredicates.add(builder.equal(root.get("role"), userCompanyRole.getRole()));
        }

        if((userCompanyRole.getUser() != null)){
            searchPredicates.add(builder.equal(root.get("user"), userCompanyRole.getUser()));
        }


        if((userCompanyRole.getCompany() != null)){
            searchPredicates.add(builder.equal(root.get("company"), userCompanyRole.getCompany()));
        }


        return getEntityManager().createQuery(criteria.where(searchPredicates.toArray(new Predicate[0]))).getResultList();
    }
}
