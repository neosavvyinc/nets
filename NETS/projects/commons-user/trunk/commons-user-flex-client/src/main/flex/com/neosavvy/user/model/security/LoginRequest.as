package com.neosavvy.user.model.security {
    public class LoginRequest {
        private var _userName:String;
        private var _password:String;


        public function LoginRequest(userName:String, password:String) {
            _userName = userName;
            _password = password;
        }

        public function get userName():String {
            return _userName;
        }

        public function get password():String {
            return _password;
        }
    }
}