package main.flex.com.buildlinks.theme.skins
{
	import flash.geom.Matrix;
	
	import mx.containers.HDividedBox;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	import mx.skins.Border;
	
	public class BoxDividerSkin extends Border
	{

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//	
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor
		 */
		public function BoxDividerSkin()
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
			return 10;
		}
		
		//----------------------------------
		//  measuredHeight
		//----------------------------------
		
		/**
		 *  @private
		 */
		override public function get measuredHeight():Number
		{
			
			return 4;
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
		override protected function updateDisplayList( w:Number, h:Number ):void
		{				
			super.updateDisplayList( w, h );
			
			var skinParent:String;
			skinParent = String(UIComponent(parent.parent.parent).className);
			
			graphics.clear();
			graphics.beginFill( 0x989895, 1 );

			if( skinParent == "HDividedBox" )
			{
				drawRoundRect( parent.parent.parent.height / 2 * -1 + 2, parent.width / 2 * -1 + 6, parent.parent.parent.height, h, 0 );
			}
			else
			{
				drawRoundRect( parent.parent.parent.width / 2 * -1 + 5, parent.height / 2 * -1 + 3, parent.parent.parent.width, h, 0 );
			}
			graphics.endFill();
			
			parent.addEventListener(ResizeEvent.RESIZE, callInvalidateDisplayList);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Method to call InvalidateDisplayList when parent is resized
		 * @param event
		 * 
		 */		
		protected function callInvalidateDisplayList(event:ResizeEvent):void
		{
			invalidateDisplayList();
		}
	}	
}