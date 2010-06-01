package main.flex.com.buildlinks.theme.skins
{
	
	import flash.display.Graphics;
	import mx.core.mx_internal;
	import mx.skins.ProgrammaticSkin;
	
	public class DateChooserIndicator extends ProgrammaticSkin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor	 
		 */
		public function DateChooserIndicator()
		{
			super();             
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
			
			graphics.clear();
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
		}
	}
}
