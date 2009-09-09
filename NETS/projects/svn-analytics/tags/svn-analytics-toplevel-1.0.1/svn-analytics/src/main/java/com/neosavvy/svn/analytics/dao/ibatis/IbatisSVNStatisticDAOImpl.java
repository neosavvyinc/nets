package com.neosavvy.svn.analytics.dao.ibatis;

import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapExecutor;
import com.neosavvy.svn.analytics.dao.SVNStatisticDAO;
import com.neosavvy.svn.analytics.dto.Author;
import com.neosavvy.svn.analytics.dto.HistoricalTeamStatistic;
import com.neosavvy.svn.analytics.dto.OverallTeamStatistic;
import com.neosavvy.svn.analytics.dto.SVNRepositoryConversionInfo;
import com.neosavvy.svn.analytics.dto.SVNRepositoryInterval;
import com.neosavvy.svn.analytics.dto.SVNStatistic;
import com.neosavvy.svn.analytics.dto.request.RefineSearchRequest;

public class IbatisSVNStatisticDAOImpl extends SqlMapClientDaoSupport implements
		SVNStatisticDAO {

	public static final String SVNSTATISTICS_INSERT_STATISTIC = "SVNStatistics.insertStatistic";
	private static final Logger logger = Logger
			.getLogger(IbatisSVNStatisticDAOImpl.class);

	public void saveStatistics(final List<SVNStatistic> statistics) {

		getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
			public Object doInSqlMapClient(SqlMapExecutor executor)
					throws SQLException {

				executor.startBatch();
				for (SVNStatistic stat : statistics) {
					logger.info("Executing insert for: " + stat.toString());
					executor.insert(SVNSTATISTICS_INSERT_STATISTIC, stat);
				}
				int rowsaffected = executor.executeBatch();

				if (logger.isInfoEnabled()) {
					logger.info("Inserted " + rowsaffected
							+ " for SVNStatistics");
				}

				return new Integer(rowsaffected);
			}
		});

	}

	@SuppressWarnings("unchecked")
	public OverallTeamStatistic[] getOverallTeamStats() {

		List<OverallTeamStatistic> overallStats = getSqlMapClientTemplate().queryForList("OverallTeamStats.getOverallStatistics");
		return overallStats.toArray(new OverallTeamStatistic[] {});

	}
	
	@SuppressWarnings("unchecked")
	public OverallTeamStatistic[] getRefinedTeamStats(
			RefineSearchRequest request) {
		
		List<OverallTeamStatistic> refinedStats = getSqlMapClientTemplate().queryForList("OverallTeamStats.getOverallStatistics", request);
		return refinedStats.toArray(new OverallTeamStatistic[] {});

	}

	@SuppressWarnings("unchecked")
	public HistoricalTeamStatistic[] getHistoricalTeamStats() {

		List<HistoricalTeamStatistic> historicalStats = getSqlMapClientTemplate().queryForList("HistoricalTeamStatistics.getHistoricalStatistics");
		return historicalStats.toArray(new HistoricalTeamStatistic[] {});

	}
	
	@SuppressWarnings("unchecked")
	public HistoricalTeamStatistic[] getRefinedHistoricalStats(RefineSearchRequest request) {

		List<HistoricalTeamStatistic> historicalStats = getSqlMapClientTemplate().queryForList("HistoricalTeamStatistics.getHistoricalStatistics", request);
		return historicalStats.toArray(new HistoricalTeamStatistic[] {});

	}

	@SuppressWarnings("unchecked")
	public Author[] getAuthors() {

		List<Author> authors = getSqlMapClientTemplate().queryForList("Author.getAuthors");
		return authors.toArray(new Author[] {});

	}

	public SVNRepositoryInterval getRepositoryInterval() {
		
		SVNRepositoryInterval interval = (SVNRepositoryInterval) getSqlMapClientTemplate().queryForObject("SvnRepositoryInterval.getSvnRepositoryInterval");
		return interval;
		
	}
	
	@SuppressWarnings("unchecked")
	public SVNRepositoryConversionInfo getRepositoryInfo(String url) {
		
		List<SVNRepositoryConversionInfo> conversionInfo = getSqlMapClientTemplate().queryForList("SVNRepositoryConversionInfo.getRepositoryInfo", url);
		if(conversionInfo != null && conversionInfo.size() > 0) {
			return conversionInfo.get(0);
		} else {
			return new SVNRepositoryConversionInfo();
		}
		
	}

}
