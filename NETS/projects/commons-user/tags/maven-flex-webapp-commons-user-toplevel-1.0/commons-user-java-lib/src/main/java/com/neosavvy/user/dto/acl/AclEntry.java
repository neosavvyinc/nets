package com.neosavvy.user.dto.acl;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: tommyodom
 * Date: Jan 16, 2010
 * Time: 7:57:00 PM
 * To change this template use File | Settings | File Templates.
 */

/**
 CREATE TABLE ACL_ENTRY(
     ID BIGSERIAL NOT NULL PRIMARY KEY,
     ACL_OBJECT_IDENTITY BIGINT NOT NULL,
     ACE_ORDER INT NOT NULL,
     SID BIGINT NOT NULL,
     MASK INTEGER NOT NULL,
     GRANTING BOOLEAN NOT NULL,
     AUDIT_SUCCESS BOOLEAN NOT NULL,
     AUDIT_FAILURE BOOLEAN NOT NULL,
     CONSTRAINT UNIQUE_UK_4 UNIQUE(ACL_OBJECT_IDENTITY,ACE_ORDER),
     CONSTRAINT FOREIGN_FK_4 FOREIGN KEY(ACL_OBJECT_IDENTITY) REFERENCES ACL_OBJECT_IDENTITY(ID),
     CONSTRAINT FOREIGN_FK_5 FOREIGN KEY(SID) REFERENCES ACL_SID(ID)
 );
 */
@Entity
@Table(name="ACL_ENTRY",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"ACL_OBJECT_IDENTITY", "ACE_ORDER"})
        }
)
public class AclEntry {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "acl_entry_id_seq")
    @SequenceGenerator(name = "acl_entry_id_seq", sequenceName = "acl_entry_id_seq", allocationSize=1)
    @Column(name="ID")
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "ACL_OBJECT_IDENTITY", nullable = false)
    private AclObjectIdentity objectIdentity;

    @Column(name = "ACE_ORDER")
    private int aceOrder;

    @ManyToOne(optional = false)
    @JoinColumn(name = "SID", nullable = false)
    private AclSid sid;

    @Column(name = "MASK", nullable = false)
    private int mask;

    @Column(name = "GRANTING", nullable = false)
    private boolean granting;

    @Column(name = "AUDIT_SUCCESS", nullable = false)
    private boolean auditSuccess;

    @Column(name = "AUDIT_FAILURE", nullable = false)
    private boolean auditFailure;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public com.neosavvy.user.dto.acl.AclObjectIdentity getObjectIdentity() {
        return objectIdentity;
    }

    public void setObjectIdentity(com.neosavvy.user.dto.acl.AclObjectIdentity objectIdentity) {
        this.objectIdentity = objectIdentity;
    }

    public int getAceOrder() {
        return aceOrder;
    }

    public void setAceOrder(int aceOrder) {
        this.aceOrder = aceOrder;
    }

    public com.neosavvy.user.dto.acl.AclSid getSid() {
        return sid;
    }

    public void setSid(com.neosavvy.user.dto.acl.AclSid sid) {
        this.sid = sid;
    }

    public int getMask() {
        return mask;
    }

    public void setMask(int mask) {
        this.mask = mask;
    }

    public boolean isGranting() {
        return granting;
    }

    public void setGranting(boolean granting) {
        this.granting = granting;
    }

    public boolean isAuditSuccess() {
        return auditSuccess;
    }

    public void setAuditSuccess(boolean auditSuccess) {
        this.auditSuccess = auditSuccess;
    }

    public boolean isAuditFailure() {
        return auditFailure;
    }

    public void setAuditFailure(boolean auditFailure) {
        this.auditFailure = auditFailure;
    }
}
