package com.neosavvy.svn.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import junit.framework.Assert;

import org.apache.log4j.PropertyConfigurator;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.neosavvy.junit4.BaseSpringAwareTestCase;
import com.neosavvy.junit4.BaseTransactionalSpringAwareTestCase;
import com.neosavvy.svn.analytics.dao.SVNFileSystemNodeDAO;
import com.neosavvy.svn.analytics.dto.file.DirectoryNode;
import com.neosavvy.svn.analytics.dto.file.FileNode;

public class TestFileNodeIbatisDaoImpl extends
		BaseTransactionalSpringAwareTestCase {
	
	@Autowired
	private SVNFileSystemNodeDAO svnFileNodeStatisticDAO;
	
	@Test
	public void testSingleFileSave() {
	
		deleteFromTables("SVN_FILE_STATISTIC");
		
		FileNode node = new FileNode();
		node.setAuthor("adam");
		node.setFileName("test");
		node.setId(1);
		node.setLastChangedRevision(1);
		node.setNumberLines(1);
		node.setParentDirectory("parentDir");
		node.setRelativePath("relativePath");
		node.setRevision(1);
		node.setRevisionDate(new Date());
		
		svnFileNodeStatisticDAO.saveFile(node);
		
		int numRows = countRowsInTable("SVN_FILE_STATISTIC");
		Assert.assertEquals(numRows, 1);
	}
	
	@Test
	public void testMultipleFileSave() {

		deleteFromTables("SVN_FILE_STATISTIC");
		
		List<FileNode> nodes = new ArrayList<FileNode>();
		
		FileNode node = new FileNode();
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
		
		FileNode node1 = new FileNode();
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
		
		svnFileNodeStatisticDAO.saveFiles(nodes);
		
		int numRows = countRowsInTable("SVN_FILE_STATISTIC");
		Assert.assertEquals(numRows, 2);
		
	}
	
	@Test
	public void testSingleDirectorySave() {
		
		deleteFromTables("SVN_DIRECTORY_STATISTIC");
		
		DirectoryNode node1 = new DirectoryNode();
		node1.setAuthor("adam1");
		node1.setId(1);
		node1.setLastChangedRevision(1);
		node1.setParentDirectory("parentDir1");
		node1.setRelativePath("relativePath1");
		node1.setRevision(1);
		node1.setRevisionDate(new Date());
		
		svnFileNodeStatisticDAO.saveDirectory(node1);
		
		int numRows = countRowsInTable("SVN_DIRECTORY_STATISTIC");
		Assert.assertEquals(numRows, 1);
	}
	
	@Test
	public void testMultipleDirectorySave() {
		
		deleteFromTables("SVN_DIRECTORY_STATISTIC");
		
		List<DirectoryNode> nodes = new ArrayList<DirectoryNode>();
		
		DirectoryNode node = new DirectoryNode();
		node.setAuthor("adam1");
		node.setId(1);
		node.setLastChangedRevision(1);
		node.setParentDirectory("parentDir1");
		node.setRelativePath("relativePath1");
		node.setRevision(1);
		node.setRevisionDate(new Date());
		nodes.add(node);
		
		DirectoryNode node1 = new DirectoryNode();
		node1.setAuthor("adam1");
		node1.setId(1);
		node1.setLastChangedRevision(1);
		node1.setParentDirectory("parentDir1");
		node1.setRelativePath("relativePath1");
		node1.setRevision(1);
		node1.setRevisionDate(new Date());
		nodes.add(node1);
		
		svnFileNodeStatisticDAO.saveDirectories(nodes);
		
		int numRows = countRowsInTable("SVN_DIRECTORY_STATISTIC");
		Assert.assertEquals(numRows, 2);
		
		
	}
	
	@Test
	public void testGetChildDirectories() {
		PropertyConfigurator.configure(TestFileNodeIbatisDaoImpl.class.getClassLoader().getResource("log4j.test.properties"));
		deleteFromTables("SVN_DIRECTORY_STATISTIC");
		
		List<DirectoryNode> nodes = new ArrayList<DirectoryNode>();
		
		DirectoryNode node = new DirectoryNode();
		node.setAuthor("adam1");
		node.setId(1);
		node.setLastChangedRevision(1);
		node.setParentDirectory(null);
		node.setRelativePath("relativePath1");
		node.setRevision(1);
		node.setRevisionDate(new Date());
		node.setRepositoryId(4);
		nodes.add(node);
		
		DirectoryNode node1 = new DirectoryNode();
		node1.setAuthor("adam1");
		node1.setId(1);
		node1.setLastChangedRevision(1);
		node1.setParentDirectory(null);
		node1.setRelativePath("relativePath2");
		node1.setRevision(1);
		node1.setRevisionDate(new Date());
		node1.setRepositoryId(4);
		nodes.add(node1);
		
		svnFileNodeStatisticDAO.saveDirectories(nodes);

		int numRows = countRowsInTable("SVN_DIRECTORY_STATISTIC");
		Assert.assertEquals(numRows, 2);
		
		DirectoryNode searchParent = new DirectoryNode();
		searchParent.setRepositoryId(4);
		searchParent.setParentDirectory("/");
		
		DirectoryNode[] directories = svnFileNodeStatisticDAO.getDirectories(searchParent);
		Assert.assertNotNull(directories);
		Assert.assertEquals(2, directories.length);
		
	}
	
	@Test
	public void testGetChildFiles() {
		PropertyConfigurator.configure(TestFileNodeIbatisDaoImpl.class.getClassLoader().getResource("log4j.test.properties"));
		deleteFromTables("SVN_FILE_STATISTIC");
		
		List<FileNode> nodes = new ArrayList<FileNode>();
		
		FileNode node = new FileNode();
		node.setAuthor("adam1");
		node.setId(1);
		node.setLastChangedRevision(1);
		node.setParentDirectory(null);
		node.setRelativePath("relativePath1");
		node.setRevision(1);
		node.setRevisionDate(new Date());
		node.setRepositoryId(4);
		nodes.add(node);
		
		FileNode node1 = new FileNode();
		node1.setAuthor("adam1");
		node1.setId(1);
		node1.setLastChangedRevision(1);
		node1.setParentDirectory(null);
		node1.setRelativePath("relativePath2");
		node1.setRevision(1);
		node1.setRevisionDate(new Date());
		node1.setRepositoryId(4);
		nodes.add(node1);
		
		svnFileNodeStatisticDAO.saveFiles(nodes);

		int numRows = countRowsInTable("SVN_FILE_STATISTIC");
		Assert.assertEquals(numRows, 2);
		
		DirectoryNode searchParent = new DirectoryNode();
		searchParent.setRepositoryId(4);
		searchParent.setParentDirectory("/");
		
		FileNode[] files = svnFileNodeStatisticDAO.getFiles(searchParent);
		Assert.assertNotNull(files);
		Assert.assertEquals(2, files.length);
		
	}

}
