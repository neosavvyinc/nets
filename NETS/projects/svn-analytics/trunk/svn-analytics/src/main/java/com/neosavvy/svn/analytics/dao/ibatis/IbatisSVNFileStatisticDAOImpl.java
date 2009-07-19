package com.neosavvy.svn.analytics.dao.ibatis;

import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapExecutor;
import com.neosavvy.svn.analytics.dao.SVNFileSystemNodeDAO;
import com.neosavvy.svn.analytics.dto.SVNRepositoryConversionInfo;
import com.neosavvy.svn.analytics.dto.file.DirectoryNode;
import com.neosavvy.svn.analytics.dto.file.FileNode;

public class IbatisSVNFileStatisticDAOImpl extends SqlMapClientDaoSupport implements
		SVNFileSystemNodeDAO {

	private static final Logger logger = Logger
			.getLogger(IbatisSVNFileStatisticDAOImpl.class);

	public void saveDirectories(final List<DirectoryNode> nodes) {
		getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
			public Object doInSqlMapClient(SqlMapExecutor executor)
					throws SQLException {

				executor.startBatch();
				for (DirectoryNode node : nodes) {
					if(logger.isDebugEnabled()) {
						logger.debug("Executing insert for: " + node.toString());
					}
					executor.insert("SVNDirectoryStatistics.insertStatistic", node);
				}
				int rowsaffected = executor.executeBatch();

				if (logger.isDebugEnabled()) {
					logger.debug("Inserted " + rowsaffected
							+ " for SVNFileStatistics");
				}

				return new Integer(rowsaffected);
			}
		});
	}

	public void saveDirectory(DirectoryNode node) {
		getSqlMapClientTemplate().insert("SVNDirectoryStatistics.insertStatistic", node);
	}

	public void saveFile(FileNode node) {
		getSqlMapClientTemplate().insert("SVNFileStatistics.insertStatistic", node);
	}

	public void saveFiles(final List<FileNode> nodes) {
		getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
			public Object doInSqlMapClient(SqlMapExecutor executor)
					throws SQLException {

				executor.startBatch();
				for (FileNode node : nodes) {
					if(logger.isDebugEnabled()) {
						logger.debug("Executing insert for: " + node.toString());
					}
					executor.insert("SVNFileStatistics.insertStatistic", node);
				}
				int rowsaffected = executor.executeBatch();

				if (logger.isDebugEnabled()) {
					logger.debug("Inserted " + rowsaffected
							+ " for SVNFileStatistics");
				}

				return new Integer(rowsaffected);
			}
		});
	}

	@SuppressWarnings("unchecked")
	public SVNRepositoryConversionInfo getFileBasedRepositoryInfo(Long id) {
		List<SVNRepositoryConversionInfo> conversionInfo = getSqlMapClientTemplate().queryForList("SVNRepositoryConversionInfo.getFileBasedRepositoryInfo", id);
		if(conversionInfo != null && conversionInfo.size() > 0) {
			return conversionInfo.get(0);
		} else {
			return new SVNRepositoryConversionInfo();
		}
	}

	@SuppressWarnings("unchecked")
	public DirectoryNode[] getDirectories(DirectoryNode parent) {
		List<DirectoryNode> directories = getSqlMapClientTemplate().queryForList("SVNDirectoryStatistics.getChildren", parent);
		return directories.toArray(new DirectoryNode[]{});
	}

	@SuppressWarnings("unchecked")
	public FileNode[] getFiles(DirectoryNode parent) {
		List<FileNode> files = getSqlMapClientTemplate().queryForList("SVNFileStatistics.getChildren", parent);
		return files.toArray(new FileNode[]{});
	}

}
