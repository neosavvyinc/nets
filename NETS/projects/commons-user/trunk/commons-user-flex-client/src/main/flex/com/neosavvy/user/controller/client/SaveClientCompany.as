package com.neosavvy.user.controller.client {
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.project.ClientCompany;
    import com.neosavvy.user.dto.project.ClientUserContact;
    import com.neosavvy.user.model.ClientServiceProxy;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.CompanyServiceProxy;

    import flash.errors.IllegalOperationError;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class SaveClientCompany extends SimpleCommand {

        override public function execute(notification:INotification):void {
            var clientProxy:ClientServiceProxy = facade.retrieveProxy(ClientServiceProxy.NAME) as ClientServiceProxy;

            if(notification.getBody() is Array && (notification.getBody() as Array).length == 2) {

                var clientCompany:ClientCompany = notification.getBody()[0];
                var clientUserContact:ClientUserContact = notification.getBody()[1];

                clientProxy.saveClientCompany(clientCompany, clientUserContact);
            } else {
                throw new IllegalOperationError("Parameters passed to SaveClientCompany were incorrect");
            }
        }
    }
}