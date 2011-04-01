package com.neosavvy.security;

import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.acls.AclEntryVoter;
import org.springframework.security.acls.model.AclService;
import org.springframework.security.acls.model.Permission;
import org.springframework.security.core.Authentication;

import java.util.Collection;

public class CustomAclEntryVoter extends AclEntryVoter {

    public CustomAclEntryVoter(AclService aclService, String processConfigAttribute, Permission[] requirePermission) {
        super(aclService, processConfigAttribute, requirePermission);
    }

    @Override
    public int vote(Authentication authentication, Object object, Collection<ConfigAttribute> attributes) {
        for(ConfigAttribute attr : attributes) {

            if (!this.supports(attr)) {
                continue;
            }
            // Need to make an access decision on this invocation
            // Attempt to locate the domain object instance to process
            Object domainObject = getDomainObjectInstance(object);

            // If this is a new object then there won't be any ACLs assigned to the object
            if (domainObject instanceof SecuredObject && SecurityHelper.getIdentity((SecuredObject)domainObject) == 0) {
                return ACCESS_ABSTAIN;
            }
        }

        return super.vote(authentication, object, attributes);
    }
}
