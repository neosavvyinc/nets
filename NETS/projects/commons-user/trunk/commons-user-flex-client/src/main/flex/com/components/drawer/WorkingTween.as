/*************************************************************************
 *
 * NEOSAVVY CONFIDENTIAL
 * __________________
 *
 *  Copyright 2008 - 2009 Neosavvy Incorporated
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Neosavvy Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Neosavvy Incorporated
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Neosavvy Incorporated.
 **************************************************************************/

/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 3/3/11
 * Time: 12:15 AM
 */
package com.components.drawer {
    import flash.events.EventDispatcher;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import flash.utils.getTimer;

    import mx.effects.easing.Quartic;
    import mx.events.TweenEvent;


    [Event( name="tweenEnd", type="mx.events.TweenEvent")]
    [Event( name="tweenStart", type="mx.events.TweenEvent")]
    [Event( name="tweenUpdate", type="mx.events.TweenEvent")]

    public class WorkingTween extends EventDispatcher {

        private var _startValue:Number;
        private var _endValue:Number;
        private var _duration:int;
        private var _easingFunction:Function;
        private var _interval:Number;
        private var _startDelay:int;

        private var timerStart : int;
        private var timer : Timer;
        private var tweenEnded : Boolean;

        public function WorkingTween(
                startValue : Number
                ,endValue : Number
                ,duration : int
                ,easingFunction : Function = null
                ,interval : int = 25
                ,startDelay : int = 0
                )
        {
            if( !easingFunction )
            {
                easingFunction = mx.effects.easing.Exponential.easeOut;
            }

            _startValue = startValue;
            _endValue = endValue;
            _duration = duration;
            _easingFunction = easingFunction;
            _interval = interval;
            _startDelay = startDelay;
        }


        public function get startValue():Number {
            return _startValue;
        }

        public function get endValue():Number {
            return _endValue;
        }

        public function get duration():int {
            return _duration;
        }

        public function get easingFunction():Function {
            return _easingFunction;
        }

        public function get interval():Number {
            return _interval;
        }

        public function get startDelay():int {
            return _startDelay;
        }

        public function get timeElapsed() : int
        {
            var elapsed : int = getTimer() - timerStart - startDelay;

            if( elapsed > duration )
            {
                elapsed = duration;
            }

            return elapsed;
        }

        public function hasEnded() : Boolean
        {
            return getTimer() >= timerStart + duration + startDelay;
        }

        public function hasStarted() : Boolean
        {
            return getTimer() >= timerStart + startDelay;
        }

        private function get totalChange() : Number
        {
            return endValue - startValue;
        }

        public function play() : void
        {
            timerStart = getTimer();

            timer = new Timer( interval );
            timer.addEventListener( TimerEvent.TIMER, onTimer );
            timer.start();

            dispatchTweenEvent( TweenEvent.TWEEN_START, startValue );
        }

        public function stop() : void
        {
            var calculatedValue : Number = updateTween();

            if( !hasEnded )
            {
                endTween( calculatedValue );
            }
        }

        public function updateTween() : Number
        {
            if( !hasStarted ) return startValue;

            var calculatedValue : Number = calculateValue();

            dispatchTweenEvent( TweenEvent.TWEEN_UPDATE, calculatedValue );

            if( hasEnded )
            {
                endTween( calculatedValue );
            }

            return calculatedValue;
        }

        public function endTween( calculatedValue : Number ) : void
        {
            if( tweenEnded ) return;

            tweenEnded = true;

            dispatchTweenEvent( TweenEvent.TWEEN_END, calculatedValue );

            cleanUp();
        }

        private function calculateValue():Number
        {
            return easingFunction( timeElapsed, startValue, totalChange, duration );
        }

        private function cleanUp(): void
        {
            if( timer )
            {
                timer.stop();
                timer.removeEventListener( TimerEvent.TIMER, onTimer );
                timer = null;
            }
        }

        private function dispatchTweenEvent( type : String , value : Number ) : void
        {
            dispatchEvent( new TweenEvent( type, false, false, value ) );
        }

        private function onTimer( event : TimerEvent ) : void
        {
            updateTween();
        }
    }
}
