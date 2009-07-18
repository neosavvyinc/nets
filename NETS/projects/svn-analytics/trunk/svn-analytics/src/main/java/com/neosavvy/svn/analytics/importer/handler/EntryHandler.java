package com.neosavvy.svn.analytics.importer.handler;

import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.List;

import org.tmatesoft.svn.core.ISVNDirEntryHandler;
import org.tmatesoft.svn.core.SVNDirEntry;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNNodeKind;

import com.neosavvy.svn.analytics.dao.SVNFileSystemNodeDAO;
import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
import com.neosavvy.svn.analytics.dto.file.DirectoryNode;
import com.neosavvy.svn.analytics.dto.file.FileNode;

public class EntryHandler implements ISVNDirEntryHandler {

	private static final Logger logger = Logger.getLogger(EntryHandler.class);

	private SVNFileSystemNodeDAO fileSystemDao;
	
	List<SVNDirEntry> directories = new ArrayList<SVNDirEntry>();
	List<SVNDirEntry> files = new ArrayList<SVNDirEntry>();
	List<SVNDirEntry> none = new ArrayList<SVNDirEntry>();
	List<SVNDirEntry> unknown = new ArrayList<SVNDirEntry>();
	
	public void handleDirEntry(SVNDirEntry entry) throws SVNException {

		if (logger.isInfoEnabled()) {
			logger.info("handleDirEntry(SVNDirEntry) - Logging entry:" + entry);
		}
		
		if( entry.getKind() == SVNNodeKind.DIR ) {
			directories.add( entry );
		} else if (entry.getKind() == SVNNodeKind.FILE ) {
			files.add( entry );
		} else if (entry.getKind() == SVNNodeKind.NONE) {
			none.add( entry );
		} else if (entry.getKind() == SVNNodeKind.UNKNOWN) {
			unknown.add( entry );
		}
	}
	
	public void flushStatistics(long revision, SVNRepositoryDTO repository) {
		
		getFileSystemDao().saveDirectories( convertDirectoryEntries( directories, revision, repository ) );
		getFileSystemDao().saveFiles( convertFileEntries( files, revision, repository ) );
		
		directories = new ArrayList<SVNDirEntry>();
		files = new ArrayList<SVNDirEntry>();
		
		//TODO: Log the none and unknown arrays because something is wrong and probably should be done about it.
		
	}

	public List<DirectoryNode> convertDirectoryEntries( List<SVNDirEntry> directories, long revision, SVNRepositoryDTO repository ) {
		List<DirectoryNode> returnObj = new ArrayList<DirectoryNode>();
		for (SVNDirEntry dirEntry : directories) {
			returnObj.add( new DirectoryNode( dirEntry, revision, repository ));
		}
		return returnObj;
	}
	
	public List<FileNode> convertFileEntries( List<SVNDirEntry> files, long revision, SVNRepositoryDTO repository  ) {
		List<FileNode> returnObj = new ArrayList<FileNode>();
		for (SVNDirEntry dirEntry : files) {
			returnObj.add( new FileNode( dirEntry, revision, repository ));
		}
		return returnObj;
	}
	
	public void setFileSystemDao(SVNFileSystemNodeDAO fileSystemDao) {
		this.fileSystemDao = fileSystemDao;
	}

	public SVNFileSystemNodeDAO getFileSystemDao() {
		return fileSystemDao;
	}

}
