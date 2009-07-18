package com.neosavvy.svn.importer;

import org.apache.log4j.Logger;
import org.apache.log4j.xml.Log4jEntityResolver;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNURL;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.internal.wc.DefaultSVNOptions;
import org.tmatesoft.svn.core.io.SVNRepository;
import org.tmatesoft.svn.core.io.SVNRepositoryFactory;
import org.tmatesoft.svn.core.wc.SVNLogClient;
import org.tmatesoft.svn.core.wc.SVNRevision;
import org.tmatesoft.svn.core.wc.SVNWCUtil;

import com.neosavvy.junit4.BaseSpringAwareTestCase;
import com.neosavvy.svn.analytics.dao.SVNFileSystemNodeDAO;
import com.neosavvy.svn.analytics.importer.SVNRepositoryDatabaseConverter;
import com.neosavvy.svn.analytics.importer.handler.EntryHandler;
import com.neosavvy.svn.analytics.util.SvnKitUtil;

public class TestSVNRepositoryConverter extends BaseSpringAwareTestCase {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(TestSVNRepositoryConverter.class);

	@Autowired
	private SVNRepositoryDatabaseConverter converter;

	@Autowired
	private SVNFileSystemNodeDAO fileSystemDao;

	@Test
	public void testRun() {
		converter.run();
	}

	@Test
	public void testBrokenRevision() {
		SvnKitUtil.setupLibrary();
		SVNRepository repository;
		try {
			repository = SVNRepositoryFactory.create(SVNURL
					.parseURIEncoded("http://neosavvy.com/svn/neosavvy"));
			ISVNAuthenticationManager authManager = SVNWCUtil
					.createDefaultAuthenticationManager("aparrish", "aparrish");
			repository.setAuthenticationManager(authManager);
			processRepositoryTree(repository, 27);
		} catch (SVNException e) {
			if (logger.isInfoEnabled()) {
				logger
						.info("testBrokenRevision() - Error while converting the revison",e);
			}

			e.printStackTrace();
		}

	}

	protected void processRepositoryTree(SVNRepository repository, long revision)
			throws SVNException {
		SVNLogClient logClient = new SVNLogClient(repository
				.getAuthenticationManager(), new DefaultSVNOptions());
		EntryHandler entryHandler = new EntryHandler();
		entryHandler.setFileSystemDao(fileSystemDao);
		logClient.doList(repository.getLocation(),
				SVNRevision.create(revision), SVNRevision.create(revision),
				false, true, entryHandler);
	}

}
