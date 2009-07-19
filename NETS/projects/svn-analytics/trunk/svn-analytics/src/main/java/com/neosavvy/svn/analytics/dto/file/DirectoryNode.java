package com.neosavvy.svn.analytics.dto.file;

import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.SVNLogEntryPath;

import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;

public class DirectoryNode extends FileSystemNode {

	public DirectoryNode() {
		super();
	}
	
	public DirectoryNode(SVNLogEntry entry, SVNLogEntryPath path, SVNRepositoryDTO repository) {
		super( entry, path, repository);
	}

	/**
	 * Constructs a <code>String</code> with all attributes
	 * in name = value format.
	 *
	 * @return a <code>String</code> representation 
	 * of this object.
	 */
	public String toString()
	{
	    final String TAB = "    ";
	    
	    String retValue = "";
	    
	    retValue = "DirectoryNode ( "
	        + super.toString() + TAB
	
	        + " )";
	
	    return retValue;
	}
	
}
