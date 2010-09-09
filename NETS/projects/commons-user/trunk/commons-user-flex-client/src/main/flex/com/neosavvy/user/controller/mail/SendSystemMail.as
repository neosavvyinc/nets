package com.neosavvy.user.controller.mail {
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;

    import com.neosavvy.user.dto.mail.MailMessageDTO;
    import com.neosavvy.user.model.MailServiceProxy;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class SendSystemMail extends ResponderAsyncCommand {

        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.controller.mail.SendSystemMail");

        public static const PARAM_FROM:String = "from";
        public static const PARAM_SUBJECT:String = "subject";
        public static const PARAM_MESSAGE:String = "message";


        public static function buildParameterObject(
                from : String
                ,message : String
                ,subject : String
                ):Object
        {
            var parameterObject : Object = new Object();
            parameterObject[PARAM_FROM] = from;
            parameterObject[PARAM_MESSAGE] = message;
            parameterObject[PARAM_SUBJECT] = subject;
            return parameterObject;
        }



        override public function execute(notification:INotification):void {
            super.execute(notification);

            var mailProxy:MailServiceProxy = facade.retrieveProxy(MailServiceProxy.NAME) as MailServiceProxy;
            var mailMessage : MailMessageDTO = new MailMessageDTO();
            if( notification.getBody() )
            {
                var noteObject : Object = notification.getBody();
                if( noteObject.hasOwnProperty(PARAM_FROM) )
                {
                    mailMessage.from = noteObject[PARAM_FROM] as String;
                }

                if( noteObject.hasOwnProperty(PARAM_SUBJECT) )
                {
                    mailMessage.subject = noteObject[PARAM_SUBJECT] as String;
                }

                if( noteObject.hasOwnProperty(PARAM_MESSAGE) )
                {
                    mailMessage.message = noteObject[PARAM_MESSAGE] as String;
                }
            }
            mailProxy.sendMailMessage( mailMessage, this );
        }


        override protected function resultHandler(resultEvent:ResultEvent):void {
            LOGGER.debug("Mail sending was successful");

        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            LOGGER.debug("Sending mail failed");

        }
    }
}