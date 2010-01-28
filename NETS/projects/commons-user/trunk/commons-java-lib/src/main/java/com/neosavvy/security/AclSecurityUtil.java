/* Copyright (c) 2008, DENKSOFT SRL. All rights reserved.
     This software is licensed under the BSD license available at
     http://www.opensource.org/licenses/bsd-license.php, with these parameters:
     <OWNER> = DENKSOFT SRL <ORGANIZATION> = DENKSOFT SRL <YEAR> = 2008
*/

package com.neosavvy.security;

import org.springframework.security.acls.sid.Sid;
import org.springframework.security.acls.*;



public interface AclSecurityUtil {

    public MutableAcl addAcl(SecuredObject securedObject, Class clazz);
    public void deleteAcl(SecuredObject securedObject, Class clazz);
    public void addPermission(SecuredObject securedObject, Permission permission, Class clazz);
    public void addPermission(SecuredObject securedObject, Sid recipient, Permission permission, Class clazz);
    public void deletePermission(SecuredObject securedObject, Sid recipient, Permission permission, Class clazz);
}
