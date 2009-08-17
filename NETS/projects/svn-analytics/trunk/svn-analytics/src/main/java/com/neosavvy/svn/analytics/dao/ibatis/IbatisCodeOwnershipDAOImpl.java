package com.neosavvy.svn.analytics.dao.ibatis;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.neosavvy.svn.analytics.dao.CodeOwnershipDAO;
import com.neosavvy.svn.analytics.dto.CodeOwnershipDTO;
import com.neosavvy.svn.analytics.dto.file.FileSystemNode;

public class IbatisCodeOwnershipDAOImpl extends SqlMapClientDaoSupport implements
		CodeOwnershipDAO {

	private static final Logger logger = Logger
			.getLogger(IbatisCodeOwnershipDAOImpl.class);

	@SuppressWarnings("unchecked")
	public CodeOwnershipDTO[] getCodeOwnership(FileSystemNode parent) {
		parent.setRelativePath(parent.getRelativePath() + "%");
		List<CodeOwnershipDTO> queryForList = getSqlMapClientTemplate().queryForList("CodeOwnership.getOwnership", parent);
		return queryForList.toArray(new CodeOwnershipDTO[]{});
	}

}
