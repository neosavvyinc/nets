package com.neosavvy.svn;

import org.apache.log4j.Logger;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import org.junit.Assert;

public class TestUtils {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(TestUtils.class);

	public static Date getDate(String date) {
	    try {
			return getDate(date, "yyyy-MM-dd");
		} catch (ParseException e) {
			logger.error(e);
			Assert.fail();
			throw new RuntimeException("Failed parsing date: " + date);
		}
	}
	
	public static Date getDate(String date, String format) throws ParseException {
	    SimpleDateFormat formatter = new SimpleDateFormat(format);
	    formatter.setTimeZone(TimeZone.getTimeZone("GMT-0"));
	    return formatter.parse(date);
	}
	
}
