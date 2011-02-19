package com.components.fileupload
{
    import flash.events.MouseEvent;
    import flash.geom.Point;

    import mx.containers.TitleWindow;
    import mx.controls.Button;
    import mx.core.Application;
    import mx.core.UIComponent;
    import mx.events.FlexEvent;
    import mx.managers.CursorManager;
    import mx.managers.CursorManagerPriority;
    import mx.managers.PopUpManager;

    [Event(name="closeWindow", type="mx.events.FlexEvent")]
	[Event(name="minWindow", type="mx.events.FlexEvent")]
	[Event(name="maxWindow", type="mx.events.FlexEvent")]

	public class ResizeWindow extends TitleWindow
	{

		public static function popResizeWindow(parentObj:UIComponent,
												childObj:UIComponent,
                                                isModal:Boolean=true,
												title:String="",
												width:Number=400,
												height:Number=400,
												layout:String="vertical",
												showButtons:Boolean=true
												):ResizeWindow
		{
			var rv : ResizeWindow;
			rv = ResizeWindow(PopUpManager.createPopUp(parentObj,ResizeWindow,isModal));
            PopUpManager.centerPopUp(rv);
			rv.showWindowButtons = showButtons;
			rv.layout = layout;
			rv.title = title;
			rv.width = width;
			rv.height = height;

			rv.addChild(childObj);

			PopUpManager.centerPopUp(rv);

			return rv;
		}
		
		private static var resizeObj:Object;
		private static var mouseState:Number = 0;
		private static var mouseMargin:Number = 10;

		
		private var oWidth:Number = 0;
		private var oHeight:Number = 0;
		private var oX:Number = 0;
		private var oY:Number = 0;
		private var oPoint:Point = new Point();
		
		private var _showWindowButtons:Boolean = false;
		private var _windowMinSize:Number = 50;
		
		public static const SIDE_OTHER:Number = 0;
		public static const SIDE_TOP:Number = 1;
		public static const SIDE_BOTTOM:Number = 2;
		public static const SIDE_LEFT:Number = 4;
		public static const SIDE_RIGHT:Number = 8;
		
		public static const EVT_MIN_RESIZE_WINDOW:String = "minResizeWindow";
		public static const EVT_MAX_RESIZE_WINDOW:String = "maxResizeWindow";
		public static const EVT_CLOSE_RESIZE_WINDOW:String = "closeResizeWindow";
		
		private static var currentType:Class = null;
		
		/**
	 	 * Constructor.
	 	 * Add mouse envent to this window and application.
	 	 * initialize the old positions.
	 	 */
		public function ResizeWindow(){
			super();
			initPosition(this);
			
			this.addEventListener(MouseEvent.MOUSE_MOVE, oMouseMove);
			this.addEventListener(MouseEvent.MOUSE_OUT, oMouseOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN, oMouseDown);
			//this.addEventListener(MouseEvent.MOUSE_UP, oMouseUp);
			this.addEventListener(FlexEvent.CREATION_COMPLETE, addButton);
			
			//Application.application.parent:SystemManager
			Application.application.parent.addEventListener(MouseEvent.MOUSE_UP, oMouseUp);
			Application.application.parent.addEventListener(MouseEvent.MOUSE_MOVE, oResize);
		}
		
		public function set showWindowButtons(show:Boolean):void{
			_showWindowButtons = show;
			if(titleBar != null){
				addButton(new FlexEvent(""));
			}
		}
		
		public function get showWindowButtons():Boolean{
			return _showWindowButtons;
		}
		
		public function set windowMinSize(size:Number):void{
			if(size > 0){
				_windowMinSize = size;
			}
		}
		
		public function get windowMinSize():Number{
			return _windowMinSize;
		}
		
		private static function initPosition(obj:Object):void{
			obj.oHeight = obj.height;
			obj.oWidth = obj.width;
			obj.oX = obj.x;
			obj.oY = obj.y;
		}
		
		/**
		 * Set the first global point that mouse down on the window.
		 * @param The MouseEvent.MOUSE_DOWN
		 */
		private function oMouseDown(event:MouseEvent):void{
			if(mouseState != SIDE_OTHER){
				resizeObj = event.currentTarget;
				initPosition(resizeObj);
				oPoint.x = resizeObj.mouseX;
				oPoint.y = resizeObj.mouseY;
				oPoint = this.localToGlobal(oPoint);
			}
		}
		
		/**
		 * Clear the resizeObj and also set the latest position.
		 * @param The MouseEvent.MOUSE_UP
		 */
		private function oMouseUp(event:MouseEvent):void{
			if(resizeObj != null){
				initPosition(resizeObj);
			}
			resizeObj = null;
		}
		

		public function changeCursor(type:Class, xOffset:Number = 0, yOffset:Number = 0):void{
			if(currentType != type){
				currentType = type;
				CursorManager.removeCursor(CursorManager.currentCursorID);
				if(type != null){
					CursorManager.setCursor(type, CursorManagerPriority.MEDIUM, xOffset, yOffset);
				}
			}
		}
		
		/**
		 * Show the mouse arrow when not draging.
		 * Call oResize(event) to resize window when mouse is inside the window area.
		 * @param The MouseEvent.MOUSE_MOVE
		 */
		private function oMouseMove(event:MouseEvent):void{
			if(resizeObj == null){
				var xPosition:Number = Application.application.parent.mouseX;
				var yPosition:Number = Application.application.parent.mouseY;
				if(xPosition >= (this.x + this.width - mouseMargin) && yPosition >= (this.y + this.height - mouseMargin)){
					changeCursor(ComponentCommon.LEFT_OBLIQUE_SIZE, -6, -6);
					mouseState = SIDE_RIGHT | SIDE_BOTTOM;
				}else if(xPosition <= (this.x + mouseMargin) && yPosition <= (this.y + mouseMargin)){
					changeCursor(ComponentCommon.LEFT_OBLIQUE_SIZE, -6, -6);
					mouseState = SIDE_LEFT | SIDE_TOP;
				}else if(xPosition <= (this.x + mouseMargin) && yPosition >= (this.y + this.height - mouseMargin)){
					changeCursor(ComponentCommon.RIGHT_OBLIQUE_SIZE, -6, -6);
					mouseState = SIDE_LEFT | SIDE_BOTTOM;
				}else if(xPosition >= (this.x + this.width - mouseMargin) && yPosition <= (this.y + mouseMargin)){
					changeCursor(ComponentCommon.RIGHT_OBLIQUE_SIZE, -6, -6);
					mouseState = SIDE_RIGHT | SIDE_TOP;
				}else if(xPosition >= (this.x + this.width - mouseMargin)){
					changeCursor(ComponentCommon.HORIZONTAL_SIZE, -9, -9);
					mouseState = SIDE_RIGHT;	
				}else if(xPosition <= (this.x + mouseMargin)){
					changeCursor(ComponentCommon.HORIZONTAL_SIZE, -9, -9);
					mouseState = SIDE_LEFT;
				}else if(yPosition >= (this.y + this.height - mouseMargin)){
					changeCursor(ComponentCommon.VERTICAL_SIZE, -9, -9);
					mouseState = SIDE_BOTTOM;
				}else if(yPosition <= (this.y + mouseMargin)){
					changeCursor(ComponentCommon.VERTICAL_SIZE, -9, -9);
					mouseState = SIDE_TOP;
				}else{
					mouseState = SIDE_OTHER;
					changeCursor(null, 0, 0);
				}
			}
			//Use SystemManager to listen the mouse reize event, so we needn't handle the event at the current object.
			//oResize(event);
		}
		
		/**
		 * Hide the arrow when not draging and moving out the window.
		 * @param The MouseEvent.MOUSE_MOVE
		 */
		private function oMouseOut(event:MouseEvent):void{
			if(resizeObj == null){
				changeCursor(null, 0, 0);
			}
		}
		
		/**
		 * Resize when the draging window, resizeObj is not null.
		 * @param The MouseEvent.MOUSE_MOVE
		 */
		private function oResize(event:MouseEvent):void{
			if(resizeObj != null){	
				resizeObj.stopDragging();
				var xPlus:Number = Application.application.parent.mouseX - resizeObj.oPoint.x;
				var yPlus:Number = Application.application.parent.mouseY - resizeObj.oPoint.y;
			    switch(mouseState){
			    	case SIDE_RIGHT | SIDE_BOTTOM:
			    		resizeObj.width = resizeObj.oWidth + xPlus > _windowMinSize ? resizeObj.oWidth + xPlus : _windowMinSize;
		    			resizeObj.height = resizeObj.oHeight + yPlus > _windowMinSize ? resizeObj.oHeight + yPlus : _windowMinSize;
			    		break;
			    	case SIDE_LEFT | SIDE_TOP:
		    			resizeObj.x = xPlus < resizeObj.oWidth - _windowMinSize ? resizeObj.oX + xPlus: resizeObj.x;
		    			resizeObj.y = yPlus < resizeObj.oHeight - _windowMinSize ? resizeObj.oY + yPlus : resizeObj.y;
			    		resizeObj.width = resizeObj.oWidth - xPlus > _windowMinSize ? resizeObj.oWidth - xPlus : _windowMinSize;
		    			resizeObj.height = resizeObj.oHeight - yPlus > _windowMinSize ? resizeObj.oHeight - yPlus : _windowMinSize;
			    		break;
			    	case SIDE_LEFT | SIDE_BOTTOM:
			    		resizeObj.x = xPlus < resizeObj.oWidth - _windowMinSize ? resizeObj.oX + xPlus: resizeObj.x;
			    		resizeObj.width = resizeObj.oWidth - xPlus > _windowMinSize ? resizeObj.oWidth - xPlus : _windowMinSize;
		    			resizeObj.height = resizeObj.oHeight + yPlus > _windowMinSize ? resizeObj.oHeight + yPlus : _windowMinSize;
			    		break;
			    	case SIDE_RIGHT | SIDE_TOP:
			    		resizeObj.y = yPlus < resizeObj.oHeight - _windowMinSize ? resizeObj.oY + yPlus : resizeObj.y;
			    		resizeObj.width = resizeObj.oWidth + xPlus > _windowMinSize ? resizeObj.oWidth + xPlus : _windowMinSize;
		    			resizeObj.height = resizeObj.oHeight - yPlus > _windowMinSize ? resizeObj.oHeight - yPlus : _windowMinSize;
			    		break;
			    	case SIDE_RIGHT:
			    		resizeObj.width = resizeObj.oWidth + xPlus > _windowMinSize ? resizeObj.oWidth + xPlus : _windowMinSize;
			    		break;
			    	case SIDE_LEFT:
			    		resizeObj.x = xPlus < resizeObj.oWidth - _windowMinSize ? resizeObj.oX + xPlus: resizeObj.x;
			    		resizeObj.width = resizeObj.oWidth - xPlus > _windowMinSize ? resizeObj.oWidth - xPlus : _windowMinSize;
			    		break;
			    	case SIDE_BOTTOM:
			    		resizeObj.height = resizeObj.oHeight + yPlus > _windowMinSize ? resizeObj.oHeight + yPlus : _windowMinSize;
			    		break;
			    	case SIDE_TOP:
			    		resizeObj.y = yPlus < resizeObj.oHeight - _windowMinSize ? resizeObj.oY + yPlus : resizeObj.y;
			    		resizeObj.height = resizeObj.oHeight - yPlus > _windowMinSize ? resizeObj.oHeight - yPlus : _windowMinSize;
			    		break;
			    }
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Control the window buttons.
		//
		//--------------------------------------------------------------------------
		
		private var windowMinButton:Button;
		private var windowMaxButton:Button;
		private var windowCloseButton:Button;
		
		/**
		 * Add the window buttons and layout them.
		 * @param The FlexEvent.CREATION_COMPLETE
		 */
		private function addButton(event:FlexEvent):void{
			if(_showWindowButtons){
				if(windowMinButton == null){
					windowMinButton = new Button();
					windowMinButton.width=10;
					windowMinButton.height=10;
					windowMinButton.focusEnabled=false;
					windowMinButton.setStyle("upSkin", ComponentCommon.WINDOW_MIN_BUTTON_1);
					windowMinButton.setStyle("overSkin", ComponentCommon.WINDOW_MIN_BUTTON_2);
					windowMinButton.setStyle("downSkin", ComponentCommon.WINDOW_MIN_BUTTON_2);
					windowMinButton.addEventListener(MouseEvent.CLICK, windowMinButton_clickHandler);
					titleBar.addChild(windowMinButton);
				}
				if(windowMaxButton == null){
					windowMaxButton = new Button();
					windowMaxButton.width=10;
					windowMaxButton.height=10;
					windowMaxButton.focusEnabled=false;
					windowMaxButton.setStyle("upSkin", ComponentCommon.WINDOW_MAX_BUTTON_1);
					windowMaxButton.setStyle("overSkin", ComponentCommon.WINDOW_MAX_BUTTON_2);
					windowMaxButton.setStyle("downSkin", ComponentCommon.WINDOW_MAX_BUTTON_2);
					windowMaxButton.addEventListener(MouseEvent.CLICK, windowMaxButton_clickHandler);
					titleBar.addChild(windowMaxButton);
				}
				if(windowCloseButton == null){
					windowCloseButton = new Button();
					windowCloseButton.width=10;
					windowCloseButton.height=10;
					windowCloseButton.focusEnabled=false;
					windowCloseButton.setStyle("upSkin", ComponentCommon.WINDOW_CLOSE_BUTTON_1);
					windowCloseButton.setStyle("overSkin", ComponentCommon.WINDOW_CLOSE_BUTTON_2);
					windowCloseButton.setStyle("downSkin", ComponentCommon.WINDOW_CLOSE_BUTTON_2);
					windowCloseButton.addEventListener(MouseEvent.CLICK, windowCloseButton_clickHandler);
					titleBar.addChild(windowCloseButton);
				}
				layoutWindowButtons();
			}
			else
			{
				if(titleBar != null)
				{
					if(windowMinButton != null)
					{
						titleBar.removeChild(windowMinButton);
						windowMinButton = null;	
					}
					if(windowMaxButton != null)
					{
						titleBar.removeChild(windowMaxButton);
						windowMaxButton = null;						
					}
					if(windowCloseButton != null)
					{
						titleBar.removeChild(windowCloseButton);
						windowCloseButton = null;						
					}
					
				}

			}
		}
		
		private function windowMinButton_clickHandler(event:MouseEvent):void{
			dispatchEvent(new FlexEvent(EVT_MIN_RESIZE_WINDOW));
		}
		
		private function windowMaxButton_clickHandler(event:MouseEvent):void{
			dispatchEvent(new FlexEvent(EVT_MAX_RESIZE_WINDOW));
		}
		
		private function windowCloseButton_clickHandler(event:MouseEvent):void{
			dispatchEvent(new FlexEvent(EVT_CLOSE_RESIZE_WINDOW));
		}
		
		private function layoutWindowButtons():void{
			if(windowMinButton != null){
				windowMinButton.move(titleBar.width - 10 * 3  - 6 - 6 - 6, (titleBar.height - 10) / 2);
			}
			if(windowMaxButton != null){
				windowMaxButton.move(titleBar.width - 10 * 2  - 6 - 6, (titleBar.height - 10) / 2);
			}
			if(windowCloseButton != null){
				windowCloseButton.move(titleBar.width - 10 - 6, (titleBar.height - 10) / 2);
			}
		}
		
		override protected function layoutChrome(unscaledWidth:Number, unscaledHeight:Number):void{
			super.layoutChrome(unscaledWidth, unscaledHeight);
			layoutWindowButtons();
		}
	}
}