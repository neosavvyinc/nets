package com.neosavvy.svn.analytics.dto.file;

import java.util.Date;
import java.util.List;

import org.tmatesoft.svn.core.SVNDirEntry;
import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.SVNLogEntryPath;

import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;

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
public class FileSystemNode {
	
	public static String TYPE_FILE = "F";
	public static String TYPE_DIRECTORY = "D";
	
	private long id;
	
	private long repositoryId;
	
	private long revision;
	
	private Date revisionDate;
	
	private long lastChangedRevision;
	
	private String author;
	
	private String relativePath;

	private String parentDirectory;

	private long numberLines;
	
	private String fileName;
	
	private String fileType;
	
	private List<FileSystemNode> children;
	
	public FileSystemNode() {
		super();
	}

	public FileSystemNode( SVNLogEntry entry, SVNLogEntryPath entryPath, SVNRepositoryDTO repository, String fileType ) {
		this.id = -1;
		this.revision = entry.getRevision();
		this.repositoryId = repository.getId();
		this.fileName = deriveFileName( entryPath.getPath() );
		this.author = entry.getAuthor();
		this.lastChangedRevision = entry.getRevision();
		this.revisionDate = entry.getDate();
		this.relativePath = entryPath.getPath();
		this.parentDirectory = deriveParentPath(entryPath.getPath());
		this.fileType = fileType;
	}
	
	protected String deriveParentPath( String relativePath ) {
		if( relativePath.lastIndexOf("/") == -1) 
			return null;
		
		return relativePath.substring(0, relativePath.lastIndexOf("/"));
	}
	
	protected String deriveFileName( String relativePath ) {
		if( relativePath.lastIndexOf("/") == -1) 
			return relativePath;
		
		return relativePath.substring(relativePath.lastIndexOf("/") + 1, relativePath.length());
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

	public long getRepositoryId() {
		return repositoryId;
	}

	public void setRepositoryId(long repositoryId) {
		this.repositoryId = repositoryId;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
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

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public List<FileSystemNode> getChildren() {
		return children;
	}

	public void setChildren(List<FileSystemNode> children) {
		this.children = children;
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
	        + "id = " + this.id + TAB
	        + "repositoryId = " + this.repositoryId + TAB
	        + "revision = " + this.revision + TAB
	        + "revisionDate = " + this.revisionDate + TAB
	        + "lastChangedRevision = " + this.lastChangedRevision + TAB
	        + "author = " + this.author + TAB
	        + "relativePath = " + this.relativePath + TAB
	        + "parentDirectory = " + this.parentDirectory + TAB
	        + "numberLines = " + this.numberLines + TAB
	        + "fileName = " + this.fileName + TAB
	        + "fileType = " + this.fileType + TAB
	        + " )";
	
	    return retValue;
	}
	
}
