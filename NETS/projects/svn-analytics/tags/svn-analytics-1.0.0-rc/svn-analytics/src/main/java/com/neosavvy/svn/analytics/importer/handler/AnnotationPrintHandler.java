package com.neosavvy.svn.analytics.importer.handler;

import java.io.File;
import java.util.Date;

import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.wc.ISVNAnnotateHandler;

import com.neosavvy.svn.analytics.dto.file.FileSystemNode;

public class AnnotationPrintHandler implements ISVNAnnotateHandler {

	private FileSystemNode node;
	
	public AnnotationPrintHandler() {
		
	}
	
	public AnnotationPrintHandler(FileSystemNode node) {
		this.node = node;
	}
	
	public void handleLine(Date date, long revision, String author, String line) {
		System.out.print("Unimplemented deprecated method");
	}

	public void handleEOF() { /* Not Necessary */
	}

	public void handleLine(Date date,// - the time moment when changes to line
										// were commited to the repository
			long revision,// - the revision the changes were commited to
			String author,// - the person who did those changes
			String line,// - a text line of the target file (on which
						// doAnnotate() was invoked)
			Date mergedDate,// - date when merge changes occurred
			long mergedRevision,// - revision in which merge changes occurred
			String mergedAuthor,// - author of merge
			String mergedPath,// - absolute repository path of the merged file
			int lineNumber) throws SVNException {
		node.setNumberLines(node.getNumberLines()+1);

	}

	public boolean handleRevision(Date arg0, long arg1, String arg2, File arg3)
			throws SVNException {
		// TODO Auto-generated method stub
		return false;
	}

	public FileSystemNode getNode() {
		return node;
	}

}
