package com.neosavvy.svn.dao.abst;

import java.util.List;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.neosavvy.junit4.BaseTransactionalSpringAwareTestCase;
import com.neosavvy.svn.analytics.dao.SVNRepositoryDAO;
import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;

public abstract class AbstractTestSvnRepositoryDAO extends BaseTransactionalSpringAwareTestCase {

	@Autowired
	private SVNRepositoryDAO repositoryDAO;
	
	@Test
	public void save() {
		
		deleteFromTables("SVN_REPOSITORY");
		
		SVNRepositoryDTO testDTO = new SVNRepositoryDTO();
		testDTO.setName("Test Fake Repository");
		testDTO.setUserName("aparrish");
		testDTO.setPassword("Password");
		testDTO.setUrl("http://url.location.of.repos");
		
		repositoryDAO.saveRepository(testDTO);
		int numRows = countRowsInTable("SVN_REPOSITORY");
		Assert.assertEquals(1, numRows);
		
	}
	
	@Test
	public void testSaveAndGetRepositories() {
		
		deleteFromTables("SVN_REPOSITORY");
		
		SVNRepositoryDTO testDTO = new SVNRepositoryDTO();
		testDTO.setName("Test Fake Repository");
		testDTO.setUserName("aparrish");
		testDTO.setPassword("Password");
		testDTO.setUrl("http://url.location.of.repos");
		
		SVNRepositoryDTO testDTO1 = new SVNRepositoryDTO();
		testDTO1.setName("Test Fake Repository 2");
		testDTO1.setUserName("aparrish");
		testDTO1.setPassword("Password");
		testDTO1.setUrl("http://url.location.of.repos.o");
		
		repositoryDAO.saveRepository(testDTO);
		repositoryDAO.saveRepository(testDTO1);
		
		List<SVNRepositoryDTO> repositories = repositoryDAO.getRepositoriesShallow();
		
		Assert.assertEquals(2, repositories.size());
	}
	
	@Test
	public void delete() {
		
		deleteFromTables("SVN_REPOSITORY");
		
		SVNRepositoryDTO testDTO = new SVNRepositoryDTO();
		testDTO.setName("Test Fake Repository");
		testDTO.setUserName("aparrish");
		testDTO.setPassword("Password");
		testDTO.setUrl("http://url.location.of.repos");
		
		repositoryDAO.saveRepository(testDTO);
		List<SVNRepositoryDTO> repositories = repositoryDAO.getRepositoriesShallow();
		
		Assert.assertEquals(1, repositories.size());
		
		repositoryDAO.deleteRepository(testDTO);
		
		repositories = repositoryDAO.getRepositories();

		Assert.assertEquals(0, repositories.size());
		
	}
	
}