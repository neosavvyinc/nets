package com.neosavvy.user.dto.acl;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: tommyodom
 * Date: Jan 16, 2010
 * Time: 7:44:18 PM
 * To change this template use File | Settings | File Templates.
 */

/**
 CREATE TABLE ACL_OBJECT_IDENTITY(
     ID BIGSERIAL NOT NULL PRIMARY KEY,
     OBJECT_ID_CLASS BIGINT NOT NULL,
     OBJECT_ID_IDENTITY BIGINT NOT NULL,
     PARENT_OBJECT BIGINT,
     OWNER_SID BIGINT,
     ENTRIES_INHERITING BOOLEAN NOT NULL,
     CONSTRAINT UNIQUE_UK_3 UNIQUE(OBJECT_ID_CLASS,OBJECT_ID_IDENTITY),
     CONSTRAINT FOREIGN_FK_1 FOREIGN KEY(PARENT_OBJECT)REFERENCES ACL_OBJECT_IDENTITY(ID),
     CONSTRAINT FOREIGN_FK_2 FOREIGN KEY(OBJECT_ID_CLASS)REFERENCES ACL_CLASS(ID),
     CONSTRAINT FOREIGN_FK_3 FOREIGN KEY(OWNER_SID)REFERENCES ACL_SID(ID)
 );
 */
@Entity
@Table(name="ACL_OBJECT_IDENTITY",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"OBJECT_ID_CLASS", "OBJECT_ID_IDENTITY"})
        }
)
public class AclObjectIdentity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "acl_object_identity_id_seq")
    @SequenceGenerator(name = "acl_object_identity_id_seq", sequenceName = "acl_object_identity_id_seq", allocationSize=1)
    @Column(name="ID")
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "OBJECT_ID_CLASS", nullable = false)
    private AclClass aclClass;

    @Column(name="OBJECT_ID_IDENTITY", nullable = false)
    private Long objectIdIdentity;

    @ManyToOne(optional = true)
    @JoinColumn(name = "PARENT_OBJECT", nullable = true)
    private AclObjectIdentity parentObject;

    @ManyToOne(optional = false)
    @JoinColumn(name = "OWNER_SID", nullable = false)
    private AclSid ownerSid;

    @Column(name = "ENTRIES_INHERITING", nullable = false)
    private boolean entriesInheriting;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public com.neosavvy.user.dto.acl.AclClass getAclClass() {
        return aclClass;
    }

    public void setAclClass(com.neosavvy.user.dto.acl.AclClass aclClass) {
        this.aclClass = aclClass;
    }

    public Long getObjectIdIdentity() {
        return objectIdIdentity;
    }

    public void setObjectIdIdentity(Long objectIdIdentity) {
        this.objectIdIdentity = objectIdIdentity;
    }

    public com.neosavvy.user.dto.acl.AclObjectIdentity getParentObject() {
        return parentObject;
    }

    public void setParentObject(com.neosavvy.user.dto.acl.AclObjectIdentity parentObject) {
        this.parentObject = parentObject;
    }

    public com.neosavvy.user.dto.acl.AclSid getOwnerSid() {
        return ownerSid;
    }

    public void setOwnerSid(com.neosavvy.user.dto.acl.AclSid ownerSid) {
        this.ownerSid = ownerSid;
    }

    public boolean isEntriesInheriting() {
        return entriesInheriting;
    }

    public void setEntriesInheriting(boolean entriesInheriting) {
        this.entriesInheriting = entriesInheriting;
    }
}
