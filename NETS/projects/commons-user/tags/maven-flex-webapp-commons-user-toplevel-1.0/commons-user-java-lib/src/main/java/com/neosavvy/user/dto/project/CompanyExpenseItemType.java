package com.neosavvy.user.dto.project;

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
 * Date: Jan 7, 2010
 * Time: 10:17:04 PM
 */
@Entity
@Table(
    name="COMPANY_EXPENSE_ITEM_TYPE" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@DiscriminatorValue("COMPANY_EXPENSE_ITEM_TYPE")
public class CompanyExpenseItemType extends ExpenseItemType {

    @ManyToOne
    @JoinColumn(name = "COMPANY_FK")
    private CompanyDTO company;

    public CompanyDTO getCompany() {
        return company;
    }

    public void setCompany(CompanyDTO company) {
        this.company = company;
    }
}
