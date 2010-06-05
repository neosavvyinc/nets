package com.buildlinks.theme.skins
{
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	import mx.core.UIComponent;
	import mx.skins.ProgrammaticSkin;
	import mx.states.AddChild;
	
	[Style(name="borderColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="topLeftRadius",type="Number",format="Radius",inherit="yes")] 
	[Style(name="topRightRadius",type="Number",format="Radius",inherit="yes")] 
	[Style(name="bottomLeftRadius",type="Number",format="Radius",inherit="yes")] 
	[Style(name="bottomRightRadius",type="Number",format="Radius",inherit="yes")] 
	[Style(name="upFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="overFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="downFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="disabledFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="toggledUpFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="toggledOverFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="toggledDownFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="toggledDisabledFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="arrowColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="isDropDown",type="Boolean",format="Boolean",inherit="yes", enumeration="True, False")]
	[Style(name="showSkinStates",type="Array",format="Boolean",inherit="no", enumeration="True, False")]
	[Style(name="ratios",type="Array",format="Color",inherit="yes")] 
	
	public class ButtonSkin extends ProgrammaticSkin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//	
		//--------------------------------------------------------------------------

		/**
		 *  Constructor
		 */
		public function ButtonSkin()
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
			return 22;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Override UpdateDisplayList 
		 * @param uw
		 * @param uh
		 * 
		 */	
		override protected function updateDisplayList(w:Number, h:Number):void 
		{	
			super.updateDisplayList(w, h);
			
			// Deinfe style variables
			var _showSkin:Boolean = true;
			var _borderColor:uint;
			var _fillColors:Array;		    
			var _arrowColor:uint;
			var isDropDown:Boolean = false;
			var showSkinStates:Array = getStyle("showSkinStates");
			
			var borderColors:Array = getStyle("borderColors");	
			var borderThickness:int = getStyle("borderThickness");
			var cornerRadius:int = getStyle("cornerRadius");
			var topLeftRadius:int = cornerRadius;
			var topRightRadius:int = cornerRadius;
			var bottomLeftRadius:int = cornerRadius;    	      
			var bottomRightRadius:int = cornerRadius;   
			var upFillColors:Array = getStyle("upFillColors");
			var overFillColors:Array = getStyle("overFillColors");
			var downFillColors:Array = getStyle("downFillColors");
			var disabledFillColors:Array = getStyle("disabledFillColors");
			var toggledUpFillColors:Array = getStyle("toggledUpFillColors");
			var toggledOverFillColors:Array = getStyle("toggledOverFillColors");;
			var toggledDownFillColors:Array = getStyle("toggledDownFillColors");
			var toggledDisabledFillColors:Array = getStyle("toggledDisabledFillColors");
			var arrowColors:Array = getStyle("arrowColors");
			var ratios:Array = getStyle("ratios");
			
			if (getStyle("topLeftRadius")) {
				topLeftRadius = getStyle("topLeftRadius");
			}    
			
			if (getStyle("topRightRadius")) {
				topRightRadius = getStyle("topRightRadius");
			}
			
			if (getStyle("bottomLeftRadius")) {
				bottomLeftRadius = getStyle("bottomLeftRadius");
			}	        	        
			
			if (getStyle("bottomRightRadius")) {
				bottomRightRadius = getStyle("bottomRightRadius");
			}
			
			if (getStyle("isDropDown")) {
				isDropDown = getStyle("isDropDown");
			}           	        
			
			graphics.clear();
			
			/*  Switch Styles based on component state */
			switch (name) {
				case "upSkin":
					_fillColors = upFillColors;
					_borderColor = borderColors[0];
					_arrowColor = arrowColors[0];
					_showSkin = showSkinStates[0];
					break;
				
				case "popUpOverSkin":	           	
				case "overSkin":
					_fillColors = overFillColors;
					_borderColor = borderColors[1];
					_arrowColor = arrowColors[1];
					_showSkin = showSkinStates[1];
					break;
				
				case "popUpDownSkin":	           	
				case "downSkin":
					_fillColors = downFillColors;
					_borderColor = borderColors[2];
					_arrowColor = arrowColors[2];
					_showSkin = showSkinStates[2];
					break;
				
				case "disabledSkin":
					_fillColors = disabledFillColors;
					_borderColor = borderColors[3];
					_arrowColor = arrowColors[3];
					_showSkin = showSkinStates[3];
					break;
				
				case "selectedUpSkin":
					_fillColors = toggledUpFillColors;
					_borderColor = borderColors[4];
					_arrowColor = arrowColors[4];
					_showSkin = showSkinStates[4];
					break;
				
				case "selectedOverSkin":
					_fillColors = toggledOverFillColors;
					_borderColor = borderColors[4];
					_arrowColor = arrowColors[4];
					_showSkin = showSkinStates[4];
					break;
				
				case "selectedDownSkin":
					_fillColors = toggledDownFillColors;
					_borderColor = borderColors[4];
					_arrowColor = arrowColors[4];
					_showSkin = showSkinStates[4];
					break;
				
				case "selectedDisabledSkin":
					_fillColors = toggledDisabledFillColors;
					_borderColor = borderColors[4];
					_arrowColor = arrowColors[4];
					_showSkin = showSkinStates[4];
					break;
				
				// Additional states for EditableComboBox
				case "editableUpSkin":
					_fillColors = upFillColors;
					_borderColor = borderColors[0];
					_arrowColor = arrowColors[0];
					topLeftRadius = 1;
					bottomLeftRadius = 1;
					break;
				
				case "editableOverSkin":
					_fillColors = overFillColors;
					_borderColor = borderColors[1];
					_arrowColor = arrowColors[1];
					topLeftRadius = 1;
					bottomLeftRadius = 1;	            	            
					break;
				
				case "editableDownSkin":
					_fillColors = downFillColors;
					_borderColor = borderColors[2];
					_arrowColor = arrowColors[2];
					topLeftRadius = 1;
					bottomLeftRadius = 1;	            	            
					break;
				
				case "editableDisabledSkin":
					_fillColors = disabledFillColors;
					_borderColor = borderColors[3];
					_arrowColor = arrowColors[3];
					topLeftRadius = 1;
					bottomLeftRadius = 1;	                      
					break; 
			}
			
			
			// Outer Fill - did this to get around a bug in graphics.lineStyle which renders the corners unevenly
			if (_showSkin)
			{
				graphics.beginFill(_borderColor, 1);					
			}
			graphics.drawRoundRectComplex(0, 0, w, h, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius);	        
			graphics.endFill();
			
			// Inner Gradient
			if (_showSkin)
			{
				graphics.beginGradientFill("linear", _fillColors, [1, 1, 1], ratios, verticalGradientMatrix( 0, 0, w, h ));				
			}			
			graphics.drawRoundRectComplex(1, 1, w - 2, h - 2, topLeftRadius - 1, topRightRadius - 1, bottomLeftRadius - 1, bottomRightRadius -1);
			graphics.endFill();
			
			if (isDropDown)
			{
				
				graphics.beginFill(_arrowColor);
				graphics.moveTo( w - 14, h / 2 - 1 );
				graphics.lineTo( w - 8, h / 2 - 1 );
				graphics.lineTo( w - 11, h / 2 - 4 );
				graphics.lineTo( w - 14, h / 2 - 1 );
				graphics.endFill();

				graphics.beginFill(_arrowColor);
				graphics.moveTo( w - 14, h / 2 + 1 );
				graphics.lineTo( w - 8, h / 2 + 1 );
				graphics.lineTo( w - 11, h / 2 + 4 );
				graphics.lineTo( w - 14, h / 2 + 1 );
				graphics.endFill();
				
				
			}
		}		
	}
}