package com.neosavvy.svn.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import junit.framework.Assert;

import org.apache.log4j.PropertyConfigurator;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.neosavvy.junit4.BaseTransactionalSpringAwareTestCase;
import com.neosavvy.svn.analytics.dao.SVNFileSystemNodeDAO;
import com.neosavvy.svn.analytics.dto.file.FileSystemNode;

public class TestFileNodeIbatisDaoImpl extends
		BaseTransactionalSpringAwareTestCase {
	
	@Autowired
	private SVNFileSystemNodeDAO svnFileNodeStatisticDAO;
	
	@Test
	public void testSingleFileSave() {
		PropertyConfigurator.configure(TestFileNodeIbatisDaoImpl.class.getClassLoader().getResource("log4j.test.properties"));
		deleteFromTables("SVN_FILE_SYSTEM_STATISTIC");
		
		FileSystemNode node = new FileSystemNode();
		node.setAuthor("adam");
		node.setFileName("test");
		node.setId(1);
		node.setLastChangedRevision(1);
		node.setNumberLines(1);
		node.setParentDirectory("parentDir");
		node.setRelativePath("relativePath");
		node.setRevision(1);
		node.setRevisionDate(new Date());
		node.setFileType(FileSystemNode.TYPE_FILE);
		
		svnFileNodeStatisticDAO.saveFileSystemNode(node);
		
		int numRows = countRowsInTable("SVN_FILE_SYSTEM_STATISTIC");
		Assert.assertEquals(numRows, 1);
	}
	
	@Test
	public void testMultipleFileSave() {

		deleteFromTables("SVN_FILE_SYSTEM_STATISTIC");
		
		List<FileSystemNode> nodes = new ArrayList<FileSystemNode>();
		
		FileSystemNode node = new FileSystemNode();
		node.setAuthor("adam");
		node.setFileName("test");
		node.setId(1);
		node.setLastChangedRevision(1);
		node.setNumberLines(1);
		node.setParentDirectory("parentDir");
		node.setRelativePath("relativePath");
		node.setRevision(1);
		node.setRevisionDate(new Date());
		nodes.add(node);
		
		FileSystemNode node1 = new FileSystemNode();
		node1.setAuthor("adam1");
		node1.setFileName("test1");
		node1.setId(1);
		node1.setLastChangedRevision(1);
		node1.setNumberLines(1);
		node1.setParentDirectory("parentDir1");
		node1.setRelativePath("relativePath1");
		node1.setRevision(1);
		node1.setRevisionDate(new Date());
		nodes.add(node1);
		
		svnFileNodeStatisticDAO.saveFileSystemNodes(nodes);
		
		int numRows = countRowsInTable("SVN_FILE_SYSTEM_STATISTIC");
		Assert.assertEquals(numRows, 2);
		
	}
	
	@Test
	public void testSingleDirectorySave() {
		
		deleteFromTables("SVN_FILE_SYSTEM_STATISTIC");
		
		FileSystemNode node1 = new FileSystemNode();
		node1.setAuthor("adam1");
		node1.setId(1);
		node1.setLastChangedRevision(1);
		node1.setParentDirectory("parentDir1");
		node1.setRelativePath("relativePath1");
		node1.setRevision(1);
		node1.setRevisionDate(new Date());
		
		svnFileNodeStatisticDAO.saveFileSystemNode(node1);
		
		int numRows = countRowsInTable("SVN_FILE_SYSTEM_STATISTIC");
		Assert.assertEquals(numRows, 1);
	}
	
	@Test
	public void testMultipleDirectorySave() {
		
		deleteFromTables("SVN_FILE_SYSTEM_STATISTIC");
		
		List<FileSystemNode> nodes = new ArrayList<FileSystemNode>();
		
		FileSystemNode node = new FileSystemNode();
		node.setAuthor("adam1");
		node.setId(1);
		node.setLastChangedRevision(1);
		node.setParentDirectory("parentDir1");
		node.setRelativePath("relativePath1");
		node.setRevision(1);
		node.setRevisionDate(new Date());
		nodes.add(node);
		
		FileSystemNode node1 = new FileSystemNode();
		node1.setAuthor("adam1");
		node1.setId(1);
		node1.setLastChangedRevision(1);
		node1.setParentDirectory("parentDir1");
		node1.setRelativePath("relativePath1");
		node1.setRevision(1);
		node1.setRevisionDate(new Date());
		nodes.add(node1);
		
		svnFileNodeStatisticDAO.saveFileSystemNodes(nodes);
		
		int numRows = countRowsInTable("SVN_FILE_SYSTEM_STATISTIC");
		Assert.assertEquals(numRows, 2);
		
		
	}
	
	@Test
	public void testGetChildDirectories() {
		PropertyConfigurator.configure(TestFileNodeIbatisDaoImpl.class.getClassLoader().getResource("log4j.test.properties"));
		deleteFromTables("SVN_FILE_SYSTEM_STATISTIC");
		
		List<FileSystemNode> nodes = new ArrayList<FileSystemNode>();
		
		FileSystemNode node = new FileSystemNode();
		node.setAuthor("adam1");
		node.setId(1);
		node.setLastChangedRevision(1);
		node.setParentDirectory(null);
		node.setRelativePath("relativePath1");
		node.setRevision(1);
		node.setRevisionDate(new Date());
		node.setRepositoryId(4);
		nodes.add(node);
		
		FileSystemNode node1 = new FileSystemNode();
		node1.setAuthor("adam1");
		node1.setId(1);
		node1.setLastChangedRevision(1);
		node1.setParentDirectory(null);
		node1.setRelativePath("relativePath2");
		node1.setRevision(1);
		node1.setRevisionDate(new Date());
		node1.setRepositoryId(4);
		nodes.add(node1);
		
		svnFileNodeStatisticDAO.saveFileSystemNodes(nodes);

		int numRows = countRowsInTable("SVN_FILE_SYSTEM_STATISTIC");
		Assert.assertEquals(numRows, 2);
		
		FileSystemNode searchParent = new FileSystemNode();
		searchParent.setRepositoryId(4);
		searchParent.setParentDirectory("/");
		
		FileSystemNode[] directories = svnFileNodeStatisticDAO.getNodes(searchParent);
		Assert.assertNotNull(directories);
		Assert.assertEquals(2, directories.length);
		
	}
	
	@Test
	public void testGetChildFiles() {
		PropertyConfigurator.configure(TestFileNodeIbatisDaoImpl.class.getClassLoader().getResource("log4j.test.properties"));
		deleteFromTables("SVN_FILE_SYSTEM_STATISTIC");
		
		List<FileSystemNode> nodes = new ArrayList<FileSystemNode>();
		
		FileSystemNode node = new FileSystemNode();
		node.setAuthor("adam1");
		node.setId(1);
		node.setLastChangedRevision(1);
		node.setParentDirectory(null);
		node.setRelativePath("relativePath1");
		node.setRevision(1);
		node.setRevisionDate(new Date());
		node.setRepositoryId(4);
		node.setFileType(FileSystemNode.TYPE_FILE);
		nodes.add(node);
		
		FileSystemNode node1 = new FileSystemNode();
		node1.setAuthor("adam1");
		node1.setId(1);
		node1.setLastChangedRevision(1);
		node1.setParentDirectory(null);
		node1.setRelativePath("relativePath2");
		node1.setRevision(1);
		node1.setRevisionDate(new Date());
		node1.setRepositoryId(4);
		node1.setFileType(FileSystemNode.TYPE_FILE);
		nodes.add(node1);
		
		svnFileNodeStatisticDAO.saveFileSystemNodes(nodes);

		int numRows = countRowsInTable("SVN_FILE_SYSTEM_STATISTIC");
		Assert.assertEquals(numRows, 2);
		
		FileSystemNode searchParent = new FileSystemNode();
		searchParent.setRepositoryId(4);
		searchParent.setParentDirectory("/");
		
		FileSystemNode[] files = svnFileNodeStatisticDAO.getNodes(searchParent);
		Assert.assertNotNull(files);
		Assert.assertEquals(2, files.length);
		
	}

}
