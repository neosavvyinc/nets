package com.neosavvy.svn.analytics.dao;

import com.neosavvy.svn.analytics.dto.CodeOwnershipDTO;
import com.neosavvy.svn.analytics.dto.file.FileSystemNode;

public interface CodeOwnershipDAO {
	
	public CodeOwnershipDTO[] getCodeOwnership(FileSystemNode parent);

}
