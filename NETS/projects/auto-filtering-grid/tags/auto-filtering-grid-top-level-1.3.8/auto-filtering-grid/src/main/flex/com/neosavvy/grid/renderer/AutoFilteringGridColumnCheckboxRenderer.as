package com.neosavvy.grid.renderer
{
import com.neosavvy.grid.model.AutoFilteringDropdownVO;

import flash.events.Event;

import mx.controls.CheckBox;

public class AutoFilteringGridColumnCheckboxRenderer extends CheckBox
{

    override public function set data(value:Object):void {
        if (value == null) {
            value = "---";
        }

        super.data = value;

        if (value && value is AutoFilteringDropdownVO)
            selected = (value as AutoFilteringDropdownVO).enabled;

        addEventListener(Event.CHANGE, changeListener);
    }

    public function changeListener(event:Event):void {
        (data as AutoFilteringDropdownVO).enabled = !(data as AutoFilteringDropdownVO).enabled;
    }

}
}