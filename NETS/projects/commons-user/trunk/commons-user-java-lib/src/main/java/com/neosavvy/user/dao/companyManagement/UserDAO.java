package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dao.base.BaseUserDAO;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserDTO;
import com.neosavvy.user.dto.project.Project;
import fineline.focal.common.types.v1.StorageServiceFileRef;

import java.util.List;
import java.util.Set;
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
 * Time: 3:21:25 PM
 */
public interface UserDAO extends BaseUserDAO<UserDTO> {

    public List<UserDTO> findUsersForCompany(CompanyDTO company, UserDTO user);

    public List<UserDTO> findAvailableUsersForProject(Project project);

    public String findMostCurrentSessionIdForUser(String username);

}
