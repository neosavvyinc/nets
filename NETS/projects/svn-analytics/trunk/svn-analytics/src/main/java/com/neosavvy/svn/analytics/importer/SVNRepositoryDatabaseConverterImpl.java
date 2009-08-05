package com.neosavvy.svn.analytics.importer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.tmatesoft.svn.core.SVNException;
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
import com.neosavvy.svn.analytics.importer.handler.LogEntryHandler;
import com.neosavvy.svn.analytics.util.SvnKitUtil;

public class SVNRepositoryDatabaseConverterImpl implements
        SVNRepositoryDatabaseConverter {

    private static final Logger logger = Logger
            .getLogger(SVNRepositoryDatabaseConverterImpl.class);

    private static boolean svnConverterRunning = false;
    
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
	
	/**
	 * This is the number of log entries for files and repositories that will be maintained in memory
	 * before they are flushed to the database. Increasing this value will cause more memory to be consumed
	 * during the conversion of a repository, but it will cause less database traffic during the conversion
	 * process of a repository
	 */
	private int flushThreshHold = 1;
	
	/**
	 * This is the number of times to attempt to log and convert a repository. If the number of 
	 * retries to log and convert exceeds this amount then a failure will occur for the repository 
	 * that is attempting to be converted
	 */
	private int retryFailureThreshHold = 5;
    

    public void run() {
    	synchronized (initializedRepositories) {
    		if( !svnConverterRunning ) {
    	        initialize(null);
    	        convert();
    	        tearDown();
        	} else {
        		throw new IllegalStateException("Could not begin SVN Repository conversion because it is already running");
        	}
		}
    }

    public void requestRefresh( SVNRepositoryDTO repository ) {
    	synchronized ( initializedRepositories ) {
    		initialize(repository);
    		convert();
    		tearDown();
		}
    }
    
    public void initialize(SVNRepositoryDTO repositoryToRefresh) {
    	svnConverterRunning = true;
        SvnKitUtil.setupLibrary();
        initializeSVNRepositoryObjects(repositoryToRefresh);
    }

    protected void initializeSVNRepositoryObjects(SVNRepositoryDTO repositoryToRefresh) {
    	List<SVNRepositoryDTO> repositories = svnRepositoryDAO.getRepositories();
    	if( repositoryToRefresh == null ) {
    		repositories = svnRepositoryDAO.getRepositoriesShallow();
    	} else {
    		repositories = new ArrayList<SVNRepositoryDTO>();
    		repositories.add(repositoryToRefresh);
    	}
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

            if (startRevision + flushThreshHold >= endRevision) {
	        	convertRepositoryFromStartToEndRevision(repository,
						startRevision, endRevision);
            } else {
            	convertRepositoryFromStartToEndRevision(repository,
						startRevision, startRevision + flushThreshHold - 1);
            }
            getEntryHandler().saveCachedStatistics();
            startRevision += flushThreshHold;
        }
    }

	protected void convertRepositoryFromStartToEndRevision(
			SVNRepository repository, long startRevision, long endRevision)
			throws SVNException {
		int retries = 0;
		while( retries <= retryFailureThreshHold ) {
			
			try {
		    	SVNLogClient logClient = new SVNLogClient(repository.getAuthenticationManager(), new DefaultSVNOptions());
				logClient.doLog(
						repository.getLocation(), 
						null,
						SVNRevision.create(startRevision), 
						SVNRevision.create(startRevision), 
						SVNRevision.create(endRevision), 
						false, 
						true, 
						false,
						0,
						null,
						getEntryHandler());
				//no failures occurred so leave the retry loop
				break;
			} catch (SVNException e) {
				retries++;
				logger.info("Failed to " +
						"" +
						"" +
						", retrying for the " + retries + "(st,nd,rd,th) time" , e);
				
				if( retries == retryFailureThreshHold) {
					logger.info("Exiting conversion for repository: " + repository.toString() + 
							" because the retry count was exceeded " +
							"while trying to convert between start:" + startRevision + " and end:" + endRevision);
					throw e;
				}
			}
			
		}
	}
    
    public void tearDown() {
        initializedRepositories = new HashMap<SVNRepositoryDTO, SVNRepository>();
        svnConverterRunning = false;
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

	public int getFlushThreshHold() {
		return flushThreshHold;
	}

	public void setFlushThreshHold(int flushThreshHold) {
		this.flushThreshHold = flushThreshHold;
	}
	
}
