package com.neosavvy.svn.analytics.importer;

import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;

public interface SVNRepositoryDatabaseConverter {

    public void initialize(SVNRepositoryDTO repositoryToRefresh);

    public void convert();

    public void tearDown();

    public void run();
    
    public void requestRefresh(SVNRepositoryDTO repositoryToRefresh);

}
