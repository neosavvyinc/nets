package com.neosavvy.user.controller {
    import com.neosavvy.user.ApplicationMediator;

    import org.puremvc.as3.multicore.interfaces.ICommand;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class CommonsUserStartupCommand extends SimpleCommand implements ICommand {

        override public function execute(note:INotification):void
        {
            var app:CommonsUser = note.getBody() as CommonsUser;
            facade.registerMediator(new ApplicationMediator(app));
        }
    }
}