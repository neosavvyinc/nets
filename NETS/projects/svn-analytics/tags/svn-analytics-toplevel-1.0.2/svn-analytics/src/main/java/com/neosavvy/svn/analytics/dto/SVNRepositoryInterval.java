package com.neosavvy.svn.analytics.dto;

import java.util.Date;

public class SVNRepositoryInterval {

	private String startMonthDate;
	private String endMonthDate;

	private Date startDayLevelDate;
	private Date endDayLevelDate;

	public String getStartMonthDate() {
		return startMonthDate;
	}

	public void setStartMonthDate(String startMonthDate) {
		this.startMonthDate = startMonthDate;
	}

	public String getEndMonthDate() {
		return endMonthDate;
	}

	public void setEndMonthDate(String endMonthDate) {
		this.endMonthDate = endMonthDate;
	}

	public Date getStartDayLevelDate() {
		return startDayLevelDate;
	}

	public void setStartDayLevelDate(Date startDayLevelDate) {
		this.startDayLevelDate = startDayLevelDate;
	}

	public Date getEndDayLevelDate() {
		return endDayLevelDate;
	}

	public void setEndDayLevelDate(Date endDayLevelDate) {
		this.endDayLevelDate = endDayLevelDate;
	}

}
