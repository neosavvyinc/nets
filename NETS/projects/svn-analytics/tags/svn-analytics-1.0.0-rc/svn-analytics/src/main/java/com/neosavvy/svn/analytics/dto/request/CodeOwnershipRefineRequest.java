package com.neosavvy.svn.analytics.dto.request;

import com.neosavvy.svn.analytics.dto.file.FileSystemNode;

public class CodeOwnershipRefineRequest extends RefineSearchRequest {

	private FileSystemNode parentNode;

	public FileSystemNode getParentNode() {
		return parentNode;
	}

	public void setParentNode(FileSystemNode parentNode) {
		this.parentNode = parentNode;
	}

	/**
	 * Constructs a <code>String</code> with all attributes
	 * in name = value format.
	 *
	 * @return a <code>String</code> representation 
	 * of this object.
	 */
	public String toString()
	{
	    final String TAB = "    ";
	    
	    String retValue = "";
	    
	    retValue = "CodeOwnershipRefineRequest ( "
	        + super.toString() + TAB
	        + "parentNode = " + this.parentNode + TAB
	        + " )";
	
	    return retValue;
	}
	
	
}
