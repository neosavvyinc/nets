package com.neosavvy.commons.user.flexmonkey.tests.Test Company Registration{
    import com.gorillalogic.flexmonkey.flexunit.tests.MonkeyFlexUnitTestSuite;

    import com.neosavvy.commons.user.flexmonkey.tests.Test Company Registration.tests.Register Company;
    import com.neosavvy.commons.user.flexmonkey.tests.Test Company Registration.tests.Login and Invite User;

    public class Test Company Registration extends MonkeyFlexUnitTestSuite{
        public function Test Company Registration(){
            addTestCase(new Register Company());
            addTestCase(new Login and Invite User());
        }
    }
}