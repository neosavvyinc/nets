package com.neosavvy.svn.analytics.dto;

public class HistoricalTeamStatistic {

	private String revisionDate;
	private long numberfOfFiles;
	private long numberOfFilesAdded;
	private long numberOfFilesDeleted;
	private long numberOfFilesModified;

	private long numberOfCommentedCommits;
	private long numberOfUnCommentedCommits;

	private long maxValue;
	
	public String getRevisionDate() {
		return revisionDate;
	}

	public void setRevisionDate(String revisionDate) {
		this.revisionDate = revisionDate;
	}

	public long getNumberfOfFiles() {
		return numberfOfFiles;
	}

	public void setNumberfOfFiles(long numberfOfFiles) {
		this.numberfOfFiles = numberfOfFiles;
	}

	public long getNumberOfFilesAdded() {
		return numberOfFilesAdded;
	}

	public void setNumberOfFilesAdded(long numberOfFilesAdded) {
		this.numberOfFilesAdded = numberOfFilesAdded;
	}

	public long getNumberOfFilesDeleted() {
		return numberOfFilesDeleted;
	}

	public void setNumberOfFilesDeleted(long numberOfFilesDeleted) {
		this.numberOfFilesDeleted = numberOfFilesDeleted;
	}

	public long getNumberOfFilesModified() {
		return numberOfFilesModified;
	}

	public void setNumberOfFilesModified(long numberOfFilesModified) {
		this.numberOfFilesModified = numberOfFilesModified;
	}

	public long getNumberOfCommentedCommits() {
		return numberOfCommentedCommits;
	}

	public void setNumberOfCommentedCommits(long numberOfCommentedCommits) {
		this.numberOfCommentedCommits = numberOfCommentedCommits;
	}

	public long getNumberOfUnCommentedCommits() {
		return numberOfUnCommentedCommits;
	}

	public void setNumberOfUnCommentedCommits(long numberOfUnCommentedCommits) {
		this.numberOfUnCommentedCommits = numberOfUnCommentedCommits;
	}

	public long getMaxValue() {
		return maxValue;
	}

	public void setMaxValue(long maxValue) {
		this.maxValue = maxValue;
	}

}
