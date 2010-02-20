package com.neosavvy.user.service;

import com.neosavvy.security.AclSecurityUtil;
import com.neosavvy.security.RunAsExecutor;
import com.neosavvy.user.dao.companyManagement.UserDAO;
import com.neosavvy.user.dao.project.ProjectDAO;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.ClientCompany;
import com.neosavvy.user.dto.project.Project;
import com.neosavvy.user.service.exception.ProjectServiceException;
import org.springframework.security.acls.domain.BasePermission;
import org.springframework.security.acls.domain.PrincipalSid;
import org.springframework.security.acls.model.Sid;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
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
    private RunAsExecutor adminExecutor;
    private AclSecurityUtil aclSecurityUtil;


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

    public void saveProjectAssignments(Project project, final List<UserDTO> assignedUsers) {
        if (project == null) {
            throw new ProjectServiceException("Must supply a project to assign users to it");
        }

        final List<UserDTO> originalUsers = findAssignedUsersForProject(project);

        project.setParticipants(assignedUsers);
        final Project savedProject = projectDAO.save(project);

        // we have to add the company permissions here because the admin user role didn't exist
        // when we persisted the company
        adminExecutor.runAsAdmin(new Runnable() {
            public void run() {
                List<UserDTO> usersToRemove = new ArrayList<UserDTO>(originalUsers);
                List<UserDTO> usersToAdd = new ArrayList<UserDTO>(assignedUsers);

                for (UserDTO assignedUser : assignedUsers) {
                    for (UserDTO originalUser : originalUsers) {
                        if (originalUser.equals(assignedUsers)) {
                            usersToAdd.remove(assignedUser);
                            usersToRemove.remove(originalUser);
                        }
                    }
                }

                for (UserDTO user : usersToRemove) {
                    Sid sid = new PrincipalSid(user.getUsername());
                    aclSecurityUtil.deletePermission(savedProject, sid, BasePermission.READ, Project.class);
                }

                for (UserDTO user : usersToAdd) {
                    Sid sid = new PrincipalSid(user.getUsername());
                    aclSecurityUtil.addPermission(savedProject, sid, BasePermission.READ, Project.class);
                }
            }
        });
    }

    public List<Project> findProjectsForUser(UserDTO user) {
        List<UserDTO> users = userDAO.findUsers(user);
        if( users == null || users.size() == 0) {
            throw new ProjectServiceException("Could not find the user specified: " + user.toString());
        }
        if( users.size() > 1 ) {
            throw new ProjectServiceException("Found more than one user for the user specified: " + user.toString());
        }

        UserDTO attachedUser = users.get(0);
        userDAO.refreshUser(attachedUser);
        List<Project> projects = attachedUser.getParticipantOfProjects();
        return projects;
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

    public RunAsExecutor getAdminExecutor() {
        return adminExecutor;
    }

    public void setAdminExecutor(RunAsExecutor adminExecutor) {
        this.adminExecutor = adminExecutor;
    }

    public AclSecurityUtil getAclSecurityUtil() {
        return aclSecurityUtil;
    }

    public void setAclSecurityUtil(AclSecurityUtil aclSecurityUtil) {
        this.aclSecurityUtil = aclSecurityUtil;
    }
}
