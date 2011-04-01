package com.neosavvy.user.dto.acl;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: tommyodom
 * Date: Jan 16, 2010
 * Time: 7:38:03 PM
 * To change this template use File | Settings | File Templates.
 */

/**
 * CREATE TABLE ACL_SID(
    ID BIGSERIAL NOT NULL PRIMARY KEY,
    PRINCIPAL BOOLEAN NOT NULL,
    SID VARCHAR(100) NOT NULL,
    CONSTRAINT UNIQUE_UK_1 UNIQUE(SID,PRINCIPAL)
);
 */
@Entity
@Table(name="ACL_SID",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"SID", "PRINCIPAL"})
        }
)
public class AclSid {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "acl_sid_id_seq")
    @SequenceGenerator(name = "acl_sid_id_seq", sequenceName = "acl_sid_id_seq", allocationSize=1)
    @Column(name="ID")
    private Long id;
    @Column(name="principal", nullable = false)
    private boolean principal;
    @Column(name="sid", nullable = false, length = 100)
    private String sid;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public boolean isPrincipal() {
        return principal;
    }

    public void setPrincipal(boolean principal) {
        this.principal = principal;
    }

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }
}
