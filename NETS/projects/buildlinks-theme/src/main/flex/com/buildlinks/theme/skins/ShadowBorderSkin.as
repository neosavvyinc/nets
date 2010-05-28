package main.flex.com.buildlinks.theme.skins
{
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	
	import mx.skins.Border;
	
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
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( uw, uh, Math.PI/2, 0, 0 );
			
			var backgroundFillColors:Array = [ 0xf3f3ee ,0xf3f3ee ];
			var backgroundFillAlphas:Array = [ 1.0, 1.0 ];
			var _borderStyle:String = "none";
			
			if (getStyle("backgroundFillColors")) {
				backgroundFillColors = getStyle("backgroundFillColors");
			} 
			
			if (getStyle("backgroundFillAlphas")) {
				backgroundFillColors = getStyle("backgroundFillAlphas");
			}
			
			if (getStyle("borderStyle")) {
				_borderStyle = getStyle("borderStyle");
			} 
			
			graphics.clear();
			if (_borderStyle == "inset")
			{
				graphics.lineStyle( 1, 0x999d9f, .5 );
			}
			graphics.beginGradientFill("linear", backgroundFillColors, backgroundFillAlphas, [0, 255], matrix);
			graphics.drawRoundRectComplex( 0, 0, uw, uh, 0, 0, 0, 0 );
			graphics.endFill();
			
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
		}
	}	
}