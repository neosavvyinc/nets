package com.buildlinks.theme.skins
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	import mx.skins.Border;
	
	public class ApplicationBorderSkin extends Border
	{
		[Embed(source='/com/buildlinks/theme/images/Swatch_brushedAluminum.png')]
		private var BackgroundImage:Class;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//	
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor
		 */
		public function ApplicationBorderSkin()
		{
			super();
		}
		//--------------------------------------------------------------------------
		//
		//  Override Methods
		//	
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 * @param uw
		 * @param uh
		 * 
		 */		
		override protected function updateDisplayList( uw:Number, uh:Number ):void
		{			
			// Styles
			var borderFillColors:Array = [ 0xe8e6d3, 0xd8dac2 ];
			var borderFillAlphas:Array = [ 1, 1 ];
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( uw, uh, Math.PI/2, 0, 0 );
			
			// Background Pattern Bitmap
			var backgroundImage:Bitmap;
			backgroundImage = new BackgroundImage();
			
			var backgroundBitmapData:BitmapData;
			backgroundBitmapData = new BitmapData(backgroundImage.width, backgroundImage.height, true, 0xffffff);
			backgroundBitmapData.draw( backgroundImage ); 
			
			graphics.clear();
			graphics.beginGradientFill("linear", borderFillColors, borderFillAlphas, [ 0, 255 ], matrix);
			graphics.drawRect( 0, 0, uw, uh );
			graphics.endFill();
			
			// Fill Pattern
			graphics.beginBitmapFill( backgroundBitmapData );
			graphics.drawRoundRectComplex(0, 0, uw, uh, 0, 0, 0, 0);
			graphics.endFill();
		}
	}
}