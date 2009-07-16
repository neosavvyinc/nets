package com.neosavvy.svn.analytics.dto.file;

import org.tmatesoft.svn.core.SVNDirEntry;

public class FileNode extends FileSystemNode {
	
	private long numberLines;
	private String fileName;
	
	public FileNode() {
		super();
	}
	
	public FileNode(SVNDirEntry dirEntry, long revision) {
		super( dirEntry, revision );
		
		this.fileName = deriveFileName( dirEntry.getRelativePath() );
	}
	
	protected String deriveFileName( String relativePath ) {
		if( relativePath.lastIndexOf("/") == -1) 
			return relativePath;
		
		return relativePath.substring(relativePath.lastIndexOf("/"), relativePath.length());
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
