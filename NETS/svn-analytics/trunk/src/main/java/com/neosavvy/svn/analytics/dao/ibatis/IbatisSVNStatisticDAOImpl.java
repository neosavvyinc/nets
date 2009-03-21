package com.neosavvy.svn.analytics.dao.ibatis;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.ibatis.sqlmap.client.SqlMapExecutor;
import com.neosavvy.svn.analytics.dao.SVNStatisticDAO;
import com.neosavvy.svn.analytics.dto.SVNStatistic;

public class IbatisSVNStatisticDAOImpl extends SqlMapClientTemplate implements
        SVNStatisticDAO {

    private static final Logger logger = Logger
            .getLogger(IbatisSVNStatisticDAOImpl.class);

    public void saveStatistics(final List<SVNStatistic> statistics) {

        execute(new SqlMapClientCallback() {
            public Object doInSqlMapClient(SqlMapExecutor executor)
                    throws SQLException {
                Iterator<SVNStatistic> itr = statistics.iterator();

                executor.startBatch();
                executor.insert("", itr.next());
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
