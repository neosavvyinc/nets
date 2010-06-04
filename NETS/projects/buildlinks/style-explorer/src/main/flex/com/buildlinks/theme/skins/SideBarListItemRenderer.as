package main.flex.com.buildlinks.theme.skins
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	import mx.controls.Image;
	import mx.controls.listClasses.ListItemRenderer;
	
	public class SideBarListItemRenderer extends ListItemRenderer
	{

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//	
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor
		 */
		public function SideBarListItemRenderer()
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
			var Icon:Class = null;			
			
			if (getStyle("icon"));
			{
				Icon = getStyle("icon");
			}
			
			graphics.lineStyle( 1, 0xcecec8, 1 );
			graphics.moveTo( -6, uh + 2 );
			graphics.lineTo( uw + 6, uh + 2 );
			graphics.endFill();
				
			
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
				
				graphics.beginBitmapFill( iconBitmapData, translationMatrix, true, true );
				graphics.drawRect(uw - xPos - 1, yPos - 1, iconImage.width, iconImage.height );
				graphics.endFill();	
			}
		}
	}
}