package com.neosavvy.user.service {
import com.neosavvy.user.dto.UserDTO;

import com.neosavvy.user.registration.event.RegistrationFailedEvent;

import flash.events.Event;

import mx.collections.ArrayCollection;
import mx.core.Application;
import mx.messaging.ChannelSet;
import mx.messaging.channels.AMFChannel;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.rpc.remoting.RemoteObject;

public class UserService {

        public function addUser( user:UserDTO ):void {
            var userService:RemoteObject = new RemoteObject();

            var channel:AMFChannel = new AMFChannel("user-amf", "http://localhost:8080/commons-user-webapp/messagebroker/amf");
            var channelSet:ChannelSet = new ChannelSet();
            channelSet.addChannel(channel);
            userService.channelSet = channelSet;


            userService.destination = "userService";
            userService.addEventListener(FaultEvent.FAULT, savefaultHandler);
            userService.addEventListener(ResultEvent.RESULT, saveresultHandler);
            userService.saveUser( user );
        }

        private function savefaultHandler(faultEvent:FaultEvent):void {
            trace("faultEvent: " + faultEvent.message);
            trace("faultEvent: " + faultEvent.fault.toString());
            var event:RegistrationFailedEvent = new RegistrationFailedEvent(faultEvent.message.toString(), faultEvent.fault.toString());
//            dispatchEvent( event );
        }

        private function saveresultHandler(resultEvent:ResultEvent):void {
//            dispatchEvent( new Event("userConfirmed",true));
        }

        public function deleteHandler( user:UserDTO ):void {
            userService = new RemoteObject();

            var channel:AMFChannel = new AMFChannel("user-amf", "http://localhost:8080/commons-user-webapp/messagebroker/amf");
            var channelSet:ChannelSet = new ChannelSet();
            channelSet.addChannel(channel);
            userService.channelSet = channelSet;


            userService.destination = "userService";
            userService.addEventListener(FaultEvent.FAULT, deletefaultHandler);
            userService.addEventListener(ResultEvent.RESULT, deleteresultHandler);
            userService.deleteUser( user );

        }

        protected function deletefaultHandler( faultEvent:FaultEvent ):void {
				trace("faultEvent: " + faultEvent.message );
				trace("faultEvent: " + faultEvent.fault.toString() );
			}

        protected function deleteresultHandler( resultEvent:ResultEvent ):void {
				var data:Array = resultEvent.result as Array;
				main(Application.application).mainView.initializeService();
        }

        protected var userService:RemoteObject;


    public function getUsers():void {
        userService = new RemoteObject();

        var channel:AMFChannel = new AMFChannel("user-amf", "http://localhost:8080/commons-user-webapp/messagebroker/amf");
        var channelSet:ChannelSet = new ChannelSet();
        channelSet.addChannel(channel);
        userService.channelSet = channelSet;


        userService.destination = "userService";
        userService.addEventListener(FaultEvent.FAULT, faultHandler);
        userService.addEventListener(ResultEvent.RESULT, resultHandler);
        userService.getUsers();
    }

    private function faultHandler(faultEvent:FaultEvent):void {
        trace("faultEvent: " + faultEvent.message);
        trace("faultEvent: " + faultEvent.fault.toString());
    }

    private function resultHandler(resultEvent:ResultEvent):void {
        var data:ArrayCollection = resultEvent.result as ArrayCollection;
        //grid.dataProvider = data;
    }
}
}