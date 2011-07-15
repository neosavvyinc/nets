/*************************************************************************
 *
 * NEOSAVVY CONFIDENTIAL
 * __________________
 *
 *  Copyright 2008 - 2009 Neosavvy Incorporated
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Neosavvy Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Neosavvy Incorporated
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Neosavvy Incorporated.
 **************************************************************************/

/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 7/14/11
 * Time: 10:59 PM
 */
package {
    import com.neosavvy.user.view.secured.SecuredContainer;
    import com.neosavvy.user.view.security.Login;

    import mx.containers.Box;

    import mx.containers.ViewStack;
    import mx.controls.Button;
    import mx.controls.Label;

    public interface INETS {

        function get navigationViewStack():ViewStack;

        function get login():Login;

        function get secureHeaderBar():Box;

        function get securedContainer():SecuredContainer

        function get logoutButton():Button;

        function get companyNameHeader():Label;

        function get loggedInUser():Label;

    }
}
