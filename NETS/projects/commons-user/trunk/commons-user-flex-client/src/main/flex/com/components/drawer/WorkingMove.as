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
 * Date: 2/9/11
 * Time: 12:10 AM
 */
package com.components.drawer {
    import flash.display.DisplayObject;

    public class WorkingMove extends AbstractWorkingEffect {
        private var _xFrom :Number;
        private var _xTo:Number;
        private var _yFrom:Number;
        private var _yTo:Number;
        public function WorkingMove(
                target : DisplayObject
                ,xFrom : Number, xTo : Number
                ,yFrom : Number, yTo : Number
                ,duration : int
                ,easingFunction : Function = null
                ,interval : int = 25
                )
        {
            super( target, 0, 1, duration, easingFunction, interval );

            _xFrom = xFrom;
            _xTo = xTo;
            _yFrom = yFrom;
            _yTo = yTo;
        }


        public function get xFrom():Number {
            return _xFrom;
        }

        public function get xTo():Number {
            return _xTo;
        }

        public function get yFrom():Number {
            return _yFrom;
        }

        public function get yTo():Number {
            return _yTo;
        }

        override protected function performUpdate( value : Number ) : void
        {
            if( !isNaN( xFrom )  && !isNaN( xTo ) )
            {
                target.x = interpolateValue( xFrom, xTo, value );
            }
            if( !isNaN( yFrom) && !isNaN( yTo ) )
            {
                target.y = interpolateValue( yFrom, yTo, value );
            }
        }
    }
}
