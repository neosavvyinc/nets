package com.neosavvy.user.dao.project;

import com.neosavvy.user.dao.base.BaseDAO;
import com.neosavvy.user.dto.companyManagement.UserCompanyRoleDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.ClientCompany;
import com.neosavvy.user.dto.project.Project;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;
/*************************************************************************
 *
 * NEOSAVVY CONFIDENTIAL
 * __________________
 *
 *  Copyright 2008 - 2009 Neosavvy Incorporated
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Neosavvy Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Neosavvy Incorporated
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Neosavvy Incorporated.
 **************************************************************************/

/**
 * User: adamparrish
 * Date: Jan 7, 2010
 * Time: 2:56:32 PM
 */
public class ProjectDAOImpl extends BaseDAO implements ProjectDAO {

    public List<Project> findProject(Project project) {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery<Project> criteria = builder.createQuery(Project.class);
        Root<Project> root = criteria.from(Project.class);
        List<Predicate> searchPredicates = new ArrayList<Predicate>();

        if(project.getCode() != null && project.getCode().length() > 0 ) {
            searchPredicates.add(builder.equal(root.get("code"), project.getCode()));
        }
        if(project.getName() != null && project.getName().length() > 0 ) {
            searchPredicates.add(builder.equal(root.get("name"), project.getName()));
        }
        if((project.getCompany() != null) && (project.getCompany().getId() != null)) {
            searchPredicates.add(builder.equal(root.get("company"), project.getCompany()));
        }

        return getEntityManager().createQuery(criteria.where(searchPredicates.toArray(new Predicate[0]))).getResultList();
    }

    public void delete(Project project) {
        getEntityManager().remove(project);
        getEntityManager().flush();
    }

    public Project findProjectById(long id) {
        return getEntityManager().find(Project.class, id);
    }

    public Project save(Project project) {
        if (project.getId() == null) {
            getEntityManager().persist(project);
        }
        else {
            project = getEntityManager().merge(project);
        }

        getEntityManager().flush();
        return project;
    }

    public List<Project> findProjectsForParentCompany(long parentCompanyId) {
        Query projectSearchQuery = getEntityManager().createQuery("select project from Project project, CompanyDTO company" +
                " where project.company.id = company.id and company.id = :companyId");
        projectSearchQuery.setParameter("companyId", parentCompanyId);
        return projectSearchQuery.getResultList();


    }
}
