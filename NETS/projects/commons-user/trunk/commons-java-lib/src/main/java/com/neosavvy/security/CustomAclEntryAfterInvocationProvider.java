/* Copyright (c) 2008, DENKSOFT SRL. All rights reserved.
     This software is licensed under the BSD license available at
     http://www.opensource.org/licenses/bsd-license.php, with these parameters:
     <OWNER> = DENKSOFT SRL <ORGANIZATION> = DENKSOFT SRL <YEAR> = 2008
*/

package com.neosavvy.security;

import org.springframework.security.*;
import org.springframework.security.afterinvocation.AclEntryAfterInvocationProvider;
import org.springframework.security.acls.AclService;
import org.springframework.security.acls.Permission;
import org.springframework.security.acls.IdentityUnavailableException;
import org.springframework.util.Assert;
import org.springframework.util.ClassUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.lang.reflect.Method;
import java.io.Serializable;


public class CustomAclEntryAfterInvocationProvider extends AclEntryAfterInvocationProvider {

    protected static final Log logger = LogFactory.getLog(CustomAclEntryAfterInvocationProvider.class);

    public CustomAclEntryAfterInvocationProvider(AclService aclService, Permission[] requirePermission) {
        super(aclService, requirePermission);
    }


    public Object decide(Authentication authentication, Object object, ConfigAttributeDefinition config, Object returnedObject) throws AccessDeniedException {
        if(returnedObject != null) {
            if(!(object instanceof SecuredObject) || getIdentity((SecuredObject)object) == 0) {
                return returnedObject;
            }
        }
        
        return super.decide(authentication, object, config, returnedObject);
    }

    private long getIdentity(SecuredObject object)  {
        if (object.getId() == null) {
            return 0;
        }
        return object.getId();
    }
}
