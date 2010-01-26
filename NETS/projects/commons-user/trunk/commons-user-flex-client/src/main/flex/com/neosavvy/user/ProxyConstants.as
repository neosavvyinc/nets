package com.neosavvy.user {
    public class ProxyConstants {

        /**
         * Set this variable to true if not running within the context
         * of a WAR file such as locally to a remote service or from a
         * statically served HTTPServer directory
         */
        public static var isRemoteEnabled:Boolean = false;

        /**
         * Change this variable to point to an environment
         */
        public static var url:String = LOCAL_TOMCAT;

        /**
         * Potential URLs for runtime environments
         */
        public static var LOCAL_TOMCAT:String = "http://localhost:8080/commons-user-webapp/messagebroker/amf";
        public static var LOCAL_GLASSFISH:String = "http://localhost:8080/nets/expenseTracker/messagebroker/amf";
        public static var TEST:String = "http://www.neosavvy.com:8080/commons-user-webapp/messagebroker/amf";
        public static var PROD:String = "http://localhost:8080/commons-user-webapp/messagebroker/amf";


        /**
         * Channel name of back end services
         */
        public static const channelName:String = "user-amf";

        /**
         * Destination names for services
         */
        public static const userServiceDestination:String = "userService";
        public static const companyServiceDestiation:String = "companyService";
        public static const clientServiceDestiation:String = "clientService";
        public static const projectServiceDestiation:String = "projectService";

    }
}