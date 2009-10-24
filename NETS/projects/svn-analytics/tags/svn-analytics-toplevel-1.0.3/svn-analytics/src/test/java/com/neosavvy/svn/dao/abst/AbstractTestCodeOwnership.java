package com.neosavvy.svn.dao.abst;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;

import com.neosavvy.junit4.BaseSpringAwareTestCase;
import com.neosavvy.svn.analytics.dao.CodeOwnershipDAO;
import com.neosavvy.svn.analytics.dto.CodeOwnershipDTO;
import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
import com.neosavvy.svn.analytics.dto.file.FileSystemNode;
import com.neosavvy.svn.analytics.dto.request.CodeOwnershipRefineRequest;

public abstract class AbstractTestCodeOwnership extends BaseSpringAwareTestCase {

	@Autowired
	protected CodeOwnershipDAO codeOwnershipDAO;
	
	@Test
	public void testGetOwnershipOfRootDirectory() {
		
		FileSystemNode parent = new FileSystemNode();
		parent.setRelativePath("/");
		
		CodeOwnershipRefineRequest request = new CodeOwnershipRefineRequest();
		request.setParentNode(parent);
		
		CodeOwnershipDTO[] repositoryOwnership = codeOwnershipDAO.getCodeOwnership(request);
		
		Assert.notNull(repositoryOwnership);
		
	}
	
	@Test
	public void testGetOwnershipOfRootDirectoryByRepository() {
		
		FileSystemNode parent = new FileSystemNode();
		parent.setRelativePath("/");
		
		CodeOwnershipRefineRequest request = new CodeOwnershipRefineRequest();
		request.setParentNode(parent);
		
		SVNRepositoryDTO repository = new SVNRepositoryDTO();
		repository.setId(41);
		
		request.setRepositories(new SVNRepositoryDTO[]{repository});
		
		CodeOwnershipDTO[] repositoryOwnership = codeOwnershipDAO.getCodeOwnership(request);
		
		Assert.notNull(repositoryOwnership);
		
	}
	
}
