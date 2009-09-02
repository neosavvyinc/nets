package com.neosavvy.svn.analytics.dao.ibatis;

import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.neosavvy.svn.analytics.dao.CodeOwnershipDAO;
import com.neosavvy.svn.analytics.dto.CodeOwnershipDTO;
import com.neosavvy.svn.analytics.dto.file.FileSystemNode;
import com.neosavvy.svn.analytics.dto.request.CodeOwnershipRefineRequest;

public class IbatisCodeOwnershipDAOImpl extends SqlMapClientDaoSupport implements
		CodeOwnershipDAO {

	private static final Logger logger = Logger
			.getLogger(IbatisCodeOwnershipDAOImpl.class);

	@SuppressWarnings("unchecked")
	public CodeOwnershipDTO[] getCodeOwnership(CodeOwnershipRefineRequest refineRequest) {
		refineRequest.getParentNode().setRelativePath(refineRequest.getParentNode().getRelativePath() + "%");
		List<CodeOwnershipDTO> queryForList = getSqlMapClientTemplate().queryForList("CodeOwnership.getOwnership", refineRequest);
		return queryForList.toArray(new CodeOwnershipDTO[]{});
	}

}
