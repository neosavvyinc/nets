package com.neosavvy.user.controller {
    import com.neosavvy.user.model.ClientServiceProxy;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.SecurityProxy;

    import com.neosavvy.user.model.UserServiceProxy;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class ModelPrepCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {
            facade.registerProxy( new SecurityProxy() );
            facade.registerProxy( new UserServiceProxy() );
            facade.registerProxy( new CompanyServiceProxy() );
            facade.registerProxy( new ClientServiceProxy() );
        }
    }
}