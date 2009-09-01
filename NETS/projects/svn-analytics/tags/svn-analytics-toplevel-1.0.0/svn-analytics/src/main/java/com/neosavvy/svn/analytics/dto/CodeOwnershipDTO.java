package com.neosavvy.svn.analytics.dto;

public class CodeOwnershipDTO {

	private String author;
	private Integer numberOfLinesInRevision;
	private Integer totalLines;
	private Double contributionRatio;

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public Integer getNumberOfLinesInRevision() {
		return numberOfLinesInRevision;
	}

	public void setNumberOfLinesInRevision(Integer numberOfLinesInRevision) {
		this.numberOfLinesInRevision = numberOfLinesInRevision;
	}

	public Integer getTotalLines() {
		return totalLines;
	}

	public void setTotalLines(Integer totalLines) {
		this.totalLines = totalLines;
	}

	public Double getContributionRatio() {
		return contributionRatio;
	}

	public void setContributionRatio(Double contributionRatio) {
		this.contributionRatio = contributionRatio;
	}

}
