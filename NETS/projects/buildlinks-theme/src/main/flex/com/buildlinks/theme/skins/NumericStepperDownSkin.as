package main.flex.com.buildlinks.theme.skins
{
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	
	import mx.skins.Border;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;

	[Style(name="downButtonUpFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="downButtonOverFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="downButtonDownFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="downButtonDisabledFillColors",type="Array",format="Color",inherit="yes")] 
	
	public class NumericStepperDownSkin extends Border
	{	
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.
		 */
		public function NumericStepperDownSkin()
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
			var _iconColor:uint;
			var _arrowColor:uint;

			var borderColors:Array = getStyle("borderColors");	
			var downButtonUpFillColors:Array = getStyle("downButtonUpFillColors");
			var downButtonOverFillColors:Array = getStyle("downButtonOverFillColors");
			var downButtonDownFillColors:Array = getStyle("downButtonDownFillColors");
			var downButtonDisabledFillColors:Array = getStyle("downButtonDisabledFillColors");
			var arrowColors:Array = getStyle("arrowColors");			
			
			graphics.clear();
			
			/*  Switch Styles based on component state */
			switch (name) {
				case "downArrowUpSkin":
					_fillColors = downButtonUpFillColors;
					_borderColor = borderColors[0];
					_arrowColor = arrowColors[0];
					break;
				
				case "downArrowOverSkin":
					_fillColors = downButtonOverFillColors;
					_borderColor = borderColors[1];
					_arrowColor = arrowColors[1];
					break;
				
				case "downArrowDownSkin":
					_fillColors = downButtonDownFillColors;
					_borderColor = borderColors[2];
					_arrowColor = arrowColors[2];
					break;
				
				case "downArrowDisabledSkin":
					_fillColors = downButtonDisabledFillColors;
					_borderColor = borderColors[3];
					_arrowColor = arrowColors[3];
					break;
			}
			
			// border
			drawRoundRect( 0, 0, w, h, 1, _borderColor, 1); 
			
			// fill
			drawRoundRect( 1, 1, w - 2, h - 2, 1, _fillColors, 1, verticalGradientMatrix(0, 0, w - 2, h - 2)); 
			
			// Draw the arrow.
			graphics.beginFill(_arrowColor);
			graphics.moveTo(w / 2, h / 2 + 2);
			graphics.lineTo(w / 2 - 3, h / 2 - 2);
			graphics.lineTo(w / 2 + 3, h / 2 - 2);
			graphics.lineTo(w / 2, h / 2 + 2);
			graphics.endFill();
		}
	}
}
