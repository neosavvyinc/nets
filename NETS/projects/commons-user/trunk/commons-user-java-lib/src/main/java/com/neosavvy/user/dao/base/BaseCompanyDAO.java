package com.neosavvy.user.dao.base;

import com.neosavvy.user.dto.companyManagement.AbstractCompany;

import java.util.List;
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
 * Date: Jan 6, 2010
 * Time: 3:38:09 AM
 */
public interface BaseCompanyDAO<T extends AbstractCompany> {
    public List<T> getCompanies();

	public T saveCompany(T company);

    public T updateCompany(T company);

	public T findCompanyById(long id);

	public List<T> findCompanies(T company);

    public void delete(T company);
}