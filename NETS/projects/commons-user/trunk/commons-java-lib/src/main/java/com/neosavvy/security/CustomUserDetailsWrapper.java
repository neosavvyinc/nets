/* Copyright (c) 2008, DENKSOFT SRL. All rights reserved.
     This software is licensed under the BSD license available at
     http://www.opensource.org/licenses/bsd-license.php, with these parameters:
     <OWNER> = DENKSOFT SRL <ORGANIZATION> = DENKSOFT SRL <YEAR> = 2008
*/

package com.neosavvy.security;

import org.springframework.security.access.hierarchicalroles.UserDetailsWrapper;
import org.springframework.security.access.hierarchicalroles.RoleHierarchy;
import org.springframework.security.core.userdetails.UserDetails;

public class CustomUserDetailsWrapper extends UserDetailsWrapper {

    private Object userInfo;

    public CustomUserDetailsWrapper(UserDetails userDetails, RoleHierarchy roleHierarchy) {
        super(userDetails, roleHierarchy);
    }

    public CustomUserDetailsWrapper(UserDetails userDetails, RoleHierarchy roleHierarchy, Object userInfo) {
        super(userDetails, roleHierarchy);
        this.userInfo = userInfo;
    }

    public Object getUserInfo() {
        return userInfo;
    }
    
}
