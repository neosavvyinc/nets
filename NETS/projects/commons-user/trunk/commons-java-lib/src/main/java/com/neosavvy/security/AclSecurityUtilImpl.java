/* Copyright (c) 2008, DENKSOFT SRL. All rights reserved.
     This software is licensed under the BSD license available at
     http://www.opensource.org/licenses/bsd-license.php, with these parameters:
     <OWNER> = DENKSOFT SRL <ORGANIZATION> = DENKSOFT SRL <YEAR> = 2008
*/

package com.neosavvy.security;

import org.springframework.security.acls.domain.ObjectIdentityImpl;
import org.springframework.security.acls.domain.PrincipalSid;
import org.springframework.security.acls.model.*;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Transactional
public class AclSecurityUtilImpl implements AclSecurityUtil {

    private static Log logger = LogFactory.getLog(AclSecurityUtil.class);

    private MutableAclService mutableAclService;
    
    public MutableAcl addAcl(SecuredObject securedObject, Class clazz) {
        ObjectIdentity oid = new ObjectIdentityImpl(clazz.getCanonicalName(), securedObject.getId());

        MutableAcl acl = null;

        // check to see if the ACL already exists, if it does then
        // we will update the parent to make sure the parent hasn't
        // changed.
        try {
            acl = (MutableAcl)mutableAclService.readAclById(oid);
        }
        catch (NotFoundException e) {
            acl = mutableAclService.createAcl(oid);
        }

        if (securedObject.getAclParentObject() != null) {
            ObjectIdentity parentOid = new ObjectIdentityImpl(securedObject.getAclParentClass().getCanonicalName(), securedObject.getAclParentObject().getId());
            try {
                Acl parentAcl = mutableAclService.readAclById(parentOid);
                acl.setParent(parentAcl);
            }
            catch (NotFoundException e) {
                // ignore
            }
        }
        
        return mutableAclService.updateAcl(acl);
    }

    public void deleteAcl(SecuredObject securedObject, Class clazz) {
        ObjectIdentity oid = new ObjectIdentityImpl(clazz.getCanonicalName(), securedObject.getId());
        mutableAclService.deleteAcl(oid, true);
    }

    public void addPermission(SecuredObject secureObject, Permission permission, Class clazz) {
        addPermission(secureObject, new PrincipalSid(getUsername()), permission, clazz);
    }

    public void addPermission(SecuredObject securedObject, Sid recipient, Permission permission, Class clazz) {
        MutableAcl acl;
        ObjectIdentity oid = new ObjectIdentityImpl(clazz.getCanonicalName(), securedObject.getId());

        try {
            acl = (MutableAcl) mutableAclService.readAclById(oid);
        } catch (NotFoundException nfe) {
            acl = addAcl(securedObject, clazz);
        }        
                                                                  
        acl.insertAce(acl.getEntries().size(), permission, recipient, true);
        mutableAclService.updateAcl(acl);

        if (logger.isDebugEnabled()) {
            logger.debug("Added permission " + permission + " for Sid " + recipient + " securedObject " + securedObject);
        }
    }

    public void deletePermission(SecuredObject securedObject, Sid recipient, Permission permission, Class clazz) {
        ObjectIdentity oid = new ObjectIdentityImpl(clazz.getCanonicalName(), securedObject.getId());
        MutableAcl acl = (MutableAcl) mutableAclService.readAclById(oid);

        // Remove all permissions associated with this particular recipient (string equality to KISS)
        List<AccessControlEntry> entries = acl.getEntries();

        for (int i = 0; i < entries.size(); i++) {
            if (entries.get(i).getSid().equals(recipient) && entries.get(i).getPermission().equals(permission)) {
                acl.deleteAce(i);
            }
        }

        mutableAclService.updateAcl(acl);

        if (logger.isDebugEnabled()) {
            logger.debug("Deleted securedObject " + securedObject + " ACL permissions for recipient " + recipient);
        }
    }

    public String getUsername() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        if (auth.getPrincipal() instanceof UserDetails) {
            return ((UserDetails) auth.getPrincipal()).getUsername();
        } else {
            return auth.getPrincipal().toString();
        }
    }

    public void setMutableAclService(MutableAclService mutableAclService) {
        this.mutableAclService = mutableAclService;
    }
}