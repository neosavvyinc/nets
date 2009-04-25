package com.neosavvy.svn.analytics.dao;

import java.util.List;

import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;

public interface SVNRepositoryDAO {
	
	public List<SVNRepositoryDTO> getRepositories();
	
	public void saveRepository(SVNRepositoryDTO repository);
	
	public void deleteRepository(SVNRepositoryDTO repository);
	
	public void updateRepository(SVNRepositoryDTO repository);

}
