package com.neosavvy.svn.analytics.dto;

import java.util.Date;

public class OverallTeamStatistic {

    private String author;
    private long numberOfCommits;

    private long numberOfFilesTouched;
    private long numberOfFilesAdded;
    private long numberOfFilesModified;
    private long numberOfFilesDeleted;

    private Date firstCommitDate;
    private Date lastCommitDate;

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public long getNumberOfCommits() {
        return numberOfCommits;
    }

    public void setNumberOfCommits(long numberOfCommits) {
        this.numberOfCommits = numberOfCommits;
    }

    public long getNumberOfFilesTouched() {
        return numberOfFilesTouched;
    }

    public void setNumberOfFilesTouched(long numberOfFilesTouched) {
        this.numberOfFilesTouched = numberOfFilesTouched;
    }

    public long getNumberOfFilesAdded() {
        return numberOfFilesAdded;
    }

    public void setNumberOfFilesAdded(long numberOfFilesAdded) {
        this.numberOfFilesAdded = numberOfFilesAdded;
    }

    public long getNumberOfFilesModified() {
        return numberOfFilesModified;
    }

    public void setNumberOfFilesModified(long numberOfFilesModified) {
        this.numberOfFilesModified = numberOfFilesModified;
    }

    public long getNumberOfFilesDeleted() {
        return numberOfFilesDeleted;
    }

    public void setNumberOfFilesDeleted(long numberOfFilesDeleted) {
        this.numberOfFilesDeleted = numberOfFilesDeleted;
    }

    public Date getFirstCommitDate() {
        return firstCommitDate;
    }

    public void setFirstCommitDate(Date firstCommitDate) {
        this.firstCommitDate = firstCommitDate;
    }

    public Date getLastCommitDate() {
        return lastCommitDate;
    }

    public void setLastCommitDate(Date lastCommitDate) {
        this.lastCommitDate = lastCommitDate;
    }

}