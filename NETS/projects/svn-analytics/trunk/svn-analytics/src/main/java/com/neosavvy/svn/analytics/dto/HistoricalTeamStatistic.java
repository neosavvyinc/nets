package com.neosavvy.svn.analytics.dto;


public class HistoricalTeamStatistic {

    private String revisionDate;
    private long numberfOfFiles;
    private long numberOfFilesAdded;
    private long numberOfFilesDeleted;
    private long numberOfFilesModified;

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

}
