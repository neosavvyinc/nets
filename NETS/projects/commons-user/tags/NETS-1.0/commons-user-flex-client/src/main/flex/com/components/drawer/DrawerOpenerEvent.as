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
 * Time: 12:05 AM
 */
package com.components.drawer {
    import flash.events.Event;

    public class DrawerOpenerEvent extends Event {

        public static const OPENING : String = "opening";
        public static const OPENED : String = "opened";

        public static const CLOSED : String = "closed";
        public static const CLOSING : String = "closing";

        public function DrawerOpenerEvent(
                type : String,
                bubbles : Boolean = false,
                cancelable : Boolean = false
                ) {
            super(type,bubbles,cancelable);
        }

        override public function clone():Event
        {
            return new DrawerOpenerEvent( type, bubbles, cancelable );
        }
    }
}
