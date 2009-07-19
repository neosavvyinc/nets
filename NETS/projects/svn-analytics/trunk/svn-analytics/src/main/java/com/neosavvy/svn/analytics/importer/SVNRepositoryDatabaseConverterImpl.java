package com.neosavvy.svn.analytics.importer;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
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

import com.neosavvy.svn.analytics.dao.SVNFileSystemNodeDAO;
import com.neosavvy.svn.analytics.dao.SVNRepositoryDAO;
import com.neosavvy.svn.analytics.dao.SVNStatisticDAO;
import com.neosavvy.svn.analytics.dto.SVNRepositoryConversionInfo;
import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
import com.neosavvy.svn.analytics.dto.SVNStatistic;
import com.neosavvy.svn.analytics.importer.handler.LogEntryHandler;
import com.neosavvy.svn.analytics.util.SvnKitUtil;

public class SVNRepositoryDatabaseConverterImpl implements
        SVNRepositoryDatabaseConverter {

    private static final Logger logger = Logger
            .getLogger(SVNRepositoryDatabaseConverterImpl.class);

    /**
     * This member contains the list of repository configuration model objects
     * that will be initialized during a conversion step and then later used to
     * drive authentication to the remote SVN repository
     * 
     * This is a Spring Configurable property.
     */
    //private List<SVNRepositoryDTO> repositories;

    /**
     * This map maintains a reference to the configuration in its key and then a
     * reference to the initialized repository after the repository is
     * initialized.
     * 
     * This is not a Spring configurable property as it is derived on startup.
     */
    private Map<SVNRepositoryDTO, SVNRepository> initializedRepositories = new HashMap<SVNRepositoryDTO, SVNRepository>();

    private SVNRepositoryDAO svnRepositoryDAO;
    private SVNStatisticDAO svnStatisticsDAO;
    private SVNFileSystemNodeDAO fileSystemDao;
	private LogEntryHandler entryHandler;
    

    public void run() {

        initialize();
        convert();
        tearDown();

    }

    public void initialize() {

        SvnKitUtil.setupLibrary();
        initializeSVNRepositoryObjects();

    }

    protected void initializeSVNRepositoryObjects() {
    	List<SVNRepositoryDTO> repositories = svnRepositoryDAO.getRepositories();
        for (SVNRepositoryDTO model : repositories) {
            try {
                SVNRepository repository = SVNRepositoryFactory.create(SVNURL
                        .parseURIEncoded(model.getUrl()));

                ISVNAuthenticationManager authManager = SVNWCUtil
                        .createDefaultAuthenticationManager(model.getUserName(),
                                model.getPassword());
                repository.setAuthenticationManager(authManager);
                model.setEndRevision(repository.getLatestRevision());
                initializedRepositories.put(model, repository);
            } catch (SVNException e) {
                logger.error("Failed to initialize a repository for: "
                        + model.toString(), e);
            }
        }
    }

    public void convert() {

        if (logger.isInfoEnabled()) {
            logger
                    .info("Beginning conversion of all configured repositories...");
        }

        for (SVNRepositoryDTO modelKey : initializedRepositories.keySet()) {

            if (logger.isInfoEnabled()) {
                logger.info("Conversion of repository named: "
                        + modelKey.getUrl() + " beginning...");
            }

            SVNRepository repository = initializedRepositories.get(modelKey);

            long startRevision = modelKey.getStartRevision();
            long endRevision = modelKey.getEndRevision();
            
            SVNRepositoryConversionInfo info = getSvnStatisticsDAO().getRepositoryInfo(modelKey.getUrl());
            if(info.getLastUpdateRevision() > startRevision) {
            	startRevision = info.getLastUpdateRevision() + 1;
            }
            
            convertRevisionsWithLogClientAndLog(modelKey, repository,
					startRevision, endRevision);

        }

    }

	private void convertRevisionsWithLogClientAndLog(SVNRepositoryDTO modelKey,
			SVNRepository repository, long startRevision, long endRevision) {
		try {
		    batchConvertRevisionsIntoDatabase(repository, startRevision,
		            endRevision, modelKey);
		} catch (SVNException e) {
		    logger.error(
		            "There was an error converting the repository from "
		                    + startRevision + " to " + endRevision
		                    + " for the " + modelKey.getUrl()
		                    + " repository.", e);
		}
	}

    protected void batchConvertRevisionsIntoDatabase(SVNRepository repository,
            long startRevision, long endRevision, SVNRepositoryDTO svnRepositoryModel) throws SVNException {
        getEntryHandler().setRepositoryModel(svnRepositoryModel);
        getEntryHandler().setRepository(repository);
        while (startRevision <= endRevision) {

            if (startRevision + 100 >= endRevision) {
	        	SVNLogClient logClient = new SVNLogClient(repository.getAuthenticationManager(), new DefaultSVNOptions());
	    		logClient.doLog(
	    				repository.getLocation(), 
    					null,
    					SVNRevision.create(startRevision), 
    					SVNRevision.create(startRevision), 
    					SVNRevision.create(endRevision), 
    					false, 
    					true, 
    					true,
    					0,
    					null,
    					getEntryHandler());
            } else {
            	SVNLogClient logClient = new SVNLogClient(repository.getAuthenticationManager(), new DefaultSVNOptions());
	    		logClient.doLog(
	    					repository.getLocation(), 
	    					null,
	    					SVNRevision.create(startRevision), 
	    					SVNRevision.create(startRevision), 
	    					SVNRevision.create(startRevision + 99), 
	    					false, 
	    					true, 
	    					true,
	    					0,
	    					null,
	    					getEntryHandler());
            }
            getEntryHandler().saveCachedStatistics();
            startRevision += 100;
        }
    }
    
    public void tearDown() {

        initializedRepositories = new HashMap<SVNRepositoryDTO, SVNRepository>();

    }

	public SVNRepositoryDAO getSvnRepositoryDAO() {
		return svnRepositoryDAO;
	}

	public void setSvnRepositoryDAO(SVNRepositoryDAO svnRepositoryDAO) {
		this.svnRepositoryDAO = svnRepositoryDAO;
	}

	public SVNStatisticDAO getSvnStatisticsDAO() {
		return svnStatisticsDAO;
	}

	public void setSvnStatisticsDAO(SVNStatisticDAO svnStatisticsDAO) {
		this.svnStatisticsDAO = svnStatisticsDAO;
	}

    public LogEntryHandler getEntryHandler() {
		return entryHandler;
	}

	public void setEntryHandler(LogEntryHandler entryHandler) {
		this.entryHandler = entryHandler;
	}

	public SVNFileSystemNodeDAO getFileSystemDao() {
		return fileSystemDao;
	}

	public void setFileSystemDao(SVNFileSystemNodeDAO fileSystemDao) {
		this.fileSystemDao = fileSystemDao;
	}

}
