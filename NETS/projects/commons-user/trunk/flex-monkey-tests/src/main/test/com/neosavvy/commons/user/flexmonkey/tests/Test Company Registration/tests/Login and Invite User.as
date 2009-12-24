package com.neosavvy.commons.user.flexmonkey.tests.Test Company Registration.tests{
    import com.gorillalogic.flexmonkey.flexunit.tests.MonkeyFlexUnitTestCase;

    import com.gorillalogic.flexmonkey.core.MonkeyTest;
    import com.gorillalogic.flexmonkey.monkeyCommands.*;
    import com.gorillalogic.flexmonkey.application.VOs.AttributeVO;
    import com.gorillalogic.flexmonkey.events.MonkeyCommandRunnerEvent;

    import mx.collections.ArrayCollection;

    public class Login and Invite User extends MonkeyFlexUnitTestCase{
        public function Login and Invite User(){
            super();
        }

        private var mtInvite User:MonkeyTest = new MonkeyTest('Invite User', 500,
            new ArrayCollection([
                new UIEventMonkeyCommand('Click', 'Login', 'automationName', ['0']),
                new UIEventMonkeyCommand('SelectText', 'username', 'automationName', ['0', '0']),
                new UIEventMonkeyCommand('Input', 'username', 'automationName', ['neosavvy']),
                new UIEventMonkeyCommand('ChangeFocus', 'username', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'password', 'automationName', ['test']),
                new UIEventMonkeyCommand('Click', 'Login', 'automationName', ['0']),
                new UIEventMonkeyCommand('Click', 'Invite Employees', 'automationName', ['0']),
                new UIEventMonkeyCommand('SelectText', 'empFName', 'automationName', ['0', '0']),
                new UIEventMonkeyCommand('SelectText', 'empFName', 'automationName', ['0', '0']),
                new UIEventMonkeyCommand('Input', 'empFName', 'automationName', ['Adam']),
                new UIEventMonkeyCommand('ChangeFocus', 'empFName', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'empLName', 'automationName', ['Parrish']),
                new UIEventMonkeyCommand('ChangeFocus', 'empLName', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'empEmail', 'automationName', ['aparrish@neosavvy.com']),
                new UIEventMonkeyCommand('Click', 'Add User', 'automationName', ['0']),
                new UIEventMonkeyCommand('Click', 'Done', 'automationName', ['0']),
                new UIEventMonkeyCommand('SelectText', 'empFName', 'automationName', ['4', '4']),
                new UIEventMonkeyCommand('SelectText', 'empFName', 'automationName', ['4', '4']),
                new UIEventMonkeyCommand('SelectText', 'empFName', 'automationName', ['0', '4']),
                new UIEventMonkeyCommand('SelectText', 'empFName', 'automationName', ['0', '4']),
                new UIEventMonkeyCommand('Input', 'empFName', 'automationName', ['Dana']),
                new UIEventMonkeyCommand('ChangeFocus', 'empFName', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'empLName', 'automationName', ['Hamlett']),
                new UIEventMonkeyCommand('ChangeFocus', 'empLName', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'empEmail', 'automationName', ['dana@neosavvyc']),
                new UIEventMonkeyCommand('Type', 'empEmail', 'automationName', ['BACKSPACE', '0']),
                new UIEventMonkeyCommand('Input', 'empEmail', 'automationName', ['.com']),
                new UIEventMonkeyCommand('Click', 'Add User', 'automationName', ['0']),
                new UIEventMonkeyCommand('Click', 'Done', 'automationName', ['0']),
                new UIEventMonkeyCommand('Click', 'Logout', 'automationName', ['0']),
                new UIEventMonkeyCommand('Click', 'Login', 'automationName', ['0']),
                new UIEventMonkeyCommand('Click', 'Invite Employees', 'automationName', ['0'])
            ]));

        private var mtInvite UserTimeoutTime:int = 53000;

        [Test]
        public function Invite User():void{
            // startTest(<MonkeyTest>, <Complete method>, <Async timeout value>, <Timeout method>);
            startTest(mtInvite User, mtInvite UserComplete, mtInvite UserTimeoutTime, defaultTimeoutHandler);
        }

        public function mtInvite UserComplete(event:MonkeyCommandRunnerEvent, passThroughData:Object):void{
            checkCommandResults(mtInvite User);
        }


    }
}