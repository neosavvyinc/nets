package com.neosavvy.user.util {
    public class StringUtils {

        public static function isValidEmail(email:String):Boolean
        {
            var emailExpression:RegExp = /^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
            return emailExpression.test(email);
        }

    }
}