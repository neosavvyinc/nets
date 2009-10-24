package com.neosavvy.util;

/**
 * 
 */

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.engine.impl.SqlMapExecutorDelegate;
import com.ibatis.sqlmap.engine.impl.SqlMapSessionImpl;
import com.ibatis.sqlmap.engine.mapping.parameter.ParameterMap;
import com.ibatis.sqlmap.engine.mapping.sql.Sql;
import com.ibatis.sqlmap.engine.mapping.statement.MappedStatement;
import com.ibatis.sqlmap.engine.scope.SessionScope;
import com.ibatis.sqlmap.engine.scope.StatementScope;

/**
 */
public class IbatisDebugger {
	/**
	 * Generate dynamic SQL with the Object parameter
	 * 
	 * @param Object
	 * @param dao
	 * @return
	 */
	public static String getSqlForIbatisRequest(SqlMapClientDaoSupport dao,
			String ibatisId, Object parameters) {
		if (parameters == null) {
			parameters = new Object();
		}
		SqlMapClientDaoSupport ibatisDao = (SqlMapClientDaoSupport) dao;
		SqlMapClient sqlMap = ibatisDao.getSqlMapClientTemplate().getSqlMapClient();
		return getSqlForIbatisRequest(sqlMap, ibatisId, parameters);
	}
	/**
	 * Generate SQL using sqlMap
	 * @param sqlMap
	 * @param ibatisId
	 * @param parameters
	 * @return
	 */
	public static String getSqlForIbatisRequest(SqlMapClient sqlMap,
			String ibatisId, Object parameters) {
		if (parameters == null) {
			parameters = new Object();
		}	
		SqlMapSessionImpl session = (SqlMapSessionImpl) sqlMap.openSession();
		SqlMapExecutorDelegate delegate = session.getDelegate();
		MappedStatement stmt = delegate.getMappedStatement(ibatisId);
    Sql sql = stmt.getSql();
    SessionScope sessionScope = new SessionScope();
    StatementScope statementScope = new StatementScope(sessionScope);
    statementScope.setStatement(stmt);
    String sqlString = sql.getSql(statementScope, parameters);
    ParameterMap params = sql.getParameterMap(statementScope, parameters);
    if (params != null) {
      for (Object param : params.getParameterObjectValues(statementScope,
          parameters)) {

        sqlString = sqlString.replaceFirst("\\?", "'"
            + param.toString() + "'");

      }
    }
    sqlString = sqlString.replaceAll("\\s+", " ");
    sqlString = (String) (new SQLFormatter()).prettyPrint(sqlString);
    session.close();
    return sqlString;
	}	
}
