package main.flex.com.buildlinks.theme.skins
{
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	
	import mx.skins.Border;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;

	[Style(name="upButtonUpFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="upButtonOverFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="upButtonDownFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="upButtonDisabledFillColors",type="Array",format="Color",inherit="yes")] 
	
	public class NumericStepperUpSkin extends Border
	{	
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.
		 */
		public function NumericStepperUpSkin()
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
			return 18;
		}
		
		//----------------------------------
		//  measuredHeight
		//----------------------------------
		
		/**
		 *  @private
		 */        
		override public function get measuredHeight():Number
		{
			return 11;
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
			var _arrowColor:uint;

			var borderColors:Array = getStyle("borderColors");	
			var upButtonUpFillColors:Array = getStyle("upButtonUpFillColors");
			var upButtonOverFillColors:Array = getStyle("upButtonOverFillColors");
			var upButtonDownFillColors:Array = getStyle("upButtonDownFillColors");
			var upButtonDisabledFillColors:Array = getStyle("upButtonDisabledFillColors");
			var arrowColors:Array = getStyle("arrowColors");			
			
			graphics.clear();
			
			/*  Switch Styles based on component state */
			switch (name) {
				case "upArrowUpSkin":
					_fillColors = upButtonUpFillColors;
					_borderColor = borderColors[0];
					_arrowColor = arrowColors[0];
					break;
				
				case "upArrowOverSkin":
					_fillColors = upButtonOverFillColors;
					_borderColor = borderColors[1];
					_arrowColor = arrowColors[1];
					break;
				
				case "upArrowDownSkin":
					_fillColors = upButtonDownFillColors;
					_borderColor = borderColors[2];
					_arrowColor = arrowColors[2];
					break;
				
				case "upArrowDisabledSkin":
					_fillColors = upButtonDisabledFillColors;
					_borderColor = borderColors[3];
					_arrowColor = arrowColors[3];
					break;
			}
			
			// border
			drawRoundRect( 0, 0, w, h, 1, _borderColor, 1); 
			
			// fill
			drawRoundRect( 1, 1, w - 2, h - 1, 1, _fillColors, 1, verticalGradientMatrix(0, 0, w - 2, h - 2)); 
			
			// Draw the arrow.
			graphics.beginFill(_arrowColor);
			graphics.moveTo(w / 2, h / 2 - 2);
			graphics.lineTo(w / 2 - 3, h / 2 + 2);
			graphics.lineTo(w / 2 + 3, h / 2 + 2);
			graphics.lineTo(w / 2, h / 2 - 2);
			graphics.endFill();
		}
	}
}
