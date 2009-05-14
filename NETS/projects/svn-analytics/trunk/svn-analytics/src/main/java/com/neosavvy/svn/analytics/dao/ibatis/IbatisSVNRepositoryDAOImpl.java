package com.neosavvy.svn.analytics.dao.ibatis;

import org.apache.log4j.Logger;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DataRetrievalFailureException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.neosavvy.svn.analytics.dao.SVNRepositoryDAO;
import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;

public class IbatisSVNRepositoryDAOImpl extends SqlMapClientDaoSupport implements SVNRepositoryDAO {

	private static final Logger logger = Logger
			.getLogger(IbatisSVNRepositoryDAOImpl.class);

	public void deleteRepository(SVNRepositoryDTO repository) {
		try {
			getSqlMapClient().delete("SvnRepository.deleteRepository", repository);
		} catch (SQLException e) {
			logger.error("deleteRepository(SVNRepositoryDTO) - Error deleting repository: ", e);
		}

	}

	@SuppressWarnings("unchecked")
	public List<SVNRepositoryDTO> getRepositories() {
		try {
			List<SVNRepositoryDTO> repositories = (List<SVNRepositoryDTO>) getSqlMapClient().queryForList("SvnRepository.getSvnRepositories");
			return repositories;
		} catch (SQLException e) {
			logger.error("Error retrieving svn repositories", e);
			throw new DataRetrievalFailureException("Error retrieving svn repositories", e);
		}
	}

	public void saveRepository(SVNRepositoryDTO repository) {
		try {
			getSqlMapClient().insert("SvnRepository.saveSvnRepository", repository);
		} catch (SQLException e) {
			logger.error("Error inserting " + repository, e);
			throw new DataIntegrityViolationException("Error inserting " + repository, e);
		}
	}

	public void updateRepository(SVNRepositoryDTO repository) {
		// TODO Auto-generated method stub

	}

}
