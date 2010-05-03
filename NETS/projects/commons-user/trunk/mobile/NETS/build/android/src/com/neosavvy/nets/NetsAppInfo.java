package com.neosavvy.nets;

import org.appcelerator.titanium.ITiAppInfo;
import org.appcelerator.titanium.TiApplication;
import org.appcelerator.titanium.TiProperties;
import org.appcelerator.titanium.util.Log;

/* GENERATED CODE
 * Warning - this class was generated from your application's tiapp.xml
 * Any changes you make here will be overwritten
 */
public class NetsAppInfo implements ITiAppInfo
{
	private static final String LCAT = "AppInfo";
	
	public NetsAppInfo(TiApplication app) {
		TiProperties properties = app.getAppProperties();
					
		properties.setString("ti.deploytype", "development");
		properties.setBool("ti.android.loadfromsdcard", true);
	}
	
	public String getId() {
		return "com.neosavvy.nets";
	}
	
	public String getName() {
		return "NETS";
	}
	
	public String getVersion() {
		return "1.0";
	}
	
	public String getPublisher() {
		return "Neosavvy, inc.";
	}
	
	public String getUrl() {
		return "http://www.neosavvy.com";
	}
	
	public String getCopyright() {
		return "2010 by Neosavvy, inc.";
	}
	
	public String getDescription() {
		return "No description provided";
	}
	
	public String getIcon() {
		return "appicon.png";
	}
	
	public boolean isAnalyticsEnabled() {
		return true;
	}
	
	public String getGUID() {
		return "b8073cf1-feb4-428a-8aef-fa9e18cc13f2";
	}
}
