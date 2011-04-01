package com.neosavvy.nets.theme.skins
{
	import flash.geom.Matrix;
	
	import mx.skins.Border;
	
	public class GrayToWhiteGradientBorderSkin extends Border
	{

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//	
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor
		 */
		public function GrayToWhiteGradientBorderSkin()
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

			var borderFillColors:Array = [0xf1f1f1 ,0xffffff];
			var borderFillAlphas:Array = [1.0, 1.0];
			
			graphics.clear();
			graphics.beginGradientFill("linear", borderFillColors, borderFillAlphas, [0, 255], matrix);
			graphics.drawRect( 0, 0, uw, uh );
//			graphics.lineStyle(1, 0x5d9b85, 1, true);
//			graphics.lineTo(0, uh);
			graphics.endFill();			
		}
	}
}