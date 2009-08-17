package com.neosavvy.svn.analytics.service;

import org.apache.log4j.Logger;

import com.neosavvy.svn.analytics.dao.CodeOwnershipDAO;
import com.neosavvy.svn.analytics.dao.SVNStatisticDAO;
import com.neosavvy.svn.analytics.dto.Author;
import com.neosavvy.svn.analytics.dto.CodeOwnershipDTO;
import com.neosavvy.svn.analytics.dto.HistoricalTeamStatistic;
import com.neosavvy.svn.analytics.dto.OverallTeamStatistic;
import com.neosavvy.svn.analytics.dto.SVNRepositoryInterval;
import com.neosavvy.svn.analytics.dto.file.FileSystemNode;
import com.neosavvy.svn.analytics.dto.request.RefineSearchRequest;

public class SvnStatServiceImpl implements SvnStatService {

	private static final Logger logger = Logger
			.getLogger(SvnStatServiceImpl.class);

	private SVNStatisticDAO dao;
	
	private CodeOwnershipDAO codeOwnershipDAO;

	public SVNStatisticDAO getDao() {
		return dao;
	}

	public void setDao(SVNStatisticDAO dao) {
		this.dao = dao;
	}

	public CodeOwnershipDAO getCodeOwnershipDAO() {
		return codeOwnershipDAO;
	}

	public void setCodeOwnershipDAO(CodeOwnershipDAO codeOwnershipDAO) {
		this.codeOwnershipDAO = codeOwnershipDAO;
	}
	
	public OverallTeamStatistic[] getOverallTeamStatistics() {
		return dao.getOverallTeamStats();
	}

	public HistoricalTeamStatistic[] getHistoricalTeamStatistics() {
		return dao.getHistoricalTeamStats();
	}

	public Author[] getAuthors() {
		return dao.getAuthors();
	}

	public SVNRepositoryInterval getRepositoryInterval() {
		return dao.getRepositoryInterval();
	}

	public HistoricalTeamStatistic[] getRefinedHistoricalTeamStatistics(
			RefineSearchRequest request) {
		return dao.getRefinedHistoricalStats(request);
	}

	public OverallTeamStatistic[] getRefinedTeamStatistics(
			RefineSearchRequest request) {
		return dao.getRefinedTeamStats(request);
	}

	public CodeOwnershipDTO[] getOwnership(FileSystemNode parent) {
		return getCodeOwnershipDAO().getCodeOwnership( parent );
	}

}
