package com.neosavvy.svn.dao.oracle;

import org.springframework.test.context.ContextConfiguration;

import com.neosavvy.svn.dao.abst.AbstractTestCodeOwnership;

@ContextConfiguration(locations = { "classpath:oracleDatasource.xml" })
public class TestOracleCodeOwnership extends AbstractTestCodeOwnership {
}
