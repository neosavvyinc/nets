package main.flex.com.buildlinks.theme.skins
{
	import mx.skins.Border;
	
	public class ScrollTrackSkin extends Border
	{

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//	
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor
		 */
		public function ScrollTrackSkin()
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
			return 12;
		}
		
		//----------------------------------
		//  measuredHeight
		//----------------------------------
		
		/**
		 *  @private
		 */        
		override public function get measuredHeight():Number
		{
			return 1;
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
			
			// User-defined styles.
			var fillColors:Array = getStyle("trackColors");
			var borderColor:uint = getStyle("borderColor");
			
			graphics.clear();
			
			// border
			drawRoundRect( 0, 0, w, h, 0, borderColor, 1 );
			
			// fill
			drawRoundRect( 1, 1, w - 2, h - 2, 0, fillColors, 1); 
		}
	}
}