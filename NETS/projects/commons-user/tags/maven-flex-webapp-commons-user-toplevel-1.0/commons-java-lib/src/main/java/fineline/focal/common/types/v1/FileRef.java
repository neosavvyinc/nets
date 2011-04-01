package fineline.focal.common.types.v1;

import javax.activation.DataSource;
import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.bind.annotation.XmlType;

import flex.messaging.annotations.FlexField;
import flex.messaging.annotations.FlexField.FlexFieldType;

/**
 * This class is a derivative work of Fineline via Tommy Odom.
 * The code herein cannot be distributed without first establishing prior written consent
 * from tommy.odom@gmail.com
 */
@XmlType(namespace="urn:fineline:focal:common:types:v1")
@Entity
@Inheritance(strategy=InheritanceType.JOINED)
@Table(name="file_refs")
@DiscriminatorColumn(name="type", length=20)
@XmlSeeAlso({StorageServiceFileRef.class, UrlFileRef.class, XmlFileRef.class, ScratchFileRef.class})
public abstract class FileRef extends AbstractEntity
{
    private static final long serialVersionUID = 1L;
    
	private Long fileSize;
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "file_ref_id_seq")
	@SequenceGenerator(name = "file_ref_id_seq", sequenceName = "file_refs_id_seq", allocationSize=1)
    @FlexField(fieldType=FlexFieldType.ReadWrite)
    @Column(name="id")
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}

	@XmlAttribute
	@Column(name="file_size", nullable=true)
	public Long getFileSize() {
		return fileSize;
	}
	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}
	
	@FlexField(fieldType=FlexFieldType.Excluded)
	public abstract DataSource getDataSource() throws Exception;
	
	public abstract String getFileName();
}
