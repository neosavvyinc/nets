package com.neosavvy.security;

import java.lang.annotation.*;

/**
 * Created by IntelliJ IDEA.
 * User: tommyodom
 * Date: Jan 19, 2010
 * Time: 7:26:48 AM
 * To change this template use File | Settings | File Templates.
 */
@Target({ElementType.METHOD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface RunAs {
    String value();
}
