package com.neosavvy.svn.analytics.dto;

public class SVNRepositoryConversionInfo {

	private String repositoryURL;
	private long lastUpdateRevision = 0;

	public String getRepositoryURL() {
		return repositoryURL;
	}

	public void setRepositoryURL(String repositoryURL) {
		this.repositoryURL = repositoryURL;
	}

	public long getLastUpdateRevision() {
		return lastUpdateRevision;
	}

	public void setLastUpdateRevision(long lastUpdateRevision) {
		this.lastUpdateRevision = lastUpdateRevision;
	}

	public String toString() {
		final String TAB = "    ";

		String retValue = "";

		retValue = "SVNRepositoryConversionInfo ( " + super.toString() + TAB
				+ "repositoryURL = " + this.repositoryURL + TAB
				+ "lastUpdateRevision = " + this.lastUpdateRevision + TAB
				+ " )";

		return retValue;
	}

}
