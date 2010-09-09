package com.neosavvy.user.model {
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.mail.MailMessageDTO;
    import com.neosavvy.user.dto.project.ClientCompany;
    import com.neosavvy.user.dto.project.ClientUserContact;

    import mx.collections.ArrayCollection;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.remoting.mxml.RemoteObject;

    public class MailServiceProxy extends AbstractRemoteObjectProxy {
        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.model.MailServiceProxy");

        public static var NAME:String = "mailProxy";

        public function MailServiceProxy()
        {
            super(NAME, null, ProxyConstants.expenseContextRoot);
        }

        public function sendMailMessage(mailMessage:MailMessageDTO, responder:IResponder):void
        {
            var mailService:RemoteObject = getService(ProxyConstants.mailServiceDestiation);
            addCallbackHandler(mailService, responder);
            mailService.sendSystemMail( mailMessage );
        }
    }
}
