package com.neosavvy.svn.analytics.importer.handler;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;
import org.tmatesoft.svn.core.ISVNLogEntryHandler;
import org.tmatesoft.svn.core.SVNDirEntry;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.SVNLogEntryPath;
import org.tmatesoft.svn.core.SVNNodeKind;
import org.tmatesoft.svn.core.SVNURL;
import org.tmatesoft.svn.core.internal.wc.DefaultSVNOptions;
import org.tmatesoft.svn.core.io.SVNRepository;
import org.tmatesoft.svn.core.wc.SVNLogClient;
import org.tmatesoft.svn.core.wc.SVNRevision;

import com.neosavvy.svn.analytics.dao.SVNFileSystemNodeDAO;
import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
import com.neosavvy.svn.analytics.dto.file.DirectoryNode;
import com.neosavvy.svn.analytics.dto.file.FileNode;
import com.neosavvy.svn.analytics.util.SvnKitUtil;

public class LogEntryHandler implements ISVNLogEntryHandler {

	private static final Logger logger = Logger
			.getLogger(LogEntryHandler.class);


	private SVNFileSystemNodeDAO fileSystemDao;
	
	private SVNRepositoryDTO repositoryModel;
	
	private SVNRepository repository;
	
	List<DirectoryNode> directories = new ArrayList<DirectoryNode>();
	List<FileNode> files = new ArrayList<FileNode>();
	List<SVNLogEntryPath> none = new ArrayList<SVNLogEntryPath>();
	List<SVNLogEntryPath> unknown = new ArrayList<SVNLogEntryPath>();
	
	public SVNFileSystemNodeDAO getFileSystemDao() {
		return fileSystemDao;
	}


	public void setFileSystemDao(SVNFileSystemNodeDAO fileSystemDao) {
		this.fileSystemDao = fileSystemDao;
	}
	
	@SuppressWarnings("unchecked")
	public void handleLogEntry(SVNLogEntry entry) throws SVNException {
		if (logger.isInfoEnabled()) {
			logger.info("handleDirEntry(SVNDirEntry) - Logging entry:" + entry);
		}
		Set entryKeys = entry.getChangedPaths().keySet();
		for (Object key : entryKeys) {
			Object entryObject = entry.getChangedPaths().get(key);
			if( entryObject instanceof SVNLogEntryPath) {
				SVNLogEntryPath entryPath = (SVNLogEntryPath)entryObject;
				
				/**
				 * Guess as to what the entry path's kind really is
				 */
				if( entryPath.getKind() == SVNNodeKind.NONE || entryPath.getKind() == SVNNodeKind.UNKNOWN) {
					SVNLogClient logClient = new SVNLogClient(repository.getAuthenticationManager(), new DefaultSVNOptions());
					SVNURL appendPath = repository.getLocation().appendPath(entryPath.getPath(), true);
					
					try {
						AnnotationPrintHandler handler = new AnnotationPrintHandler(new FileNode(entry, entryPath, repositoryModel));
						logClient.doAnnotate(appendPath
								,SVNRevision.create(entry.getRevision())
								,SVNRevision.create(entry.getRevision())
								,SVNRevision.create(entry.getRevision())
								,handler);
						files.add(handler.getNode());
					} catch (SVNException e) {
						if(logger.isDebugEnabled()) {
							logger.debug("Failed to annotate entry: " + entryPath + " so it must be a directory or a binary file");
						}
						
						try {
							@SuppressWarnings("unused")
							Collection entriesFromDirectory = repository.getDir(entryPath.getPath(), entry.getRevision(), null,(Collection)null);
							directories.add(new DirectoryNode(entry, entryPath, repositoryModel));
						} catch (SVNException binException) {
							if( entryPath.getType() == SVNLogEntryPath.TYPE_DELETED) {
								if(logger.isDebugEnabled()) {
									logger.debug("Failed to list the directory and it was deleted, so ignoring for now");
								}
								continue;
							}
							if(logger.isDebugEnabled()) {
								logger.debug("Failed to list the directory so the entry must actually be a binary file" + entryPath.getPath());
							}
							files.add(new FileNode(entry,entryPath,repositoryModel));
						}
					} 
				}
			}
		}
	}
	
	public void saveCachedStatistics() {

		getFileSystemDao().saveDirectories( directories );
		getFileSystemDao().saveFiles( files );

		directories = new ArrayList<DirectoryNode>();
		files = new ArrayList<FileNode>();
	}


	public SVNRepositoryDTO getRepositoryModel() {
		return repositoryModel;
	}


	public void setRepositoryModel(SVNRepositoryDTO repositoryModel) {
		this.repositoryModel = repositoryModel;
	}


	public SVNRepository getRepository() {
		return repository;
	}


	public void setRepository(SVNRepository repository) {
		this.repository = repository;
	}

	
	
}
