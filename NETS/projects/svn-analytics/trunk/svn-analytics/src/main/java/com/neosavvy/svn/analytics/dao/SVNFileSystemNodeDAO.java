package com.neosavvy.svn.analytics.dao;

import java.util.List;

import com.neosavvy.svn.analytics.dto.SVNRepositoryConversionInfo;
import com.neosavvy.svn.analytics.dto.SVNRepositoryDTO;
import com.neosavvy.svn.analytics.dto.file.DirectoryNode;
import com.neosavvy.svn.analytics.dto.file.FileNode;

public interface SVNFileSystemNodeDAO {

	public void saveFile( FileNode node );
	
	public void saveDirectory( DirectoryNode node );
	
	public void saveFiles( final List<FileNode> nodes );
	
	public void saveDirectories( final List<DirectoryNode> nodes );
	
	public SVNRepositoryConversionInfo getFileBasedRepositoryInfo(Long id);
	
	public DirectoryNode[] getDirectories(DirectoryNode parent);
	
	public FileNode[] getFiles(DirectoryNode parent);
}
