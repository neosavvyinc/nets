package com.neosavvy.commons.user.flexmonkey.tests.Test Company Registration.tests{
    import com.gorillalogic.flexmonkey.flexunit.tests.MonkeyFlexUnitTestCase;

    import com.gorillalogic.flexmonkey.core.MonkeyTest;
    import com.gorillalogic.flexmonkey.monkeyCommands.*;
    import com.gorillalogic.flexmonkey.application.VOs.AttributeVO;
    import com.gorillalogic.flexmonkey.events.MonkeyCommandRunnerEvent;

    import mx.collections.ArrayCollection;

    public class Register Company extends MonkeyFlexUnitTestCase{
        public function Register Company(){
            super();
        }

        private var mtFill out Company form:MonkeyTest = new MonkeyTest('Fill out Company form', 500,
            new ArrayCollection([
                new UIEventMonkeyCommand('Click', 'New Company's Click Here', 'automationName', ['0']),
                new UIEventMonkeyCommand('SelectText', 'companyName', 'automationName', ['0', '0']),
                new UIEventMonkeyCommand('Input', 'companyName', 'automationName', ['Neosavvy, Inc']),
                new UIEventMonkeyCommand('ChangeFocus', 'companyName', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'addressOne', 'automationName', ['4500 Manor Village Way ']),
                new UIEventMonkeyCommand('ChangeFocus', 'addressOne', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'addressTwo', 'automationName', ['Apt 127']),
                new UIEventMonkeyCommand('ChangeFocus', 'addressTwo', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'city', 'automationName', ['Raleigh']),
                new UIEventMonkeyCommand('ChangeFocus', 'city', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Type', 'state', 'automationName', ['N', '0']),
                new UIEventMonkeyCommand('Type', 'state', 'automationName', ['N', '0']),
                new UIEventMonkeyCommand('Type', 'state', 'automationName', ['N', '0']),
                new UIEventMonkeyCommand('Type', 'state', 'automationName', ['N', '0']),
                new UIEventMonkeyCommand('Type', 'state', 'automationName', ['N', '0']),
                new UIEventMonkeyCommand('Type', 'state', 'automationName', ['N', '0']),
                new UIEventMonkeyCommand('Type', 'state', 'automationName', ['N', '0']),
                new UIEventMonkeyCommand('Type', 'state', 'automationName', ['TAB', '0']),
                new UIEventMonkeyCommand('ChangeFocus', 'state', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'postalCode', 'automationName', ['271']),
                new UIEventMonkeyCommand('Type', 'postalCode', 'automationName', ['BACKSPACE', '0']),
                new UIEventMonkeyCommand('Input', 'postalCode', 'automationName', ['612']),
                new UIEventMonkeyCommand('ChangeFocus', 'postalCode', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Type', 'country', 'automationName', ['TAB', '0']),
                new UIEventMonkeyCommand('ChangeFocus', 'country', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'administrativeUser', 'automationName', ['neosavvy']),
                new UIEventMonkeyCommand('ChangeFocus', 'administrativeUser', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'administrativeFirstName', 'automationName', ['William']),
                new UIEventMonkeyCommand('ChangeFocus', 'administrativeFirstName', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'administrativeMiddleName', 'automationName', ['Adam']),
                new UIEventMonkeyCommand('ChangeFocus', 'administrativeMiddleName', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'administrativeLastName', 'automationName', ['Parrish']),
                new UIEventMonkeyCommand('ChangeFocus', 'administrativeLastName', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'administrativeEmail', 'automationName', ['aparrish1@neosavvy.com']),
                new UIEventMonkeyCommand('ChangeFocus', 'administrativeEmail', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'administrativePassword', 'automationName', ['test']),
                new UIEventMonkeyCommand('ChangeFocus', 'administrativePassword', 'automationName', ['false', 'TAB']),
                new UIEventMonkeyCommand('Input', 'administrativeConfirmPassword', 'automationName', ['test']),
                new UIEventMonkeyCommand('Click', '1-10', 'automationName', ['0']),
                new UIEventMonkeyCommand('Click', 'Register Company', 'automationName', ['0'])
            ]));

        private var mtFill out Company formTimeoutTime:int = 65000;

        [Test]
        public function Fill out Company form():void{
            // startTest(<MonkeyTest>, <Complete method>, <Async timeout value>, <Timeout method>);
            startTest(mtFill out Company form, mtFill out Company formComplete, mtFill out Company formTimeoutTime, defaultTimeoutHandler);
        }

        public function mtFill out Company formComplete(event:MonkeyCommandRunnerEvent, passThroughData:Object):void{
            checkCommandResults(mtFill out Company form);
        }


    }
}