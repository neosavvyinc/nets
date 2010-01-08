package com.neosavvy.user.dao.project;

import com.neosavvy.user.dao.base.BaseDAO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.ClientCompany;
import com.neosavvy.user.dto.project.Project;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;

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
        Criteria criteria = getCurrentSession().createCriteria(Project.class);
        if(project.getCode() != null && project.getCode().length() > 0 ) {
            criteria.add(Restrictions.eq("code", project.getCode()));
        }
        if(project.getName() != null && project.getName().length() > 0 ) {
            criteria.add(Restrictions.eq("name", project.getName()));
        }       
        return criteria.list();
    }

    public void delete(Project project) {
        getCurrentSession().delete(project);
        getCurrentSession().flush();
    }

    public Project findProjectById(int id) {
        return (Project) getCurrentSession()
                .createCriteria(Project.class)
                .add( Restrictions.idEq(id) )
                .uniqueResult();
    }

    public void save(Project project) {
        getCurrentSession().saveOrUpdate(project);
        getCurrentSession().flush();
    }

    public List<ClientCompany> findProjectsForParentCompany(Project exampleProject) {
        Query projectSearchQuery = getCurrentSession().createQuery("select project from Project project, CompanyDTO company" +
                " where project.client_company_fk = company.id and company.id = :companyId");
        projectSearchQuery.setLong("companyId",exampleProject.getCompany().getId());
        return projectSearchQuery.list();


    }
}
