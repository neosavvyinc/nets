package com.neosavvy.user.controller {
import com.neosavvy.user.event.UserEvent;

import com.neosavvy.user.model.UserModel;

import mx.collections.ArrayCollection;
import mx.rpc.AsyncToken;
import mx.rpc.Fault;
import mx.rpc.remoting.RemoteObject;

public class GetUsersCommand {

        [Inject]
        public var userService:RemoteObject;

        [Inject]
        public var userModel:UserModel;

        public function execute (event:UserEvent) : AsyncToken {
            trace("Handling GetUsersCommand.execute()");
            return userService.getUsers();
        }

        public function result (users:ArrayCollection) : void {
            trace("Handling GetUsersCommand.result()");
            userModel.users = users;
        }

        public function error (fault:Fault) : void {
            trace("Handling GetUsersCommand.error()");
            trace("Fault: " + fault.toString());
        }


    }
}