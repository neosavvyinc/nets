package com.neosavvy.svn.analytics;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;

public class DatabaseInitializer implements InitializingBean {

    private JdbcTemplate template;

    public void afterPropertiesSet() throws Exception {

        try {
            template.queryForInt("SELECT COUNT(*) FROM SVN_STATISTIC");
        } catch (DataAccessException e) {
            template.execute(
                "CREATE TABLE SVN_STATISTIC "+
                "( "+
                "AUTHOR VARCHAR(100) "+
                ",REVISION INT NOT NULL "+
                ",SVN_REPOSITORY_URL VARCHAR(1024) NOT NULL "+
                ",REV_DATE TIMESTAMP NOT NULL "+
                ",MESSAGE VARCHAR(4096) "+
                ",NUM_FILES_IN_REV INT "+
                ",NUM_FILES_ADDED_IN_REV INT "+
                ",NUM_FILES_DELETED_IN_REV INT "+
                ",NUM_FILES_MODIFIED_IN_REV INT "+
                ",VALID_COMMENT INT "+
                ",INVALID_COMMENT INT "+
                ");"
            );
            template.execute(
                "ALTER TABLE SVN_STATISTIC ADD CONSTRAINT SVN_STATISTIC_PK PRIMARY KEY (REVISION,SVN_REPOSITORY_URL);"
            );
        }


        try {
            template.queryForInt("SELECT COUNT(*) FROM SVN_REPOSITORY");
        } catch (DataAccessException e) {
            template.execute(
                "CREATE TABLE SVN_REPOSITORY "+
                "( "+
                "ID INT "+
                ",NAME VARCHAR(255) NOT NULL "+
                ",URL VARCHAR(1024) NOT NULL "+
                ",USERNAME VARCHAR(1024) NOT NULL "+
                ",PASSWORD VARCHAR(1024) NOT NULL "+
                ",START_REV INT "+
                ",END_REV INT "+
                ");"
            );
            template.execute(
                "ALTER TABLE SVN_REPOSITORY ADD CONSTRAINT SVN_REPOSITORY_PK PRIMARY KEY (ID);"
            );
            template.execute(
                "ALTER TABLE SVN_REPOSITORY ADD CONSTRAINT SVN_REPOSITORY_URL UNIQUE (URL);"
            );
            template.execute(
                "CREATE SEQUENCE SVN_REPOSITORY_SEQ AS INTEGER START WITH 1 INCREMENT BY 1;"
            );
        }



        try {
            template.queryForInt("SELECT COUNT(*) FROM SVN_FILE_SYSTEM_STATISTIC");
        } catch (DataAccessException e) {
            template.execute(
                "CREATE TABLE SVN_FILE_SYSTEM_STATISTIC "+
                "( "+
                    "ID INT "+
                    ",REPOSITORY_ID INT NOT NULL "+
                    ",REVISION INT NOT NULL "+
                    ",REVISION_DATE DATE NOT NULL "+
                    ",LAST_CHANGED_REVISION INT NOT NULL "+
                    ",AUTHOR VARCHAR(1024) "+
                    ",RELATIVE_PATH VARCHAR(4000) "+
                    ",PARENT_DIRECTORY VARCHAR(4000) "+
                    ",NUMBER_OF_LINES INT "+
                    ",FILE_NAME VARCHAR(4000) "+
                    ",FILE_TYPE VARCHAR(1) "+
                ");"
            );

            template.execute(
                "ALTER TABLE SVN_FILE_SYSTEM_STATISTIC ADD CONSTRAINT SVN_FILE_SYSTEM_STATISTIC_PK PRIMARY KEY (ID);"
            );

            template.execute(
                "CREATE SEQUENCE SVN_FILE_SYSTEM_STATISTIC_SEQ AS INTEGER START WITH 1 INCREMENT BY 1;"
            );

        }

    }

    public void setDataSource(final DataSource dataSource) {
        this.template = new JdbcTemplate(dataSource);
    }

}
