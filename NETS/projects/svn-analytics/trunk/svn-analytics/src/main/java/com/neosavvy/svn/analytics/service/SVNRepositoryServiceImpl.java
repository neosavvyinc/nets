package com.neosavvy.svn.analytics.service;

import com.neosavvy.svn.analytics.dao.SVNFileSystemNodeDAO;
import com.neosavvy.svn.analytics.dao.SVNRepositoryDAO;
import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
import com.neosavvy.svn.analytics.dto.file.FileSystemNode;
import com.neosavvy.svn.analytics.importer.SVNRepositoryDatabaseConverter;
import com.neosavvy.svn.analytics.util.SvnKitUtil;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNURL;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.io.SVNRepository;
import org.tmatesoft.svn.core.io.SVNRepositoryFactory;
import org.tmatesoft.svn.core.wc.SVNWCUtil;

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
        SvnKitUtil.setupLibrary();
        try {
        SVNRepository initializedRepository = SVNRepositoryFactory.create(SVNURL
                        .parseURIEncoded(repository.getUrl()));

                ISVNAuthenticationManager authManager = SVNWCUtil
                        .createDefaultAuthenticationManager(repository.getUserName(),
                                repository.getPassword());
                initializedRepository.setAuthenticationManager(authManager);
            initializedRepository.testConnection();
        } catch (SVNException e) {
            throw new RuntimeException("Repository URL was wrong, or user/pass was incorrect",e);
        }
		repositoryDAO.saveRepository(repository);
	}

	public void updateRepository(SVNRepositoryDTO repository) {
		repositoryDAO.updateRepository(repository);
	}

	public FileSystemNode[] getDirectoriesForRepository(
			SVNRepositoryDTO repository, FileSystemNode parent) {
		parent.setRepositoryId(repository.getId());
		FileSystemNode[] directories = fileSystemDAO.getNodes(parent);
		return directories;
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
