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
 * Date: 2/13/11
 * Time: 3:05 PM
 */
package com.neosavvy.user.view.secured.userInfo {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.model.SecurityProxy;

    import flash.events.MouseEvent;

    import flexlib.controls.PromptingTextInput;

    import mx.controls.Button;
    import mx.controls.Label;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class YourInformationMediator extends Mediator implements IMediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.userInfo.YourInformationMediator")

        public static const NAME:String = "YourInformationMediator";

        private var _securityProxy:SecurityProxy;

        public function YourInformationMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }


        override public function onRegister():void {
            super.onRegister();

            changePasswordButton.addEventListener(MouseEvent.CLICK, onChangePasswordClicked);
            changePasswordConfirmed.addEventListener(MouseEvent.CLICK, onChangePasswordConfirmClicked);

            _securityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
        }

        private function onChangePasswordClicked(event:MouseEvent):void {
            changePasswordButton.visible = false;
            changePasswordButton.includeInLayout = false;

            newPassword.visible = true;
            newPassword.includeInLayout = true;
            newPassword.text = null;
            verifyPassword.visible = true;
            verifyPassword.includeInLayout = true;
            verifyPassword.text = null;
            currentPassword.visible = true;
            currentPassword.includeInLayout = true;
            currentPassword.text = null;
            changePasswordConfirmed.visible = true;
            changePasswordConfirmed.includeInLayout = true;

            changePasswordButton.visible = false;
            changePasswordButton.includeInLayout = false;
        }


        private function onChangePasswordConfirmClicked(event:MouseEvent):void
        {
            resetErrors();

            var activeUser : UserDTO = _securityProxy.activeUser;
            if( currentPassword.text == activeUser.password)
            {
                onCurrentPasswordVerified();
            }
            else
            {
                onCurrentPasswordFailed();
            }

        }

        private function resetErrors():void
        {
            currentPasswordIncorrectErrorLabel.visible = false;
            currentPasswordIncorrectErrorLabel.includeInLayout = false;
            passwordConfirmationErrorLabel.visible = false;
            passwordConfirmationErrorLabel.includeInLayout = false;
            passwordStrengthErrorLabel.visible = false;
            passwordStrengthErrorLabel.includeInLayout = false;
        }

        private function onCurrentPasswordFailed():void
        {
            currentPasswordIncorrectErrorLabel.visible = true;
            currentPasswordIncorrectErrorLabel.includeInLayout = true;
        }

        private function onCurrentPasswordVerified():void
        {

            if( verifyPassword.text != newPassword.text )
            {
                passwordConfirmationErrorLabel.visible = true;
                passwordConfirmationErrorLabel.includeInLayout = true;
                return;
            }

            if( verifyPassword.text.length < 8 || newPassword.text.length < 8)
            {
                passwordStrengthErrorLabel.visible = true;
                passwordStrengthErrorLabel.includeInLayout = true;
                return;
            }

            var activeUser : UserDTO = _securityProxy.activeUser;
            activeUser.password = newPassword.text;
            activeUser.passwordReset = false;

            sendNotification(ApplicationFacade.SAVE_USER_REQUEST, activeUser);
        }


        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.SAVE_USER_FAILED
                ,ApplicationFacade.SAVE_USER_SUCCESS
                ,ApplicationFacade.NAVIGATE_TO_YOUR_INFORMATION
            ];
        }


        override public function handleNotification(notification:INotification):void {
            switch( notification.getName() )
            {
                case ApplicationFacade.SAVE_USER_FAILED:
                    onSaveUserFailed();
                    break;
                case ApplicationFacade.SAVE_USER_SUCCESS:
                    onSaveUserSuccess();
                    break;
                case ApplicationFacade.NAVIGATE_TO_YOUR_INFORMATION:
                    resetErrors();
                    resetChangePasswordForm();
                    break;
            }
        }

        private function onSaveUserSuccess():void {
            resetErrors();

            resetChangePasswordForm();
        }

        private function resetChangePasswordForm():void {
            changePasswordButton.visible = true;

            currentPassword.visible = false;
            currentPassword.includeInLayout = false;
            newPassword.visible = false;
            newPassword.includeInLayout = false;
            verifyPassword.visible = false;
            verifyPassword.includeInLayout = false;

            changePasswordConfirmed.visible = false;
            changePasswordConfirmed.includeInLayout = false;
        }

        private function onSaveUserFailed():void {
        }

        public function get yourInformation():YourInformation
        {
            return viewComponent as YourInformation;
        }

        public function get changePasswordButton():Button
        {
            return yourInformation.changePassword;
        }

        public function get newPassword():PromptingTextInput
        {
            return yourInformation.newPassword;
        }

        public function get verifyPassword():PromptingTextInput
        {
            return yourInformation.verifyPassword;
        }

        public function get currentPassword():PromptingTextInput
        {
            return yourInformation.currentPassword;
        }

        public function get changePasswordConfirmed():Button
        {
            return yourInformation.changePasswordConfirmed;
        }

        public function get passwordConfirmationErrorLabel():Label
        {
            return yourInformation.passwordConfirmationErrorLabel;
        }

        public function get currentPasswordIncorrectErrorLabel():Label
        {
            return yourInformation.currentPasswordIncorrectErrorLabel;
        }

        public function get passwordStrengthErrorLabel():Label
        {
            return yourInformation.passwordStrengthErrorLabel;
        }
    }
}
