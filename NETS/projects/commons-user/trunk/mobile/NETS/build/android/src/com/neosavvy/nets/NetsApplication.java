package com.neosavvy.nets;

import org.appcelerator.titanium.TiApplication;

public class NetsApplication extends TiApplication {

	@Override
	public void onCreate() {
		super.onCreate();
		
		appInfo = new NetsAppInfo(this);
	}
}
