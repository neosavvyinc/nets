package com.neosavvy.user.controller {
    import com.neosavvy.user.model.SecurityProxy;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class ModelPrepCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {
            facade.registerProxy( new SecurityProxy() );
        }
    }
}