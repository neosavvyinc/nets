package com.neosavvy.svn.analytics.service;

import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
import com.neosavvy.svn.analytics.dto.file.DirectoryNode;
import com.neosavvy.svn.analytics.dto.file.FileNode;

public interface SvnRepositoryService {

	public SVNRepositoryDTO[] getRepositories();

	public void saveRepository(SVNRepositoryDTO repository);

	public void deleteRepository(SVNRepositoryDTO repository);

	public void updateRepository(SVNRepositoryDTO repository);
	
	public DirectoryNode[] getDirectoriesForRepository(SVNRepositoryDTO repository, DirectoryNode parent);
	
	public FileNode[] getFilesForRepository(SVNRepositoryDTO repository, DirectoryNode parent);
	
	public void requestConversion(SVNRepositoryDTO repository);
}
