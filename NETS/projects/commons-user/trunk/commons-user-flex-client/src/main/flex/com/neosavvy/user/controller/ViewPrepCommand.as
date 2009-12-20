package com.neosavvy.user.controller {
    import com.neosavvy.user.ApplicationMediator;

    import com.neosavvy.user.view.companyManagement.CompanyManagementMediator;
    import com.neosavvy.user.view.secured.employeeInvitation.EmployeeManagementMediator;
    import com.neosavvy.user.view.login.RegistrationAndLoginWindowMediator;

    import com.neosavvy.user.view.security.LoginMediator;
    import com.neosavvy.user.view.secured.userManagement.UserManagementMediator;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class ViewPrepCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {
            var application:CommonsUser = notification.getBody() as CommonsUser;
            facade.registerMediator( new ApplicationMediator(application) );

            //facade.registerMediator( new RegistrationAndLoginWindowMediator() );
//            facade.registerMediator( new UserManagementMediator( application.userManagement ) );
            facade.registerMediator( new CompanyManagementMediator( application.companyManagement ) );
            facade.registerMediator( new LoginMediator( application.login ) );
        }
    }
}