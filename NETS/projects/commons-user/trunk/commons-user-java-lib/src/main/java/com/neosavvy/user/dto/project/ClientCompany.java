package com.neosavvy.user.dto.project;

import com.neosavvy.user.dto.companyManagement.AbstractCompany;

import javax.persistence.Entity;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
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

    @OneToOne
    private ClientUserContact clientContact;

}
