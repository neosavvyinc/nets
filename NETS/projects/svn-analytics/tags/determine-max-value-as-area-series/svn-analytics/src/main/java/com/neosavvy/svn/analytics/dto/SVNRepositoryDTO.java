package com.neosavvy.svn.analytics.dto;

public class SVNRepositoryDTO {

	private long id;
	private String name;
    private String url;
    private String userName;
    private String password;
    private long startRevision = 0;
    private long endRevision = -1;

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

}
