package com.neosavvy.util;

import java.lang.reflect.Method;
import java.util.Collection;

import org.apache.log4j.Logger;
import org.springframework.aop.AfterReturningAdvice;
import org.springframework.aop.MethodBeforeAdvice;
import org.springframework.aop.ThrowsAdvice;
import org.springframework.beans.factory.BeanCreationException;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.event.RowHandler;

/**
 * Before, After, and Throwing advice for Ibatis SqlMapClient.
 * DEBUG log level on this class must be enabled in order for work to be performed.
 *   log4j.logger.com.neosavvy.util=DEBUG
 *   
 * Example Spring config:
 * 
 *   <bean id="sqlMapClientTarget" class="org.springframework.orm.ibatis.SqlMapClientFactoryBean">
 *     ...
 *   </bean>
 *   
 *   <bean id="sqlMapClient" class="org.springframework.aop.framework.ProxyFactoryBean">
 *     <property name="proxyInterfaces" value="com.ibatis.sqlmap.client.SqlMapClient"/>
 *     <property name="target" ref="sqlMapClientTarget"/>
 *     <property name="interceptorNames">
 *       <list>
 *         <value>sqlMapClientLogger</value>
 *       </list>
 *     </property>
 *   </bean>
 *   
 *   <bean id="sqlMapClientLogger" class="mil.af.gcssdsrf.framework.ibatis.SqlMapClientLoggerAdvice">
 *     <property name="sqlContextHolder" ref="sqlContextHolder"/>
 *   </bean>
 * 
 * @author matthewg
 *
 */
public class SqlMapClientLoggerAdvice implements MethodBeforeAdvice, AfterReturningAdvice, ThrowsAdvice {

  private static final Logger logger = Logger.getLogger(SqlMapClientLoggerAdvice.class);
  
//  protected SqlContextHolder sqlContextHolder;
  
//  public void setSqlContextHolder(SqlContextHolder sqlContextHolder) {
//    this.sqlContextHolder = sqlContextHolder;
//  }

  private StackTraceElement[] getStackTrace() {
    //return Thread.getStackTrace();  // Java 1.5 method (more efficient)
    Throwable t = new Throwable();
    return t.getStackTrace();
  }
  
  private String findCaller(String methodName) {
    StackTraceElement[] stackTrace = getStackTrace();
    for (int i=2; i < stackTrace.length; i++) {  // i=2 because we can skip (at least) the first 2 things in the stack trace
      if (stackTrace[i].getMethodName().equals(methodName)) {
        // method names match, found current method, look at next StackTraceElement to find immediate caller of this method
        if ((i+1) < stackTrace.length) {  // array index safety check, make sure there is a next StackTraceElement
          StackTraceElement next = stackTrace[i+1];
          if (next != null) {
            return next.getClassName() + "." + next.getMethodName();
          }
        }
      }
    }
    return "<unknown>";
  }
  
  public void before(Method method, Object[] args, Object target) throws Throwable {
    if (!logger.isDebugEnabled()) {
      return;  // don't do any work if debug logging is not enabled for this class; we can effectively enable/disable this functionality via the logging config
    }
    
    if (!(target instanceof SqlMapClient)) {
      throw new RuntimeException("Advice can only be applied to instances of com.ibatis.sqlmap.client.SqlMapClient");
    }
    
    Class[] parameterTypes = method.getParameterTypes();
    if (null == parameterTypes || 0 == parameterTypes.length || !(args[0] instanceof String)) {
      logger.debug("Nothing to log for method: " + method.getName());
      return;  // do nothing for SqlMapClient methods with no arguments or SqlMapClient methods where the first argument is something other than a String
    }
    
    // at this point we are dealing with a SqlMapClient method where the first parameter is a String
    // when the first parameter of a SqlMapClient method is a String, it is always the mapped Ibatis statement id (according to their API)
    String ibatisId = (String) args[0];
    String caller = findCaller(method.getName());  // find the immediate caller of the method we are intercepting
    logger.debug(caller + " called SqlMapClient." + method.getName() + " with " + args.length + " parameters");
    logger.debug("Ibatis statement id: " + ibatisId);
    
    Object param = new Object();
    if (parameterTypes.length > 1) {
      // calling a SqlMapClient method with more than one argument
      if (!parameterTypes[1].isPrimitive() && !(args[1] instanceof RowHandler)) {  // ignore if second argument is a primitive or a RowHandler object
        param = args[1];  // in all other cases, second argument is the parameterObject (according to their API)
      }
    }
    
    try {
	    String sql = IbatisDebugger.getSqlForIbatisRequest((SqlMapClient) target, ibatisId, param);
	    logger.debug(sql);
    } catch (Exception e) {
    	logger.error(e);
    }
//    if (sqlContextHolder != null) {
//      try {
//        sqlContextHolder.addSqlContext(sql);
//      } catch (BeanCreationException e) {
//        // this exception will happen if there is no holder in the context
//        // for instance, if you are using a spring request-scoped bean and are doing something outside that scope (i.e. in another thread)
//        // just write a log message
//        logger.debug("Caught BeanCreationException when calling sqlContextHolder.addSqlContext(sql), likely there is no sqlContextHolder in scope");
//      }
//    }
  }
  
  public void afterThrowing(Method method, Object[] args, Object target, Exception ex) {
    if (!logger.isDebugEnabled()) {
      return;  // don't do any work if debug logging is not enabled for this class; we can effectively enable/disable this functionality via the logging config
    }
    
    if (!(target instanceof SqlMapClient)) {
      throw new RuntimeException("Advice can only be applied to instances of com.ibatis.sqlmap.client.SqlMapClient");
    }
    
    logger.debug("Exception was thrown", ex);
  }
  
  public void afterReturning(Object returnValue, Method method, Object[] args, Object target) throws Throwable {
    if (!logger.isDebugEnabled()) {
      return;  // don't do any work if debug logging is not enabled for this class; we can effectively enable/disable this functionality via the logging config
    }
    
    if (!(target instanceof SqlMapClient)) {
      throw new RuntimeException("Advice can only be applied to instances of com.ibatis.sqlmap.client.SqlMapClient");
    }
    
    int rows = 0;
    if (returnValue instanceof Integer) {
      rows = (Integer) returnValue;
    } else if (returnValue instanceof Collection) {
      rows = ((Collection) returnValue).size();
    } else if (returnValue != null) {
      // single object returned
      rows = 1;
    }
    logger.debug("Rows returned/affected: " + rows);
  }

}
