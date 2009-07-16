package com.neosavvy.svn.analytics.dao.mock;

import org.apache.log4j.Logger;

import java.util.List;

import com.neosavvy.svn.analytics.dao.SVNFileSystemNodeDAO;
import com.neosavvy.svn.analytics.dto.file.DirectoryNode;
import com.neosavvy.svn.analytics.dto.file.FileNode;

public class MockSVNFileSystemNodeDAO implements SVNFileSystemNodeDAO {

	private static final Logger logger = Logger.getLogger(MockSVNFileSystemNodeDAO.class);

	public void saveDirectories(List<DirectoryNode> nodes) {
		for (DirectoryNode directoryNode : nodes) {
			logger.info(directoryNode.toString());
		}
	}

	public void saveDirectory(DirectoryNode node) {
		logger.info(node.toString());
	}

	public void saveFile(FileNode node) {
		logger.info(node.toString());
	}

	public void saveFiles(List<FileNode> nodes) {
		for (FileNode fileNode : nodes) {
			logger.info(fileNode.toString());
		}
	}

}
