package com.neosavvy.svn.importer;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;
import org.tmatesoft.svn.core.*;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.internal.wc.DefaultSVNOptions;
import org.tmatesoft.svn.core.io.SVNRepository;
import org.tmatesoft.svn.core.io.SVNRepositoryFactory;
import org.tmatesoft.svn.core.wc.SVNLogClient;
import org.tmatesoft.svn.core.wc.SVNRevision;
import org.tmatesoft.svn.core.wc.SVNWCUtil;

import com.neosavvy.svn.analytics.importer.handler.AnnotationPrintHandler;
import com.neosavvy.svn.analytics.util.SvnKitUtil;

public class TestFileBasedSvnKitOperations {


    @Test
    public void testFindFirstRevisionForDirectory() throws SVNException {
        SvnKitUtil.setupLibrary();
        SVNRepository repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded("http://neosavvy.com/svn/projects/commons-user/"));
        ISVNAuthenticationManager authManager = SVNWCUtil.createDefaultAuthenticationManager("aparrish", "aparrish");
        repository.setAuthenticationManager(authManager);
        SVNLogClient logClient = new SVNLogClient(repository
				.getAuthenticationManager(), new DefaultSVNOptions());

        logClient.doLog(
                repository.getLocation()
                ,new String[]{}
                ,SVNRevision.create(0L)
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
                       System.out.println(minValueForBranch);
                    }
                }

        );

        Assert.assertEquals("The value determined did not match the value expected",minValueForBranch, 162L);
    }

    private long minValueForBranch=Long.MAX_VALUE;


	@Test
	public void testFileConversion() throws SVNException {
		SvnKitUtil.setupLibrary();
		SVNRepository repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded("http://neosavvy.com/svn/neosavvy/"));
		ISVNAuthenticationManager authManager = SVNWCUtil.createDefaultAuthenticationManager("aparrish", "aparrish");
		repository.setAuthenticationManager(authManager);
		
		int revision = 5;
		List<SVNDirEntry> reposTree = getReposTree(repository, revision);
		
		List<SVNDirEntry> directories = new ArrayList<SVNDirEntry>();
		List<SVNDirEntry> files = new ArrayList<SVNDirEntry>();
		List<SVNDirEntry> none = new ArrayList<SVNDirEntry>();
		List<SVNDirEntry> unknown = new ArrayList<SVNDirEntry>();
		
		for (SVNDirEntry entry : reposTree) {
			if( entry.getKind() == SVNNodeKind.DIR ) {
				directories.add( entry );
			} else if (entry.getKind() == SVNNodeKind.FILE ) {
				files.add( entry );
			} else if (entry.getKind() == SVNNodeKind.NONE) {
				none.add( entry );
			} else if (entry.getKind() == SVNNodeKind.UNKNOWN) {
				unknown.add( entry );
			}
		}
		
		dumpSvnDirEntryCollection(directories);
		dumpSvnDirEntryCollection(files);
		//dumpSvnFileEntries(files, repository, revision);
//		dumpSvnDirEntryCollection(none);
//		dumpSvnDirEntryCollection(unknown);
		
	}
	
	public void dumpSvnDirEntryCollection( List<SVNDirEntry> entries ) {
		for (SVNDirEntry dirEntry : entries) {
			System.out.println(dirEntry + " path: " + dirEntry.getRelativePath());
		}
	}
	
	public void dumpSvnFileEntries( List<SVNDirEntry> entries, SVNRepository repository, long revision) {
		for (SVNDirEntry dirEntry : entries) {
			annotateFileForRepository(repository, dirEntry, revision, revision, revision);
		}
	}
 
	public List<SVNDirEntry> getReposTree(SVNRepository repository, long revision) {
		SVNLogClient logClient = new SVNLogClient(repository
				.getAuthenticationManager(), new DefaultSVNOptions());
		final List<SVNDirEntry> entries = new LinkedList<SVNDirEntry>();
		try {
			logClient.doList(
						repository.getLocation(), 
						SVNRevision.create(revision), 
						SVNRevision.create(revision), 
						false, 
						true, 
						new ISVNDirEntryHandler() {
							public void handleDirEntry(SVNDirEntry entry)
									throws SVNException {
								entries.add(entry);
						}
					});
		} catch (SVNException e) {
			e.printStackTrace();
		}
		return entries;
	}
	
	public void annotateFileForRepository(SVNRepository repository, SVNDirEntry fileEntry, long pegRevision, long startRevision, long endRevision) {
		SVNLogClient logClient = new SVNLogClient(repository.getAuthenticationManager(), new DefaultSVNOptions());

		System.out.println("\n\n" + fileEntry + " path: " + fileEntry.getRelativePath());
		
		try {
			SVNURL url = repository.getLocation();
			SVNURL appendPath = url.appendPath(fileEntry.getRelativePath(), false);
			logClient.doAnnotate(
						appendPath, 
						SVNRevision.create(pegRevision), 
						SVNRevision.create(startRevision), 
						SVNRevision.create(endRevision), 
						true, 
						false, 
						new AnnotationPrintHandler()
					, null);

		} catch (SVNException e) {
			e.printStackTrace();
		}
	}
}
