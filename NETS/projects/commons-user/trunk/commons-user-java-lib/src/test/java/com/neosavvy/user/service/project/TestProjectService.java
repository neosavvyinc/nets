package com.neosavvy.user.service.project;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.ClientCompany;
import com.neosavvy.user.dto.project.Project;
import com.neosavvy.user.util.ProjectTestUtil;
import junit.framework.Assert;
import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import java.util.*;
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


    private Project p0;
    private Project p1;

    @Before
    public void setupCommonData() {
        super.setup();
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

        Project p0 = new Project();
        p0.setCompany(testCompany);
        p0.setName("TestProject");
        p0.setStartDate(new Date());
        p0.setEndDate(new Date());
        projectService.addProject(p0,testCompany,clientCompanies.get(0));

        Project p1 = new Project();
        p1.setCompany(testCompany);
        p1.setName("TestProject2");
        p1.setStartDate(new Date());
        p1.setEndDate(new Date());
        projectService.addProject(p1,testCompany,clientCompanies.get(0));

        this.p0 = p0;
        this.p1 = p1;
    }

    @After
    public void tearDown() {
        p0 = null;
    }

    @Test
    public void testGetAssignedUsersForProjectWithNoneAssigned() {
        //should returned none

        List<UserDTO> usersForProject = projectService.findAssignedUsersForProject(p0);

        Assert.assertNotNull("The user list from the find method should not be null", usersForProject);
        Assert.assertEquals("There should be no assigned users at this time", 0, usersForProject.size());


    }

    @Test
    public void testGetAvailableUsersForProjectWithNoneAssigned() {
        //should return three users

        List<UserDTO> availableUsers = projectService.findAvailableUsersForProject(p0);

        Assert.assertNotNull("The available users list should not be null" , availableUsers);
        Assert.assertEquals("There should be 4 available users when none are assigned", availableUsers.size(), 4);
    }

    @Test
    public void testGetAvailableUsersForProjectWithOneAssigned() {

        List<UserDTO> availableUsers = projectService.findAvailableUsersForProject(p0);
        List<UserDTO> assignments = new ArrayList();
        assignments.add(availableUsers.get(0));

        projectService.saveProjectAssignments(p0, assignments);

        List<UserDTO> availableUsersAfterAssignments = projectService.findAvailableUsersForProject(p0);
        Assert.assertNotNull("The available users list should not be null" , availableUsersAfterAssignments);
        Assert.assertEquals("There should be 3 available users when 1 is assigned", availableUsersAfterAssignments.size(), 3);
    }

    @Test
    public void testGetAvailableUsersForProjectWithAllAssigned() {

        List<UserDTO> availableUsers = projectService.findAvailableUsersForProject(p0);

        List<UserDTO> assignedUsers = new ArrayList();
        assignedUsers.addAll(availableUsers);
        projectService.saveProjectAssignments(p0, assignedUsers);

        List<UserDTO> availableUsersAfterAssignments = projectService.findAvailableUsersForProject(p0);

        Assert.assertNotNull("The available users list should not be null" , availableUsersAfterAssignments);
        Assert.assertEquals("There should be no available users when all are assigned", availableUsersAfterAssignments.size(), 0);
    }

    @Test
    public void testGetAssignedUsersForProjectWithAllAssigned() {
        List<UserDTO> availableUsers = projectService.findAvailableUsersForProject(p0);
        List<UserDTO> assignedUsers = new ArrayList();
        assignedUsers.addAll(availableUsers);
        projectService.saveProjectAssignments(p0, assignedUsers);

        List<UserDTO> assignedUsersAfterSave = projectService.findAssignedUsersForProject(p0);

        Assert.assertNotNull("The assigned users list should not be null" , assignedUsersAfterSave);
        Assert.assertEquals("There should be 4 users assigned", assignedUsersAfterSave.size(), 4);
    }

    @Test
    public void testGetAssignedUsersForProjectsWithOneAssigned() {
        List<UserDTO> availableUsers = projectService.findAvailableUsersForProject(p0);
        List<UserDTO> assignments = new ArrayList<UserDTO>();
        assignments.add(availableUsers.get(0));

        projectService.saveProjectAssignments(p0, assignments);

        List<UserDTO> assignedUsers = projectService.findAssignedUsersForProject(p0);
        Assert.assertNotNull("The assigned users list should not be null" , assignedUsers);
        Assert.assertEquals("There should be 1 assigned users when 1 is assigned", assignedUsers.size(), 1);
    }

    @Test
    public void testThreeUsersWithTwoProjects() {
        List<UserDTO> p0availableUsers = projectService.findAvailableUsersForProject(p0);
        List<UserDTO> p1availableUsers = projectService.findAvailableUsersForProject(p1);

        Assert.assertNotNull("All users should be available for p0 thus should not be null",p0availableUsers);
        Assert.assertNotNull("All users should be available for p1 thus should not be null",p1availableUsers);

        Assert.assertEquals("There should be 3 availble users for p0",p0availableUsers.size(),4);
        Assert.assertEquals("There should be 3 available users for p1", p1availableUsers.size(),4);

        projectService.saveProjectAssignments(p0,p0availableUsers);
        List<UserDTO> p0assignedUsers = projectService.findAssignedUsersForProject(p0);
        Assert.assertEquals("There should be 3 assigned users to p0",4,p0assignedUsers.size());

        List<UserDTO> p1availableUsersAfterP0Assignments = projectService.findAvailableUsersForProject(p1);
        Assert.assertEquals("P0 assignments should not affect p1 availability",p1availableUsersAfterP0Assignments.size(),4);

        UserDTO p1Assignment = p1availableUsersAfterP0Assignments.get(2);
        List<UserDTO> p1Assignments = new ArrayList<UserDTO>();
        p1Assignments.add(p1Assignment);
        projectService.saveProjectAssignments(p1, p1Assignments);

        List<UserDTO> p0availabilityAfterBothProjectsModified = projectService.findAvailableUsersForProject(p0);
        List<UserDTO> p1availabilityAfterBothProjectsModified = projectService.findAvailableUsersForProject(p1);

        Assert.assertEquals("Should be no availability on P0",p0availabilityAfterBothProjectsModified.size(),0);
        Assert.assertEquals("Should be 3 available users on P1",p1availabilityAfterBothProjectsModified.size(),3);

    }

    @Test
    @Ignore
    public void testFindProjectsForCompanyAndUser() {

        UserDTO user = ProjectTestUtil.createAltTestUser();

        List<Project> projectsForUser = projectService.findProjectsForUser(user);

        Assert.assertNotNull("There should be no projects set for the user at this point.",projectsForUser);
        Assert.assertEquals("There should be a 0 length arraylist at this point",0,projectsForUser.size());

        List<UserDTO> users = userService.findUsers(user);

        projectService.saveProjectAssignments(p0,users);
        projectService.saveProjectAssignments(p1,users);

        List<Project> projectsForUserAfterAssignments = projectService.findProjectsForUser(user);

        Assert.assertNotNull("There should be a non null return after assigning the project to a user", projectsForUserAfterAssignments);
        Assert.assertEquals("There should be two assigned projects to this user", 2, projectsForUserAfterAssignments.size());


    }
}
