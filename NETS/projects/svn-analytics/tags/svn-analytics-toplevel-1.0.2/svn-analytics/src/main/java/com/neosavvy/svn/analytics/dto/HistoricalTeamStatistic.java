package com.neosavvy.svn.analytics.dto;

public class HistoricalTeamStatistic {

	private String revisionDate;
	private long numberfOfFiles;
	private long numberOfFilesAdded;
	private long numberOfFilesDeleted;
	private long numberOfFilesModified;

	private long numberOfCommentedCommits;
	private long numberOfUnCommentedCommits;
	
	private long numberOfFilesAddedRate;
	private long numberOfFilesDeletedRate;
	private long numberOfFilesModifiedRate;
	

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

	public long getNumberOfFilesAddedRate() {
		return numberOfFilesAddedRate;
	}

	public void setNumberOfFilesAddedRate(long numberOfFilesAddedRate) {
		this.numberOfFilesAddedRate = numberOfFilesAddedRate;
	}

	public long getNumberOfFilesDeletedRate() {
		return numberOfFilesDeletedRate;
	}

	public void setNumberOfFilesDeletedRate(long numberOfFilesDeletedRate) {
		this.numberOfFilesDeletedRate = numberOfFilesDeletedRate;
	}

	public long getNumberOfFilesModifiedRate() {
		return numberOfFilesModifiedRate;
	}

	public void setNumberOfFilesModifiedRate(long numberOfFilesModifiedRate) {
		this.numberOfFilesModifiedRate = numberOfFilesModifiedRate;
	}

}
