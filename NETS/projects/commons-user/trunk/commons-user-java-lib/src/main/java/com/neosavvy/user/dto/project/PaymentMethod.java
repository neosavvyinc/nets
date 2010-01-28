package com.neosavvy.user.dto.project;

import com.neosavvy.user.dto.base.BaseDTO;

import javax.persistence.*;
/*************************************************************************
 *
 * NEOSAVVY CONFIDENTIAL
 * __________________
 *
 *  Copyright 2008 - 2009 Neosavvy Incorporated
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Neosavvy Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Neosavvy Incorporated
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Neosavvy Incorporated.
 **************************************************************************/

/**
 * User: adamparrish
 * Date: Jan 2, 2010
 * Time: 11:37:09 AM
 */
@Entity
@Table(
    name="PAYMENT_METHOD" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn( name = "TYPE" )
public abstract class PaymentMethod extends BaseDTO {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "payment_method_id_seq")
    @SequenceGenerator(name = "payment_method_id_seq", sequenceName = "payment_method_id_seq", allocationSize=1)
	@Column(name="ID")
	private Long id;  

    @Column(name="NAME")
    private String name;

    @Column(name="DESCRIPTION")
    private String description;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
