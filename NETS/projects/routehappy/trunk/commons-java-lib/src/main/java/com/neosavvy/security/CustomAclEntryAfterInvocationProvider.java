/* Copyright (c) 2008, DENKSOFT SRL. All rights reserved.
     This software is licensed under the BSD license available at
     http://www.opensource.org/licenses/bsd-license.php, with these parameters:
     <OWNER> = DENKSOFT SRL <ORGANIZATION> = DENKSOFT SRL <YEAR> = 2008
*/

package com.neosavvy.security;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.acls.model.AclService;
import org.springframework.security.acls.model.Permission;
import org.springframework.security.acls.afterinvocation.AclEntryAfterInvocationProvider;
import org.springframework.security.core.Authentication;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.Collection;
import java.util.List;


public class CustomAclEntryAfterInvocationProvider extends AclEntryAfterInvocationProvider {

    protected static final Log logger = LogFactory.getLog(CustomAclEntryAfterInvocationProvider.class);

    public CustomAclEntryAfterInvocationProvider(AclService aclService, List<Permission> requirePermission) {
        super(aclService, requirePermission);
    }


    public Object decide(Authentication authentication, Object object, Collection<ConfigAttribute> config, Object returnedObject) throws AccessDeniedException {
        if(returnedObject != null) {
            if(!(object instanceof SecuredObject) || SecurityHelper.getIdentity((SecuredObject)object) == 0) {
                return returnedObject;
            }
        }
        
        return super.decide(authentication, object, config, returnedObject);
    }

}
