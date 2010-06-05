package com.buildlinks.theme.skins
{
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	
	import mx.skins.Border;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;
	
	public class RadioButtonIcon extends Border
	{	
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.
		 */
		public function RadioButtonIcon()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  measuredWidth
		//----------------------------------
		
		/**
		 *  @private
		 */    
		override public function get measuredWidth():Number
		{
			return 14;
		}
		
		//----------------------------------
		//  measuredHeight
		//----------------------------------
		
		/**
		 *  @private
		 */        
		override public function get measuredHeight():Number
		{
			return 14;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
			
			// Deinfe style variables
			var _borderColor:uint;
			var _fillColors:Array;		    
			var _iconColor:uint;
			var drawCircle:Boolean = false;
			
			var borderColors:Array = getStyle("borderColors");	
			var upFillColors:Array = getStyle("upFillColors");
			var overFillColors:Array = getStyle("overFillColors");
			var downFillColors:Array = getStyle("downFillColors");
			var disabledFillColors:Array = getStyle("disabledFillColors");
			var toggledUpFillColors:Array = getStyle("toggledUpFillColors");
			var toggledOverFillColors:Array = getStyle("toggledOverFillColors");;
			var toggledDownFillColors:Array = getStyle("toggledDownFillColors");
			var toggledDisabledFillColors:Array = getStyle("toggledDisabledFillColors");
			
			// Placeholder styles stub	
			var radioColor:uint = 0x2f3a41;
			
			graphics.clear();
			
			/*  Switch Styles based on component state */
			switch (name) {
				case "upIcon":
					_fillColors = upFillColors;
					_borderColor = borderColors[0];
					drawCircle = false;
					break;
				
				case "overIcon":
					_fillColors = overFillColors;
					_borderColor = borderColors[1];
					drawCircle = false;
					break;
				
				case "downIcon":
					_fillColors = downFillColors;
					_borderColor = borderColors[2];
					drawCircle = false;
					break;
				
				case "disabledIcon":
					_fillColors = disabledFillColors;
					_borderColor = borderColors[3];
					drawCircle = false;
					break;
				
				case "selectedUpIcon":
					_fillColors = upFillColors;
					_borderColor = borderColors[0];
					drawCircle = true;					
					break;
				
				case "selectedOverIcon":
					_fillColors = overFillColors;
					_borderColor = borderColors[1];
					drawCircle = true;
					break;
				
				case "selectedDownIcon":
					_fillColors = downFillColors;
					_borderColor = borderColors[2];
					drawCircle = true;
					break;
				
				case "selectedDisabledIcon":
					_fillColors = disabledFillColors;
					_borderColor = borderColors[3];
					drawCircle = true;
					break;			
			}
			
			// border
			drawRoundRect( 0, 0, w, h, w / 2, _borderColor, 1); 
			
			// box fill
			drawRoundRect( 1, 1, w - 2, h - 2, w / 2, _fillColors, 1, verticalGradientMatrix(0, 0, w - 2, h - 2)); 		
	
			
			// radio symbol

			
			// Draw radio symbol
			if (drawCircle)
			{
				drawRoundRect( 4, 4, w - 8, h - 8, w / 2, radioColor, 1 );
			}
			
			var ds:DropShadowFilter = new DropShadowFilter;
			
			ds.alpha = .5;
			ds.angle = 45;
			ds.distance = 2;
			ds.quality = 1;
			ds.blurX = 3;
			ds.blurY = 3;
			ds.color = 0x262e33;
			ds.inner = true;

			this.filters = [ds];

		}
	}
}
