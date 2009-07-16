package com.neosavvy.svn.analytics.dto.file;

import java.util.Date;

import org.tmatesoft.svn.core.SVNDirEntry;

/**
 * This class is abstract to allow for directories or files to be handled
 * a bit differently and also stored in two tables separately.
 * 
 * This is an example of output on a directory from a logClient call
 * name=analytics
 * , kind=dir
 * , size=0
 * , hasProps=false
 * , lastchangedrev=4
 * , lastauthor=aparrish
 * , lastchangeddate=Fri Mar 20 23:32:03 EDT 2009 
 * , path: svn-analytics/trunk/src/main/resources/com/neosavvy/svn/analytics
 * 
 * This is an example of output on a file from a logClient call
 * name=svn-analytics
 * name=log4j.test.properties
 * , kind=file
 * , size=312
 * , hasProps=false
 * , lastchangedrev=3
 * , lastauthor=aparrish
 * , lastchangeddate=Fri Mar 20 20:52:39 EDT 2009 
 * , path: svn-analytics/trunk/src/test/java/log4j.test.properties
 */
public abstract class FileSystemNode {
	
	private long id;
	
	private long revision;
	
	private Date revisionDate;
	
	private long lastChangedRevision;
	
	private String author;
	
	private String relativePath;

	private String parentDirectory;

	public FileSystemNode() {
		super();
	}

	public FileSystemNode( SVNDirEntry entry, long revision ) {
		this.id = -1;
		this.revision = revision;
		
		this.author = entry.getAuthor();
		this.lastChangedRevision = entry.getRevision();
		this.revisionDate = entry.getDate();
		this.relativePath = entry.getRelativePath();
		this.parentDirectory = deriveParentPath(entry.getRelativePath());
		
	}
	
	protected String deriveParentPath( String relativePath ) {
		if( relativePath.lastIndexOf("/") == -1) 
			return null;
		
		return relativePath.substring(0, relativePath.lastIndexOf("/"));
	}
	
	public long getRevision() {
		return revision;
	}

	public void setRevision(long revision) {
		this.revision = revision;
	}

	public Date getRevisionDate() {
		return revisionDate;
	}

	public void setRevisionDate(Date revisionDate) {
		this.revisionDate = revisionDate;
	}
	
	public long getLastChangedRevision() {
		return lastChangedRevision;
	}

	public void setLastChangedRevision(long lastChangedRevision) {
		this.lastChangedRevision = lastChangedRevision;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getRelativePath() {
		return relativePath;
	}

	public void setRelativePath(String relativePath) {
		this.relativePath = relativePath;
	}

	public String getParentDirectory() {
		return parentDirectory;
	}

	public void setParentDirectory(String parentDirectory) {
		this.parentDirectory = parentDirectory;
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
	    
	    retValue = "FileSystemNode ( "
	        + super.toString() + TAB
	        + "revision = " + this.revision + TAB
	        + "revisionDate = " + this.revisionDate + TAB
	        + "lastChangedRevision = " + this.lastChangedRevision + TAB
	        + "author = " + this.author + TAB
	        + "relativePath = " + this.relativePath + TAB
	        + "parentDirectory = " + this.parentDirectory + TAB
	        + " )";
	
	    return retValue;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	

}
