package com.neosavvy.nets.mobile
{
	
	import spark.components.supportClasses.SkinnableComponent;
	
	
	
	public class ProgressGauge extends SkinnableComponent
	{
		
		public static const GREEN : Number = 0x0000FF;
		public static const YELLOW : Number = 0x00FF00;
		public static const RED : Number = 0xFF0000;
		
		public static const RED_PERCENTAGE : Number = 90;
		public static const YELLOW_PERCENTAGE : Number = 75;
		
		private var _currentPercentage : Number = 0;

		[Bindable]
		public function get currentPercentage():Number
		{
			return _currentPercentage;
		}

		public function set currentPercentage(value:Number):void
		{
			if( value > 100) 
				value = 100;
			
			if( value < 0 )
				value = 0; 
			
			_currentPercentage = value;
			currentPercentageChanged = true;
			invalidateProperties();
			skin.invalidateDisplayList();
		}
		
		
		
		private var currentPercentageChanged : Boolean = false;
		
		[Bindable]
		public var currentColor : Number = GREEN;
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if( currentPercentageChanged )
			{
				if( currentPercentage >= RED_PERCENTAGE )
				{
					currentColor = RED;	
				}
				else if ( currentPercentage >= YELLOW_PERCENTAGE && currentPercentage < RED_PERCENTAGE )
				{
					currentColor = YELLOW;
				}
				else
				{
					currentColor = GREEN;
				}
				currentPercentageChanged = false;
			}
		}
		
		override protected function getCurrentSkinState():String
		{
			return super.getCurrentSkinState();
		} 
		
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
	}
}