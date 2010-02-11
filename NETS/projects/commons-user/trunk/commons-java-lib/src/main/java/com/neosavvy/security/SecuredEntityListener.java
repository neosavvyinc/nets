package com.neosavvy.security;

import com.neosavvy.security.AclSecurityUtil;
import com.neosavvy.security.RunAsExecutor;
import com.neosavvy.security.SecuredObject;
import fineline.focal.common.types.v1.EntityListener;
import org.springframework.security.acls.domain.BasePermission;
import org.springframework.security.acls.sid.PrincipalSid;
import org.springframework.security.acls.sid.Sid;

/**
 * Created by IntelliJ IDEA.
 * User: tommyodom
 * Date: Jan 22, 2010
 * Time: 7:56:17 PM
 * To change this template use File | Settings | File Templates.
 */
public class SecuredEntityListener implements EntityListener {
    private AclSecurityUtil aclSecurityUtil;
    private RunAsExecutor adminExecutor;

    public void postPersist(Object entity) {
        if (entity instanceof SecuredObject) {
            final SecuredObject securedEntity = (SecuredObject)entity;
            adminExecutor.runAsAdmin(new Runnable() {
                public void run() {
                    aclSecurityUtil.addAcl(securedEntity, securedEntity.getAclClass());
                    if (securedEntity.getOwnerUsername() != null) {
                        Sid ownerSid = new PrincipalSid(securedEntity.getOwnerUsername());
                        aclSecurityUtil.addPermission(securedEntity, ownerSid, BasePermission.READ, securedEntity.getAclClass());
                        aclSecurityUtil.addPermission(securedEntity, ownerSid, BasePermission.WRITE, securedEntity.getAclClass());
                        aclSecurityUtil.addPermission(securedEntity, ownerSid, BasePermission.DELETE, securedEntity.getAclClass());
                    }
                }
            });
        }

    }

    public void postRemove(Object entity) {
        if (entity instanceof SecuredObject) {
            final SecuredObject securedEntity = (SecuredObject)entity;
            adminExecutor.runAsAdmin(new Runnable() {
                public void run() {
                    aclSecurityUtil.deleteAcl(securedEntity, securedEntity.getAclClass());
                }
            });
        }
    }

    public void postLoad(Object entity) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public void postUpdate(Object entity) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public void prePersist(Object entity) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public void preRemove(Object entity) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public void preUpdate(Object entity) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public AclSecurityUtil getAclSecurityUtil() {
        return aclSecurityUtil;
    }

    public void setAclSecurityUtil(AclSecurityUtil aclSecurityUtil) {
        this.aclSecurityUtil = aclSecurityUtil;
    }

    public RunAsExecutor getAdminExecutor() {
        return adminExecutor;
    }

    public void setAdminExecutor(RunAsExecutor adminExecutor) {
        this.adminExecutor = adminExecutor;
    }
}