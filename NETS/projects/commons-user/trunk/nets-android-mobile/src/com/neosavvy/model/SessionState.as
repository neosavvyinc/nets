package com.neosavvy.model
{
	import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
	import com.neosavvy.user.dto.companyManagement.UserDTO;

	public class SessionState
	{
		private var _user : UserDTO;
		private var _securityWrapper : SecurityWrapperDTO;
		
		
		public function get user():UserDTO
		{
			return _user;
		}

		public function set user(value:UserDTO):void
		{
			_user = value;
		}

		public function get securityWrapper():SecurityWrapperDTO
		{
			return _securityWrapper;
		}

		public function set securityWrapper(value:SecurityWrapperDTO):void
		{
			_securityWrapper = value;
		}
		
		

	}
}