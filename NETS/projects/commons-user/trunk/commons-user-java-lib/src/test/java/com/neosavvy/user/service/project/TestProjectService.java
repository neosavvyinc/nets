package com.neosavvy.user.service.project;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.ClientCompany;
import com.neosavvy.user.dto.project.Project;
import com.neosavvy.user.util.ProjectTestUtil;
import junit.framework.Assert;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Date;
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
 * Date: Jan 26, 2010
 * Time: 9:46:30 PM
 */
public class TestProjectService extends BaseProjectManagementServiceTest {


    private Project project;

    @Before
    public void setupCommonData() {
        setupAsAdminUser();
        // add a company so that the parent relationship can be established
        CompanyDTO testCompany = saveTestCompanyForParent();


        UserDTO user1 = ProjectTestUtil.createAltTestUser();
        UserDTO user2 = ProjectTestUtil.createAltTestUser2();
        UserDTO user3 = ProjectTestUtil.createAltTestUser3();

        addUserToCompany(testCompany, user1);
        addUserToCompany(testCompany, user2);
        addUserToCompany(testCompany, user3);

        List<ClientCompany> clientCompanies = clientService.findClientsForParentCompany(testCompany);

        Project p = new Project();
        p.setCompany(testCompany);
        p.setName("TestProject");
        p.setStartDate(new Date());
        p.setEndDate(new Date());
        projectService.addProject(p,testCompany,clientCompanies.get(0));

        this.project = p;
    }

    @After
    public void tearDown() {
        project = null;
    }

    @Test
    public void testGetAssignedUsersForProjectWithNoneAssigned() {
        //should returned none

        List<UserDTO> usersForProject = projectService.findAssignedUsersForProject(project);

        Assert.assertNotNull("The user list from the find method should not be null", usersForProject);
        Assert.assertEquals("There should be no assigned users at this time", 0, usersForProject.size());


    }

    @Test
    public void testGetAvailableUsersForProjectWithNoneAssigned() {
        //should return three users

        List<UserDTO> availableUsers = projectService.findAvailableUsersForProject(project);

        Assert.assertNotNull("The available users list should not be null" , availableUsers);
        Assert.assertEquals("There should be 4 available users when none are assigned", availableUsers.size(), 4);
    }

    @Test
    public void testGetAvailableUsersForProjectWithOneAssigned() {

        List<UserDTO> availableUsers = projectService.findAvailableUsersForProject(project);
        List<UserDTO> assignments = new ArrayList<UserDTO>();
        assignments.add(availableUsers.get(0));

        projectService.saveProjectAssignments(project, assignments);

        List<UserDTO> availableUsersAfterAssignments = projectService.findAvailableUsersForProject(project);
        Assert.assertNotNull("The available users list should not be null" , availableUsersAfterAssignments);
        Assert.assertEquals("There should be 3 available users when 1 is assigned", availableUsersAfterAssignments.size(), 3);
    }

    @Test
    public void testGetAvailableUsersForProjectWithAllAssigned() {

        List<UserDTO> availableUsers = projectService.findAvailableUsersForProject(project);

        projectService.saveProjectAssignments(project, availableUsers);

        List<UserDTO> availableUsersAfterAssignments = projectService.findAvailableUsersForProject(project);

        Assert.assertNotNull("The available users list should not be null" , availableUsersAfterAssignments);
        Assert.assertEquals("There should be no available users when all are assigned", availableUsersAfterAssignments.size(), 0);
    }

    @Test
    public void testGetAssignedUsersForProjectWithAllAssigned() {
        List<UserDTO> availableUsers = projectService.findAvailableUsersForProject(project);

        projectService.saveProjectAssignments(project, availableUsers);

        List<UserDTO> assignedUsers = projectService.findAssignedUsersForProject(project);

        Assert.assertNotNull("The assigned users list should not be null" , assignedUsers);
        Assert.assertEquals("There should be 4 users assigned", assignedUsers.size(), 4);
    }

    @Test
    public void testGetAssignedUsersForProjectsWithOneAssigned() {
        List<UserDTO> availableUsers = projectService.findAvailableUsersForProject(project);
        List<UserDTO> assignments = new ArrayList<UserDTO>();
        assignments.add(availableUsers.get(0));

        projectService.saveProjectAssignments(project, assignments);

        List<UserDTO> assignedUsers = projectService.findAssignedUsersForProject(project);
        Assert.assertNotNull("The assigned users list should not be null" , assignedUsers);
        Assert.assertEquals("There should be 1 assigned users when 1 is assigned", assignedUsers.size(), 1);
    }
}
