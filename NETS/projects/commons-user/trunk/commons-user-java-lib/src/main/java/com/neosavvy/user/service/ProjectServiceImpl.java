package com.neosavvy.user.service;

import com.neosavvy.user.dao.companyManagement.UserDAO;
import com.neosavvy.user.dao.project.ProjectDAO;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.ClientCompany;
import com.neosavvy.user.dto.project.Project;
import com.neosavvy.user.service.exception.ProjectServiceException;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
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
 * Time: 4:14:44 PM
 */
@Transactional
public class ProjectServiceImpl implements ProjectService {

    private ProjectDAO projectDAO;

    private UserDAO userDAO;


    public void addProject(Project project, CompanyDTO company, ClientCompany clientCompany) {
        if (project == null) {
            throw new ProjectServiceException("Cannot create a null project");
        }
        if (company == null) {
            throw new ProjectServiceException("Cannot create a project without a company to own it");
        }
        if (clientCompany == null) {
            throw new ProjectServiceException("Cannot create a project without a client to send invoices to");
        }

        project.setCompany(company);
        project.setClient(clientCompany);
        projectDAO.save(project);
    }

    public List<Project> findProjectsForParentCompany(CompanyDTO company) {
        if (company == null) {
            throw new ProjectServiceException("Cannot find projects without a parent company");
        }
        Project project = new Project();
        project.setCompany(company);
        return projectDAO.findProject(project);
    }

    public List<UserDTO> findAssignedUsersForProject(Project project) {
        if (project == null) {
            throw new ProjectServiceException("Must supply a project to find users who are assigned to it");
        }

        Project attachedProject = projectDAO.findProjectById(project.getId());

        if (attachedProject == null) {
            throw new ProjectServiceException("The project supplied did not yet exist in the database");
        }

        return attachedProject.getParticipants();
    }

    public List<UserDTO> findAvailableUsersForProject(Project project) {
        if (project == null) {
            throw new ProjectServiceException("Must supply a project to find users who are assigned to it");
        }

        Project attachedProject = projectDAO.findProjectById(project.getId());

        if (attachedProject == null) {
            throw new ProjectServiceException("The project supplied did not yet exist in the database");
        }

        return userDAO.findAvailableUsersForProject(attachedProject);
    }

    public void saveProjectAssignments(Project project, List<UserDTO> assignedUsers) {
        if (project == null) {
            throw new ProjectServiceException("Must supply a project to assign users to it");
        }

        project.setParticipants(assignedUsers);
        projectDAO.save(project);
    }

    public ProjectDAO getProjectDAO() {
        return projectDAO;
    }

    public void setProjectDAO(ProjectDAO projectDAO) {
        this.projectDAO = projectDAO;
    }

    public UserDAO getUserDAO() {
        return userDAO;
    }

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

}
