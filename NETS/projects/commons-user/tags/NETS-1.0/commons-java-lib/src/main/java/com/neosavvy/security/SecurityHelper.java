package com.neosavvy.security;

public class SecurityHelper {
    public static long getIdentity(SecuredObject object)  {
        if (object.getId() == null) {
            return 0;
        }
        return object.getId();
    }
}
