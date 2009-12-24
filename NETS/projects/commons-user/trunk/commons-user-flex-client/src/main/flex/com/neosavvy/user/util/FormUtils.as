package com.neosavvy.user.util {
    import mx.controls.TextInput;

    public class FormUtils {

        public static function isInputSet(textInputField:TextInput):Boolean {

            if(textInputField == null) {
                return false;
            }

            if(textInputField.text == null || textInputField.text == "") {
                return false;
            }

            return true;

        }

    }
}