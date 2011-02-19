package com.neosavvy.user {
public class ProxyConstants {
    public static var isRemoteEnabled:Boolean = false;
    public static var url:String = LOCAL;

    public static var LOCAL:String = "http://localhost:8080/commons-user-webapp/messagebroker/amf";
    public static var TEST:String = "http://www.neosavvy.com:8080/commons-user-webapp/messagebroker/amf";
    public static var PROD:String = "http://localhost:8080/commons-user-webapp/messagebroker/amf";

}
}