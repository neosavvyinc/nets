package com.neosavvy.svn.analytics.dto;

import java.util.List;

import com.neosavvy.svn.analytics.dto.file.FileSystemNode;
import com.neosavvy.svn.analytics.util.SvnKitUtil;
import org.tmatesoft.svn.core.SVNURL;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.io.SVNRepository;
import org.tmatesoft.svn.core.io.SVNRepositoryFactory;
import org.tmatesoft.svn.core.wc.SVNWCUtil;

public class SVNRepositoryDTO {

	private long id;
	private String name;
    private String url;
    private String userName;
    private String password;
    private long startRevision = 0;
    private long endRevision = -1;
    
    private List<FileSystemNode> children;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}    

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public long getStartRevision() {
        return startRevision;
    }

    public void setStartRevision(long startRevision) {
        this.startRevision = startRevision;
    }

    public long getEndRevision() {
        return endRevision;
    }

    public void setEndRevision(long endRevision) {
        this.endRevision = endRevision;
    }

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<FileSystemNode> getChildren() {
		return children;
	}

	public void setChildren(List<FileSystemNode> children) {
		this.children = children;
	}

    public String getRoot() {

        SvnKitUtil.setupLibrary();
        try {
            SVNRepository repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(this.getUrl()));
            ISVNAuthenticationManager authManager = SVNWCUtil.createDefaultAuthenticationManager(getUserName(), getPassword());
            repository.setAuthenticationManager(authManager);
            String path = repository.getLocation().getPath();
            String root = repository.getRepositoryRoot(true).getPath();
            if( path.equals(root) ) {
                return null;
            } else if( !path.equals(root) ) {
                String derivedRoot = path.substring(root.length(), path.lastIndexOf("/"));
                return derivedRoot;
            }
            return path;
        } catch (Exception e) {
            return null;
        }
    }
}
