package com.neosavvy.svn.analytics.importer;

public interface SVNRepositoryDatabaseConverter {
	
	public void initialize();
	
	public void convert();
	
	public void tearDown();

}
