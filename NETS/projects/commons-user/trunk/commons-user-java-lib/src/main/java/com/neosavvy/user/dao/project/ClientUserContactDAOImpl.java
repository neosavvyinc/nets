package com.neosavvy.user.dao.project;

import com.neosavvy.user.dao.base.BaseUserDAO;
import com.neosavvy.user.dao.base.BaseUserDAOImpl;
import com.neosavvy.user.dto.project.ClientUserContact;
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
 * Time: 4:24:48 PM
 */
public class ClientUserContactDAOImpl extends BaseUserDAOImpl<ClientUserContact> implements ClientUserContactDAO {
    @Override
    protected Class getTypeClass() {
        return ClientUserContact.class;
    }
}
