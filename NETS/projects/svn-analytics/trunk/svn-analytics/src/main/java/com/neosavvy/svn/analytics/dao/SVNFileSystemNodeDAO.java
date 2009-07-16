package com.neosavvy.svn.analytics.dao;

import java.util.List;

import com.neosavvy.svn.analytics.dto.file.DirectoryNode;
import com.neosavvy.svn.analytics.dto.file.FileNode;

public interface SVNFileSystemNodeDAO {

	public void saveFile( FileNode node );
	
	public void saveDirectory( DirectoryNode node );
	
	public void saveFiles( final List<FileNode> nodes );
	
	public void saveDirectories( final List<DirectoryNode> nodes );
	
}
