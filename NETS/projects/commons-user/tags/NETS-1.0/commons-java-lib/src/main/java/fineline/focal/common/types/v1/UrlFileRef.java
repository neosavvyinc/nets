package fineline.focal.common.types.v1;


import java.net.URL;

import javax.activation.DataSource;
import javax.activation.URLDataSource;
import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
@XmlType(namespace="urn:fineline:focal:common:types:v1")
@Entity
@Table(name="url_file_refs")
@DiscriminatorValue("url")
public class UrlFileRef extends FileRef
{
    private static final long serialVersionUID = 1L;
    
	private String url;
	
	public DataSource getDataSource() throws Exception
	{
		return new URLDataSource(new URL(url));
	}

	@XmlElement(required=true)
	@Column(name="url", length=200, nullable=false)
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
    public String getFileName() {
        StringBuilder builder = new StringBuilder(getUrl());
        int pathIndex = builder.lastIndexOf("/");
        
        if (pathIndex != -1) {
            int queryParamsIndex = builder.indexOf("?", pathIndex);
            
            if (queryParamsIndex != -1) {
                return builder.substring(pathIndex + 1, queryParamsIndex);
            }
            
            return builder.substring(pathIndex + 1);
        }
        
        return builder.toString();
    }
}
