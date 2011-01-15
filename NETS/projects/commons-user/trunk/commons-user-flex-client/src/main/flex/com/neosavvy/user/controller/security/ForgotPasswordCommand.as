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
 * Date: 1/7/11
 * Time: 11:57 AM
 */
package com.neosavvy.user.controller.security {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;

    import com.neosavvy.user.dto.companyManagement.UserDTO;

    import com.neosavvy.user.model.SecurityProxy;

    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class ForgotPasswordCommand extends ResponderAsyncCommand {

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var user:UserDTO = notification.getBody() as UserDTO;
            var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
            securityProxy.resetUserPassword( user , this );

        }

        override protected function faultHandler(faultEvent:FaultEvent):void {
            sendNotification(ApplicationFacade.FORGOT_PASSWORD_FAULT);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            sendNotification(ApplicationFacade.FORGOT_PASSWORD_SUCCESS);
        }
    }
}
