package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.ClientCompany;
import com.neosavvy.user.dto.project.Project;
import org.springframework.security.access.annotation.Secured;

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
 * Time: 4:13:36 PM
 */
public interface ProjectService {

    @Secured({"ROLE_ADMIN", "OBJECT_ACL_WRITE"})
    public void addProject(Project project, CompanyDTO company, ClientCompany clientCompany);

    @Secured({"ROLE_ADMIN", "AFTER_ACL_COLLECTION_READ"})
    public List<Project> findProjectsForParentCompany(CompanyDTO company);

    @Secured({"ROLE_ADMIN", "AFTER_ACL_COLLECTION_READ"})
    public List<UserDTO> findAvailableUsersForProject(Project project);

    @Secured({"ROLE_ADMIN", "AFTER_ACL_COLLECTION_READ"})
    public List<UserDTO> findAssignedUsersForProject(Project project);

    @Secured({"ROLE_ADMIN", "OBJECT_ACL_WRITE"})
    public void saveProjectAssignments(Project project, List<UserDTO> assignedUsers);

    @Secured({"ROLE_EMPLOYEE", "AFTER_ACL_COLLECTION_READ"})
    List<Project> findProjectsForUser(UserDTO user);
}
