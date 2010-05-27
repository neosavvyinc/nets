package main.flex.com.buildlinks.theme.skins
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	import mx.skins.Border;
	
	public class StripedBorderSkin extends Border
	{
		[Embed(source='main/resources/com/buildlinks/theme/images/Swatch_stripes.png')]
		private var BackgroundImage:Class;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//	
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor
		 */
		public function StripedBorderSkin()
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
			var borderFillColors:Array = [ 0xffffff, 0xffffff ];
			var borderFillAlphas:Array = [ 1, 1 ];
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( uw, uh, Math.PI/2, 0, 0 );
			
			// Background Pattern Bitmap
			var backgroundImage:Bitmap;
			backgroundImage = new BackgroundImage();
			
			var backgroundBitmapData:BitmapData;
			backgroundBitmapData = new BitmapData( backgroundImage.width, backgroundImage.height, true, 0xffffff );
			backgroundBitmapData.draw( backgroundImage ); 
			
			graphics.clear();
			graphics.beginGradientFill( "linear", borderFillColors, borderFillAlphas, [ 0, 255 ], matrix );
			graphics.drawRect( 0, 0, uw, uh );
			graphics.endFill();
			
			// Fill Pattern
			graphics.beginBitmapFill( backgroundBitmapData );
			graphics.drawRect( 0, uh - backgroundImage.height, uw, backgroundImage.height );
			graphics.endFill();
			
/*			graphics.lineStyle( 1, 0x91918e, 1, true );
			graphics.moveTo( 0, uh );
			graphics.lineTo( uw, uh );*/
		}
	}
}