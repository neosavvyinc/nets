package fineline.focal.common.types.v1;

import javax.activation.DataSource;
import javax.mail.util.ByteArrayDataSource;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
@XmlType(namespace="urn:fineline:focal:common:types:v1")
public class XmlFileRef extends FileRef 
{
    private static final long serialVersionUID = 1L;
    
	private byte[] data;
	private String contentType;
	private String fileName;
	
	public DataSource getDataSource() throws Exception
	{
		return new ByteArrayDataSource(data, contentType);
	}
	
	@XmlElement(required=true)
	public byte[] getData() {
		return data;
	}

	public void setData(byte[] data) {
		this.data = data;
	}

	@XmlElement(required=true)
	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	@XmlElement(required=true)
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
		
}
