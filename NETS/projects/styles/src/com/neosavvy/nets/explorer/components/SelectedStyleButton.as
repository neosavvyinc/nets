package com.neosavvy.nets.explorer.components
{

	import mx.controls.Button;
	import mx.controls.ButtonPhase;
	import mx.core.mx_internal;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;

	use namespace mx_internal;


	/**
	 * A custom Button class for setting the state of a Toggled button text color
	 * By default, flex uses the same Up, Down, Over style state of text on a
	 * button that is selected and not selected.
	 *
	 * The css term for text in the down state is "text-selected-color". But buttons
	 * use the same Up,over,down styles if the button is selected. Adobe's terminology
	 * can make styling buttons confusing.
	 *
	 * This class uses the selectedButtonTextStyleName style in the same way that
	 * the ToggleButtonBar class behaves.
	 *
	 * If selectedButtonTextStyleName is not set textSelectedColor will be used as color
	 * and textRollOverColor in the selected state of the button.
	 */

	public class SelectedStyleButton extends Button
	{

		//--------------------------------------------------------------------------
		//
		// Constant string literals
		//
		//--------------------------------------------------------------------------

		private static const COLOR:String="color";
		private static const TEXT_ROLL_OVER_COLOR:String="textRollOverColor";
		private static const TEXT_SELECTED_COLOR:String="textSelectedColor";
		private static const SELECTED_BUTTON_TEXT_STYLE_NAME:String="selectedButtonTextStyleName";
		private static const DOT:String=".";

		//--------------------------------------------------------------------------
		//
		// Methods
		//
		//--------------------------------------------------------------------------

		//------------------------
		// Framework overrides
		//------------------------

		/**
		 * @mx_internal
		 * @override
		 *
		 * Overriding viewSkinForPhase to support the selectedButtonTextStyleName
		 * style as it behaves in ToggleButtonBar.
		 */

		override mx_internal function viewSkinForPhase(tempSkinName:String, stateName:String):void
		{
			super.mx_internal::viewSkinForPhase(tempSkinName, stateName);
			// Handle the selected state of a button 	
			if (selected == true && enabled == true)
			{

				// Check for the selectedButtonTextStyleName in the applied
				// style declaration	
				var selectedButtonTextStyle:CSSStyleDeclaration=null;
				var selectedButtonTextStyleName:String=getStyle(SELECTED_BUTTON_TEXT_STYLE_NAME);

				if (selectedButtonTextStyleName != null)
				{
					selectedButtonTextStyle=StyleManager.getStyleDeclaration(DOT + selectedButtonTextStyleName);
				}

				var phase:String=super.mx_internal::phase;
				var labelColor:Number=0;

				// If selectedButtonTextStyle is defined, use it's text styles
				if (selectedButtonTextStyle != null)
				{
					if (phase == ButtonPhase.OVER)
					{
						labelColor=selectedButtonTextStyle.getStyle(TEXT_ROLL_OVER_COLOR);
					}
					else if (phase == ButtonPhase.DOWN)
					{
						labelColor=selectedButtonTextStyle.getStyle(TEXT_SELECTED_COLOR);
					}
					else
					{
						labelColor=selectedButtonTextStyle.getStyle(COLOR);
					}

				}

				// If selectedButtonTextStyle is not defined, assume textSelectedColor
				// should be used for all button phases when the button is selected

				else
				{
					labelColor=getStyle(TEXT_SELECTED_COLOR);
				}
				textField.setColor(labelColor);
			}
		}
	} // end class
} // end package



