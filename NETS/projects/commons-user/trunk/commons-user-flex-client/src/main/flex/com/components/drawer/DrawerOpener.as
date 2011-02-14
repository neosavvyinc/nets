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
 * Time: 11:20 PM
 */
package com.components.drawer {
    import com.neosavvy.user.view.secured.employeeInvitation.Actions;

    import flash.events.Event;

    import mx.core.Container;
    import mx.core.IDeferredInstance;
    import mx.core.IMXMLObject;
    import mx.core.UIComponent;
    import mx.core.UIComponent;
    import mx.effects.Effect;
    import mx.events.FlexEvent;
    import mx.events.ResizeEvent;
    import mx.events.TweenEvent;
    import mx.styles.CSSStyleDeclaration;

    public class DrawerOpener extends CSSStyleDeclaration implements IMXMLObject {

        public static const ALIGN_LEFT : String = "left";
        public static const ALIGN_RIGHT : String = "right";

        private var parent : Container;
        private var move : Effect;//WorkingMove;
        private var parentCreated : Boolean;
        private var drawCreated : Boolean;

        public var animate : Boolean = false;
        public var overlap : Number = 0;

        [Inspectable(enumeration="left,right")]
        public var alignment : String = ALIGN_RIGHT;

        public var stretchToParentHeight : Boolean = true;

        public var name : String = DrawerUtil.RIGHT_DRAWER_NAME;

        private var _gutterTop : Number = 30;


        [Bindable]
        public function get gutterTop():Number {
            return _gutterTop;
        }

        public function set gutterTop(value:Number):void {
            _gutterTop = value;
            positionDrawerVertically();
        }

        private var _gutterBottom : Number = 30;

        public function set gutterBottom( value : Number ) : void
        {
            _gutterBottom = value;
            positionDrawerVertically();
        }

        [Bindable]
        public function get gutterBottom( ) : Number
        {
            return _gutterBottom;
        }

        private var _visible : Boolean = true;


        public function get visible():Boolean {
            return _visible;
        }

        public function set visible(value:Boolean):void {
            _visible = value;

            if( drawCreated )
            {
                UIComponent( _drawer.getInstance() ).visible = _visible;
            }
        }

        private var _drawer : IDeferredInstance;


        public function get drawerInstance():UIComponent {
            return UIComponent(_drawer.getInstance() );
        }

        public function set drawer(value:IDeferredInstance):void {
            if( _drawer == value ) return;

            removeDrawer();
            _drawer = value;
            drawCreated = true;
            if( drawerInstance.initialized )
            {
                drawerInstance.addEventListener( Event.ADDED_TO_STAGE, onDrawerCreated );
            }
            else
            {
                drawerInstance.addEventListener( FlexEvent.CREATION_COMPLETE, onDrawerCreated );
            }
            invalidate();
        }

        private var _open : Boolean = false;

        [Bindable("opened")]
        [Bindable("closed")]
        public function get open() : Boolean
        {
            return _open;
        }

        public function set open( value : Boolean ) : void
        {
            if( open == value ) return;

            _open = value;
            invalidate();
        }

        public function initialized( document : Object, id : String ) : void
        {
            var parentContainer : Container = document as Container;

            if( !parentContainer )
            {
                throw new Error("DrawerOpener must be declared in a container");
            }

            parent = parentContainer;
            parent.addEventListener(FlexEvent.CREATION_COMPLETE, onParentCreationComplete);
            parent.addEventListener(ResizeEvent.RESIZE, onParentResize);
        }

        public function invalidate() : void
        {
            if( !parentCreated || !_drawer ) return;

            if( _open )
            {
                openDrawer();
            }
            else
            {
                closeDrawer();
            }
        }

        private function openDrawer():void
        {
            cleanUpMove();

            if( !parent.rawChildren.contains( drawerInstance ))
            {
                drawerInstance.name = name;
                parent.rawChildren.addChildAt( drawerInstance, 0 );

                if( !drawCreated ) return;
            }

            var xTo : int = calculateXPosition();

            if( animate )
            {
//                move = new WorkingMove(
//                    drawerInstance,
//                    drawerInstance.x,
//                    xTo,
//                    drawerInstance.y,
//                    drawerInstance.y,
//                    500
//                );
                move.play();

                move.addEventListener( TweenEvent.TWEEN_END, onOpened );
                dispatchDrawerEvent( DrawerOpenerEvent.OPENING );
            }
            else
            {
                drawerInstance.x = xTo;
                dispatchDrawerEvent( DrawerOpenerEvent.OPENED );
            }

            _open = true;
        }

        private function closeDrawer():void
        {
            cleanUpMove();

            var xTo : int = alignment == ALIGN_RIGHT ?
                    parent.width - drawerInstance.width :
                    0;

            if( animate )
            {
//                move = new WorkingMove(
//                    drawerInstance,
//                    drawerInstance.x,
//                    xTo,
//                    drawerInstance.y,
//                    drawerInstance.y,
//                    500
//                );
                move.play();

                move.addEventListener( TweenEvent.TWEEN_END, onClosed );
                dispatchDrawerEvent( DrawerOpenerEvent.CLOSING );
            }
            else
            {
                drawerInstance.x = xTo;
                dispatchDrawerEvent( DrawerOpenerEvent.CLOSED );
            }

            _open = false;
        }

        private function cleanUpMove():void
        {
            if( move )
            {
                move.removeEventListener( TweenEvent.TWEEN_END, onOpened );
                move.removeEventListener( TweenEvent.TWEEN_END, onClosed );

                move.stop();
            }

            move = null;
        }

        private function removeDrawer():void
        {
            if ( ! _drawer || !drawerInstance )
            {
                return;
            }

            if( parent.rawChildren.contains( drawerInstance ) )
            {
                parent.rawChildren.removeChild( drawerInstance );
            }
        }

        private function positionDrawer():void
        {
            positionDrawerVertically();
            positionDrawerHorizontally();
        }

        private function positionDrawerHorizontally():void {
            if( !drawCreated ) return;
            drawerInstance.x = calculateXPosition();
        }

        private function positionDrawerVertically():void
        {
            if( !drawCreated ) return;
            drawerInstance.y = gutterTop;

            if(stretchToParentHeight)
            {
                drawerInstance.height = parent.height - gutterTop - gutterBottom;
            }
        }

        private function calculateXPosition():int
        {
            return alignment == ALIGN_RIGHT ?
                    parent.width - overlap :
                    - ( drawerInstance.getExplicitOrMeasuredWidth() + overlap );

        }

        private function onDrawerCreated( event : Event ) : void
        {
            drawCreated = true;

            var drawerInstance : UIComponent = UIComponent( _drawer.getInstance() );
            drawerInstance.removeEventListener( event.type, onDrawerCreated );
            drawerInstance.width = drawerInstance.getExplicitOrMeasuredWidth();
            drawerInstance.x = parent.width - drawerInstance.getExplicitOrMeasuredWidth();
            drawerInstance.visible = _visible;

            drawerInstance.addEventListener( ResizeEvent.RESIZE, onDrawerResize );
            positionDrawerVertically();
            openDrawer();
        }

        private function onParentCreationComplete( event : FlexEvent ) : void
        {
            parent.removeEventListener(FlexEvent.CREATION_COMPLETE, onParentCreationComplete);
            parentCreated = true;
            invalidate();
        }

        private function onDrawerResize( event : ResizeEvent ) : void
        {
            parent.dispatchEvent( event );
        }

        private function onParentResize( event : ResizeEvent ) : void
        {
            positionDrawer();
        }

        private function onOpened( event : Event ) : void
        {
            cleanUpMove();
            dispatchDrawerEvent( DrawerOpenerEvent.OPENED );
        }

        private function onClosed( event : Event ) : void
        {
            cleanUpMove();
            removeDrawer();
            dispatchDrawerEvent( DrawerOpenerEvent.CLOSED );
        }

        private function dispatchDrawerEvent( type : String ) : void
        {
            dispatchEvent( new DrawerOpenerEvent( type ) );
            parent.dispatchEvent( new DrawerOpenerEvent( type ) );
        }
        


    }
}
