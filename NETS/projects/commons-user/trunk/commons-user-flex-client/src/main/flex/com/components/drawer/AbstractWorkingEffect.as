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
 * Time: 12:28 AM
 */
package com.components.drawer {
    import flash.display.DisplayObject;

    import mx.events.TweenEvent;

    public class AbstractWorkingEffect extends WorkingTween {
        private var _target:DisplayObject;
        public function AbstractWorkingEffect(
            target : DisplayObject
            ,startValue : Number
            ,endValue : Number
            ,duration : int
            ,easingFunction : Function = null
            ,interval : int = 25
            ,startDelay : int = 0
        )
        {
            super( startValue, endValue, duration, easingFunction, interval, startDelay);

            _target = target;

            addEventListener( TweenEvent.TWEEN_UPDATE, onTweenUpdate );
            addEventListener( TweenEvent.TWEEN_END, onTweenEnd );
        }


        public function get target():DisplayObject {
            return _target;
        }

        protected function interpolateValue(
                startValue : Number
                ,endValue : Number
                ,fraction : Number
                ) : Number
        {
            return startValue + ( ( endValue - startValue ) * fraction );
        }

        protected function performUpdate( value : Number ) : void
        {
            //override due to abstraction
        }

        override public function stop():void
        {
            super.stop();

            cleanUp();
        }

        private function cleanUp():void
        {
            removeEventListener( TweenEvent.TWEEN_UPDATE, onTweenUpdate );
            removeEventListener( TweenEvent.TWEEN_END, onTweenEnd );
        }

        private function onTweenUpdate( event : TweenEvent ) : void
        {
            performUpdate( Number( event.value ) );
        }

        private function onTweenEnd( event : TweenEvent ) : void
        {
            cleanUp();
        }

    }
}
