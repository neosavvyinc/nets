package com.neosavvy.user.service;

import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.util.ProjectTestUtil;
import fineline.focal.common.storage.StorageServiceClient;
import fineline.focal.common.types.v1.AbstractEntity;
import fineline.focal.common.types.v1.FileRef;
import fineline.focal.common.types.v1.ScratchFileRef;
import fineline.focal.common.types.v1.StorageServiceFileRef;
import fineline.focal.storage.service.v1.StorageService;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import junit.framework.Assert;
import org.springframework.test.context.ContextConfiguration;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import java.util.Date;
import java.util.List;

public class TestUserService extends BaseSpringAwareServiceTestCase {
    protected UserDTO adminUser;

    @Before
    public void setupAdministrator() {
        adminUser = setupAsAdminUser();
    }

    @Test
    public void testGetUsers() throws Exception{
        List<UserDTO> users = userService.findUsers(adminUser);
        Assert.assertFalse(users.isEmpty());
    }

    @Test
    public void testEmployeeUpdateUser() throws Exception{
        UserDTO user = setupAsEmployeeUser();
        user.setMiddleName(null);
        userService.updateUser(user);
        UserDTO foundUser = userDAO.findUserById(user.getId());
        Assert.assertNotNull(foundUser);
        Assert.assertNull(foundUser.getMiddleName());
    }

    @Test
    public void testAdminUpdateUser() throws Exception{
        adminUser.setMiddleName(null);
        userService.updateUser(adminUser);
        UserDTO foundUser = userDAO.findUserById(adminUser.getId());
        Assert.assertNotNull(foundUser);
        Assert.assertNull(foundUser.getMiddleName());
    }

    @Test
    public void testConfirmUser() throws Exception{
        Assert.assertFalse(findUsers().isEmpty());
        clearAuthentication();
        Assert.assertTrue(userService.confirmUser(adminUser.getUsername(), adminUser.getRegistrationToken()));
        loginAsUser(adminUser);

        UserDTO foundUser = userDAO.findUserById(adminUser.getId());
        Assert.assertTrue(foundUser.getActive());
        Assert.assertTrue(foundUser.getConfirmedRegistration());
    }

    @Test
    public void testFindUserById() throws Exception{

        UserDTO  testUser = ProjectTestUtil.createTestUser();
        userDAO.saveUser(testUser);
        Assert.assertFalse(findUsers().isEmpty());
        Assert.assertNotNull("findUserById should return the user that we just added when we search by the id for it",
                userService.findUserById(testUser.getId()));
    }

    @Test
    @Ignore
    public void testSaveFileRefToUser() throws Exception
    {
        deleteFromTables("user_company_role","users","user_receipts","storage_service_file_refs");

        UserDTO testUser = ProjectTestUtil.createTestUser();
        userDAO.saveUser( testUser );

        StorageServiceFileRef fr = new StorageServiceFileRef();
        fr.setId(1L);
        fr.setCreationDate(new Date());
        fr.setFileSize(10000L);
        fr.setLastModifiedDate(new Date());
        fr.setRecordStatus(AbstractEntity.STATUS_ACTIVE);

        //storage related
        fr.setBucket("testBucket");
        fr.setContentType("testContentType");
        fr.setKey("testFileKey");
        fr.setFileName("testFileName");
        fr.setLocation("testLocation");
        fr.setOwner(testUser.getUsername());

        simpleJdbcTemplate.update("INSERT INTO file_refs (id,created_at,file_size,last_modified_at,record_status,type) values (?,?,?,?,?,?)", new Object[]{fr.getId(),fr.getCreationDate(),fr.getFileSize(),fr.getLastModifiedDate(),new String(fr.getRecordStatus()+""),"image"});
        simpleJdbcTemplate.update("INSERT INTO storage_service_file_refs values (?,?,?,?,?,?,?)", new Object[]{fr.getId(),fr.getBucket(),fr.getContentType(),fr.getKey(),fr.getFileName(),fr.getLocation(),testUser.getUsername()});


        int users = countRowsInTable("users");
        int storage_file_refs = countRowsInTable("storage_service_file_refs");
        int user_receipts = countRowsInTable("user_receipts");

        Assert.assertEquals("There should be only one user at this time",1,users);
        Assert.assertEquals("There should be only one file reference at this time",1,storage_file_refs);
        Assert.assertEquals("There should be no user receipts at this time",0,user_receipts);

        userService.associateReceiptUploadWithUser(testUser, fr);

        user_receipts = countRowsInTable("user_receipts");
        Assert.assertEquals("There should be one user receipt at this time",1,user_receipts);


    }

    private List<UserDTO> findUsers() {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery query = builder.createQuery(UserDTO.class);
        query.from(UserDTO.class);
        return getEntityManager().createQuery(query).getResultList();
    }

}
