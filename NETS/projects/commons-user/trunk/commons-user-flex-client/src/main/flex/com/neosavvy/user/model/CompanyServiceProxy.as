package com.neosavvy.user.model {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.CompanyDTO;
    import com.neosavvy.user.dto.CompanyDTO;
    import com.neosavvy.user.dto.CompanyDTO;

    import com.neosavvy.user.dto.UserCompanyRoleDTO;
    import com.neosavvy.user.dto.UserDTO;
    import com.neosavvy.user.dto.UserDTO;

    import com.neosavvy.user.dto.UserInviteDTO;
    import com.neosavvy.user.model.UserServiceProxy;

    import mx.collections.ArrayCollection;
    import mx.collections.ListCollectionView;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import mx.messaging.AbstractProducer;
    import mx.messaging.ChannelSet;
    import mx.messaging.channels.AMFChannel;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.mxml.RemoteObject;

    import org.puremvc.as3.multicore.patterns.proxy.Proxy;

    public class CompanyServiceProxy extends Proxy {
        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.model.CompanyServiceProxy");

        public static var NAME:String = "companyProxy";

        private var remote:Boolean = ProxyConstants.isRemoteEnabled;

        public function CompanyServiceProxy()
        {
            super(NAME, null);
        }

        /***
         * This variable should maintain the reference to the
         * active and working company.
         *
         * When a user logs in this variable should be set based on
         * what company they are associated with
         */
        public function get activeCompany():CompanyDTO{
            if( !data ) {
                //check the UserServiceProxy just in case it has an activeCompany
                var userService:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy
                var activeUser:UserDTO = userService.activeUser;
                if( activeUser ) {
                    var userCompanyRoles:ListCollectionView = activeUser.userCompanyRoles;
                    if( userCompanyRoles && userCompanyRoles.length > 0 ) {
                        var userCompanyRole:UserCompanyRoleDTO = userCompanyRoles.getItemAt(0) as UserCompanyRoleDTO;
                        var company:CompanyDTO = userCompanyRole.company;
                        data = company;
                    }
                }
            }


            return data as CompanyDTO;
        }

        private var _invitedUsersForActiveCompany:ArrayCollection = new ArrayCollection();


        public function get invitedUsersForActiveCompany():ArrayCollection {
            return _invitedUsersForActiveCompany;
        }

        public function set invitedUsersForActiveCompany(value:ArrayCollection):void {
            _invitedUsersForActiveCompany = value;
        }

        public function addCompany(company:CompanyDTO, user:UserDTO):void
        {
            var companyService:RemoteObject = getCompanyService();
            companyService.addEventListener(ResultEvent.RESULT, handleSaveCompanyResult);
            companyService.addEventListener(FaultEvent.FAULT, handleSaveCompanyFault);
            companyService.addCompany( company, user );
        }

        private function handleSaveCompanyFault(event:FaultEvent):void {
            LOGGER.debug("Save Company failed: " + event.toString());
            sendNotification(ApplicationFacade.SAVE_COMPANY_FAILED);
        }

        private function handleSaveCompanyResult(event:ResultEvent):void {
            LOGGER.debug("Company was returned");
            this.data = event.result as ArrayCollection;
            sendNotification(ApplicationFacade.SAVE_COMPANY_SUCCESS);
        }

        public function addEmployeeToCompany( user:UserDTO ):void
        {
            var companyService:RemoteObject = getCompanyService();
            companyService.addEventListener(ResultEvent.RESULT, handleSaveEmployeeToCompanyResult);
            companyService.addEventListener(FaultEvent.FAULT, handleSaveEmployeeToCompanyFault);
            companyService.addEmployeeToCompany( user );
        }

        private function handleSaveEmployeeToCompanyFault(event:FaultEvent):void {
        }

        private function handleSaveEmployeeToCompanyResult(event:ResultEvent):void {
        }

        public function inviteUsers( userInvite:UserInviteDTO ):void {
            var companyService:RemoteObject = getCompanyService();
            companyService.addEventListener(ResultEvent.RESULT, handleInviteUsersResult);
            companyService.addEventListener(FaultEvent.FAULT, handleInviteUsersFault);
            companyService.inviteUsers( activeCompany, userInvite );
        }

        private function handleInviteUsersFault(event:FaultEvent):void {
            LOGGER.debug("User invites failed!");
            LOGGER.error(event.toString());
            sendNotification(ApplicationFacade.INVITE_USER_TO_COMPANY_FAILED);
        }

        private function handleInviteUsersResult(event:ResultEvent):void {
            LOGGER.debug("User invites successful");
            sendNotification(ApplicationFacade.INVITE_USER_TO_COMPANY_SUCCESS);
        }

        public function getInvitedUsers():void {
            var companyService:RemoteObject = getCompanyService();
            companyService.addEventListener(ResultEvent.RESULT, handleGetInvitedUsersResult);
            companyService.addEventListener(FaultEvent.FAULT, handleGetInvitedUsersFault);
            companyService.getInvitedUsers( activeCompany );
        }

        private function handleGetInvitedUsersFault(event:FaultEvent):void {
            LOGGER.debug("Get Invited Users Failed");

            sendNotification(ApplicationFacade.GET_INVITED_USERS_FAILED);
        }

        private function handleGetInvitedUsersResult(event:ResultEvent):void {
            LOGGER.debug("Get Invited Users Success");

            if(event.result != null)
                _invitedUsersForActiveCompany = event.result as ArrayCollection;
            else
                _invitedUsersForActiveCompany = new ArrayCollection();

            sendNotification(ApplicationFacade.GET_INVITED_USERS_SUCCESS);
        }

        public function deleteUserCompanyInvite(userInvite:UserInviteDTO):void {
            var companyService:RemoteObject = getCompanyService();
            companyService.addEventListener(ResultEvent.RESULT, handleDeleteInvitedUserResult);
            companyService.addEventListener(FaultEvent.FAULT, handleDeleteInvitedUserFault);
            companyService.deleteInvitedUser( activeCompany, userInvite );
        }

        private function handleDeleteInvitedUserFault(event:FaultEvent):void {
            LOGGER.debug("User Invite Delete Failed for: " + event.toString());
            sendNotification(ApplicationFacade.DELETE_USER_COMPANY_INVITE_FAILED);
        }

        private function handleDeleteInvitedUserResult(event:ResultEvent):void {
            LOGGER.debug("User Invite Delete Succeeded");
            sendNotification(ApplicationFacade.DELETE_USER_COMPANY_INVITE_SUCCESS);
        }

        public function sendInvite( userInvite:UserInviteDTO ):void {
            var companyService:RemoteObject = getCompanyService();
            companyService.addEventListener(ResultEvent.RESULT, handleSendInviteResult);
            companyService.addEventListener(FaultEvent.FAULT, handleSendInviteFault);
            companyService.sendInvite( userInvite );
        }

        private function handleSendInviteFault(event:FaultEvent):void {
            LOGGER.debug("User invite failed" + event.toString());
            sendNotification(ApplicationFacade.SEND_USER_INVITE_FAILED);
        }

        private function handleSendInviteResult(event:ResultEvent):void {
            LOGGER.debug("User invite success");
            sendNotification(ApplicationFacade.SEND_USER_INVITE_SUCCESS);
        }

        /****
         *
         * Helper functions
         *
         ****/
        private function getCompanyServiceChannelSet():ChannelSet {
            var channel:AMFChannel = new AMFChannel(ProxyConstants.channelName, ProxyConstants.url);
            var channelSet:ChannelSet = new ChannelSet();
            channelSet.addChannel(channel);
            return channelSet;
        }

        private function getCompanyService():RemoteObject {
            var userService:RemoteObject = new RemoteObject();
            userService.channelSet = getCompanyServiceChannelSet();
            userService.destination = ProxyConstants.companyServiceDestiation;
            return userService;
        }


        }
}