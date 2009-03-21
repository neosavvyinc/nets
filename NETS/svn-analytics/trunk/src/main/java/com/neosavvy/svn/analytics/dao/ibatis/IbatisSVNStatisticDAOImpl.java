package com.neosavvy.svn.analytics.dao.ibatis;

import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.ibatis.sqlmap.client.SqlMapExecutor;
import com.neosavvy.svn.analytics.dao.SVNStatisticDAO;
import com.neosavvy.svn.analytics.dto.SVNStatistic;

public class IbatisSVNStatisticDAOImpl extends SqlMapClientTemplate implements
        SVNStatisticDAO {

    public static final String SVNSTATISTICS_INSERT_STATISTIC = "SVNStatistics.insertStatistic";
    private static final Logger logger = Logger
            .getLogger(IbatisSVNStatisticDAOImpl.class);

    public void saveStatistics(final List<SVNStatistic> statistics) {

        execute(new SqlMapClientCallback() {
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

}
