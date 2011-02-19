package fineline.focal.common.types.v1;

import java.io.File;
import java.util.Date;

import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
@XmlRootElement
@XmlType
public class ScratchFileRef extends FileRef
{
    private static final long serialVersionUID = 1L;
    
    public static final String SCRATCH_ROOT = "/focal/storage/_focal_users";
    
    private String username;
    private String fileName;
    
    public ScratchFileRef() {}
    
    public ScratchFileRef(String username, File file) {
        this.username = username;
        this.fileName = file.getName();
        this.lastModifiedDate = new Date(file.lastModified());
    }
    
    public File getFile() {
        return new File(SCRATCH_ROOT + "/_" + username + "/" + fileName);
    }
    
    @Override
    public DataSource getDataSource() throws Exception {
        return new FileDataSource(getFile());
    }

    @XmlElement(required=true)
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    @XmlElement(required=true)
    public String getFileName() {
        return fileName;
    }
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
}
