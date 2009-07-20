package com.neosavvy.svn.analytics.service;

import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
import com.neosavvy.svn.analytics.dto.file.FileSystemNode;

public interface SvnRepositoryService {

	public SVNRepositoryDTO[] getRepositories();

	public void saveRepository(SVNRepositoryDTO repository);

	public void deleteRepository(SVNRepositoryDTO repository);

	public void updateRepository(SVNRepositoryDTO repository);
	
	public FileSystemNode[] getDirectoriesForRepository(SVNRepositoryDTO repository, FileSystemNode parent);
	
	public void requestConversion(SVNRepositoryDTO repository);
}
