package com.neosavvy.views
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.controls.ProgressBar;
	import mx.controls.ProgressBarMode;
	import mx.managers.PopUpManager;
	
	import spark.components.Label;

	public class UploadProgressManager extends EventDispatcher
	{
		private var progressBar : Label;
		
		public function startProgress( parentObject : DisplayObject ):void
		{
			/*progressBar = new ProgressBar();
			progressBar.minimum = 0;
			progressBar.maximum = 100;
			progressBar.mode = ProgressBarMode.MANUAL;*/
			
			
			progressBar = new Label();
			PopUpManager.addPopUp( progressBar, parentObject );
			PopUpManager.centerPopUp( progressBar );
		}
		
		public function progressComplete():void
		{
			PopUpManager.removePopUp( progressBar );	
		}
		
		public function updateProgress( currentValue : Number, total : Number ):void
		{
			
			var currentPercent : Number = Math.round((currentValue / total) * 100);
			
			progressBar.text = "Upload " + currentPercent + "% complete...";
			
			if( currentValue == total )
			{
				dispatchEvent( new Event("uploadCompleteEvent") );
			}
		}
		
		
	}
}