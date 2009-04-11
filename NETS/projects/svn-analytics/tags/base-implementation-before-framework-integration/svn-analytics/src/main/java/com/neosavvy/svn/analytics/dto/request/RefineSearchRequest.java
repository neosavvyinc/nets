package com.neosavvy.svn.analytics.dto.request;

import java.util.Date;

public class RefineSearchRequest {

	private Date startDate;
	private Date endDate;

	private String[] userNames;

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String[] getUserNames() {
		return userNames;
	}

	public void setUserNames(String[] userNames) {
		this.userNames = userNames;
	}

}
