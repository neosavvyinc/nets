package com.neosavvy.svn.analytics.dto.file;

import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.SVNLogEntryPath;

import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;

public class FileNode extends FileSystemNode {
	
	private long numberLines;
	private String fileName;
	
	public FileNode() {
		super();
	}
	
	public FileNode(SVNLogEntry log, SVNLogEntryPath path, SVNRepositoryDTO repository) {
		super( log, path, repository );
		
		this.fileName = deriveFileName( path.getPath() );
	}
	
	protected String deriveFileName( String relativePath ) {
		if( relativePath.lastIndexOf("/") == -1) 
			return relativePath;
		
		return relativePath.substring(relativePath.lastIndexOf("/") + 1, relativePath.length());
	}

	public long getNumberLines() {
		return numberLines;
	}

	public void setNumberLines(long numberLines) {
		this.numberLines = numberLines;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
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
	    
	    retValue = "FileNode ( "
	        + super.toString() + TAB
	        + "numberLines = " + this.numberLines + TAB
	        + "fileName = " + this.fileName + TAB
	        + " )";
	
	    return retValue;
	}
	
}
