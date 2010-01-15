package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dao.base.BaseDAO;
import com.neosavvy.user.dto.companyManagement.RoleDTO;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;


public class RoleDAOImpl extends BaseDAO implements RoleDAO{
    public RoleDTO saveRole(RoleDTO role) {
        if (role.getId() == null) {
            getEntityManager().persist(role);
        }
        else {
            role = getEntityManager().merge(role);
        }
        getEntityManager().flush();

        return role;
    }

    public RoleDTO findRoleById(long id) {
        return getEntityManager().find(RoleDTO.class, id);
    }

    public List<RoleDTO> findRoles(RoleDTO role) {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery<RoleDTO> criteria = builder.createQuery(RoleDTO.class);
        Root<RoleDTO> root = criteria.from(RoleDTO.class);
        List<Predicate> searchPredicates = new ArrayList<Predicate>();

        if(role.getShortName() != null && role.getShortName().length() > 0) {
            searchPredicates.add(builder.equal(root.get("shortName"), role.getShortName()));
        }
        if(role.getLongName() != null && role.getLongName().length() > 0) {
            searchPredicates.add(builder.equal(root.get("longName"), role.getLongName()));
        }
        return getEntityManager().createQuery(criteria.where(searchPredicates.toArray(new Predicate[0]))).getResultList();
    }

    public void deleteRole(RoleDTO role) {
        getEntityManager().remove(role);
        getEntityManager().flush();
    }
}
