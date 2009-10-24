package com.neosavvy.svn.analytics.util;

import org.hsqldb.Server;
import org.hsqldb.persist.HsqlProperties;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * This code is the intellectual property of Neosavvy, Inc.
 *
 * @author adamparrish
 *         Date: Oct 17, 2009
 *         Time: 3:09:59 PM
 */
public class HSQLServerStartupListener implements ServletContextListener {

    protected Server server = null;

    protected HsqlProperties properties;

    public void contextInitialized(ServletContextEvent event) {
        server = new Server();
        server.setDatabasePath(0,"SVNANALYTICS");
        server.setDatabaseName(0,"SVNANALYTICS");
        server.setSilent(false);
        server.setTrace(true);
        server.start();
    }

    public void contextDestroyed(ServletContextEvent event) {
        server.stop();
    }
}
