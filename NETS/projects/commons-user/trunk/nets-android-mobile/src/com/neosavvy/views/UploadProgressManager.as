package com.neosavvy.views
{
	import com.neosavvy.nets.mobile.ProgressGauge;
	import com.neosavvy.nets.mobile.StoplightingProgressGauge;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.managers.PopUpManager;
	
	import spark.components.Label;

	public class UploadProgressManager extends EventDispatcher
	{
		
		private var progressGauge : ProgressGauge;
		
		public function startProgress( parentObject : DisplayObject ):void
		{
			/*progressBar = new ProgressBar();
			progressBar.minimum = 0;
			progressBar.maximum = 100;
			progressBar.mode = ProgressBarMode.MANUAL;*/
			
			
			progressGauge = new ProgressGauge();
			progressGauge.setStyle("skinClass", StoplightingProgressGauge );
			PopUpManager.addPopUp( progressGauge, parentObject );
			PopUpManager.centerPopUp( progressGauge );
		}
		
		public function progressComplete():void
		{
			PopUpManager.removePopUp( progressGauge );	
		}
		
		public function updateProgress( currentValue : Number, total : Number ):void
		{
			
			var currentPercent : Number = Math.round((currentValue / total) * 100);
			
			progressGauge.currentPercentage = currentPercent;
			
			if( currentValue == total )
			{
				dispatchEvent( new Event("uploadCompleteEvent") );
			}
		}
		
		
	}
}