package com.buildlinks.theme.skins
{
	
	import flash.geom.Matrix;
	
	import mx.skins.Border;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;
	
	public class ScrollThumbSkin extends Border
	{		

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.
		 */
		public function ScrollThumbSkin()
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
			return 12;
		}
		
		//----------------------------------
		//  measuredHeight
		//----------------------------------
		
		/**
		 *  @private
		 */
		override public function get measuredHeight():Number
		{
			return 23;
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
			
			// User-defined styles.
			var radius:Number = Math.max(getStyle("cornerRadius") - 1, 0);
			var _fillColors:Array;

			var upFillColors:Array = getStyle("upFillColors");
			var overFillColors:Array = getStyle("overFillColors");
			var downFillColors:Array = getStyle("downFillColors");
			var disabledFillColors:Array = getStyle("disabledFillColors");
			
			graphics.clear();
			
			switch (name) {
				default:
				case "thumbUpSkin":
					_fillColors = upFillColors;
					break;
				
				case "thumbOverSkin":	           	
					_fillColors = overFillColors;
					break;
				
				case "thumbDownSkin":	           	
					_fillColors = downFillColors;
					break;
				
				case "thumbDisabledSkin":
					_fillColors = disabledFillColors;
					break;
			}
			
			var matrix:Matrix = new Matrix();			
			matrix.createGradientBox( w, h, Math.PI/2, 0, 0 );
			
			graphics.lineStyle(1, 0x707070, .75, true);
			graphics.beginGradientFill("linear", _fillColors, [ 1, 1 ], [ 0, 255 ], matrix);				
			graphics.drawRect( 0, 0, w -1, h );
			graphics.endFill();
			
			graphics.lineStyle( 1, 0xcfcfcf, .75, true );
			graphics.moveTo( 1, h + 1 );
			graphics.lineTo( w - 2, h + 1 );
			graphics.endFill();
		}
	}	
}
