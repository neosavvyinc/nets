package com.neosavvy.svn.analytics.dto.request;

import java.util.Date;

import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;

public class RefineSearchRequest {

	public static String CONST_DAILY = "daily";
	public static String CONST_MONTHLY = "monthly";
	
	private Date startDate;
	private Date endDate;
	
	private String incrementType = CONST_DAILY;

	private String[] userNames;
	private SVNRepositoryDTO[] repositories;

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

	public SVNRepositoryDTO[] getRepositories() {
		return repositories;
	}

	public void setRepositories(SVNRepositoryDTO[] repositories) {
		this.repositories = repositories;
	}
	
}
