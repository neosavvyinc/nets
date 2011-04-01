package com.neosavvy.nets.theme.skins
{
	import flash.geom.Matrix;
	
	import mx.skins.Border;
	
	public class GrayToGrayGradientBorderSkin extends Border
	{

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//	
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor
		 */
		public function GrayToGrayGradientBorderSkin()
		{
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		override protected function updateDisplayList( uw:Number, uh:Number ):void
		{
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( uw, uh, Math.PI/2, 0, 0 );

			var borderFillColors:Array = [0xffffff ,0xbdd3cb];
			var borderFillAlphas:Array = [1.0, 1.0];
			
			graphics.clear();
			graphics.beginGradientFill("linear", borderFillColors, borderFillAlphas, [0, 255], matrix);
			graphics.drawRect( 0, 0, uw, uh );
			graphics.endFill();			
		}
	}
}