package com.neosavvy.util;

/**
 * 
 * Default implementation for holding SQL Context.
 * 
 * Example spring config, showing a request-scoped bean as standard JDK interface-based proxy.
 * Setting proxy-target-class to true would create a class-based proxy requiring CGLIB.
 * 
 *   <bean id="sqlContextHolder" class="mil.af.gcssdsrf.framework.ibatis.DefaultSqlContextHolder" scope="request">
 *     <aop:scoped-proxy proxy-target-class="false"/>
 *   </bean>
 * 
 * @author matthewg
 *
 */
public class DefaultSqlContextHolder implements SqlContextHolder {

  private static final String newline = System.getProperty("line.separator");
  
  private StringBuffer sql = new StringBuffer();

  public void addSqlContext(String sqlContext) {
    if (sql.length() > 0) {
      sql.append(newline);
    }
    sql.append(sqlContext);
  }

  public String getSqlContext() {
    return sql.toString();
  }

  public void setSqlContext(String sqlContext) {
    sql = new StringBuffer(sqlContext);
  }

}
