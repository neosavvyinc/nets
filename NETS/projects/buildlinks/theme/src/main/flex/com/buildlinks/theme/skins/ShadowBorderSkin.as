package com.buildlinks.theme.skins
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	
	import mx.skins.Border;
	import mx.states.AddChild;
	
	[Style(name="backgroundFillColors",type="Array",format="Color",inherit="yes")] 
	[Style(name="backgroundFillAlphas",type="Array",format="Color",inherit="yes")] 
	
	public class ShadowBorderSkin extends Border
	{

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//	
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor
		 */
		public function ShadowBorderSkin()
		{
			super();
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
		override protected function updateDisplayList( uw:Number, uh:Number ):void
		{

			var _backgroundFillColors:Array = [ 0xf3f3ee ,0xf3f3ee ];
			var _backgroundFillAlphas:Array = [ 1.0, 1.0 ];
			var Icon:Class = null;
			var _borderStyle:String = "none";
			
			if (getStyle("backgroundFillColors")) {
				_backgroundFillColors = getStyle("backgroundFillColors");
			} 
			
			if (getStyle("backgroundFillAlphas")) {
				_backgroundFillColors = getStyle("backgroundFillAlphas");
			}
			
			if (getStyle("borderStyle")) {
				_borderStyle = getStyle("borderStyle");
			} 
			
			if (getStyle("icon"));
			{
				Icon = getStyle("icon");
			}
			
			graphics.clear();
			if (_borderStyle == "inset")
			{
				graphics.lineStyle( 1, 0x999d9f, .5 );
			}
			graphics.beginGradientFill("linear", _backgroundFillColors, _backgroundFillAlphas, [0, 255], verticalGradientMatrix( 0, 0, uw, uh ));
			graphics.drawRoundRectComplex( 0, 0, uw, uh, 0, 0, 0, 0 );
			graphics.endFill();
			
			// Draw shadow on inside or outside depending on usage
			var ds:DropShadowFilter = new DropShadowFilter;
			
			if (_borderStyle == "inset")
			{
				ds.alpha = .5;
				ds.angle = 45;
				ds.distance = 2;
				ds.quality = 1;
				ds.blurX = 3;
				ds.blurY = 3;
				ds.color = 0x262e33;
				ds.inner = true;
			}
			else
			{
				ds.alpha = .2;
				ds.angle = 90;
				ds.distance = 2;
				ds.quality = 5;
				ds.blurX = 10;
				ds.blurY = 10;
				ds.color = 0x000000;
			}
			
			this.filters = [ds];
			
			// Include icon
			if (Icon)
			{ 
				var iconImage:Bitmap;
				iconImage = new Icon();
				
				var iconBitmapData:BitmapData;
				iconBitmapData = new BitmapData( iconImage.width, iconImage.height, true, 0xffffff );
				iconBitmapData.draw( iconImage );
				
				var translationMatrix:Matrix = new Matrix();
				var xPos:Number = 6;
				var yPos:Number = 4;
				
				translationMatrix.translate( xPos, yPos );
				
				graphics.lineStyle( 1, 0xffffff, 1, true );
				graphics.beginBitmapFill( iconBitmapData, translationMatrix, true, true );
				graphics.drawRect( xPos - 1, yPos - 1, iconImage.width + 1, iconImage.height + 1 );
				graphics.endFill();	
			}
		}
	}	
}