/* Copyright (c) 2008, DENKSOFT SRL. All rights reserved.
     This software is licensed under the BSD license available at
     http://www.opensource.org/licenses/bsd-license.php, with these parameters:
     <OWNER> = DENKSOFT SRL <ORGANIZATION> = DENKSOFT SRL <YEAR> = 2008
*/

package com.neosavvy.security;

import org.springframework.dao.DataAccessException;
import org.springframework.security.access.hierarchicalroles.RoleHierarchy;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.util.Assert;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class CustomUserDetailsServiceWrapper implements UserDetailsService {

    private static Log log = LogFactory.getLog(CustomUserDetailsServiceWrapper.class);

    @PersistenceContext
    private EntityManager entityManager;
    private UserDetailsService userDetailsService = null;
    private RoleHierarchy roleHierarchy = null;
    private Class[] userInfoObjectTypes;

    public void setRoleHierarchy(RoleHierarchy roleHierarchy) {
        this.roleHierarchy = roleHierarchy;
    }

    public void setUserDetailsService(UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, DataAccessException {
        Assert.notEmpty(userInfoObjectTypes);
        UserDetails userDetails = userDetailsService.loadUserByUsername(username);

        for(Class clazz: userInfoObjectTypes) {
            try {
                CriteriaBuilder builder = entityManager.getCriteriaBuilder();
                CriteriaQuery<?> criteria = builder.createQuery(clazz);
                Root<?> root = criteria.from(clazz);
                CriteriaQuery<?> query = criteria.where(builder.equal(root.get("username"), username));
                Query q = entityManager.createQuery(query);
                List results = q.getResultList();

                if (!results.isEmpty()) {
                    return new CustomUserDetailsWrapper(userDetails, roleHierarchy, results.get(0));
                }
            } catch (PersistenceException ex) {
                log.warn("Caught persistence exception looking up user object of class " + clazz.getName() + " with username " + username);
            }
        }
        return new CustomUserDetailsWrapper(userDetails, roleHierarchy);
    }

    public UserDetailsService getWrappedUserDetailsService() {
        return userDetailsService;
    }

    public void setUserInfoObjectTypes(Class[] userInfoObjectTypes) {
        this.userInfoObjectTypes = userInfoObjectTypes;
    }
}
