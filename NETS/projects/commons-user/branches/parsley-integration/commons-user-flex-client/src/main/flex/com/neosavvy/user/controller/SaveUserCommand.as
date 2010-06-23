package com.neosavvy.user.controller {
    import com.neosavvy.user.event.UserEvent;
    import com.neosavvy.user.model.UserModel;

    import mx.rpc.AsyncToken;
    import mx.rpc.Fault;
    import mx.rpc.remoting.RemoteObject;

    public class SaveUserCommand {

        [Inject]
        public var userService:RemoteObject;

        [Inject]
        public var userModel:UserModel;

        public function execute (event:UserEvent) : AsyncToken {
            trace("Handling AddUserCommand.execute()");
            return userService.saveUser( event.user );
        }

        public function result (object:Object) : void {
            trace("Handling AddUserCommand.result()");
        }

        public function error (fault:Fault) : void {
            trace("Handling AddUserCommand.error()");
            trace("Fault: " + fault.toString());
        }
    }
}