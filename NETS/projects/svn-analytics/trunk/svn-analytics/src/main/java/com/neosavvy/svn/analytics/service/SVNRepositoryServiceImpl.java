package com.neosavvy.svn.analytics.service;

import com.neosavvy.svn.analytics.dao.SVNFileSystemNodeDAO;
import com.neosavvy.svn.analytics.dao.SVNRepositoryDAO;
import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
import com.neosavvy.svn.analytics.dto.file.DirectoryNode;
import com.neosavvy.svn.analytics.dto.file.FileNode;
import com.neosavvy.svn.analytics.importer.SVNRepositoryDatabaseConverter;

public class SVNRepositoryServiceImpl implements SvnRepositoryService {

	private SVNRepositoryDAO repositoryDAO;
	
	private SVNFileSystemNodeDAO fileSystemDAO;
	
	private SVNRepositoryDatabaseConverter converter;
	
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

	public DirectoryNode[] getDirectoriesForRepository(
			SVNRepositoryDTO repository, DirectoryNode parent) {
		parent.setRepositoryId(repository.getId());
		DirectoryNode[] directories = fileSystemDAO.getDirectories(parent);
		return directories;
	}

	public FileNode[] getFilesForRepository(SVNRepositoryDTO repository,
			DirectoryNode parent) {
		parent.setRepositoryId(repository.getId());
		FileNode[] files = fileSystemDAO.getFiles(parent);
		return files;
	}

	public void requestConversion(SVNRepositoryDTO repository) {
		converter.requestRefresh(repository);
	}
	
	public SVNRepositoryDAO getRepositoryDAO() {
		return repositoryDAO;
	}

	public void setRepositoryDAO(SVNRepositoryDAO repositoryDAO) {
		this.repositoryDAO = repositoryDAO;
	}

	public SVNFileSystemNodeDAO getFileSystemDAO() {
		return fileSystemDAO;
	}

	public void setFileSystemDAO(SVNFileSystemNodeDAO fileSystemDAO) {
		this.fileSystemDAO = fileSystemDAO;
	}

	public SVNRepositoryDatabaseConverter getConverter() {
		return converter;
	}

	public void setConverter(SVNRepositoryDatabaseConverter converter) {
		this.converter = converter;
	}	
	
}
