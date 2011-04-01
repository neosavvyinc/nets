package com.neosavvy.user.dto.project;

import com.neosavvy.security.SecuredObject;
import com.neosavvy.user.dto.base.BaseUserDTO;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import fineline.focal.common.types.v1.EntityListenerManager;

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
 * Date: Jan 5, 2010
 * Time: 9:38:51 AM
 */
@Entity
@Table(
    name="CLIENT_USER_CONTACT" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@EntityListeners(EntityListenerManager.class)
public class ClientUserContact extends BaseUserDTO implements SecuredObject<ClientUserContact> {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "client_user_contact_id_seq")
    @SequenceGenerator(name = "client_user_contact_id_seq", sequenceName = "client_user_contact_id_seq", allocationSize=1)
    @Column(name="ID")
    private Long id;


    @OneToOne(mappedBy = "clientContact")
    private ClientCompany clientCompany;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public ClientCompany getClientCompany() {
        return clientCompany;
    }

    public void setClientCompany(ClientCompany clientCompany) {
        this.clientCompany = clientCompany;
    }

    public SecuredObject getAclParentObject() {
        if (clientCompany != null) {
            return clientCompany.getParentCompany();
        }
        return null;
    }

    public Class getAclParentClass() {
        return CompanyDTO.class;
    }

    public Class<ClientUserContact> getAclClass() {
        return ClientUserContact.class;
    }
    
    public String getOwnerUsername() {
        return null;
    }

    public ClientUserContact() {
        super();
    }
}
