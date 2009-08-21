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
		if( incrementType == null ) {
			return CONST_DAILY;
		}
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

	/**
	 * Constructs a <code>String</code> with all attributes
	 * in name = value format.
	 *
	 * @return a <code>String</code> representation 
	 * of this object.
	 */
	public String toString()
	{
	    final String TAB = "    ";
	    
	    String retValue = "";
	    
	    retValue = "RefineSearchRequest ( "
	        + super.toString() + TAB
	        + "startDate = " + this.startDate + TAB
	        + "endDate = " + this.endDate + TAB
	        + "incrementType = " + this.incrementType + TAB
	        + "userNames = " + this.userNames + TAB
	        + "repositories = " + this.repositories + TAB
	        + " )";
	
	    return retValue;
	}

	
}
