package com.neosavvy.svn.analytics.dao;

import java.util.List;

import com.neosavvy.svn.analytics.dto.SVNRepositoryConversionInfo;
import com.neosavvy.svn.analytics.dto.file.FileSystemNode;

public interface SVNFileSystemNodeDAO {

	public void saveFileSystemNode( FileSystemNode node );
	
	public void saveFileSystemNodes( final List<FileSystemNode> nodes );
	
	public SVNRepositoryConversionInfo getFileBasedRepositoryInfo(Long id);
	
	public FileSystemNode[] getNodes(FileSystemNode parent);
	
}
