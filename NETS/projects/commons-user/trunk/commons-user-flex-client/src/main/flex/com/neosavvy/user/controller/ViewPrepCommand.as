package com.neosavvy.user.controller {
    import com.neosavvy.user.ApplicationMediator;
    import com.neosavvy.user.view.secured.progress.ProgressBarMediator;
    import com.neosavvy.user.view.security.LoginMediator;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class ViewPrepCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {
            var application:NETS = notification.getBody() as NETS;
            facade.registerMediator(new ApplicationMediator(application));
            facade.registerMediator(new ProgressBarMediator(null));
//            facade.registerMediator(new SignupMediator(application.signupContent));
            facade.registerMediator(new LoginMediator(application.login));
//            facade.registerMediator(new ConfirmUserRegistrationMediator(application.signupContent.confirmUserRegistration));
        }
    }
}