package com.neosavvy.svn.analytics.importer.helper;

import com.neosavvy.svn.analytics.util.SvnKitUtil;
import org.tmatesoft.svn.core.ISVNLogEntryHandler;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.SVNURL;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.internal.wc.DefaultSVNOptions;
import org.tmatesoft.svn.core.io.SVNRepository;
import org.tmatesoft.svn.core.io.SVNRepositoryFactory;
import org.tmatesoft.svn.core.wc.SVNLogClient;
import org.tmatesoft.svn.core.wc.SVNRevision;
import org.tmatesoft.svn.core.wc.SVNWCUtil;

/**
 * This code is the intellectual property of Neosavvy, Inc.
 *
 * @author adamparrish
 *         Date: Oct 20, 2009
 *         Time: 11:39:09 PM
 */
public class RepositoryMinRevisionHelper {

    private  long minValueForBranch = Long.MAX_VALUE;
    public long determineMinRevisionForRepository(String url, String username, String password) throws SVNException {
        SvnKitUtil.setupLibrary();
        SVNRepository repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(url));
        ISVNAuthenticationManager authManager = SVNWCUtil.createDefaultAuthenticationManager(username, password);
        repository.setAuthenticationManager(authManager);
        SVNLogClient logClient = new SVNLogClient(repository
				.getAuthenticationManager(), new DefaultSVNOptions());

        logClient.doLog(
                repository.getLocation()
                ,new String[]{}
                , SVNRevision.create(0L)
                ,SVNRevision.HEAD
                ,SVNRevision.create(0L)
                ,true
                ,false
                ,0L
                ,new ISVNLogEntryHandler(){
                    public void handleLogEntry(SVNLogEntry svnLogEntry) throws SVNException {
                       if(minValueForBranch > svnLogEntry.getRevision()) {
                           minValueForBranch = svnLogEntry.getRevision();
                       }
                    }
                }

        );
        return minValueForBranch;
    }
}
