package com.neosavvy.svn.dao.mysql;

import org.springframework.test.context.ContextConfiguration;

import com.neosavvy.svn.dao.abst.AbstractTestCodeOwnership;

@ContextConfiguration(locations = { "classpath:mysqlDatasource.xml" })
public class TestMysqlCodeOwnership extends AbstractTestCodeOwnership {
}
