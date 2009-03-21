package com.neosavvy.svn.analytics.dto;

import java.util.Date;

import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.SVNLogEntryPath;

/**
 * This class encapsulates the Data calculated to help generate statistics on
 * SVN commits from a SVN Repository
 * 
 * 
 * @author adamparrish
 * @version 1.0
 */
public class SVNStatistic {

	public SVNStatistic() {
		super();
	}

	public SVNStatistic(SVNLogEntry entry) {
		this.setAuthor(entry.getAuthor());
		this.setDate(entry.getDate());
		this.setMessage(entry.getMessage());
		this.setNumFilesInRevision(entry.getChangedPaths().keySet().size());
		calculatePathEntryStatistics(entry);
	}

	protected void calculatePathEntryStatistics(SVNLogEntry entry) {

		numFilesAddedInRevision = 0;
		numFilesDeletedInRevision = 0;
		numFilesModifiedInRevision = 0;
		for (Object pathKey : entry.getChangedPaths().keySet()) {
			SVNLogEntryPath path = (SVNLogEntryPath) entry.getChangedPaths()
					.get(pathKey);
			char type = path.getType();
			if (type == 'A') {
				numFilesAddedInRevision++;
			} else if (type == 'D') {
				numFilesDeletedInRevision++;
			} else if (type == 'M') {
				numFilesModifiedInRevision++;
			}
		}
	}

	/**
	 * The author for the revision
	 * 
	 * @see org.tmatesoft.svn.core.SVNLogEntry#getAuthor()
	 */
	private String author;

	/**
	 * The revision of the current statistic
	 * 
	 * @see org.tmatesoft.svn.core.SVNLogEntry#getRevision()
	 */
	private long revision;

	/**
	 * The date of the revision's creation
	 * 
	 * @see org.tmatesoft.svn.core.SVNLogEntry#getDate()
	 */
	private Date date;

	/**
	 * The message entered by the user during commit
	 * 
	 * @see org.tmatesoft.svn.core.SVNLogEntry#getMessage()
	 */
	private String message;

	/**
	 * Derived via taking the count of the keySet SVNLogEntry.getChangedPaths()
	 * 
	 * @see org.tmatesoft.svn.core.SVNLogEntry#getChangedPaths()
	 */
	private int numFilesInRevision;

	/**
	 * Derived via taking the count of the values from
	 * SVNLogEntry.getChangedPaths() who have a value of 'A'
	 * 
	 * @see org.tmatesoft.svn.core.SVNLogEntryPath#getType()
	 */
	private int numFilesAddedInRevision;

	/**
	 * Derived via taking the count of the values from
	 * SVNLogEntry.getChangedPaths() who have a value of 'D'
	 * 
	 * @see org.tmatesoft.svn.core.SVNLogEntryPath#getType()
	 */
	private int numFilesDeletedInRevision;

	/**
	 * Derived via taking the count of the values from
	 * SVNLogEntry.getChangedPaths() who have a value of 'M'
	 * 
	 * @see org.tmatesoft.svn.core.SVNLogEntryPath#getType()
	 */
	private int numFilesModifiedInRevision;

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public long getRevision() {
		return revision;
	}

	public void setRevision(long revision) {
		this.revision = revision;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getNumFilesInRevision() {
		return numFilesInRevision;
	}

	public void setNumFilesInRevision(int numFilesInRevision) {
		this.numFilesInRevision = numFilesInRevision;
	}

	public int getNumFilesAddedInRevision() {
		return numFilesAddedInRevision;
	}

	public void setNumFilesAddedInRevision(int numFilesAddedInRevision) {
		this.numFilesAddedInRevision = numFilesAddedInRevision;
	}

	public int getNumFilesDeletedInRevision() {
		return numFilesDeletedInRevision;
	}

	public void setNumFilesDeletedInRevision(int numFilesDeletedInRevision) {
		this.numFilesDeletedInRevision = numFilesDeletedInRevision;
	}

	public int getNumFilesModifiedInRevision() {
		return numFilesModifiedInRevision;
	}

	public void setNumFilesModifiedInRevision(int numFilesModifiedInRevision) {
		this.numFilesModifiedInRevision = numFilesModifiedInRevision;
	}

	/**
	 * Constructs a <code>String</code> with all attributes in name = value
	 * format.
	 * 
	 * @return a <code>String</code> representation of this object.
	 */
	public String toString() {
		final String TAB = "    ";

		String retValue = "";

		retValue = "SVNStatistic ( " + super.toString() + TAB + "author = "
				+ this.author + TAB + "revision = " + this.revision + TAB
				+ "date = " + this.date + TAB + "message = " + this.message
				+ TAB + "numFilesInRevision = " + this.numFilesInRevision + TAB
				+ "numFilesAddedInRevision = " + this.numFilesAddedInRevision
				+ TAB + "numFilesDeletedInRevision = "
				+ this.numFilesDeletedInRevision + TAB
				+ "numFilesModifiedInRevision = "
				+ this.numFilesModifiedInRevision + TAB + " )";

		return retValue;
	}

}
