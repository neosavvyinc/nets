package com.neosavvy.user.dto.project;

import com.neosavvy.user.dto.companyManagement.AbstractCompany;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;

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
 * Time: 11:17:59 AM
 */

@Entity
@Table(
    name="CLIENT_COMPANY" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
public class ClientCompany extends AbstractCompany {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "client_company_id_seq")
    @SequenceGenerator(name = "client_company_id_seq", sequenceName = "client_company_id_seq", allocationSize=1)
    @Column(name="ID")
    private Long id;

    @OneToOne
    @JoinColumn(name="CLIENT_USER_CONTACT_FK")
    private ClientUserContact clientContact;

    @OneToOne
    @JoinColumn(name="PARENT_COMPANY_FK")
    private CompanyDTO parentCompany;

    public ClientUserContact getClientContact() {
        return clientContact;
    }

    public void setClientContact(ClientUserContact clientContact) {
        this.clientContact = clientContact;
    }

    public CompanyDTO getParentCompany() {
        return parentCompany;
    }

    public void setParentCompany(CompanyDTO parentCompany) {
        this.parentCompany = parentCompany;
    }


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public ClientCompany() {
        super();
    }
}
