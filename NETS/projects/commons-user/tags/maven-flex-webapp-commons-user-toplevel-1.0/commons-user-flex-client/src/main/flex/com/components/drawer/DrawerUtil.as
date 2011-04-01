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
 * Date: 2/8/11
 * Time: 11:24 PM
 */
package com.components.drawer {
    import flash.display.DisplayObject;

    import flash.sampler._getInvocationCount;

    import mx.core.IRawChildrenContainer;
    import mx.core.IUIComponent;
    import mx.core.UIComponent;

    public class DrawerUtil {

        public static const RIGHT_DRAWER_NAME : String = "drawer";
        public static const LEFT_DRAWER_NAME : String = "leftDrawer";

        public static function getVisibleDrawerPath(
                component : IUIComponent
                ) : Number
        {
            if( component is IRawChildrenContainer == false ) return 0;

            var drawer : DisplayObject = IRawChildrenContainer(
                    component
            ).rawChildren.getChildByName( RIGHT_DRAWER_NAME );

            var leftDrawer : DisplayObject = IRawChildrenContainer(
                    component
            ).rawChildren.getChildByName( LEFT_DRAWER_NAME );

            var visibleWidth : int = 0;
            if( drawer && drawer.visible )
            {
                visibleWidth += drawer.width;
            }

            if( leftDrawer && leftDrawer.visible )
            {
                visibleWidth += leftDrawer.width;
            }

            if( visibleWidth > 0 )
            {
                return visibleWidth;
            }

            return 0;
            
        }

        public static function getMaximizedXPosition(
                component : UIComponent
                ) : Number
        {
            if ( component is IRawChildrenContainer == false ) return 0;

            var leftDrawer : DisplayObject = IRawChildrenContainer(
                    component
            ).rawChildren.getChildByName( LEFT_DRAWER_NAME );

            if( leftDrawer )
            {
                return leftDrawer.width;
            }

            return 0;
        }

    }
}
