package com.neosavvy.svn.analytics.service;

import com.neosavvy.svn.analytics.dao.SVNRepositoryDAO;
import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;

public class SVNRepositoryServiceImpl implements SvnRepositoryService {

	private SVNRepositoryDAO repositoryDAO;
	
	public void deleteRepository(SVNRepositoryDTO repository) {
		repositoryDAO.deleteRepository(repository);
	}

	public SVNRepositoryDTO[] getRepositories() {
		return repositoryDAO.getRepositories().toArray(new SVNRepositoryDTO[]{});
	}

	public void saveRepository(SVNRepositoryDTO repository) {
		repositoryDAO.saveRepository(repository);
	}

	public void updateRepository(SVNRepositoryDTO repository) {
		repositoryDAO.updateRepository(repository);
	}

	public SVNRepositoryDAO getRepositoryDAO() {
		return repositoryDAO;
	}

	public void setRepositoryDAO(SVNRepositoryDAO repositoryDAO) {
		this.repositoryDAO = repositoryDAO;
	}

}
