package com.neosavvy.svn.analytics.dto.request;

import java.util.Date;

public class RefineSearchRequest {

	public static String CONST_DAILY = "daily";
	public static String CONST_MONTHLY = "monthly";
	
	private Date startDate;
	private Date endDate;
	
	private String incrementType = CONST_DAILY;

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

	public String getIncrementType() {
		return incrementType;
	}

	public void setIncrementType(String incrementType) {
		this.incrementType = incrementType;
	}

}
