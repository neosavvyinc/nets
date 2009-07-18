package com.neosavvy.svn.analytics.dto.file;

import org.tmatesoft.svn.core.SVNDirEntry;

import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;

public class DirectoryNode extends FileSystemNode {

	public DirectoryNode() {
		super();
	}
	
	public DirectoryNode(SVNDirEntry dirEntry, long revision, SVNRepositoryDTO repository) {
		super( dirEntry, revision, repository);
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
