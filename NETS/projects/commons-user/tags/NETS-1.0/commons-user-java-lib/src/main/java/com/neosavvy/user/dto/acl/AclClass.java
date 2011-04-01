package com.neosavvy.user.dto.acl;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: tommyodom
 * Date: Jan 16, 2010
 * Time: 7:42:28 PM
 * To change this template use File | Settings | File Templates.
 */

/**
 CREATE TABLE ACL_CLASS(
     ID BIGSERIAL NOT NULL PRIMARY KEY,
     CLASS VARCHAR NOT NULL,
     CONSTRAINT UNIQUE_UK_2 UNIQUE(CLASS)
 );
 *
 */
@Entity
@Table(name="ACL_CLASS",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"CLASS"})
        }
)
public class AclClass {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "acl_class_id_seq")
    @SequenceGenerator(name = "acl_class_id_seq", sequenceName = "acl_class_id_seq", allocationSize=1)
    @Column(name="ID")
    private Long id;
    @Column(name="class", nullable = false)
    private String clazz;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getClazz() {
        return clazz;
    }

    public void setClazz(String clazz) {
        this.clazz = clazz;
    }
}
