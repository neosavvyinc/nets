package com.buildlinks.theme.skins
{
	
	import flash.display.Graphics;
	import mx.skins.Border;
	import mx.utils.ColorUtil;
	
	public class DateChooserYearArrowSkin extends Border
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.
		 */
		public function DateChooserYearArrowSkin()
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
			return 9;
		}
		
		//----------------------------------
		//  measuredHeight
		//----------------------------------
		
		/**
		 *  @private
		 */
		override public function get measuredHeight():Number
		{
			return 6;
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
			
			var _arrowColor:uint;
			var arrowColors:Array = getStyle("arrowColors");			
		
			graphics.clear();
			
			switch (name)
			{
				case "prevYearUpSkin":
				case "nextYearUpSkin":
				{
					_arrowColor = arrowColors[0];
					
					break;
				}
					
				case "prevYearOverSkin":
				case "nextYearOverSkin":
				{
					_arrowColor = arrowColors[1];
					break;
				}
					
				case "prevYearDownSkin":
				case "nextYearDownSkin":		
				{
					_arrowColor = arrowColors[2];
					break;
				}
					
				case "prevYearDisabledSkin":
				case "nextYearDisabledSkin":
				{
					_arrowColor = arrowColors[3];					
					break;
				}
			}
			
			// Viewable Button area				
			graphics.beginFill(_arrowColor);
			
			if (name.charAt(0) == "p")
			{
				graphics.moveTo(3, h / 2 + 2);
				graphics.lineTo(0, h / 2 - 2);
				graphics.lineTo(6, h / 2 - 2);
				graphics.lineTo(3, h / 2 + 2);
			}
			else
			{								
				graphics.moveTo(3, h / 2 - 2);
				graphics.lineTo(0, h / 2 + 2);
				graphics.lineTo(6, h / 2 + 2);
				graphics.lineTo(3, h / 2 - 2);
			}
			graphics.endFill();				
		}
	}
}
