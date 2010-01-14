package com.neosavvy.user.util;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.servlet.ServletContextListener;
import javax.sql.DataSource;
/*************************************************************************
 *
 * NEOSAVVY CONFIDENTIAL
 * __________________
 *
 *  Copyright 2008 - 2009 Neosavvy Incorporated
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Neosavvy Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Neosavvy Incorporated
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Neosavvy Incorporated.
 **************************************************************************/

/**
 * User: adamparrish
 * Date: Dec 24, 2009
 * Time: 9:15:30 AM
 */
public class DatabaseInitializerListener implements InitializingBean {

    public static Logger logger = Logger.getLogger(DatabaseInitializerListener.class);

    private JdbcTemplate template;

    public void afterPropertiesSet () {

        try {
            template.execute("TRUNCATE TABLE EXPENSE_REPORT_ITEM");       
            template.execute("TRUNCATE TABLE EXPENSE_REPORT");
            template.execute("TRUNCATE TABLE PROJECT_PAYMENT_METHOD");
            template.execute("TRUNCATE TABLE STANDARD_PAYMENT_METHOD");
            template.execute("TRUNCATE TABLE PROJECT_TYPE");
            template.execute("TRUNCATE TABLE PROJECT");
            template.execute("TRUNCATE TABLE CLIENT_COMPANY");
            template.execute("TRUNCATE TABLE CLIENT_USER_CONTACT");
            template.execute("TRUNCATE TABLE COMPANY");
            template.execute("TRUNCATE TABLE ROLE");
            template.execute("TRUNCATE TABLE USERS");
            template.execute("TRUNCATE TABLE USER_COMPANY_ROLE");
            template.execute("TRUNCATE TABLE USER_INVITE");
            template.update("INSERT INTO ROLE(ID,LONG_NAME,SHORT_NAME) VALUES (nextval('role_id_seq'),?, ?)",new Object[]{"Administrator","ROLE_ADMIN"});
            template.update("INSERT INTO ROLE(ID,LONG_NAME,SHORT_NAME) VALUES (nextval('role_id_seq'),?, ?)",new Object[]{"Employee","ROLE_EMPLOYEE"});
        } catch (DataAccessException e) {
            logger.error(e);
        }
        
    }

    public DataSource getDataSource() {
        return template.getDataSource();
    }

    public void setDataSource( DataSource dataSource ) {
        this.template = new JdbcTemplate( dataSource );
    }
}
