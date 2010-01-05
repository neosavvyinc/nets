package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dao.BaseSpringAwareDAOTestCase;
import com.neosavvy.user.dto.companyManagement.UserInviteDTO;
import org.junit.Test;
import org.junit.Assert;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 19, 2009
 * Time: 11:41:13 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestUserInviteDAO extends BaseSpringAwareDAOTestCase {
    @Test
	public void testSaveUserInvite() {
        cleanupTables();
        UserInviteDTO userInvite = createTestUserInvite();

		userInviteDAO.saveUserInvite(userInvite);
		Assert.assertTrue(userInvite.getId() > 0);
	}

    @Test
    public void testDeleteUserInvite() {
        cleanupTables();
        int numRows = countRowsInTable("USER_INVITE");
        Assert.assertEquals("The table should be empty", 0, numRows);

        UserInviteDTO userInvite = createTestUserInvite();
        userInviteDAO.saveUserInvite(userInvite);

        numRows = countRowsInTable("USER_INVITE");
        Assert.assertEquals(numRows, 1);

        userInviteDAO.deleteUserInvite(userInvite);

        numRows = countRowsInTable("USER_INVITE");
        Assert.assertEquals(0,numRows);
    }

    @Test
    public void testFindUserInviteById() {
        cleanupTables();

        UserInviteDTO userInvite = createTestUserInvite();
        userInviteDAO.saveUserInvite(userInvite);

        int numRows = countRowsInTable("USER_INVITE");

        Assert.assertEquals("Num of rows is not equal to 1", 1, numRows);

        UserInviteDTO userInviteFound = userInviteDAO.findUserInviteById(userInvite.getId());

        Assert.assertNotNull("UserInvite object was found by id " + userInvite.getId(), userInviteFound);
    }

    @Test
    public void testGetUserInvites() {
        cleanupTables();

        UserInviteDTO userInvite = createTestUserInvite();
        userInviteDAO.saveUserInvite(userInvite);

        int numRows = countRowsInTable("USER_INVITE");

        Assert.assertEquals("Num of rows is not equal to 1", 1, numRows);

        List<UserInviteDTO> userInvitesFound = userInviteDAO.getUserInvites();

        Assert.assertTrue("UserInvite objects were found ", userInvitesFound.size() > 0);
    }

    @Test
    public void testFindByFirstName() {
        setupCriteriaBasedSearchTest();

        UserInviteDTO searchCriteria = new UserInviteDTO();
        searchCriteria.setFirstName("William");

        List<UserInviteDTO> usersFound = userInviteDAO.findUserInvites(searchCriteria);

        assertSearchCriteriaResults(usersFound,1);
    }

    @Test
    public void testFindByMiddleName() {
        setupCriteriaBasedSearchTest();

        UserInviteDTO searchCriteria = new UserInviteDTO();
        searchCriteria.setMiddleName("Adam");

        List<UserInviteDTO> userInvitesFounds = userInviteDAO.findUserInvites(searchCriteria);

        assertSearchCriteriaResults(userInvitesFounds,1);
    }

    @Test
    public void testFindByLastName() {
        setupCriteriaBasedSearchTest();

        UserInviteDTO searchCriteria = new UserInviteDTO();
        searchCriteria.setLastName("Parrish");

        List<UserInviteDTO> userInvitesFounds = userInviteDAO.findUserInvites(searchCriteria);

        assertSearchCriteriaResults(userInvitesFounds,1);
    }

    @Test
    public void testFindByEmail() {
        setupCriteriaBasedSearchTest();

        UserInviteDTO searchCriteria = new UserInviteDTO();
        searchCriteria.setEmailAddress("aparrish1@neosavvy.com");

        List<UserInviteDTO> userInvitesFounds = userInviteDAO.findUserInvites(searchCriteria);

        assertSearchCriteriaResults(userInvitesFounds,1);
    }

    private void setupCriteriaBasedSearchTest() {
        cleanupTables();

        UserInviteDTO userInvite = createTestUserInvite();
        UserInviteDTO userInvite2 = createAltTestUserInvite();

        userInviteDAO.saveUserInvite(userInvite);
        userInviteDAO.saveUserInvite(userInvite2);

        int numRows = countRowsInTable("USER_INVITE");
        Assert.assertEquals("Num of rows is not equal to 2", 2, numRows);
    }


}
