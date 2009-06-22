package com.neosavvy.svn.analytics.service;

import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;

public interface SvnRepositoryService {

	public SVNRepositoryDTO[] getRepositories();

	public void saveRepository(SVNRepositoryDTO repository);

	public void deleteRepository(SVNRepositoryDTO repository);

	public void updateRepository(SVNRepositoryDTO repository);
	
}
