package com.buildlinks.theme.skins
{
	import flash.geom.Matrix;
	
	import mx.skins.ProgrammaticSkin;
	
	[Style(name="borderColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="topLeftRadius",type="Number",format="Radius",inherit="yes")] 
	[Style(name="topRightRadius",type="Number",format="Radius",inherit="yes")] 
	[Style(name="upFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="overFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="downFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="disabledFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="selectedUpFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="selectedOverFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="selectedDownFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="selectedDisabledFillColors",type="Array",format="Color",inherit="yes")] 

	public class TabSkin extends ProgrammaticSkin
	{	  		    
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//	
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor
		 */
		public function TabSkin()
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
			return 20;
		}
		
		//----------------------------------
		//  measuredHeight
		//----------------------------------
		
		/**
		 *  @private
		 */
		override public function get measuredHeight():Number
		{
			return 20;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		override protected function updateDisplayList(w:Number, h:Number):void 
		{	
			super.updateDisplayList(w, h);
			
			// Variable for tracking skin state
			var _isSelected:Boolean = false;
			
			// Deinfe style variables
			var _borderColor:uint;
			var _fillColors:Array = new Array;		    
			
			var borderColors:Array = getStyle("borderColors");	
			var borderThickness:int = getStyle("borderThickness");
			var cornerRadius:int = getStyle("cornerRadius");
			var topLeftRadius:int = cornerRadius;
			var topRightRadius:int = cornerRadius;
			
			// Hard coding the color values here as using the getStyle method 
			// yeilds a runtime error in Flex SDK 3.5 -- @TODO fix bug
			var upFillColors:Array = [0xffffff, 0xe9e9e9];
			var overFillColors:Array = [0xf1fce1, 0xb2bea3];
			var downFillColors:Array = [0xe0fcb8, 0xa1be79];
			var disabledFillColors:Array = [0xffffff, 0xffffff];
			var selectedUpFillColors:Array = [0xffffff, 0xffffff];
			var selectedOverFillColors:Array = [0xffffff, 0xffffff];
			var selectedDownFillColors:Array = [0xffffff, 0xffffff];
			var selectedDisabledFillColors:Array = [0xffffff, 0xffffff];

			if (getStyle("topLeftRadius")) {
				topLeftRadius = getStyle("topLeftRadius");
			}    
			
			if (getStyle("topRightRadius")) {
				topRightRadius = getStyle("topRightRadius");
			}
			
			graphics.clear();
			
			/*  Switch Styles based on component state */
			switch (name) {
				case "upSkin":
					_fillColors = upFillColors;
					_borderColor = borderColors[0];
					break;
				
				case "overSkin":
					_fillColors = overFillColors;
					_borderColor = borderColors[1];
					break;
				
				case "downSkin":
					_fillColors = downFillColors;
					_borderColor = borderColors[2];
					break;
				
				case "disabledSkin":
					_fillColors = disabledFillColors;
					_borderColor = borderColors[3];
					break;
				
				case "selectedUpSkin":
					_fillColors = selectedUpFillColors;
					_borderColor = borderColors[4];
					_isSelected = true;
					break;
				
				case "selectedOverSkin":
					_fillColors = selectedOverFillColors;
					_borderColor = borderColors[4];
					_isSelected = true;
					break;
				
				case "selectedDownSkin":
					_fillColors = selectedDownFillColors;
					_borderColor = borderColors[4];
					_isSelected = true;
					break;
				
				case "selectedDisabledSkin":
					_fillColors = selectedDisabledFillColors;
					_borderColor = borderColors[4];
					_isSelected = true;
					break;
			}
			
			// Outer Fill - did this to get around a bug in graphics.lineStyle which renders the corners unevenly
			graphics.beginFill(_borderColor, 1);
			graphics.drawRoundRectComplex(0, 0, w, h, topLeftRadius, topRightRadius, 0, 0);	        
			graphics.endFill();
			
			// Inner Gradient
			graphics.beginGradientFill("linear", _fillColors, [1, 1], [60, 255], verticalGradientMatrix( 0, 0, w, h ));
			graphics.drawRoundRectComplex(1, 1, w - 2, h - 2, topLeftRadius - 1, topRightRadius - 1, 0, 0);
			graphics.endFill();
			
			// Overlay bottom portion of tab when selected to create illusion of connection
			if(_isSelected)
			{
				graphics.beginFill(0xfefefe, 1);
				graphics.drawRect(1, h - 1, w - 2, 1);
				graphics.endFill();
			}
		}		
	}
}
