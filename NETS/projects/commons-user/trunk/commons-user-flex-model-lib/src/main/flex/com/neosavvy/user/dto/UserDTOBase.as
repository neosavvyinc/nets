/**
 * Generated by Gas3 v1.1.0 (Granite Data Services).
 *
 * WARNING: DO NOT CHANGE THIS FILE. IT MAY BE OVERRIDDEN EACH TIME YOU USE
 * THE GENERATOR. CHANGE INSTEAD THE INHERITED CLASS (UserDTO.as).
 */

package com.neosavvy.user.dto {

    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;
    import mx.collections.ListCollectionView;
    import org.granite.meta;

    [Bindable]
    public class UserDTOBase extends BaseUserDTO {

        private var _confirmedRegistration:Boolean;
        private var _active:Boolean;
        private var _password:String;
        private var _registrationToken:String;
        private var _userCompanyRoles:ListCollectionView;
        private var _username:String;

        public function set confirmedRegistration(value:Boolean):void {
            _confirmedRegistration = value;
        }

        public function get confirmedRegistration():Boolean {
            return _confirmedRegistration;
        }

        public function set password(value:String):void {
            _password = value;
        }
        public function get password():String {
            return _password;
        }

        public function set registrationToken(value:String):void {
            _registrationToken = value;
        }
        public function get registrationToken():String {
            return _registrationToken;
        }

        public function set userCompanyRoles(value:ListCollectionView):void {
            _userCompanyRoles = value;
        }
        public function get userCompanyRoles():ListCollectionView {
            return _userCompanyRoles;
        }

        public function set username(value:String):void {
            _username = value;
        }
        public function get username():String {
            return _username;
        }
        public function get active():Boolean {
            return _active;
        }

        public function set active(value:Boolean):void {
            _active = value;
        }
    }
}