package com.neosavvy.user.model {
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.companyManagement.CompanyDTO;
    import com.neosavvy.user.dto.companyManagement.UserCompanyRoleDTO;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.dto.companyManagement.UserInviteDTO;

    import flash.errors.IllegalOperationError;

    import mx.collections.ArrayCollection;
    import mx.collections.ListCollectionView;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.remoting.mxml.RemoteObject;

    public class CompanyServiceProxy extends AbstractRemoteObjectProxy {
        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.model.CompanyServiceProxy");

        public static var NAME:String = "companyProxy";

        public function CompanyServiceProxy()
        {
            super(NAME, null, ProxyConstants.expenseContextRoot);
        }

        /***
         * This variable should maintain the reference to the
         * active and working company.
         *
         * When a user logs in this variable should be set based on
         * what company they are associated with
         */
        public function get activeCompany():CompanyDTO {
            if (!data) {
                //check the UserServiceProxy just in case it has an activeCompany
                var userService:UserServiceProxy = facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy
                var activeUser:UserDTO = userService.activeUser;
                if (activeUser) {
                    var userCompanyRoles:ListCollectionView = activeUser.userCompanyRoles;
                    if (userCompanyRoles && userCompanyRoles.length > 0) {
                        var userCompanyRole:UserCompanyRoleDTO = userCompanyRoles.getItemAt(0) as UserCompanyRoleDTO;
                        var company:CompanyDTO = userCompanyRole.company;
                        data = company;
                    } else {
                        LOGGER.debug("Could not determine your active company");
                    }
                } else {
                    LOGGER.debug("Could not determine your active user");
                }
            }


            return data as CompanyDTO;
        }

        override public function clearCachedValues():void {
            data = null;
            _inactiveUsersForCompany = new ArrayCollection();
            _allUsersForCompany = new ArrayCollection();
            _activeUsersForCompany = new ArrayCollection();
            _invitedUsersForActiveCompany = new ArrayCollection();
        }

        private var _invitedUsersForActiveCompany:ArrayCollection = new ArrayCollection();

        private var _allUsersForCompany:ArrayCollection = new ArrayCollection();

        private var _activeUsersForCompany:ArrayCollection = new ArrayCollection();

        private var _inactiveUsersForCompany:ArrayCollection = new ArrayCollection();

        public function get invitedUsersForActiveCompany():ArrayCollection {
            return _invitedUsersForActiveCompany;
        }

        public function get allUsersForCompany():ArrayCollection {
            return _allUsersForCompany;
        }

        public function get activeUsersForCompany():ArrayCollection {
            return _activeUsersForCompany;
        }

        public function get inactiveUsersForCompany():ArrayCollection {
            return _inactiveUsersForCompany;
        }

        public function set invitedUsersForActiveCompany(value:ArrayCollection):void {
            _invitedUsersForActiveCompany = value;
        }

        public function set allUsersForCompany(value:ArrayCollection):void {
            _allUsersForCompany = value;
        }

        public function set activeUsersForCompany(value:ArrayCollection):void {
            _activeUsersForCompany = value;
        }

        public function set inactiveUsersForCompany(value:ArrayCollection):void {
            _inactiveUsersForCompany = value;
        }

        public function addCompany(company:CompanyDTO, user:UserDTO, responder:IResponder):void
        {
            var companyService:RemoteObject = getService(ProxyConstants.companyServiceDestiation);
            addCallbackHandler(companyService, responder);
            companyService.addCompany(company, user);
        }

        public function addEmployeeToCompany(user:UserDTO, responder:IResponder):void
        {
            var companyService:RemoteObject = getService(ProxyConstants.companyServiceDestiation);
            addCallbackHandler(companyService, responder);
            companyService.addEmployeeToCompany(user);
        }

        public function inviteUsers(userInvite:UserInviteDTO, responder:IResponder):void {
            var companyService:RemoteObject = getService(ProxyConstants.companyServiceDestiation);
            addCallbackHandler(companyService, responder);
            companyService.inviteUsers(activeCompany, userInvite);
        }

        public function getInvitedUsers(responder:IResponder):void {
            var companyService:RemoteObject = getService(ProxyConstants.companyServiceDestiation);
            addCallbackHandler(companyService, responder);
            companyService.getInvitedUsers(activeCompany);
        }

        public function deleteUserCompanyInvite(userInvite:UserInviteDTO, responder:IResponder):void {
            var companyService:RemoteObject = getService(ProxyConstants.companyServiceDestiation);
            addCallbackHandler(companyService, responder);
            companyService.deleteInvitedUser(activeCompany, userInvite);
        }

        public function sendInvite(userInvite:UserInviteDTO, responder:IResponder):void {
            var companyService:RemoteObject = getService(ProxyConstants.companyServiceDestiation);
            addCallbackHandler(companyService, responder);
            companyService.sendInvite(userInvite);
        }

        public function findUsersForCompany(company:CompanyDTO, responder:IResponder):void {
            var companyService:RemoteObject = getService(ProxyConstants.companyServiceDestiation);
            addCallbackHandler(companyService, responder);
            companyService.findUsersForCompany(activeCompany);
        }

        public function findActiveUsersForCompany(responder:IResponder):void {
            var companyService:RemoteObject = getService(ProxyConstants.companyServiceDestiation);
            addCallbackHandler(companyService, responder);
            companyService.findActiveUsersForCompany(activeCompany);
        }

        public function findInactiveUsersForCompany(company:CompanyDTO, responder:IResponder):void {
            var companyService:RemoteObject = getService(ProxyConstants.companyServiceDestiation);
            addCallbackHandler(companyService, responder);
            companyService.findInactiveUsersForCompany(activeCompany);
        }

    }
}
