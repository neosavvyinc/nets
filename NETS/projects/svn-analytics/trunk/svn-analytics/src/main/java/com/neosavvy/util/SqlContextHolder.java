package com.neosavvy.util;

/**
 * 
 * Simple interface for holding SQL Context.
 * Used to facilitate standard JDK interface-based proxy (instead of class-based CGLIB proxy).
 * 
 * @author matthewg
 *
 */
public interface SqlContextHolder {

  public void addSqlContext(String sqlContext);
  public String getSqlContext();
  public void setSqlContext(String sqlContext);

}
