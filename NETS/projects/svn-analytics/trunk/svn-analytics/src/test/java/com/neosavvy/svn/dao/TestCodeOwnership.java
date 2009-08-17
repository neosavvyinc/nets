package com.neosavvy.svn.dao;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;

import com.neosavvy.junit4.BaseSpringAwareTestCase;
import com.neosavvy.svn.analytics.dao.CodeOwnershipDAO;
import com.neosavvy.svn.analytics.dto.CodeOwnershipDTO;
import com.neosavvy.svn.analytics.dto.file.FileSystemNode;

public class TestCodeOwnership extends BaseSpringAwareTestCase {

	@Autowired
	protected CodeOwnershipDAO codeOwnershipDAO;
	
	@Test
	public void testGetOwnershipOfRootDirectory() {
		
		FileSystemNode parent = new FileSystemNode();
		parent.setRelativePath("/");
		
		CodeOwnershipDTO[] repositoryOwnership = codeOwnershipDAO.getCodeOwnership(parent);
		
		Assert.notNull(repositoryOwnership);
		
	}
	
}
