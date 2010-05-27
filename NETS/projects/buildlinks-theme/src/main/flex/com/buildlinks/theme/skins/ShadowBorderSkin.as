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
			
			var ds:DropShadowFilter = new DropShadowFilter;
			
			ds.alpha = .2;
			ds.angle = 90;
			ds.distance = 2;
			ds.quality = 5;
			ds.blurX = 10;
			ds.blurY = 10;
			ds.color = 0x000000;
			
			this.filters = [ds];
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
			
			if (getStyle("backgroundFillColors")) {
				backgroundFillColors = getStyle("backgroundFillColors");
			} 
			
			if (getStyle("backgroundFillAlphas")) {
				backgroundFillColors = getStyle("backgroundFillAlphas");
			} 
			
			graphics.clear();
			graphics.beginGradientFill("linear", backgroundFillColors, backgroundFillAlphas, [0, 255], matrix);
			graphics.drawRoundRectComplex( 0, 0, uw, uh, 0, 0, 0, 0 );
			graphics.endFill();
			
		}
	}	
}