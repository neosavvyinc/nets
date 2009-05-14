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
import org.tmatesoft.svn.core.io.SVNRepository;
import org.tmatesoft.svn.core.io.SVNRepositoryFactory;
import org.tmatesoft.svn.core.wc.SVNWCUtil;

import com.neosavvy.svn.analytics.dao.SVNRepositoryDAO;
import com.neosavvy.svn.analytics.dao.SVNStatisticDAO;
import com.neosavvy.svn.analytics.dto.SVNRepositoryConversionInfo;
import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
import com.neosavvy.svn.analytics.dto.SVNStatistic;
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
                        .createDefaultAuthenticationManager(model.getName(),
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

    }

    @SuppressWarnings("unchecked")
    protected void batchConvertRevisionsIntoDatabase(SVNRepository repository,
            long startRevision, long endRevision, SVNRepositoryDTO svnRepositoryModel) throws SVNException {
        Collection<SVNLogEntry> log;
        while (startRevision <= endRevision) {

            if (startRevision + 100 >= endRevision) {
                log = repository.log(new String[] { "" }, null, startRevision,
                        endRevision, true, true);
            } else {
                log = repository.log(new String[] { "" }, null, startRevision,
                        startRevision + 99, true, true);
            }
            List<SVNStatistic> stats = new ArrayList<SVNStatistic>();
            for (Object entry : log.toArray()) {
                if (entry instanceof SVNLogEntry) {
                    stats.add(new SVNStatistic((SVNLogEntry) entry, svnRepositoryModel));
                }
            }

            getSvnStatisticsDAO().saveStatistics(stats);
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

}
