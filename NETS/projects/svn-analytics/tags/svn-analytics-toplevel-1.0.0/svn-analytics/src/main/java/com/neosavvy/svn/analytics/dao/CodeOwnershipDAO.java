package com.neosavvy.svn.analytics.dao;

import com.neosavvy.svn.analytics.dto.CodeOwnershipDTO;
import com.neosavvy.svn.analytics.dto.request.CodeOwnershipRefineRequest;

public interface CodeOwnershipDAO {
	
	public CodeOwnershipDTO[] getCodeOwnership(CodeOwnershipRefineRequest parent);

}
