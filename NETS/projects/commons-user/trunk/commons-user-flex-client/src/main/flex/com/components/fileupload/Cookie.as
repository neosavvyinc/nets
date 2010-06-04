package com.components.fileupload
{

    import flash.external.ExternalInterface;

    /**
     * The Cookie class provides a simple way to create or access
     * cookies in the embedding HTML document of the application.
     *
     */
    public class Cookie {

        /**
         * Flag if the class was properly initialized.
         */
        private static var _initialized:Boolean = false;

        /**
         * Name of the cookie.
         */
        private var _name:String;

        /**
         * Contents of the cookie.
         */
        private var _value:String;

        /**
         * Flag indicating if a cookie was just created. It is <code>true</code>
         * when the cookie did not exist before and <code>false</code> otherwise.
         */
        private var _isNew:Boolean;

        /**
         * Name of the external javascript function used for getting
         * cookie information.
         */
        private static const GET_COOKIE:String = "cookieGetCookie";

        /**
         * Name of the external javascript function used for setting
         * cookie information.
         */
        private static const SET_COOKIE:String = "cookieSetCookie";

        /**
         * Javascript code to define the GET_COOKIE function.
         */
        private static var FUNCTION_GET_COOKIE:String =
                "function () { " +
                "if (document." + GET_COOKIE + " == null) {" +
                GET_COOKIE + " = function (name) { " +
                "if (document.cookie) {" +
                "cookies = document.cookie.split('; ');" +
                "for (i = 0; i < cookies.length; i++) {" +
                "param = cookies[i].split('=', 2);" +
                "if (decodeURIComponent(param[0]) == name) {" +
                "value = decodeURIComponent(param[1]);" +
                "return value;" +
                "}" +
                "}" +
                "}" +
                "return null;" +
                "};" +
                "}" +
                "}";

        /**
         * Javascript code to define the SET_COOKIE function.
         */
        private static var FUNCTION_SET_COOKIE:String =
                "function () { " +
                "if (document." + SET_COOKIE + " == null) {" +
                SET_COOKIE + " = function (name, value) { " +
                "document.cookie = name + '=' + value;" +
                "};" +
                "}" +
                "}";

        /**
         * Initializes the class by injecting javascript code into
         * the embedding document. If the class was already initialized
         * before, this method does nothing.
         */
        private static function initialize():void {
            if (Cookie._initialized) {
                return;
            }

            if (!ExternalInterface.available) {
                throw new Error("ExternalInterface is not available in this container. Internet Explorer ActiveX, Firefox, Mozilla 1.7.5 and greater, or other browsers that support NPRuntime are required.");
            }

            // Add functions to DOM if they aren't already there
            ExternalInterface.call(FUNCTION_GET_COOKIE);
            ExternalInterface.call(FUNCTION_SET_COOKIE);

            Cookie._initialized = true;
        }

        /**
         * Creates a new Cookie object. If a cookie with the specified
         * name already exists, the existing value is used. Otherwise
         * a new cookie is created as soon as a value is assigned to it.
         *
         * @param name The name of the cookie
         */
        public function Cookie(name:String) {
            Cookie.initialize();

            this._name = name;
            this._value = ExternalInterface.call(GET_COOKIE, name) as String;

            this._isNew = this._value == null;
        }

        /**
         * The name of the cookie.
         */
        public function get name():String {
            return this._name;
        }

        /**
         * The value of the cookie. If it is a new cookie, it is not
         * made persistent until a value is assigned to it.
         */
        public function get value():String {
            return this._value;
        }

        /**
         * @private
         */
        public function set value(value:String):void {
            this._value = value;

            ExternalInterface.call(SET_COOKIE, this._name, this._value);
        }

        /**
         * The <code>isNew</code> property indicates if the cookie
         * already exists or not.
         */
        public function get isNew():Boolean {
            return this._isNew;
        }
    }

}