package com.neosavvy.svn.analytics.dao.ibatis;

import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapExecutor;
import com.neosavvy.svn.analytics.dao.SVNFileSystemNodeDAO;
import com.neosavvy.svn.analytics.dto.SVNRepositoryConversionInfo;
import com.neosavvy.svn.analytics.dto.file.FileSystemNode;

public class IbatisSVNFileStatisticDAOImpl extends SqlMapClientDaoSupport implements
		SVNFileSystemNodeDAO {

	private static final Logger logger = Logger
			.getLogger(IbatisSVNFileStatisticDAOImpl.class);

	public void saveFileSystemNode(FileSystemNode node) {
		getSqlMapClientTemplate().insert("SVNFileSystemStatistics.insertStatistic", node);
	}

	public void saveFileSystemNodes(final List<FileSystemNode> nodes) {
		getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
			public Object doInSqlMapClient(SqlMapExecutor executor)
					throws SQLException {

				executor.startBatch();
				for (FileSystemNode node : nodes) {
					if(logger.isDebugEnabled()) {
						logger.debug("Executing insert for: " + node.toString());
					}
					executor.insert("SVNFileSystemStatistics.insertStatistic", node);
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
	public FileSystemNode[] getNodes(FileSystemNode parent) {
		List<FileSystemNode> directories = getSqlMapClientTemplate().queryForList("SVNFileSystemStatistics.getChildren", parent);
		return directories.toArray(new FileSystemNode[]{});
	}

}
